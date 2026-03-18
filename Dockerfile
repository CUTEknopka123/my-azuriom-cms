FROM php:8.2-apache

# 1. Системные зависимости
RUN apt-get update && apt-get install -y \
    libpng-dev libjpeg-dev libfreetype6-dev zip libzip-dev unzip wget\
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd mysqli pdo pdo_mysql zip bcmath

RUN a2enmod rewrite

WORKDIR /var/www/html
RUN wget -O Azuriom.zip https://github.com/Azuriom/Azuriom/releases/download/v1.2.9/Azuriom-1.2.9.zip \
	    && unzip Azuriom.zip \
            && rm Azuriom.zip

RUN sed -i 's|/var/www/html|/var/www/html/public|g' /etc/apache2/sites-available/000-default.conf
