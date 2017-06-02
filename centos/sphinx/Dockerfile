FROM centos:7

MAINTAINER Mikhail Bakulin <bakulin_m@tass.ru>

ENV TZ 'Europe/Moscow'

ADD files /

RUN yum -y update && \
    yum install -y epel-release

ENV SPHINX_LOG_DIR=/var/log/sphinx \
    SPHINX_CONF=/etc/sphinx/sphinx.conf \
    SPHINX_RUN=/run/sphinx/searchd.pid \
    SPHINX_DATA_DIR=/opt/sphinx/index

RUN yum install -y "http://sphinxsearch.com/files/sphinx-2.2.11-1.rhel7.x86_64.rpm" && \
    yum clean all

# binlog_path
RUN mkdir -p /opt/sphinx/logs

# Forward sphinx logs to docker log collector
#RUN ln -sf /dev/stdout ${SPHINX_LOG_DIR}/searchd.log \
#    && ln -sf /dev/stdout ${SPHINX_LOG_DIR}/query.log

EXPOSE 9312 9306

VOLUME ["${SPHINX_DATA_DIR}"]

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/bin/searchd"]