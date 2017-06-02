FROM centos:7

MAINTAINER Mikhail Bakulin <bakulin_m@tass.ru>

ENV TZ 'Europe/Moscow'

ADD files /

RUN yum -y update && \
    yum install -y epel-release wget

# install java
RUN cd /usr/src && wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u121-b13/e9e7ea248e2c4826b92b3f075a80e441/jdk-8u121-linux-x64.rpm"

RUN yum -y localinstall /usr/src/jdk-8u121-linux-x64.rpm
RUN rpm --import http://packages.elastic.co/GPG-KEY-elasticsearch
RUN yum -y install elasticsearch && \
    yum -y clean all

RUN rm /usr/src/jdk-8u121-linux-x64.rpm

ENV PATH /usr/share/elasticsearch/bin:$PATH
ENV ES_JAVA_OPTS="-Xms1g -Xmx1g"

WORKDIR /usr/share/elasticsearch

RUN set -ex \
	&& for path in \
		./data \
		./logs \
		./config \
		./config/scripts \
	; do \
		mkdir -p "$path"; \
		chown -R elasticsearch:elasticsearch "$path"; \
	done

EXPOSE 9200 9300

USER elasticsearch

CMD ["elasticsearch"]