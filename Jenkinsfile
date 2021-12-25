pipeline {   
    agent any
    stages {
        stage("Git SCM"){
            steps{
            
                git branch: 'main', credentialsId: 'git-app', url: 'https://github.com/dhlee011/application.git'
            }
        }
        stage('Building Image') {
            steps{
                script{
                    slackSend(message: "Build Start!" , color: 'good', tokenCredentialId: 'slack-key')
                    app = docker.build("902268280034.dkr.ecr.ap-northeast-2.amazonaws.com/dhlee")
                    sh "git remote remove origin"
                    
                }
            }
        }
        stage('Docker Image Push To ECR') {
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
        stage('Manifest File Push To k8s-manifest Repository') {
            steps{
                script{
                    slackSend(message: "manifestfile Push To github Start!" , color: 'good', tokenCredentialId: 'slack-key')
                    withCredentials([usernamePassword(credentialsId: 'git-app', passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) {
                    sh """
                    git rm -r --cached .
                    rm -rf *
                    ls
                    #!/bin/bash
                    cat>nginx.yaml<<-EOF
                    
---
apiVersion: v1
kind: ServiceAccount
metadata:
  labels:
    app.kubernetes.io/name: alb-ingress-controller
  name: alb-ingress-controller
  namespace: nginx

---


apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app.kubernetes.io/name: alb-ingress-controller
  name: alb-ingress-controller
  namespace: nginx
spec:
  selector:
    matchLabels:
      app.kubernetes.io/name: alb-ingress-controller
  template:
    metadata:
      labels:
        app.kubernetes.io/name: alb-ingress-controller
    spec:
      containers:
        - name: alb-ingress-controller
          args:
            - --ingress-class=alb
            - --cluster-name=eks-cluster-dev
            - --aws-vpc-id=vpc-01caf96063ed0cbd9		##########
            - --aws-region=ap-northeast-2
          image: docker.io/amazon/aws-alb-ingress-controller:v1.1.3
      serviceAccountName: alb-ingress-controller                    
---

apiVersion: v1
kind: Service
metadata:
  name: nginx-service
  namespace: nginx
  annotations:
    alb.ingress.kubernetes.io/healthcheck-path: "/"
spec:
  selector:
     app: nginx
  type: NodePort
  ports:
  - port: 8080
    protocol: TCP
    targetPort: 80

---

apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx
  namespace: nginx
  labels:
    app: nginx
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx 
  template:
    metadata:
      labels:
        app: nginx 
    spec:
      containers:
      - name: nginx
        image: nginx:1.14.2
        ports:
        - containerPort: 80


---

apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  namespace: nginx
  name: nginx-ingress
  annotations:
    kubernetes.io/ingress.class: alb
    alb.ingress.kubernetes.io/scheme: internet-facing
    alb.ingress.kubernetes.io/target-type: instance
spec:
  rules:
    - http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: "nginx-service"
                port:
                  number: 8080
EOF"""

                    sh "git config --global user.name dhlee011"
                    sh "git config --global user.email dlehdgo011@naver.com"
                    sh "git remote add origin https://github.com/dhlee011/k8s-manifest"                       
                    sh "git add ."
                    sh "git commit -m '1-init'"
                    sh "git push -f https://${GIT_USERNAME}:${GIT_PASSWORD}@github.com/dhlee011/k8s-manifest.git"
                    
                    }                                                 
                }
            }
        }
    }
}
