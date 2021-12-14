pipeline {
  environment {
    imagename = "test/test2"
    dockerImage = ''
  }
  agent any
  stages {
    stage('Cloning Git') {
        checkout scm

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
