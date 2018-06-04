#!/usr/bin/env bash
WAIT_FOR=${WAIT_FOR:=""}
WAIT_SLEEP=${WAIT_SLEEP:="2"}
CEREBRO_USERNAME=${CEREBRO_USERNAME:="admin"}
CEREBRO_PASSWORD=${CEREBRO_PASSWORD:="admin"}
ES_HOST=${ES_HOST:="elasticsearch"}
ES_PORT=${ES_PORT:="9200"}
export CEREBRO_USERNAME
export CEREBRO_PASSWORD
export ES_HOST
export ES_PORT

# wait until is ready
if [ ! -z "$WAIT_FOR" ]; then
    IFS=', ' read -r -a WAIT_FOR_CONTAINER <<< "$WAIT_FOR"
    for var in "$@"
    do
        IFS=: read HOST PORT <<< "$WAIT_FOR_CONTAINER"
        while true; do
            nmap -Pn -p"$PORT" "$HOST" | awk "\$1 ~ /$PORT/ {print \$2}" | grep open
            if [ $? -eq 0 ]; then
                break
            fi
            sleep "$WAIT_SLEEP"
        done
    done
echo -e "\e[1;48;3;33mDependencies ready, starting master process.\e[0m"
fi

envsubst < /usr/cerebro/conf/application.tpl > /usr/cerebro/conf/application.conf
exec "$@"
