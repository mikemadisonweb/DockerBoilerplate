FROM mikemadweb/go-ubuntu:latest

COPY files /

RUN go get github.com/derekparker/delve/cmd/dlv \
    && chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]