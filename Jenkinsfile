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
            '''
            }
        }
  
    }
}
