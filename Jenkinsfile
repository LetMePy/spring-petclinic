

pipeline {
    agent {
        docker {
            image 'maven:3.6.3-openjdk-17-slim' 
            args '-v /root/.m2:/root/.m2' 
        }
    }
    stages {
        stage('Build') { 
            steps {
                sh './mvnw package -X' 
            }
        }
    }
}

