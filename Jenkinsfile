


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

                    sh "cd .."
                    sh "git rm --cached gitops_test"
                    sh "rm -rf gitops_test"
                    sh "mkdir ww"
                    sh "cd ww"
                    sh "echo 'zzz' > zzz"
                    sh "git remote -v"
                    
                    git branch: 'main', credentialsId: 'test', url: 'https://github.com/dhlee011/k8s-manifest.git'
                                                      
                    sh "git add ."
                    sh "git commit -m "    
                    sh "git push https://${GIT_AUTHOR_NAME}:${GIT_PASSWORD}@https://github.com/dhlee011/k8s-manifest"
                    sh "git remote update origin --prune"
                    sh "git remote show origin"
                    sh "git remote -v"
                    
                    sh "git push https://github.com/dhlee011/k8s-manifest main"
                                   
                }
            }
        }
    }
}
