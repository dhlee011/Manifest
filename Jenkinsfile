pipeline {
  agent any
  stages {
    stage('git pull') {
      steps {
        // https://github.com/dhlee011/Gitops_Test will replace by sed command before RUN
        git url: 'https://github.com/dhlee011/Gitops_Test', branch: 'main'
      }
    }
    stage('k8s deploy'){
      steps {
        kubernetesDeploy(kubeconfigId: 'kubeconfig',
                         configs: '*.yaml')
      }
    }    
  }
}