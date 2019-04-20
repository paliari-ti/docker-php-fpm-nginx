FROM paliari/php-fpm-nginx:oci8

LABEL maintainer='Marcos A Paliari <marcos@paliari.com.br>'

RUN apk update \
 && apk add --no-cache imagemagick \
 && rm -rf /var/cache/apk/*
