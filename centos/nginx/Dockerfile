FROM centos:7

MAINTAINER Mikhail Bakulin <bakulin_m@tass.ru>

ENV TZ 'Europe/Moscow'

ADD files /

RUN groupadd -r www-data && useradd -r -g www-data www-data

# Install Nginx
RUN curl -O "http://nginx.org/keys/nginx_signing.key"
RUN rpm --import nginx_signing.key
RUN yum update -y && \
    yum install -y epel-release && \
    yum install -y nginx nmap

ENTRYPOINT ["/entrypoint.sh"]
CMD ["nginx"]

RUN usermod -u 1000 www-data

EXPOSE 80
EXPOSE 443