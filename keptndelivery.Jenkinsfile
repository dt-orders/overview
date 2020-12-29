@Library('keptn-library')_
def keptn = new sh.keptn.Keptn()

node {
    properties([
        parameters([
         string(defaultValue: 'keptnorders', description: 'Name of your Keptn Project you have setup for progressive delivery', name: 'Project', trim: false), 
         string(defaultValue: 'staging', description: 'First stage you want to deploy into', name: 'Stage', trim: false), 
         string(defaultValue: 'order', description: 'Order Service', name: 'orderService', trim: false),
         string(defaultValue: 'docker.io/dtdemos/dt-orders-order-service:1', description: 'Order Service with Tag [:1,:2:3]', name: 'orderImage', trim: false),
         string(defaultValue: 'customer', description: 'Customer Service', name: 'customerService', trim: false),
         string(defaultValue: 'docker.io/dtdemos/dt-orders-customer-service:1', description: 'Customer Service with Tag [:1,:2:3]', name: 'customerImage', trim: false),
         string(defaultValue: 'frontend', description: 'FrontEnd Service', name: 'frontendService', trim: false),
         string(defaultValue: 'docker.io/dtdemos/dt-orders-frontend:1', description: 'Tag:1', name: 'frontendImage', trim: false),
         string(defaultValue: 'catalog', description: 'Catalog Service', name: 'catalogService', trim: false),
         string(defaultValue: 'docker.io/dtdemos/dt-orders-catalog-service:1', description: 'Tag:1', name: 'catalogImage', trim: false),
         string(defaultValue: '20', description: 'How many minutes to wait until Keptn is done? 0 to not wait', name: 'WaitForResult'),
         choice(name: "DEPLOY_TO", choices: ["all", "order", "catalog", "frontend","customer"])
        ])
    ])


    stage() {
        parallel {  
    		stage('Trigger orderService') {
    			when { expression { param.DEPLOY_TO == "all" || param.DEPLOY_TO == "order" } }
    			 steps {
        			echo "Progressive Delivery: Triggering Keptn to deliver ${params.orderImage}"

        			// send deployment finished to trigger tests
        			def keptnContext = keptn.sendConfigurationChangedEvent project:"${params.Project}", service:"${params.orderService}", stage:"${params.Stage}", image:"${params.orderImage}" 
        			String keptn_bridge = env.KEPTN_BRIDGE
        			echo "Open Keptns Bridge: ${keptn_bridge}/trace/${keptnContext}"
        		}	
    		}
    		stage('Trigger customerService') {
    		    when { expression { param.DEPLOY_TO == "all" || param.DEPLOY_TO == "customer" } }
    		     steps {
       				echo "Progressive Delivery: Triggering Keptn to deliver ${params.customerImage}"

        			// send deployment finished to trigger tests
        			def keptnContext = keptn.sendConfigurationChangedEvent project:"${params.Project}", service:"${params.customerService}", stage:"${params.Stage}", image:"${params.customerImage}" 
        			String keptn_bridge = env.KEPTN_BRIDGE
        			echo "Open Keptns Bridge: ${keptn_bridge}/trace/${keptnContext}"
				} 
    		}    
    		stage('Trigger CatalogService') {
    		    when { expression { param.DEPLOY_TO == "all" || param.DEPLOY_TO == "catalog" } }
    		     steps {
        			echo "Progressive Delivery: Triggering Keptn to deliver ${params.catalogImage}"

        			// send deployment finished to trigger tests
        			def keptnContext = keptn.sendConfigurationChangedEvent project:"${params.Project}", service:"${params.catalogService}", stage:"${params.Stage}", image:"${params.catalogImage}" 
        			String keptn_bridge = env.KEPTN_BRIDGE
        			echo "Open Keptns Bridge: ${keptn_bridge}/trace/${keptnContext}"
        		 }
    		}  
    		stage('Trigger FrontendService') {
    		    when { expression { param.DEPLOY_TO == "all" || param.DEPLOY_TO == "frontend" } }
    		     steps {
        			echo "Progressive Delivery: Triggering Keptn to deliver ${params.frontendImage}"

        			// send deployment finished to trigger tests
        			def keptnContext = keptn.sendConfigurationChangedEvent project:"${params.Project}", service:"${params.frontendService}", stage:"${params.Stage}", image:"${params.frontendImage}" 
        			String keptn_bridge = env.KEPTN_BRIDGE
        			echo "Open Keptns Bridge: ${keptn_bridge}/trace/${keptnContext}"
        		 }	
    		}          
    		stage('Wait for Result') {
        		waitTime = 0
        		if(params.WaitForResult?.isInteger()) {
            		waitTime = params.WaitForResult.toInteger()
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
