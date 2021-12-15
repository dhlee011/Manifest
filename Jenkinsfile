pipeline {
    agent any
    environment {
        AWS_ACCOUNT_ID="902268280034"
        AWS_DEFAULT_REGION="ap-northeast-2" 
        IMAGE_REPO_NAME="dhlee"
        IMAGE_TAG="test"
        REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"
    }
    stages {
        stage("git"){
            steps{
                git branch: 'main', credentialsId: 'dlehdgo', url: 'https://github.com/dhlee011/Gitops_Test.git'
            }
        }
        stage('Logging into AWS ECR') {
            steps{        
                sh "aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com"                                 
            }
        }        
        stage('Building image') {
            steps{
            sh '''
            docker info
            git clone https://github.com/dhlee011/gitops_test.git
            sleep 10
            docker build https://github.com/dhlee011/gitops_test.git#main:.
            docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}:${IMAGE_TAG}
            '''
            }
        }
  
    }
}
