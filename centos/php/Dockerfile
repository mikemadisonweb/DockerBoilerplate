FROM centos:7

MAINTAINER Mikhail Bakulin <bakulin_m@tass.ru>

ENV TZ 'Europe/Moscow'

ADD files /

RUN yum -y update && \
    yum install -y epel-release

RUN curl "http://rpms.famillecollet.com/enterprise/remi-release-7.rpm" -o "remi-release-7.rpm" && \
    rpm -Uvh remi-release-7*.rpm

RUN groupadd -r www-data && useradd -r -g www-data www-data

RUN yum -y update && \
    yum -y install --enablerepo="remi,remi-php71" php php-common && \
    yum -y install --enablerepo="remi,remi-php71" php-fpm \
        php-cli \
        php-bcmath \
        php-gd \
        php-intl \
        php-json \
        php-mbstring \
        php-mcrypt \
        php-mysql \
        php-pdo \
        php-zip \
        php-memcached \
        php-process \
        php-xdebug  \
        php-tidy \
        php-xml \
        php-curl && \
        yum clean all

RUN usermod -u 1000 www-data

CMD ["php-fpm", "-F"]

EXPOSE 9000
