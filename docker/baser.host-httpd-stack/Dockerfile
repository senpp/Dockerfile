FROM php:7.1.33-apache-buster

LABEL version="1.0.0",maintainer="phuongthephung@gmail.com"

ENV TZ Asia/Ho_Chi_Minh
ARG REDIS_VERSION=5.0.1
ARG APCU_VERSION=5.1.17
ARG APCU_BC_VERSION=1.0.5

# Install requirement packages
RUN apt-get update -qqy \
  && apt-get install -qqy \
  apt-utils ca-certificates software-properties-common apt-transport-https lsb-release \
  acl \
  openssl \
  tzdata \
  libbz2-dev libicu-dev libmcrypt-dev libfreetype6-dev libjpeg-dev libwebp-dev libjpeg62-turbo-dev \
  libpng-dev libxpm-dev libapache2-mod-xsendfile \
  && echo "Asia/Ho_Chi_Minh" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata \
  && echo 'alias ll="ls -lah --color=auto"' >> /etc/bash.bashrc \
  && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install PHP Extensions
RUN docker-php-ext-configure intl \
  && docker-php-ext-configure gd \
    --with-gd --with-webp-dir --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    --with-png-dir --with-zlib-dir --with-xpm-dir \
    --enable-gd-native-ttf \
  && docker-php-ext-install \
      iconv \
      mcrypt \
      intl \
      pdo \
      pdo_mysql \
      mbstring \
      zip \
      gd \
      exif \
      bz2

# Install PHP Pecl Extensions
RUN pecl install redis-$REDIS_VERSION \
  && docker-php-ext-enable redis \
  && pecl install apcu-$APCU_VERSION \
  && docker-php-ext-enable apcu \
  && pecl install apcu_bc-$APCU_BC_VERSION \
  && docker-php-ext-enable apc \
  && rm -f /usr/local/etc/php/conf.d/docker-php-ext-apc.ini \
  && rm -f /usr/local/etc/php/conf.d/docker-php-ext-apcu.ini

# Optimizing Apache2
ADD apache2/conf/security.conf /etc/apache2/conf-available/
RUN a2enmod \
  # Enable required modules
  ssl \
  rewrite \
  headers \
  xsendfile \
  # Disable default sites
  && a2dissite 000-default default-ssl \
  && mkdir -p /var/lock/apache2 \
  && mkdir -p /var/run/apache2

# Optimizing PHP
COPY php/php.ini /usr/local/etc/php/php.ini
ADD php/exts/*.ini /usr/local/etc/php/conf.d/

# Cleaning...
RUN apt-get clean \
  && pecl clear-cache \
  && rm -rf \
    /var/lib/apt/lists/* \
    /usr/include/php \
    /usr/lib/php/build \
    /tmp/* \
    /var/tmp/*