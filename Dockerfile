FROM ubuntu:18.04
RUN apt-get update
RUN apt-get install -y nginx
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:ondrej/php
RUN apt-get update
RUN apt-get install -y php7.4-fpm
RUN apt-get install -y php7.4
RUN ls -al /etc/nginx/sites-available
WORKDIR /etc/nginx/sites-available
RUN cat default

