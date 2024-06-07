pipeline {
    agent any 
    environment{
        DOCKERHUB_CREDENTIALS=credentials('dockerhub')
    }
    stages{
        stage('init'){
            steps{
                sh 'docker rm -f $(docker ps -aq) || true'
            }
        }
        stage('build'){
            steps{
                sh 'chmod +x deploy.sh'
                sh './deploy.sh'
            }
        }
        stage('push'){
            steps{
                sh "echo \$DOCKERHUB_CREDENTIALS_PSW | docker login -u \$DOCKERHUB_CREDENTIALS_USR --password-stdin"
                sh "docker tag lab-6-mysql:5.7 dilworth10/lab-6-sql1:latest"
                sh "docker tag lab-6-flask-app:5.7 dilworth10/lab-6-flask-app:latest"
                sh "docker push dilworth10/lab-6-sql1:latest"
                sh "docker push dilworth10/lab-6sql1:latest"
            }
        }
    }
}