FROM centos:7

MAINTAINER Mikhail Bakulin <bakulin_m@tass.ru>

ENV TZ 'Europe/Moscow'

RUN yum -y update && \
    yum install -y epel-release

# Нам нужен php для исполнения консольных команд Yii2
RUN curl "http://rpms.famillecollet.com/enterprise/remi-release-7.rpm" -o "remi-release-7.rpm" && \
    rpm -Uvh remi-release-7*.rpm

ADD files /

ENV HOME=/home/pm2
ENV PM2_HOME=/home/pm2/.pm2

RUN yum -y install nodejs npm nmap && \
    yum -y install --enablerepo="remi,remi-php71" php \
        php-common \
        php-cli \
        php-bcmath \
        php-intl \
        php-json \
        php-mbstring \
        php-mysql \
        php-pdo \
        php-xdebug  \
        php-xml \
        php-process \
        php-curl && \
    yum clean all

RUN npm install -g pm2

RUN useradd pm2 && \
    chown -R pm2:pm2 /home/pm2 && \
    usermod -u 1000 pm2

EXPOSE 3000

USER pm2

ENTRYPOINT ["/home/pm2/entrypoint.sh"]

CMD ["pm2-docker", "/var/www/spir/nodejs/docker-process.yml"]