#!/bin/bash
WAIT_FOR=${WAIT_FOR:=""}
WAIT_SLEEP=${WAIT_SLEEP:="1"}

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
fi

echo -e "\e[1;48;3;33mDependencies ready, starting master process.\e[0m"
set -e
exec "$@"