FROM alpine:edge

COPY root /

RUN echo http://dl-4.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories \
    && chmod +x /entrypoint

RUN apk add --update bash pwgen mongodb \
    && rm -rf /var/cache/apk/*

VOLUME /data/db /data/configdb

ENTRYPOINT ["/entrypoint"]

EXPOSE 27017 28017

CMD ["mongod"]