FROM centos:7

MAINTAINER Mikhail Bakulin <bakulin_m@tass.ru>

ENV TZ 'Europe/Moscow'

ADD files /

RUN yum -y install epel-release && \
    yum -y update && \
    yum -y upgrade && \