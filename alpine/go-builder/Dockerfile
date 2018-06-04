FROM docker

# Go
ENV GOLANG_VERSION 1.10.1

RUN apk add --no-cache ca-certificates \
        wget \
        git \
        openssl \
        bash \
        gcc \
        make \
        musl-dev \
        go

RUN export \
        GOROOT_BOOTSTRAP="$(go env GOROOT)" \
        GOOS="$(go env GOOS)" \
        GOARCH="$(go env GOARCH)" \
        GO386="$(go env GO386)" \
        GOARM="$(go env GOARM)" \
        GOHOSTOS="$(go env GOHOSTOS)" \
        GOHOSTARCH="$(go env GOHOSTARCH)" \
    ; \
    \
    wget -q -O go.tgz "https://golang.org/dl/go$GOLANG_VERSION.src.tar.gz"; \
    echo 'a84afc9dc7d64fe0fa84d4d735e2ece23831a22117b50dafc75c1484f1cb550e *go.tgz' | sha256sum -c -; \
    tar -C /usr/local -xzf go.tgz; \
    rm go.tgz; \
    cd /usr/local/go/src; \
    ./make.bash; \
    apk del .build-deps; \
    export PATH="/usr/local/go/bin:$PATH"; \
    go version

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"

# Glide
ARG GLIDE_VERSION=0.12.3
ARG GLIDE_DOWNLOAD_URL="https://github.com/Masterminds/glide/releases/download/v${GLIDE_VERSION}/glide-v${GLIDE_VERSION}-linux-amd64.tar.gz"
ARG COMPOSE_VERSION=1.21.0
ENV GLIBC 2.23-r3

RUN wget -q -O glide.tar.gz "$GLIDE_DOWNLOAD_URL" \
    && tar -xzf glide.tar.gz \
    && mv linux-amd64/glide /usr/bin/ \
    && rm -r linux-amd64 \
    && rm glide.tar.gz

# Docker-compose
RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub && \
    wget -q https://github.com/sgerrand/alpine-pkg-glibc/releases/download/$GLIBC/glibc-$GLIBC.apk && \
    apk add --no-cache glibc-$GLIBC.apk && rm glibc-$GLIBC.apk && \
    ln -s /lib/libz.so.1 /usr/glibc-compat/lib/ && \
    ln -s /lib/libc.musl-x86_64.so.1 /usr/glibc-compat/lib

RUN wget -q -O /usr/local/bin/docker-compose https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m`  \
    && chmod +x /usr/local/bin/docker-compose