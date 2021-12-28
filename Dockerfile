FROM ubuntu:14.04
RUN apt-get update
RUN apt-get install -y nginx
RUN apt-get install -y software-properties-common
RUN apt-get install -y php-fpm
RUN add-apt-repository -y ppa:ondrej/php
RUN apt-get update
RUN apt-get install -y php7.4

WORKDIR /etc/nginx
CMD ["nginx", "-g", "daemon off;"]
EXPOSE 80
