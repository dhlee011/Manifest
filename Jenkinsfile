pipeline {   
    agent any
    stages {
        stage("git"){
            steps{
            
                git branch: 'main', credentialsId: 'git-app', url: 'https://github.com/dhlee011/Gitops_Test.git'
            }
        }
        stage('Building image') {
            steps{
                script{
                    slackSend(message: "Build Start!" , color: 'good', tokenCredentialId: 'slack-key')
                    
                    sh '''
                    docker info
                    git clone https://github.com/dhlee011/gitops_test.git
                    docker build https://github.com/dhlee011/gitops_test.git#main:.
                    ls -al
                    pwd                
                    git remote remove origin
                    '''
                    app = docker.build("902268280034.dkr.ecr.ap-northeast-2.amazonaws.com/dhlee")
                    
                }
            }
        }
        stage('push image') {
            steps{
                script{
                    slackSend(message: "Docker Image Push To ECR Start!" , color: 'good', tokenCredentialId: 'slack-key')
                    docker.withRegistry('https://902268280034.dkr.ecr.ap-northeast-2.amazonaws.com', 'ecr:ap-northeast-2:AWS-KEY') {
                    app.push("${env.BUILD_NUMBER}")
                    app.push("nginx-latest")
                    
                    }                    
                }
            }
        }
        stage('push image2') {
            steps{
                script{
                    slackSend(message: "manifestfile Push To github Start!" , color: 'good', tokenCredentialId: 'slack-key')
                    git branch: 'main', credentialsId: 'git-app', url: 'https://github.com/dhlee011/application.git'
                    withCredentials([usernamePassword(credentialsId: 'git-app', passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) {
                    sh '''
                    git rm -r --cached .
                    cd ..
                    rm -rf application
                    mkdir push
                    cd push
                    git init
                    git config --global user.name dhlee011
                    git config --global user.email dlehdgo011@naver.com
                    git remote add origin https://github.com/dhlee011/k8s-manifest
                    git add .
                    git commit -m 'test-init'

                    git push -f https://${GIT_USERNAME}:${GIT_PASSWORD}@github.com/dhlee011/k8s-manifest.git                
                    '''
                    }
                   
                              
                }
            }
        }
    }
}
