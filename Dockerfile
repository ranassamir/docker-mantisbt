# 
# Dockerfile for mantisbt 
# 
FROM php:7-apache
MAINTAINER Ranassamir Lobo <ranassamir@gmail.com> 
RUN a2enmod rewrite
RUN set -xe \
    && apt-get update \
    && apt-get install -y libpng12-dev libjpeg-dev libpq-dev libxml2-dev \
    && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
    && docker-php-ext-install gd mbstring mysqli pdo pdo_mysql pdo_pgsql soap \
    && rm -rf /var/lib/apt/lists/*
ENV MANTIS_VER 2.6.0 
ENV MANTIS_MD5 b37ab5fa125e919d86734d349ad87c51 
ENV MANTIS_URL https://ufpr.dl.sourceforge.net/project/mantisbt/mantis-stable/${MANTIS_VER}/mantisbt-${MANTIS_VER}.tar.gz
ENV MANTIS_FILE mantisbt.tar.gz 
RUN set -xe \
    && curl -fSL ${MANTIS_URL} -o ${MANTIS_FILE} \
    && echo "${MANTIS_MD5}  ${MANTIS_FILE}" | md5sum -c \
    && tar -xz --strip-components=1 -f ${MANTIS_FILE} \
    && rm ${MANTIS_FILE} \
    && chown -R www-data:www-data .
RUN set -xe \
    && ln -sf /usr/share/zoneinfo/America/Bahia /etc/localtime \
    && echo 'date.timezone = "America/Bahia"' > /usr/local/etc/php/php.ini