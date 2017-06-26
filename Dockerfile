FROM php:7.0.8-apache
RUN docker-php-ext-install mysqli
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
    && docker-php-ext-install -j$(nproc) iconv mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd
RUN a2enmod rewrite
RUN mkdir /var/www/my_project/
COPY my_project.conf /etc/apache2/sites-available/
RUN a2ensite my_project
RUN service apache2 restart
