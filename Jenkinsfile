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
            docker build https://github.com/dhlee011/gitops_test.git#main:dockerfile
            '''
            }
        }
  
    }
}
