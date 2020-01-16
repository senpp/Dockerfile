# STAGE 1: INSTALL COMPOSER
FROM composer:latest as composer

# STAGE 2: PHP
FROM php:7.4.1-fpm-alpine

# Environment variables
ARG TZ=Asia/Ho_Chi_Minh

# Install requirement packages
RUN apk --update add ca-certificates tzdata \
  oniguruma-dev \
  # Reconfig TimeZone
  && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install PHP Extensions
RUN docker-php-ext-install \
  pdo \
  pdo_mysql \
  mbstring

# php.ini secured
COPY php.ini /usr/local/etc/php/php.ini

# Install composer
COPY --from=composer /usr/bin/composer /usr/bin/composer

# Cleaning...
RUN rm -rf \
    /var/cache/apk/* \
    /var/lib/apt/lists/* \
    /usr/include/php \
    /usr/lib/php/build \
    /tmp/* \
    /var/tmp/*
