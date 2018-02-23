FROM php:5.4-fpm

RUN DEBIAN_FRONTEND=noninteractive apt-get update -q
RUN DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        libmcrypt-dev \
        libcurl4-nss-dev \
        libc-client-dev libkrb5-dev \
        zlib1g-dev libicu-dev g++

# Set timezone
RUN rm /etc/localtime
RUN ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime
RUN "date"

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl
RUN docker-php-ext-install iconv mysqli pdo pdo_mysql mcrypt intl gd curl imap

EXPOSE 9000

WORKDIR /var/www/html
CMD ["/usr/local/sbin/php-fpm", "--nodaemonize"]
