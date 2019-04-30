FROM php:7.3-fpm

LABEL maintainer="Marcos Paliari <marcos@paliari.com.br>"

ENV fpm_conf /usr/local/etc/php-fpm.d/www.conf

COPY start.sh /start.sh

RUN apt-get update && apt-get -y install wget bsdtar libaio1 curl git zlib1g-dev libzip-dev \
  && wget -qO- https://github.com/paliari/docker-php7-apache/raw/master/oracle/instantclient-basic-linux.x64-12.2.0.1.0.zip | bsdtar -xvf- -C /usr/local \
  && wget -qO- https://github.com/paliari/docker-php7-apache/raw/master/oracle/instantclient-sdk-linux.x64-12.2.0.1.0.zip | bsdtar -xvf- -C /usr/local \
  && wget -qO- https://github.com/paliari/docker-php7-apache/raw/master/oracle/instantclient-sqlplus-linux.x64-12.2.0.1.0.zip | bsdtar -xvf- -C /usr/local \
  && ln -s /usr/local/instantclient_12_2 /usr/local/instantclient \
  && ln -s /usr/local/instantclient/libclntsh.so.* /usr/local/instantclient/libclntsh.so \
  && ln -s /usr/local/instantclient/lib* /usr/lib \
  && ln -s /usr/local/instantclient/sqlplus /usr/bin/sqlplus \
  && docker-php-ext-configure oci8 --with-oci8=instantclient,/usr/local/instantclient \
  && docker-php-ext-install oci8 \
  && docker-php-ext-install pdo_mysql exif opcache \
  && apt-get install -y libicu-dev libaio-dev libxml2-dev libjpeg-dev libpng-dev libfreetype6-dev \
  && docker-php-ext-install intl soap dom \
  && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
  && docker-php-ext-install gd \
  && docker-php-ext-install zip \
  && apt-get install -y imagemagick nginx supervisor \
  && apt-get purge -y --auto-remove \
  && apt-get clean -y \
  && rm -rf /var/lib/apt/lists/* \
  && mkdir -p /var/www/html/public \
  && chmod +x /start.sh \
  && sed -i \
        -e "s/;catch_workers_output\s*=\s*yes/catch_workers_output = yes/g" \
        -e "s/pm.max_children = 5/pm.max_children = 4/g" \
        -e "s/pm.start_servers = 2/pm.start_servers = 3/g" \
        -e "s/pm.min_spare_servers = 1/pm.min_spare_servers = 2/g" \
        -e "s/pm.max_spare_servers = 3/pm.max_spare_servers = 4/g" \
        -e "s/;pm.max_requests = 500/pm.max_requests = 200/g" \
        -e "s/user = www-data/user = nginx/g" \
        -e "s/group = www-data/group = nginx/g" \
        -e "s/;listen.mode = 0660/listen.mode = 0666/g" \
        -e "s/;listen.owner = www-data/listen.owner = nginx/g" \
        -e "s/;listen.group = www-data/listen.group = nginx/g" \
        -e "s/listen = 127.0.0.1:9000/listen = \/var\/run\/php-fpm.sock/g" \
        -e "s/^;clear_env = no$/clear_env = no/" \
        ${fpm_conf} \
  && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY conf/vars.ini /usr/local/etc/php/conf.d/vars.ini
COPY src/index.php /var/www/html/public/index.php

ADD conf/nginx-site.conf /etc/nginx/sites-available/default
ADD conf/supervisord-php-fpm.ini /etc/conf.d/php-fpm.ini
ADD conf/supervisord-nginx.ini /etc/conf.d/nginx.ini

EXPOSE 80
EXPOSE 443

WORKDIR /var/www/html

ENTRYPOINT ["docker-php-entrypoint"]

CMD ["/start.sh"]
