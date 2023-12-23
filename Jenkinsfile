

pipeline {
    agent any
    
    environment {
        DOCKER_REGISTRY = 'skandersoltane'
        DOCKER_REPO = 'petclinic'
        DOCKER_IMAGE_TAG = 'latest'
    }

    stages {

        stage('Build') { 
            steps {
                script {
                    sh './mvnw package -DskipTests' 
                }
            }
        }

        stage('Build and Push Docker Image') {
            steps {
                script {
                    def dockerImage = "${DOCKER_REGISTRY}/${DOCKER_REPO}:${env.BUILD_NUMBER}"

                    // Build Docker image
                    sh "docker build -t ${dockerImage} ."

                    // Push Docker image to DockerHub
                    sh "docker login -u skandersoltane -p kDXbX2GEQfy93et"
                    sh "docker push ${dockerImage}"
                }
            }
        }

        stage('Deploy') {
            steps {
                 script {
                    sh """
                        kubectl set image deployment/petclinic-deployment petclinic=skandersoltane/petclinic:"${env.BUILD_NUMBER}"
                    """
                }
            }
        }
    }
}

