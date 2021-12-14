pipeline {
  agent any
  stages {
    stage('git scm update') {
      steps {
        git url: 'https:/dhlee011/Gitops_test.git', branch: 'main'
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
