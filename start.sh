#!/bin/bash

# Set custom webroot
if [ ! -z "$WEBROOT" ]; then
 sed -i "s#root /var/www/html;#root ${WEBROOT};#g" /etc/nginx/sites-available/default.conf
fi

# Start supervisord and services
exec /usr/bin/supervisord -n -c /etc/supervisord.conf
