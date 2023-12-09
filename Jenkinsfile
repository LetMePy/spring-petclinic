

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
    }
}

