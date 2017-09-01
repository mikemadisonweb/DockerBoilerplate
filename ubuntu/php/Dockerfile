FROM ubuntu:16.04

ENV LANG=C.UTF-8

RUN echo 'Europe/Moscow' | tee /etc/timezone \
    && apt-get -yq update \
    && apt-get -yq install software-properties-common \
    && add-apt-repository ppa:ondrej/php \
    && apt-get -yq update \
    && apt-get -yq install php7.1 \
        php7.1-common \
        php7.1-fpm \
        php7.1-cli \
        php7.1-mysql \
        php7.1-xml \
        php7.1-dom \
        php7.1-intl \
        php7.1-xdebug \
    && mkdir -p /var/run/php

ADD files /

EXPOSE 9000

CMD ["php-fpm7.1"]