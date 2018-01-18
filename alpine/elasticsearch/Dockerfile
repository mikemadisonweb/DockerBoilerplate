FROM alpine:3.7

ARG ES_VERSION=6.0.0
ARG ES_DIR="/opt"

RUN apk add --update openjdk8-jre openssl wget bash && \
    mkdir -p ${ES_DIR}

ENV PATH ${ES_DIR}/elasticsearch/bin:$PATH
ENV ES_JAVA_OPTS="-Xms1g -Xmx1g"

RUN wget -q -O - "https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${ES_VERSION}.tar.gz" | tar -zxf - && \
    mv -v elasticsearch-${ES_VERSION} ${ES_DIR}/elasticsearch

WORKDIR ${ES_DIR}/elasticsearch

RUN adduser -h ${ES_DIR}/elasticsearch -g elasticsearch -s /bin/bash -D elasticsearch && \
    for path in \
        ./data \
        ./logs \
        ./config \
        ./config/scripts \
    ; do \
        mkdir -p "$path"; \
        chown -R elasticsearch:elasticsearch "$path"; \
    done

USER elasticsearch

COPY root /

EXPOSE 9200 9300

VOLUME ${ES_DIR}/elasticsearch/data

CMD ["elasticsearch"]