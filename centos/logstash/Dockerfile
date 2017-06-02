FROM logstash

MAINTAINER Mikhail Bakulin <bakulin_m@tass.ru>

ENV TZ 'Europe/Moscow'

ADD files /
RUN chmod 755 /logstash.conf

RUN apt-get update && \
    apt-get install -y nmap

EXPOSE 5000

ENTRYPOINT ["/entrypoint.sh"]

CMD ["logstash", "-f", "/logstash.conf"]