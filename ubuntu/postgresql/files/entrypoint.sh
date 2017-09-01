#!/usr/bin/env bash

set -m

PG_ROOT_PASSWORD_FILE=${PGBASE}/pwfile
PG_ROOT_PASSWORD=${PG_ROOT_PASSWORD:-$(pwgen -c -n -1 16)}
PG_USER=${PG_USER:="user"}
PG_PASS=${PG_PASS:="pass"}
PG_DATABASE=${PG_DATABASE:="test"}

init() {
    # Ensure that database has been loaded
    sleep 3
    psql << EOF
        CREATE USER ${PG_USER} WITH PASSWORD '$PG_PASS';
        CREATE DATABASE ${PG_DATABASE} OWNER ${PG_USER};
EOF
}

if [ ! -d "$PGDATA" ]; then
    echo "${PG_ROOT_PASSWORD}" > ${PG_ROOT_PASSWORD_FILE}
    chmod 600 ${PG_ROOT_PASSWORD_FILE}

    ${PG_BINDIR}/initdb --locale ${LANG} -D ${PGDATA} --pwfile ${PG_ROOT_PASSWORD_FILE} \
        --username postgres --encoding UTF8 --auth trust

    echo "*************************************************************************"
    echo " PostgreSQL password is ${PG_ROOT_PASSWORD}"
    echo "*************************************************************************"

    unset PG_ROOT_PASSWORD

    exec "$@" &
    init
    echo "*************************************************************************"
    echo "User ${PG_USER} and database ${PG_DATABASE} was successfully created"
    echo "*************************************************************************"

    fg
fi

exec "$@"