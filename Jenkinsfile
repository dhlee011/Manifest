pipeline {
    agent any
    stages {
        stage("git"){
            steps{
            
                git branch: 'main', credentialsId: 'test', url: 'https://github.com/dhlee011/Gitops_Test.git'
            }
        }
        stage('Building image') {
            steps{
                script{
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
                    docker.withRegistry('https://902268280034.dkr.ecr.ap-northeast-2.amazonaws.com', 'ecr:ap-northeast-2:AWSC') {
                    app.push("${env.BUILD_NUMBER}")
                    app.push("latest")
                    
                    }                    
                }
            }
        }
        stage('push image2') {
            steps{
                script{
                    sh "mkdir ww"
                    sh "cd ww"
                    sh "echo "zzz" > zzz
                    sh "git remote -v"
                    git branch: 'main', credentialsId: 'test', url: 'https://github.com/dhlee011/k8s-manifest.git'
                    sh "git remote set-url origin https://github.com/dhlee011/k8s-manifest"
                    sh "git remote update origin --prune"
                    sh "git remote -v"
                    sh "git add ."
                    sh "git push -u origin main"
                                        
                }
            }
        }
    }
}
