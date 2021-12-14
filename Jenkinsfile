pipeline {
  agent any
  stages {
    stage('git scm update') {
      steps {
        git url: 'https://github.com/dhlee011/Gitops_Test.git', branch: 'main'
      }
    }
    stage('dockerfile build ') {
      steps {
        sh '''
        docker info        
        docker build -t nginx https://github.com/dhlee011/Gitops_Test
        '''
      }
    }

  }
}
