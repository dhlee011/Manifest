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
        docker build -t nginx github.com/dhlee011/Gitops_Test
        app = docker.build("902268280034.dkr.ecr.ap-northeast-2.amazonaws.com/test-ecr")
        '''
      }
    }

    stage('dockerfile push ') {
      steps {
        docker.withRegistry('https://902268280034.dkr.ecr.ap-northeast-2.amazonaws.com/test-ecr', 'ecr:ap-northeast-2:teichae-ecr-credentials') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
        }
      }
    }
  }
}
