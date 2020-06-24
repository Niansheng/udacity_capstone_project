pipeline {
    environment {
        registry = "victorliun/nginx-app"
        registryCredential = "dockerhub"
    }
    agent any
    stages {
        stage('Lint HTML') {
            steps {
                sh 'tidy -q -e www/*.html'
                sh 'hadolint Dockerfile'
            }
        }
        stage('Build Image') {
            steps {
                // sh 'docker build -t nginx-app .'
                script {
                    dockerImage = docker.build registry + ":latest"
                }
            }
        }
        stage('Push Image') {
            steps {
                script {
                    docker.withRegistry( '', registryCredential ) {
                        dockerImage.push()
                    }
                }
                // sh 'docker tag nginx-app victorliu/nginx-app'
                // sh 'docker push victorliu/nginx-app'
            }
        }
        stage('Remove Unused docker image') {
            steps{
                sh "docker rmi $registry:latest"
            }
        }
        stage('Set current kubectl context') {
			steps {
				withAWS(region:'eu-west-2', credentials:'aws-capstone') {
					sh '''
						kubectl config use-context arn:aws:eks:eu-west-2:564479081737:cluster/capstonecluster
					'''
				}
			}
		}

		stage('Deploy blue container') {
			steps {
				withAWS(region:'eu-west-2', credentials:'aws-capstone') {
					sh '''
						kubectl apply -f ./deploy/blue-controller.json
					'''
				}
			}
		}

		stage('Deploy green container') {
			steps {
				withAWS(region:'eu-west-2', credentials:'aws-capstone') {
					sh '''
						kubectl apply -f ./deploy/green-controller.json
					'''
				}
			}
		}

		stage('Create the service in the cluster, redirect to blue') {
			steps {
				withAWS(region:'eu-west-2', credentials:'aws-capstone') {
					sh '''
						kubectl apply -f ./deploy/blue-service.json
					'''
				}
			}
		}

		stage('Wait user approve') {
            steps {
                input "Ready to redirect traffic to green?"
            }
        }

		stage('Create the service in the cluster, redirect to green') {
			steps {
				withAWS(region:'eu-west-2', credentials:'aws-capstone') {
					sh '''
						kubectl apply -f ./deploy/green-service.json
					'''
				}
			}
		}
	}
}