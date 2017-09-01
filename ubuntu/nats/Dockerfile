FROM mikemadweb/go-ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive

ENV NATS_VERSION 1.0.2

COPY files /

RUN apt-get update \
    && apt-get install -yq unzip

RUN set -eux; \
	dpkgArch="$(dpkg --print-architecture)"; \
	case "${dpkgArch##*-}" in \
		amd64) goRelArch='linux-amd64'; goRelSha256='1862f4c3d3907e59b04a757cfda0ea7aa9ef39274af99a784f5be843c80c6772' ;; \
		armhf) goRelArch='linux-armv6l'; goRelSha256='3c30a3e24736ca776fc6314e5092fb8584bd3a4a2c2fa7307ae779ba2735e668' ;; \
		i386) goRelArch='linux-386'; goRelSha256='ff4895eb68fb1daaec41c540602e8bb4c1e8bb2f0e7017367171913fc9995ed2' ;; \
		ppc64el) goRelArch='linux-ppc64le'; goRelSha256='e5fb00adfc7291e657f1f3d31c09e74890b5328e6f991a3f395ca72a8c4dc0b3' ;; \
		s390x) goRelArch='linux-s390x'; goRelSha256='e2ec3e7c293701b57ca1f32b37977ac9968f57b3df034f2cc2d531e80671e6c8' ;; \
		*) goRelArch='src'; goRelSha256='5f5dea2447e7dcfdc50fa6b94c512e58bfba5673c039259fd843f68829d99fa6'; \
			echo >&2; echo >&2 "warning: current architecture ($dpkgArch) does not have a corresponding Go binary release; will be building from source"; echo >&2; \
	esac; \
	url="https://github.com/nats-io/gnatsd/releases/download/v${NATS_VERSION}/gnatsd-v${NATS_VERSION}-${goRelArch}.zip"; \
	wget -O nats.zip "$url"; \
	unzip -p nats.zip gnatsd-v${NATS_VERSION}-${goRelArch}/gnatsd > /usr/local/go/bin/gnatsd; \
	chmod +x /usr/local/go/bin/gnatsd; \
	rm nats.zip;

ENTRYPOINT ["gnatsd"]

EXPOSE 4222 8222 6222

# -DV, log and trace / -m, monitoring port / -c, configuration file
CMD ["-m", "8222", "-c", "/gnatsd.conf"]