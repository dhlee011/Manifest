FROM jenkins/jenkins:lts
USER root
RUN ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime
RUN apt upgrade -y
RUN apt-get update -y
RUN curl -fsSL get.docker.com -o get-docker.sh && sh get-docker.sh
