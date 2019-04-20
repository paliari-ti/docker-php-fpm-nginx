#!/bin/bash

# Set custom webroot
if [ ! -z "$WEBROOT" ]; then
 sed -i "s#root /var/www/html;#root ${WEBROOT};#g" /etc/nginx/conf.d/default.conf
fi

# Set php.ini
if [ ! -z "$SET_PHP_INI_ENV" ]; then
	if [ -f "/usr/local/etc/php/php.ini-${SET_PHP_INI_ENV}" ]; then
		cp -f "/usr/local/etc/php/php.ini-${SET_PHP_INI_ENV}" /usr/local/etc/php/php.ini
    fi
fi

# Start supervisord and services
exec /usr/bin/supervisord -n -c /etc/supervisord.conf
