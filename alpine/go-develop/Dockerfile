FROM golang:1.10-alpine

COPY root /

RUN apk add --no-cache ca-certificates \
        wget \
        unzip \
        dpkg \
        git \
        curl \
        gcc \
        musl-dev \
        nmap \
        bash

ENV GOPATH="/go"
ENV PATH="$GOPATH/bin:/usr/local/go/bin:$PATH"
ENV TZ="Europe/Moscow"

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" \
    && chmod -R 777 "$GOPATH" \
    && chmod +x /entrypoint.sh

RUN go get github.com/tockins/realize \
    && go get github.com/derekparker/delve/cmd/dlv

WORKDIR $GOPATH
ENTRYPOINT ["/entrypoint.sh"]

CMD ["realize", "start"]
