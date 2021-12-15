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
                script{
                    sh '''
                    docker info
                    git clone https://github.com/dhlee011/gitops_test.git
                    docker build https://github.com/dhlee011/gitops_test.git#main:.
                    '''
                    app = docker.build("902268280034.dkr.ecr.ap-northeast-2.amazonaws.com/dhlee")
                }
            }
        }
        stage('push image') {
            steps{
                script{
                    docker.withRegistry('https://902268280034.dkr.ecr.ap-northeast-2.amazonaws.com', 'ecr:ap-northeast-2:AWSC') {
                    app.push("${env.BUILD_NUMBER}")
                    app.push("latest")
                    withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'dlehdgo', usernameVariable: 'dhlee', passwordVariable: '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']]) {

                        sh("git tag -a some_tag -m 'Jenkins'")
                        sh('git push https://${GIT_USERNAME}:${GIT_PASSWORD}@gitops_test --tags')
                        }
                    }
                }
            }
        }
    }
}
