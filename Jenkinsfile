pipeline {
  environment {
    imagename = "yenigul/hacicenkins"
    dockerImage = ''
  }
  agent any
  stages {
    stage('Cloning Git') {
      steps {
        git([url: 'https://github.com/dhlee011/Gitops_Test.git', branch: 'main', credentialsId: 'dhlee011'])

      }
    }
    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build imagename
        }
      }
    }

  }
}
