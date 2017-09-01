FROM ubuntu:16.04

ARG DEBIAN_FRONTEND=noninteractive
ARG PG_VERSION=9.6

ENV TZ "Europe/Moscow"
ENV LANG "en_US.UTF-8"
ENV PGBASE "/var/lib/postgresql"
ENV PGDATA "${PGBASE}/${PG_VERSION}/main"
ENV PG_BINDIR "/usr/lib/postgresql/${PG_VERSION}/bin"
ENV PG_CONFIG_DIR "/etc/postgresql/${PG_VERSION}/main"
ENV PG_CONFIG_FILE "${PG_CONFIG_DIR}/postgresql.conf"

COPY files /

RUN echo ${TZ} | tee /etc/timezone \
    && chmod +x /entrypoint.sh \
    && apt-get update \
    && apt-get install -yq software-properties-common python-software-properties wget \
    && add-apt-repository -y "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main" \
    && wget --quiet -O - "https://www.postgresql.org/media/keys/ACCC4CF8.asc" | apt-key add - \
    && apt-get update \
    && apt-get install -yq locales \
    && locale-gen ${LANG} \
    && update-locale LANG=${LANG} \
    && apt-get install -yq \
        postgresql-${PG_VERSION} \
        postgresql-contrib-${PG_VERSION} \
        pwgen \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/*

RUN rm -rf ${PGBASE} \
    && mkdir -p ${PGBASE} \
    && mkdir -p /var/run/postgresql/${PG_VERSION}-main.pg_stat_tmp \
    && chown -R postgres:postgres ${PGBASE} \
    && chown -R postgres:postgres /var/run/postgresql \
    && chmod g+s /var/run/postgresql

RUN echo "host all  all    0.0.0.0/0  md5" >> ${PG_CONFIG_DIR}/pg_hba.conf \
  && echo "host all  all    ::/0  md5" >> ${PG_CONFIG_DIR}/pg_hba.conf \
  && echo "listen_addresses='*'" >> ${PG_CONFIG_FILE}

USER postgres

VOLUME ["${PGBASE}"]

EXPOSE 5432

ENTRYPOINT ["/entrypoint.sh"]

CMD ${PG_BINDIR}/postgres -D ${PGDATA} -c config_file=${PG_CONFIG_FILE}