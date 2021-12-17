


pipeline {
    agent any
    stages {
        stage("git"){
            steps{
            
                git branch: 'main', credentialsId: 'TEST', url: 'https://github.com/dhlee011/Gitops_Test.git'
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
                    sh "git rm -r --cached ."
                    sh "cd .."
                    sh "rm -rf gitops_test"
                    sh "mkdir ww"
                    sh "cd ww"
                    sh "echo 'zzz' > zzz"
                    sh "git remote -v"
                   
                    sh "git remote add origin https://github.com/dhlee011/k8s-manifest"
                    withCredentials([usernamePassword( credentialsId : 'TEST', usernameVariable : 'dhlee011', passwordVariable : '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')]) {
                    sh "git config user.email \"dlehdgo011@naver.com\""
                    sh "git config user.name \"dhlee011\""
                    sh "git checkout main"    
                   
                    sh "git config --local credential.helper '!f() { echo username=\\dhlee011; echo password=\\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; }; f'"
  
                    sh "git add ."    
                    sh "git remote show origin"
                    sh "git remote -v"
                    sh "git config --global credential.helper store"
                    sh "git push -u origin +main"
                    }               
                }
            }
        }
    }
}
