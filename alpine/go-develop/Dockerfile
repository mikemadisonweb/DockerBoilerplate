FROM registry.cpadev.com:4567/widgets/core/go

COPY root /

RUN apk add --update curl gcc musl-dev netcat-openbsd lsof && rm -rf /var/cache/apk/*

RUN go get github.com/tockins/realize \
    && go get github.com/derekparker/delve/cmd/dlv \
    && chmod +x /entrypoint

ENTRYPOINT ["/entrypoint"]

CMD ["realize", "start"]
