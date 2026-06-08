pipeline {
    agent any

    environment {
        IMAGE = "sweta82/xm-app:latest"
    }

    stages {

        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }
        stage('Docker Login') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'docker-credentials',
                        usernameVariable: 'DOCKER_USERNAME',
                        passwordVariable: 'DOCKER_PASSWORD'
                    )
                ]) {
                    sh '''
                        echo "$DOCKER_PASSWORD" | docker login \
                        -u "$DOCKER_USERNAME" \
                        --password-stdin
                    '''
                }
            }
        }

        stage('Build Image') {
            steps {
                sh '''
                    docker build -t $IMAGE .
                '''
            }
        }

        stage('Push Image') {
            steps {
                sh '''
                    docker push $IMAGE
                '''
            }
        }
    }
}