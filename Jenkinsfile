pipeline {
    agent any
    stages {
        stage("git"){
            steps{
                git branch: 'main', credentialsId: 'dlehdgo', url: 'https://github.com/dhlee011/Gitops_Test.git'
            }
        }
        stage('Building image') {
            steps{
            sh '''
            docker info
            git clone https://github.com/dhlee011/gitops_test.git
            sleep 10
            docker build https://github.com/dhlee011/gitops_test.git#main:.
            '''
            app = docker.build("902268280034.dkr.ecr.ap-northeast-2.amazonaws.com/dhlee")
            }
        }
        stage('push image') {
            docker.withRegistry('https://902268280034.dkr.ecr.ap-northeast-2.amazonaws.com', 'ecr:ap-northeast-2:AWSC') {
                app.push("${env.BUILD_NUMBER}")
                app.push("latest")
            }  
      
        }
    }
}
