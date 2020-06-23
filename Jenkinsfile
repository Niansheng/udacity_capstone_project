pipeline {
    environment {
        registry = "victorliun/nginx-app"
        registryCredential = ‘dockerhub’
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
    }
}
