FROM golang:1.8-alpine

COPY files /

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN apk add --update ca-certificates \
    && apk add wget unzip dpkg git \
    && rm /var/cache/apk/*

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" \
    && chmod -R 777 "$GOPATH" \
    && chmod +x /entrypoint.sh

RUN go get github.com/pilu/fresh \
    && chmod +x /entrypoint.sh

WORKDIR $GOPATH

ENTRYPOINT ["/entrypoint.sh"]

CMD ["fresh", "-c", "/fresh.conf"]
