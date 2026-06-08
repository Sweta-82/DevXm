pipeline {
    agent any

    environment {
        IMAGE = "sweta82/xm-app:latest"
    }

    stages {
        stage('Prepare') {
            steps {
                echo 'Preparing workspace and forcing SCM checkout for debugging'
                checkout scm
                sh '''
                  echo "Running on node: $NODE_NAME"
                  echo "Workspace: $(pwd)"
                  echo "Git branch:"; git rev-parse --abbrev-ref HEAD || true
                  echo "Files in workspace:"; ls -la || true
                '''
            }
        }

        stage('Check Docker') {
            steps {
                sh 'docker --version'
            }
        }

        stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    sh 'echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE .'
            }
        }

        stage('Push Docker Image') {
            steps {
                sh 'docker push $IMAGE'
            }
        }

    }

    post {
        always {
            sh 'docker logout || true'
        }
    }
}