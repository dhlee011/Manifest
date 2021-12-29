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
RUN sed -i '1,1000d' /etc/nginx/sites-available/default
RUN set -x \
&& echo "\
    server {\n\
      index index.php index.html;\n\
      error_log /var/log/nginx/error.log;\n\
      access_log /var/log/nginx/access.log;\n\
      root /code;\n\
\n\
      location / {\n\
          try_files $uri $uri/ /index.php?$query_string;\n\
      }\n\
\n\
      location ~ \.php$ {\n\
          try_files $uri =404;\n\
          fastcgi_split_path_info ^(.+\.php)(/.+)$;\n\
          fastcgi_pass php:9000;\n\
          fastcgi_index index.php;\n\
          include fastcgi_params;\n\
          fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;\n\
          fastcgi_param PATH_INFO $fastcgi_path_info;\n\
        }\n\
    }" > /etc/nginx/sites-available/default \
&& cat default
RUN  aws s3 cp s3://test13132/html /usr/share/nginx/html --recursive
