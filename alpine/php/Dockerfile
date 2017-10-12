FROM php:7.1-fpm-alpine

RUN apk --no-cache --update add \
        make \
        wget \
        postgresql-dev \
        libxml2-dev \
        icu-dev \
    && rm -rf /tmp/* \
    && rm -rf /var/cache/apk/*

RUN docker-php-ext-configure opcache \
    && docker-php-ext-configure pdo_pgsql \
    && docker-php-ext-configure xml \
    && docker-php-ext-configure dom \
    && docker-php-ext-configure intl

# Build and install PHP extensions
RUN docker-php-ext-install opcache \
    pdo_pgsql \
    xml \
    dom \
    intl

ADD files /

EXPOSE 9001

CMD ["php-fpm"]