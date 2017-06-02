#!/bin/bash

set -e

if [ "${1:0:1}" = '-' ]; then
	set -- mysqld_safe "$@"
fi

function create_database() {
    echo -e "\e[1;48;3;33mCreating database '$MARIADB_DB'.\e[0m"
    echo "CREATE DATABASE IF NOT EXISTS $MARIADB_DB CHARACTER SET utf8 COLLATE utf8_unicode_ci;"  >> "$tempSqlFile"
}

function create_user() {
    echo -e "\e[1;48;3;33mCreating MariaDB user '$MARIADB_USER' with '$MARIADB_PASS' password.\e[0m"
    echo "CREATE USER '$MARIADB_USER'@'%' IDENTIFIED BY '$MARIADB_PASS'" >> "$tempSqlFile"
    echo "GRANT ALL PRIVILEGES ON $MARIADB_DB.* TO '$MARIADB_USER'@'%' WITH GRANT OPTION" >> "$tempSqlFile"
    echo 'FLUSH PRIVILEGES ;' >> "$tempSqlFile"
}

# User-provided env variables
MARIADB_USER=${MARIADB_USER:="admin"}
MARIADB_PASS=${MARIADB_PASS:-$(pwgen -s 12 1)}
MARIADB_DB=${MARIADB_DB:="test"}

# Other variables
VOLUME_HOME="/var/lib/mysql"
ERROR_LOG="$VOLUME_HOME/error.log"

if [ "$1" = 'mysqld_safe' ]; then
    tail -F "$ERROR_LOG" & # tail all db logs to stdout
    tempSqlFile='/tmp/mysql-first-time.sql'
    create_database
    create_user

    set -- "$@" --init-file="$tempSqlFile"
fi

exec "$@"