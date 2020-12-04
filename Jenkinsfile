pipeline {
    agent any
    parameters {
        // these will be presented as build parameters 
        choice(name: 'frontend_version', choices: ['1'], description: '1 = Normal behavior')
        choice(name: 'order_service_version', choices: ['1','2','3'], description: '1 = Normal behavior. 2 = 50% exception for /line URL and and n+1 back-end calls for /form.html')
        choice(name: 'customer_service_version', choices: ['1','2','3'], description: '1 = Normal behavior. 2 = High Response time for /list.html')
        choice(name: 'catalog_service_version', choices: ['1'], description: '1 = Normal behavior')
    }
    environment {
        // stored as jenkins credentials. Values are masked
        DT_URL = "https://${env.DT_ACCOUNTID}"
        DT_TOKEN = "${env.DT_API_TOKEN}"

        // file locations
        DOCKER_COMPOSE_TEMPLATE_FILE = "/home/ubuntu/workshop/lab4/docker-compose.template"
        DOCKER_COMPOSE_FILE = "/home/ubuntu/workshop/lab4/docker-compose.yaml"
        WAIT_TILL_READY_FILE = "/home/ubuntu/workshop/helper-scripts/wait-till-ready.sh"
        LOAD_TEST_FILE = "/home/ubuntu/workshop/lab3/sendtraffic.sh"
        //templates
        FRONT_END_FILE_TEMPLATE_FILE = "/var/jenkins_home/workspace/Test/k8/template/frontend.yaml"
        CATALOG_FILE_TEMPLATE_FILE = "/var/jenkins_home/workspace/Test/k8/template/catalog-service.yaml"
        ORDER_FILE_TEMPLATE_FILE = "/var/jenkins_home/workspace/Test/k8/template/order-service.yaml"
        CUSTOMER_FILE_TEMPLATE_FILE = "/var/jenkins_home/workspace/Test/k8/template/customer-service.yaml"         
        
    
        // build the docker image name using tag value passed as parameters
        frontendimage = "docker.io/dtdemos/dt-orders-frontend:${params.frontend_version}"
        orderserviceimage = "docker.io/dtdemos/dt-orders-catalog-service:${params.order_service_version}"
        customerserviceimage = "docker.io/dtdemos/dt-orders-customer-service:${params.customer_service_version}"
        catalogserviceimage = "docker.io/dtdemos/dt-orders-catalog-service:${params.catalog_service_version}"
    }
    stages {
        stage('configure-services') {
            steps {
                script {
                    echo "============================================="
                    echo "Deployment configuration"
                    echo "frontendimage          : ${env.frontendimage}"
                    echo "orderserviceimage      : ${env.orderserviceimage}"
                    echo "customerserviceimage   : ${env.customerserviceimage}"
                    echo "catalogserviceimage    : ${env.catalogserviceimage}"
                    echo "============================================="
                }
            }
        }

        stage('install keptn') {
            steps {
                script {
                sh "pwd"
                //sh "wget -O  https://get.keptn.sh | sudo -E bash"    
                sh "wget -O keptn.tar https://github.com/keptn/keptn/releases/download/0.7.3/0.7.3_keptn-linux.tar"
                sh "tar -xvf keptn.tar"
                sh "chmod +x keptn"
                sh "mv keptn /tmp/keptn"    
                sh "ls"
                sh "keptn version"
                }
            }
        }
        stage('keptn send') {
            steps {
                script {
                 sh "/tmp/keptn send event new-artifact --project=keptnorders --service=catalog --image=docker.io/dtdemos/dt-orders-catalog-service --tag=${params.catalog_service_version}"
                 sh "/tmp/keptn send event new-artifact --project=keptnorders --service=order --image=docker.io/dtdemos/dt-orders-order-service --tag=${params.order_service_version}"
                 sh "/tmp/keptn send event new-artifact --project=keptnorders --service=customer --image=docker.io/dtdemos/dt-orders-customer-service --tag=${params.customer_service_version}"
                 sh "/tmp/keptn send event new-artifact --project=keptnorders --service=frontend --image=docker.io/dtdemos/dt-orders-frontend --tag=${params.frontend_version}"   
                }
            }    
        }
        
        stage('Push Dynatrace Deployment Event') {
            steps {
                script {
                    DYNATRACE_API_URL="${DT_URL}/api/v1/events"
                    DEPLOY_VERSION = "frontend:${params.frontend_version} order:${params.order_service_version} customer:${params.customer_service_version} catalog:${params.catalog_service_version}"

                    POST_DATA="""{
                        "eventType": "CUSTOM_DEPLOYMENT",
                        "attachRules": {
                                "tagRule": [
                                    {
                                        "meTypes":"SERVICE",
                                        "tags": [
                                            {
                                                "context": "ENVIRONMENT",
                                                "key": "app",
                                                "value": "keptn-orders"
                                            }
                                        ]
                                    }
                                ]
                        },
                        "deploymentName" : "Deployment for keptn-orders - ${env.BUILD_TAG}",
                        "deploymentVersion" : "${DEPLOY_VERSION}",
                        "deploymentProject" : "keptn-orders",
                        "source" : "Jenkins",
                        "ciBackLink" : "${env.JENKINS_URL}",
                        "customProperties" : {
                            "JenkinsUrl" : "${env.JOB_URL}",
                            "BuildUrl" : "${env.BUILD_URL}",
                            "GitCommit" : "${env.GIT_COMMIT}"
                        }
                    }"""

                    echo "${POST_DATA}"
                    echo "${DYNATRACE_API_URL}"

                    sh "curl -X POST ${DYNATRACE_API_URL} -H 'Content-type: application/json' -H 'Authorization: Api-Token ${DT_TOKEN}' -d '${POST_DATA}'"
                }
            }
        }

        stage('Execute Test') {
            steps {
                script {
                    TEST_START = sh(script: 'echo "$(date -u +%s)"', returnStdout: true).trim()
                    sh "${LOAD_TEST_FILE} 120 ${env.BUILD_TAG}"
                    TEST_END = sh(script: 'echo "$(date -u +%s)"', returnStdout: true).trim()
                    echo "TEST_START: ${TEST_START}  TEST_END: ${TEST_END}"
                }
            }
        }

        stage('Push Dynatrace Test Annotation Event') {
            steps {
                script {
                    DYNATRACE_API_URL="${DT_URL}/api/v1/events"
                    DEPLOY_VERSION = "frontend:${params.frontend_version} order:${params.order_service_version} customer:${params.customer_service_version} catalog:${params.catalog_service_version}"

                    POST_DATA="""{
                        "eventType": "CUSTOM_ANNOTATION",
                        "attachRules": {
                                "tagRule": [
                                    {
                                        "meTypes":"SERVICE",
                                        "tags": [
                                            {
                                                "context": "ENVIRONMENT",
                                                "key": "app",
                                                "value": "keptn-orders"
                                            }
                                        ]
                                    }
                                ]
                        },
                        "source": "Jenkins",
                        "annotationType": "Load Test Jenkins-${env.BUILD_NUMBER}",
                        "annotationDescription": "Load Test for keptn-orders ${env.BUILD_TAG}",
                        "customProperties" : {
                            "JenkinsUrl" : "${env.JOB_URL}",
                            "BuildUrl" : "${env.BUILD_URL}",
                            "GitCommit" : "${env.GIT_COMMIT}",
                            "deploymentVersion" : "${DEPLOY_VERSION}"
                        },
                        "start": "${TEST_START}000",
                        "end": "${TEST_END}000"
                    }"""

                    echo "${POST_DATA}"
                    echo "${DYNATRACE_API_URL}"

                    sh "curl -X POST ${DYNATRACE_API_URL} -H 'Content-type: application/json' -H 'Authorization: Api-Token ${DT_TOKEN}' -d '${POST_DATA}'"
                }
            }
        }
    }
}
