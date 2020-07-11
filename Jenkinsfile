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

    	stage("checkout"){
    		when { branch 'develop'}
    			agent { label 'build'}
    			steps {
    				checkout scm
    		}
    	}

    	 stage("build docker image"){
    	 	when { branch 'develop'}
    	 		agent { label 'build'}
    	 		steps {
            sh "docker-compose -p demoflaskApp down"
    	 			sh "docker network ls"
    	 			sh 'docker build -t demoflaskapp:latest .'
    	 		}
    	 }

    	 stage("deploy"){
    	 	when { branch 'develop'}
    	 		agent { label 'build'}
    	 		steps {
    	 			sh "docker-compose -p demoflaskApp up -d"
    	 	}
    	 }

    	 stage("Robot testing") {
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
    }
   }
