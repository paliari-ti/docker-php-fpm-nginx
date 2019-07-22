FROM php:7.3-fpm-alpine3.9

LABEL maintainer='Marcos A Paliari <marcos@paliari.com.br>'

ENV fpm_conf /usr/local/etc/php-fpm.d/www.conf
ENV php_vars /usr/local/etc/php/conf.d/docker-vars.ini

ADD start.sh /start.sh

RUN apk update \
  && apk upgrade \
  && apk add --no-cache bash supervisor nginx libpng-dev g++ zlib-dev icu-dev libxml2-dev libzip-dev \
  && apk del musl-dev linux-headers libffi-dev augeas-dev python-dev make autoconf \
  && mkdir /run/nginx \
  && mkdir -p /var/log/supervisor \
  && chmod 755 /start.sh \
  && docker-php-ext-install pdo_mysql gd exif intl soap dom zip opcache \
  && echo "cgi.fix_pathinfo=0" > ${php_vars} &&\
    echo "upload_max_filesize = 100M"  >> ${php_vars} &&\
    echo "post_max_size = 100M"  >> ${php_vars} &&\
    echo "variables_order = \"EGPCS\""  >> ${php_vars} && \
    echo "memory_limit = 2048M"  >> ${php_vars} && \
    echo "short_open_tag = On"  >> ${php_vars} && \
    sed -i \
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
  && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer \
  && rm -rf /var/cache/apk/* /tmp/pear/

ADD conf/nginx-site.conf /etc/nginx/conf.d/default.conf
ADD conf/supervisord.conf /etc/supervisord.conf
ADD conf/supervisord-php-fpm.ini /etc/supervisor.d/php-fpm.ini
ADD conf/supervisord-nginx.ini /etc/supervisor.d/nginx.ini
ADD src/index.php /var/www/html/index.php
ADD conf/php-opcache.ini /usr/local/etc/php/conf.d/opcache-recommended.ini

WORKDIR /var/www/html

EXPOSE 80

CMD ["/start.sh"]
