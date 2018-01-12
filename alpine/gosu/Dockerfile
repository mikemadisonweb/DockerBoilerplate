FROM alpine:3.7

ARG GOSU_VERSION="1.10"
ARG GOSU_BASE_PATH="https://github.com/tianon/gosu/releases/download"
ARG GPG_KEYS="B42F6819007F00F88E364FD4036A9C25BF357DD4"

RUN set -x \
    && apk add --update --virtual .buildDeps \
        curl \
        dpkg \
        gnupg \
    && osArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
    && curl -sSL ${GOSU_BASE_PATH}/${GOSU_VERSION}/gosu-${osArch} -o gosu \
    && curl -sSL ${GOSU_BASE_PATH}/${GOSU_VERSION}/gosu-${osArch}.asc -o gosu.asc \
    && ( gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "${GPG_KEYS}" \
         || gpg --keyserver pgp.mit.edu --recv-keys "${GPG_KEYS}" \
         || gpg --keyserver keyserver.pgp.com --recv-keys "${GPG_KEYS}" ) \
    && gpg --batch --verify gosu.asc gosu \
    && apk del .buildDeps \
    && rm -rf /var/cache/apk/* \
    && chmod +x gosu \
    && mv gosu /usr/local/bin/gosu