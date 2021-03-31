@Library('keptn-library')_
import sh.keptn.Keptn
def keptn = new sh.keptn.Keptn()

pipeline {
    agent any
    
    environment {
    	def waitTime = 0
    }

    parameters {
         string(defaultValue: 'easytravel', description: 'Name of your Keptn Project you have setup for progressive delivery', name: 'Project', trim: false) 
         string(defaultValue: 'staging', description: 'First stage you want to deploy into', name: 'Stage', trim: false) 
         string(defaultValue: 'easytravel-mongodb', description: 'easytravel Mongo DB', name: 'Service1', trim: false)
         string(defaultValue: 'docker.io/dynatrace/easytravel-mongodb:latest', description: 'Mongo DB Image', name: 'Image1', trim: false)
         string(defaultValue: 'easytravel-backend', description: 'easytravel Backend', name: 'Service2', trim: false)
         string(defaultValue: 'docker.io/dynatrace/easytravel-backend:latest', description: 'easytravel Backend', name: 'Image2', trim: false)
         string(defaultValue: 'easytravel-frontend', description: 'easytracel Frontend', name: 'Service3', trim: false)
         string(defaultValue: 'docker.io/dynatrace/easytravel-frontend:latest', description: 'easytravel Frontend', name: 'Image3', trim: false)
         string(defaultValue: 'easytravel-www', description: 'easytravel nginx service', name: 'Service4', trim: false)
         string(defaultValue: 'docker.io/dynatrace/easytravel-nginx:latest', description: 'easytravel nginx', name: 'Image4', trim: false)
         string(defaultValue: '20', description: 'How many minutes to wait until Keptn is done? 0 to not wait', name: 'WaitForResult')
         choice(name: 'DEPLOY_TO', choices: ["none", "all", "easytravelMongoDB", "easytravel-backend", "easytravel-frontend", "easytravel-www"])
    }

    stages {        
        	stage('Trigger ${params.Service3}') {
    		    when { expression { params.DEPLOY_TO == "all" || params.DEPLOY_TO == "easytravel-frontend" } }
    		     steps {
        			echo "Progressive Delivery: Triggering Keptn to deliver ${params.Image3}"
        			script {
					  // Initialize the Keptn Project
                      keptn.keptnInit project:"${params.Project}", service:"${params.Service3}", stage:"${params.Stage}", monitoring:"dynatrace" 
				      //set a label
				      def labels=[:]
                      labels.put('TriggeredBy', 'Jenkins')
        			  // Deploy via keptn
        			  def keptnContext = keptn.sendConfigurationChangedEvent image:"${params.Image3}", labels : labels
        			  String keptn_bridge = env.KEPTN_BRIDGE
        			  echo "Open Keptns Bridge: ${keptn_bridge}/trace/${keptnContext}"
        			}
        		 }	
    		} 
    		stage('Trigger ${params.Service1}') {
    			when { expression { params.DEPLOY_TO == "all" || params.DEPLOY_TO == "easytravelMongoDB" } }
    			 steps {
        			echo "Progressive Delivery: Triggering Keptn to deliver ${params.Image1}"			   
        			script {
        			    keptn.keptnInit project:"${params.Project}", service:"${params.Service1}", stage:"${params.Stage}", monitoring:"dynatrace"
        			    def labels=[:]
                        labels.put('TriggeredBy', 'Jenkins') 
        				def keptnContext = keptn.sendConfigurationChangedEvent image:"${params.Image1}", labels : labels
        				String keptn_bridge = env.KEPTN_BRIDGE
        				echo "Open Keptns Bridge: ${keptn_bridge}/trace/${keptnContext}"
        			}
        		}	
    		}
    		stage('Trigger ${params.Service2}') {
    		    when { expression { params.DEPLOY_TO == "all" || params.DEPLOY_TO == "easytravel-backend" } }
    		     steps {
       				echo "Progressive Delivery: Triggering Keptn to deliver ${params.Image2}"
        			script {
        			    keptn.keptnInit project:"${params.Project}", service:"${params.Service2}", stage:"${params.Stage}", monitoring:"dynatrace"
        			    def labels=[:]
                        labels.put('TriggeredBy', 'Jenkins') 
        				def keptnContext = keptn.sendConfigurationChangedEvent image:"${params.Image2}", labels : labels
        				String keptn_bridge = env.KEPTN_BRIDGE
        				echo "Open Keptns Bridge: ${keptn_bridge}/trace/${keptnContext}"
        			}	
				} 
    		}    
    		stage('Trigger ${params.Service4}') {
    		    when { expression { params.DEPLOY_TO == "all" || params.DEPLOY_TO == "easytravel-www" } }
    		     steps {
        			echo "Progressive Delivery: Triggering Keptn to deliver ${params.Image4}"
        			script {
        			    keptn.keptnInit project:"${params.Project}", service:"${params.Service4}", stage:"${params.Stage}", monitoring:"dynatrace"
        				def labels=[:]
                        labels.put('TriggeredBy', 'Jenkins')
        				def keptnContext = keptn.sendConfigurationChangedEvent image:"${params.Image4}", labels : labels 
        				String keptn_bridge = env.KEPTN_BRIDGE
        				echo "Open Keptns Bridge: ${keptn_bridge}/trace/${keptnContext}"
        			}
        		 }
    		}          
           stage('Wait for Result') {          
                 steps {             
            		script {                         
       					if(params.WaitForResult?.isInteger()) {
           					def waitTime = params.WaitForResult.toInteger()
       					}
       					if(waitTime > 0) {
           					echo "Waiting until Keptn is done and returns the results"
           					def result = keptn.waitForEvaluationDoneEvent setBuildResult:true, waitTime:waitTime
           					echo "${result}"
       					} else {
           					echo "Not waiting for results. Please check the Keptns bridge for the details!"
       					}
       	  			}	
       	  		}
	  		}    
  	}
} 
