pipeline {
  agent any
  stages {
    stage('git scm update') {
      steps {
        git url: 'https://github.com/dhlee011/Gitops_Test.git', branch: 'main'
      }
    }
    stage('docker build and push') {
      steps {
        sh '''
        docker info
        docker build -t 192.168.1.10:8443/echo-ip .
        docker push 192.168.1.10:8443/echo-ip
        sudo
        '''
      }
    }
  }
}
