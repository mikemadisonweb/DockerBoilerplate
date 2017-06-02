FROM centos:7

MAINTAINER Mikhail Bakulin <bakulin_m@tass.ru>

ENV TZ 'Europe/Moscow'

ADD files /

# Install the basic requirements
RUN yum -y update && \
    yum -y install epel-release && \
    yum -y install pwgen wget logrotate && \
    yum -y install nss_wrapper gettext && \
    yum clean all

RUN groupadd -r rabbitmq && useradd -r -g rabbitmq rabbitmq
RUN usermod -u 1000 rabbitmq

# Setup rabbitmq-server
#RUN useradd -d /var/lib/rabbitmq -u 1001 -o -g 0 rabbitmq && \
RUN yum -y install rabbitmq-server && \
    yum clean all

RUN rabbitmq-plugins enable rabbitmq_management

# Send the logs to stdout
ENV RABBITMQ_LOGS=- RABBITMQ_SASL_LOGS=-

# Set  workdir
WORKDIR /var/lib/rabbitmq

# Set permissions for openshift run
RUN chown -R rabbitmq:rabbitmq /etc/rabbitmq /var/lib/rabbitmq /var/log/rabbitmq/ && \
    chmod -R ug+rw /etc/rabbitmq /var/lib/rabbitmq && \
    find /etc/rabbitmq -type d -exec chmod g+x {} + && \
    find /var/lib/rabbitmq -type d -exec chmod g+x {} +

RUN chown -R rabbitmq:rabbitmq /tmp/rabbitmq && \
    chmod -R ug+rwx /tmp/rabbitmq && \
    find /tmp/rabbitmq -type d -exec chmod g+x {} +

# expose some ports
# 5672 rabbitmq-server - amqp port
# 15672 rabbitmq-server - for management plugin
EXPOSE 5672 15672

ENTRYPOINT ["/entrypoint.sh"]

USER rabbitmq

CMD ["/usr/sbin/rabbitmq-server"]