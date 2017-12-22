FROM alpine:3.6

RUN addgroup redis \
	&& adduser -H -D -s /bin/false -G redis redis

ARG REDIS_VERSION="4.0.6"
ARG	REDIS_DOWNLOAD_URL="http://download.redis.io/releases/redis-${REDIS_VERSION}.tar.gz"
ENV REDIS_DATA_DIR="/data"

COPY root /

RUN buildDeps='curl tar patch make gcc musl-dev linux-headers' \
	&& set -x \
	&& apk add --update $buildDeps \
	&& curl -sSL "${REDIS_DOWNLOAD_URL}" -o redis.tar.gz \
	&& mkdir -p /usr/src/redis \
	&& tar -xzf redis.tar.gz -C /usr/src/redis --strip-components=1 \
	&& rm -f redis.tar.gz \
	&& cd /usr/src/redis \
	&& make \
	&& make install \
	&& cd / \
	&& rm -rf /usr/src \
	&& apk del $buildDeps \
	&& rm -rf /var/cache/apk/* \
    && chmod +x /entrypoint

RUN apk add --update bash \
    && mkdir ${REDIS_DATA_DIR} \
    && chown redis:redis ${REDIS_DATA_DIR}

VOLUME ${REDIS_DATA_DIR}

WORKDIR ${REDIS_DATA_DIR}

EXPOSE 6379

ENTRYPOINT ["/entrypoint"]

CMD ["redis-server"]