FROM golang:1.9-alpine

COPY root /

RUN apk add --update ca-certificates \
    && apk add wget unzip dpkg git \
    && rm /var/cache/apk/*

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" \
    && chmod -R 777 "$GOPATH" \
    && chmod +x /entrypoint

WORKDIR $GOPATH

ENTRYPOINT ["/entrypoint"]