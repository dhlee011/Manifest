FROM ubuntu:18.04
RUN apt-get update
RUN apt-get install -y nginx
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:ondrej/php
RUN apt-get update
RUN apt-get install -y php7.4-fpm
RUN apt-get install -y php7.4
RUN sed -i 's/user = apache */user = nginx/' /etc/php/7.4/fpm/pool.d/www.conf
RUN sed -i 's/group = apache */group = nginx/' /etc/php/7.4/fpm/pool.d/www.conf
RUN sed -i 's/;listen.owner = nobody */listen.owner = nginx/' /etc/php/7.4/fpm/pool.d/www.conf
RUN sed -i 's/;listen.group = nobody */listen.group = nginx/' /etc/php/7.4/fpm/pool.d/www.conf
RUN sed -i 's/listen = 127.0.0.1:9000 */listen = \/var\/run\/php-fpm\/php-fpm.sock/' /etc/php/7.4/fpm/pool.d/www.conf
RUN sed -i '/location/d' /etc/nginx/conf.d/default.conf
RUN sed -i '/}/d' /etc/nginx/conf.d/default.conf
RUN sed -i "2d" /etc/nginx/conf.d/default.conf
RUN echo "index index.php index.html index.htm;" >> /etc/nginx/conf.d/default.conf
WORKDIR /usr/share/nginx/html
COPY /home/ec2-user/html /usr/share/nginx/html

WORKDIR /etc/nginx
CMD ["nginx", "-g", "daemon off;"]
EXPOSE 80
