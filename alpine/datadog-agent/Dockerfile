FROM datadog/agent

ADD root /

ENV DD_APM_ENABLED="true"

RUN apt-get update \
    && apt-get install gettext-base \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/init"]