void setBuildStatus(String message, String state) {
  step([
      $class: "GitHubCommitStatusSetter",
      reposSource: [$class: "ManuallyEnteredRepositorySource", url: "https://github.com/richhamseth/flask-app.git"],
      contextSource: [$class: "ManuallyEnteredCommitContextSource", context: "ci/jenkins/build-status"],
      errorHandlers: [[$class: "ChangingBuildStatusErrorHandler", result: "UNSTABLE"]],
      statusResultSource: [ $class: "ConditionalStatusResultSource", results: [[$class: "AnyBuildResult", message: message, state: state]] ]
  ]);
}

pipeline {
    agent none
    stages {

    	stage("checkout from develop"){
    		when { branch 'develop'}
    			agent { label 'build'}
    			steps {
    				checkout scm
    		}
    	}

      stage("checkout from feature/*"){
        when { branch 'feature/*'}
          agent { label 'build'}
          steps {
            checkout scm
        }
      }

    	 stage("build docker image from develop"){
    	 	when { branch 'develop'}
    	 		agent { label 'build'}
    	 		steps {
            sh "docker-compose -p demoflaskApp down"
    	 			sh "docker network ls"
    	 			sh 'docker build -t demoflaskapp:latest .'
    	 		}
    	 }

       stage("build docker image from feature/*"){
        when { branch 'feature/*'}
          agent { label 'build'}
          steps {
            sh "docker-compose -p demoflaskApp down"
            sh "docker network ls"
            sh 'docker build -t demoflaskapp:latest .'
          }
       }

    	 stage("deploy from develop"){
    	 	when { branch 'develop'}
    	 		agent { label 'build'}
    	 		steps {
    	 			sh "docker-compose -p demoflaskApp up -d"
    	 	}
    	 }

       stage("deploy from feature/*"){
        when { branch 'feature/*'}
          agent { label 'build'}
          steps {
            sh "docker-compose -p demoflaskApp up -d"
        }
       }

    	 stage("Robot testing from develop") {
    	 	when { branch 'develop'}
    	 		agent { label 'build'}
    	 		steps {
    	 			sh "docker build -t robotflaskapp:latest -f ${workspace}/testing/Dockerfile ."
            dir( "testing/" ) {
              withDockerContainer(args: '-v $PWD:/testing --network=demoflaskApp', image: 'robotflaskapp:latest') {
                sh "robot Flaskapp.robot"
              }
            }
            }
        }

       stage("Robot testing from fetaure/*") {
        when { branch 'feature/*'}
          agent { label 'build'}
          steps {
            sh "docker build -t robotflaskapp:latest -f ${workspace}/testing/Dockerfile ."
            dir( "testing/" ) {
              withDockerContainer(args: '-v $PWD:/testing --network=demoflaskApp', image: 'robotflaskapp:latest') {
                sh "robot Flaskapp.robot"
              }
            }
            }
        }
    }
   }
