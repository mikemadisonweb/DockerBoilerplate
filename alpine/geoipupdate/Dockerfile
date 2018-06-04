FROM alpine:3.7

ARG VERSION=2.5.0

COPY root /

ENV DATABASE_DIR=/geo
ENV CONFIG_FILE=${DATABASE_DIR}/geoip.conf

RUN apk add --no-cache \
        bash \
        wget \
        build-base \
        openssh-client \
        ca-certificates \
        file \
        zlib-dev \
        curl-dev \
    && wget https://github.com/maxmind/geoipupdate/releases/download/v${VERSION}/geoipupdate-${VERSION}.tar.gz \
    && tar zxvf geoipupdate-${VERSION}.tar.gz \
    && cd geoipupdate-${VERSION} \
    && ./configure \
    && make \
    && make install \
    && cd .. \
    && rm -rf ./geoipupdate-${VERSION} \
    && mkdir /geo \
    && chown -R 1000:1000 /geo \
    && chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD ["geoipupdate"]