# docker-php-fpm-nginx
Docker image of PHP 7 with fpm and nginx in alpine linux


### Versioning
| Docker Tag | Git Release | Nginx Version | PHP Version | Alpine Version |
|-----|-------|-----|--------|--------|
| latest | Master Branch |1.14.2 | 7.3.4 | 3.9 |

### Links
- [https://github.com/paliari/docker-php-fpm-nginx](https://github.com/paliari/docker-php-fpm-nginx)
- [https://hub.docker.com/r/paliari/php-fpm-nginx](https://hub.docker.com/r/paliari/php-fpm-nginx)

## Quick Start
To pull from docker hub:
```
docker pull paliari/php-fpm-nginx:latest
```
### Running
To simply run the container:
```
sudo docker run -d paliari/php-fpm-nginx

sduo docker run -p 80:80 -d -e 'WEBROOT=/var/www/html/public' -e 'SET_PHP_INI_ENV=production' -e 'PHP_MEM_LIMIT=20' -e 'PHP_POST_MAX_SIZE=10' -e 'PHP_UPLOAD_MAX_FILESIZE=10' paliari/php-fpm-nginx:latest
```

### Environments custom
| Name | Type | Default | Info | 
|-----|-----|-----|-----|
| WEBROOT | string | /var/www/html | Set custom webroot |
| PHP_MEM_LIMIT | integer | 128 | Define PHP memory limit in MB |
| PHP_POST_MAX_SIZE | integer | 100 | Define PHP post max size in MB |
| PHP_UPLOAD_MAX_FILESIZE | integer | 100 | Define PHP upload max filesize in MB |
| TIMEZONE | string | UTC | Set custom timezone |
| SET_PHP_INI_ENV | enum(development, production) | | If defined, create /usr/local/etc/php/php.ini (recommended in production) |

## Tags

### latest

[Dockerfile](https://github.com/paliari/docker-php-fpm-nginx/blob/master/nginx/Dockerfile)

```
# pull lasted
docker pull paliari/php-fpm-nginx
# or custom version
docker pull paliari/php-fpm-nginx:1.0.0
```

### oci8

Image with PHP ext oci8 configured.

[Dockerfile](https://github.com/paliari/docker-php-fpm-nginx/blob/master/oci8/Dockerfile)

```
# pull lasted
docker pull paliari/php-fpm-nginx:oci8
# or custom version
docker pull paliari/php-fpm-nginx:1.0.0-oci8
```

### imagemagick

Image with imagemagick installed in OS.

[Dockerfile](https://github.com/paliari/docker-php-fpm-nginx/blob/master/imagemagick/Dockerfile)

```
# pull lasted
docker pull paliari/php-fpm-nginx:imagemagick
# or custom version
docker pull paliari/php-fpm-nginx:1.0.0-imagemagick
```
