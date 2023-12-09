

pipeline {
    agent any

    stages {
        stage('Build') { 
            steps {
                script {
                    sh './mvnw package' 
                }
            }
        }

        stage('Build image') {
            /* This builds the actual image; synonymous to
            * docker build on the command line */
            app = docker.build('skandersoltane/petclinic')
        }

        stage('Push image') {
            /* Finally, we'll push the image with two tags:
            * First, the incremental build number from Jenkins
            * Second, the 'latest' tag.
            * Pushing multiple tags is cheap, as all the layers are reused. */
            docker.withRegistry('https://registry.hub.docker.com', 'dockerhub-id') {
                app.push("${env.BUILD_NUMBER}")
                app.push('latest')
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

