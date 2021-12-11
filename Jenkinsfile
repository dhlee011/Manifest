node {
     stage('Clone repository') {
         checkout scm
     }
     stage('Build image') {
         app = docker.build("teichae/jenkins")
     }
     stage('Push image') {
         withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'dhlee011', usernameVariable: 'dhlee011', passwordVariable: 'dltk5maxwell2@']]) {

    sh("git tag -a some_tag -m 'Jenkins'")
    sh('git push https://${GIT_USERNAME}:${GIT_PASSWORD}@github.com/dhlee011/Gitops_Test.git')
     }
       
 }
