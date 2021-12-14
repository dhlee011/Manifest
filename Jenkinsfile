pipeline {
  agent any
  stages {
    stage('Cloning Git') {
      steps {   
        git branch: 'main', credentialsId: 'ehdgo', url: 'https://github.com/dhlee011/Gitops_Test'

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
