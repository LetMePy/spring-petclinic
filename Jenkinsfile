

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
                    sh './mvnw package' 
                }
            }
        }

        stage('Build and Push Docker Image') {
            steps {
                script {
                    def dockerImage = "${DOCKER_REGISTRY}/${DOCKER_REPO}:${DOCKER_IMAGE_TAG}"

                    // Build Docker image
                    sh "docker build -t ${dockerImage} ."

                    // Push Docker image to DockerHub
                    sh "docker login -u skandersoltane -p kDXbX2GEQfy93et"
                    sh "docker push ${dockerImage}"
                }
            }
        }

        stage('Ansible') {
            /* Move the Ansible playbook execution directly within the stage */
            script {
                sh 'ansible-playbook kubectl-setup-playbook.yaml'
            }
        }

        stage('Deploy') {
            script {
                sh """
                    kubectl set image deployment/petclinic-deployment petclinic=skandersoltane/petclinic:"${env.BUILD_NUMBER}"
                """
            }
        }
    }
}

