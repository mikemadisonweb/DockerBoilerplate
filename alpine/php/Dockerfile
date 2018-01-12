FROM php:7.2.1-fpm-alpine3.7

COPY root /

# Install PHP extensions
RUN apk --no-cache --update add \
        make \
        wget \
        libxml2-dev \
        icu-dev \
    && rm -rf /tmp/* \
    && rm -rf /var/cache/apk/*

RUN docker-php-ext-configure opcache \
    && docker-php-ext-configure xml \
    && docker-php-ext-configure dom \
    && docker-php-ext-configure intl

# Build and install PHP extensions
RUN docker-php-ext-install opcache \
    xml \
    dom \
    intl

# Build mongodb extension
RUN apk update && apk add autoconf openssl-dev g++ pcre-dev && \
    pecl install mongodb && \
    docker-php-ext-enable mongodb && \
    apk del --purge autoconf openssl-dev g++ pcre-dev

EXPOSE 9001

CMD ["php-fpm"]