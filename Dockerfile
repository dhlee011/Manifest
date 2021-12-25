FROM centos7
RUN yum update
RUN yum install -y nginx
WORKDIR /etc/nginx
CMD ["nginx", "-g", "daemon off;"]
EXPOSE 80
