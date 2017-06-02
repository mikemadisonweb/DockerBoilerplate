FROM centos:7

MAINTAINER Mikhail Bakulin <bakulin_m@tass.ru>

ENV TZ 'Europe/Moscow'

ADD files /

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r memcache && useradd -r -g memcache memcache

RUN yum update -y && \
    yum install -y epel-release && \
    yum install -y memcached

USER memcache

EXPOSE 11211

CMD ["memcached"]