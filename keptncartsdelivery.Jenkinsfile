@Library('keptn-library')_
import sh.keptn.Keptn
def keptn = new sh.keptn.Keptn()

pipeline {
    agent any
    
    environment {
    	def waitTime = 0
    }

    parameters {
         string(defaultValue: 'sockshop', description: 'Name of your Keptn Project you have setup for progressive delivery', name: 'Project', trim: false) 
         string(defaultValue: 'dev', description: 'First stage you want to deploy into', name: 'Stage', trim: false) 
         string(defaultValue: 'carts', description: 'Carts Service', name: 'cartsService', trim: false)
         string(defaultValue: 'docker.io/keptnexamples/carts:0.12.1', description: 'Carts Service with Tag [:0.12.1,:0.12.2:0.12.3]', name: 'cartsImage', trim: false)
         string(defaultValue: 'carts-db', description: 'Carts mongoDB', name: 'carts-dbService', trim: false)
         string(defaultValue: 'docker.io/mongo:4.2.2', description: 'Carts-db Service with Tag [:4.2.2]', name: 'carts-dbImage', trim: false)
         string(defaultValue: '20', description: 'How many minutes to wait until Keptn is done? 0 to not wait', name: 'WaitForResult')
         choice(name: 'DEPLOY_TO', choices: ["all", "carts", "carts-db"])
    }

    stages {        
        	stage('Trigger cartsService') {
    		    when { expression { params.DEPLOY_TO == "all" || params.DEPLOY_TO == "carts" } }
    		     steps {
        			echo "Progressive Delivery: Triggering Keptn to deliver ${params.cartsImage}"
        			script {
					  // Initialize the Keptn Project
                      keptn.keptnInit project:"${params.Project}", service:"${params.cartsService}", stage:"${params.Stage}", monitoring:"dynatrace" 
				      //set a label
				      def labels=[:]
                      labels.put('TriggeredBy', 'Jenkins')
        			  // Deploy via keptn
        			  def keptnContext = keptn.sendConfigurationChangedEvent image:"${params.cartsImage}", labels : labels
        			  String keptn_bridge = env.KEPTN_BRIDGE
        			  echo "Open Keptns Bridge: ${keptn_bridge}/trace/${keptnContext}"
        			}
        		 }	
    		} 
    		stage('Trigger carts-dbService') {
    			when { expression { params.DEPLOY_TO == "all" || params.DEPLOY_TO == "carts-db" } }
    			 steps {
        			echo "Progressive Delivery: Triggering Keptn to deliver ${params.carts-dbImage}"			   
        			script {
        			    keptn.keptnInit project:"${params.Project}", service:"${params.carts-dbService}", stage:"${params.Stage}", monitoring:"dynatrace"
        			    def labels=[:]
                        labels.put('TriggeredBy', 'Jenkins') 
        				def keptnContext = keptn.sendConfigurationChangedEvent image:"${params.carts-dbImage}", labels : labels
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
