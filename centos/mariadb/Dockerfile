FROM centos:7

MAINTAINER Mikhail Bakulin <bakulin_m@tass.ru>

ENV TZ 'Europe/Moscow'

COPY files /

RUN yum update -y && \
    yum install -y epel-release && \
    yum install -y MariaDB-server hostname net-tools pwgen && \
    yum clean all

ENTRYPOINT ["/entrypoint.sh"]

# Place VOLUME statement below all changes to /var/lib/mysql
VOLUME "/var/lib/mysql"

EXPOSE 3306

CMD ["mysqld_safe"]
