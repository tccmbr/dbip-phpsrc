FROM php:8.1-apache

RUN apt-get update && apt-get install -y
RUN apt-get install -y libonig-dev libpng-dev zlib1g zlib1g-dev
RUN docker-php-ext-install gd mbstring pdo pdo_mysql mysqli
RUN cp /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini
COPY src/ /var/www/html/