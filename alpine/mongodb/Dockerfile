FROM frolvlad/alpine-glibc:alpine-3.7

ARG MONGODB_VERSION="3.6.1"
ARG	MONGODB_DOWNLOAD_URL="https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-${MONGODB_VERSION}.tgz"
ENV MONGODB_INSTALL_DIR="/usr/src/mongo"
ENV MONGODB_DATA_DIR="/data"

COPY root /

RUN buildDeps='curl tar' \
    && set -x \
    && apk add --update $buildDeps \
	&& curl -sSL "${MONGODB_DOWNLOAD_URL}" -o mongo.tar.gz \
	&& mkdir -p ${MONGODB_INSTALL_DIR} \
	&& tar -xzf mongo.tar.gz -C ${MONGODB_INSTALL_DIR} --strip-components=1 \
	&& rm -f mongo.tar.gz \
	&& cd ${MONGODB_INSTALL_DIR} \
	&& apk del $buildDeps \
	&& rm -rf /var/cache/apk/* \
    && chmod +x /entrypoint.sh

RUN apk add --update bash pwgen \
    && adduser -h ${MONGODB_INSTALL_DIR} -g mongo -s /bin/bash -D mongo \
    && for path in \
        ${MONGODB_DATA_DIR} \
        ${MONGODB_DATA_DIR}/db \
        ${MONGODB_DATA_DIR}/configdb \
        ${MONGODB_INSTALL_DIR} \
    ; do \
        mkdir -p "$path"; \
        chown -R mongo:mongo "$path"; \
    done \
    && chown -R mongo:mongo /entrypoint.sh

ENV PATH ${MONGODB_INSTALL_DIR}/bin:${PATH}

VOLUME ${MONGODB_DATA_DIR}/db ${MONGODB_DATA_DIR}/configdb

USER mongo

EXPOSE 27017 28017

ENTRYPOINT ["/entrypoint.sh"]

CMD ["mongod", "--bind_ip", "0.0.0.0"]