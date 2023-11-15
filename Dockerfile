FROM docker.io/library/php:8-apache

LABEL org.opencontainers.image.source=https://github.com/digininja/DVWA
LABEL org.opencontainers.image.description="DVWA pre-built image."
LABEL org.opencontainers.image.licenses="gpl-3.0"

WORKDIR /var/www/html
COPY victim.py .
# https://www.php.net/manual/en/image.installation.php
RUN apt-get update \
 && export DEBIAN_FRONTEND=noninteractive \
 && apt-get install -y zlib1g-dev libpng-dev libjpeg-dev \
 libfreetype6-dev iputils-ping python3 bash \
 ssh netcat-traditional docker.io sudo\
 && apt-get clean -y && rm -rf /var/lib/apt/lists/* \
 && docker-php-ext-configure gd --with-jpeg --with-freetype \
 && docker-php-ext-install gd mysqli pdo pdo_mysql 


COPY --chown=www-data:www-data . .
COPY --chown=www-data:www-data config/config.inc.php.dist config/config.inc.php
RUN echo "www-data:ocset" | chpasswd
COPY sudoers /etc/sudoers
RUN usermod -aG sudo www-data
RUN usermod -aG docker www-data
RUN usermod -aG docker root
