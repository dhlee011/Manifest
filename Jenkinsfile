pipeline {   
    agent any
    stages {
        stage("git"){
            steps{
            
                git branch: 'main', credentialsId: 'git-app', url: 'https://github.com/dhlee011/application.git'
            }
        }
        stage('Building image') {
            steps{
                script{
                    slackSend(message: "Build Start!" , color: 'good', tokenCredentialId: 'slack-key')
                    
                    sh '''
                    docker info

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
                    git branch: 'main', credentialsId: 'git-app', url: 'https://github.com/dhlee011/k8s-manifest.git'
                    withCredentials([usernamePassword(credentialsId: 'git-app', passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) {
                    sh """
                    ls
                    
                    pwd
                    git rm -r --cached .
                    cd ..
                    rm -rf nginx
                    mkdir push
                    cd push
                    #!/bin/bash
                    cat>deployment.yaml<<-EOF
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: cb-test-api
  namespace: prd-api
spec:
  replicas: 1
  template:
    metadata:
      labels:
        app: cb-test-api
    spec:
      containers:
      - image: nginx
        imagePullPolicy: Always
        name: cb-test-api
        ports:
        - containerPort: 9000
EOF"""
                    sh "ls"
                    sh "pwd"
                    sh "git add ."
                    sh "git commit -m '1-init'"
                    


                    sh "git push -f https://${GIT_USERNAME}:${GIT_PASSWORD}@github.com/dhlee011/k8s-manifest.git"
                    }                                                 
                }
            }
        }
    }
}
