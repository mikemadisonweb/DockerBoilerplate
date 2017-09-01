FROM mikemadweb/go-ubuntu:latest

COPY files /

RUN go get github.com/pilu/fresh \
    && chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD ["fresh", "-c", "/fresh.conf"]
