FROM openjdk:8-jre-alpine

ARG CEREBRO_VERSION=0.7.2

RUN set -x \
    && apk add --no-cache \
       bash \
       nmap \
       wget \
       tar \
    && cd /usr/ \
    && wget -q -O cerebro-${CEREBRO_VERSION}.tgz https://github.com/lmenezes/cerebro/releases/download/v${CEREBRO_VERSION}/cerebro-${CEREBRO_VERSION}.tgz \
    && tar zxvf cerebro-${CEREBRO_VERSION}.tgz \
    && rm cerebro-${CEREBRO_VERSION}.tgz \
    && mkdir cerebro-${CEREBRO_VERSION}/logs \
    && mv cerebro-${CEREBRO_VERSION} cerebro

COPY root /

# Install envsubst
RUN set -x \
    && apk add --update libintl \
    && apk add --virtual build_deps gettext \
    && cp /usr/bin/envsubst /usr/local/bin/envsubst \
    && apk del build_deps \
    && chmod +x /entrypoint.sh

ENV PATH /usr/cerebro/bin:${PATH}

EXPOSE 9100

ENTRYPOINT ["/entrypoint.sh"]
CMD ["cerebro", "-Dhttp.port=9100"]