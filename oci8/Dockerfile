FROM paliari/php-fpm-nginx:latest

LABEL maintainer='Marcos A Paliari <marcos@paliari.com.br>'

ENV LD_LIBRARY_PATH /usr/local/instantclient_12_2
ENV ORACLE_HOME /usr/local/instantclient

RUN apk update \
 && apk add --no-cache php7-pear php7-dev gcc musl-dev libnsl libaio make \
 && curl -L -o /tmp/basic.zip https://github.com/paliari/docker-php-fpm-nginx/blob/master/oci8/oracle/instantclient-basic-linux.x64-12.2.0.1.0.zip?raw=true \
 && curl -L -o /tmp/sdk.zip https://github.com/paliari/docker-php-fpm-nginx/blob/master/oci8/oracle/instantclient-sdk-linux.x64-12.2.0.1.0.zip?raw=true \
 && curl -L -o /tmp/sqlplus.zip https://github.com/paliari/docker-php-fpm-nginx/blob/master/oci8/oracle/instantclient-sqlplus-linux.x64-12.2.0.1.0.zip?raw=true \
 && unzip -d /usr/local/ /tmp/basic.zip \
 && unzip -d /usr/local/ /tmp/sdk.zip \
 && unzip -d /usr/local/ /tmp/sqlplus.zip \
 && ln -s /usr/local/instantclient_12_2 ${ORACLE_HOME} \
 && ln -s ${ORACLE_HOME}/libclntsh.so.* ${ORACLE_HOME}/libclntsh.so \
 && ln -s ${ORACLE_HOME}/libocci.so.* ${ORACLE_HOME}/libocci.so \
 && ln -s ${ORACLE_HOME}/lib* /usr/lib \
 && ln -s ${ORACLE_HOME}/sqlplus /usr/bin/sqlplus \
 && ln -s /usr/lib/libnsl.so.2.0.0  /usr/lib/libnsl.so \
 && echo "instantclient,${ORACLE_HOME}" | pecl install oci8 \
 && echo 'extension=oci8.so' > /usr/local/etc/php/conf.d/docker-php-ext-oci8.ini \
 && apk del php7-pear php7-dev gcc musl-dev make \
 && rm -rf /tmp/*.zip /var/cache/apk/* /tmp/pear/
