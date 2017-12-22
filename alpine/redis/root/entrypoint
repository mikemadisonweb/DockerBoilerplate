#!/usr/bin/env bash

# User-provided env variables
REDIS_CONFIG=${REDIS_CONFIG:="/etc/redis/redis.conf"}

cmd="$@ ${REDIS_CONFIG}"

if [ -n "${REDIS_PASSWORD}" ]; then
    echo "Password is set to ${REDIS_PASSWORD}"
    cmd="$cmd --requirepass ${REDIS_PASSWORD}"
fi

exec $cmd;