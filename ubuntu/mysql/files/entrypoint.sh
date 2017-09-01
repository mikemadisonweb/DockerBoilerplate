#!/bin/bash

set -e

# User-provided env variables
MYSQL_USER=${MYSQL_USER:="admin"}
MYSQL_PASS=${MYSQL_PASS:-$(pwgen -s 12 1)}
MYSQL_DB=${MYSQL_DB:="test"}

if [ "${1:0:1}" = '-' ]; then
	set -- mysqld_safe "$@"
fi

function create_database() {
    echo -e "\e[1;48;3;33mCreating database '$MYSQL_DB'.\e[0m"
    echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DB CHARACTER SET utf8 COLLATE utf8_unicode_ci;"  >> "$tempSqlFile"
}

function create_user() {
    echo -e "\e[1;48;3;33mCreating MariaDB user '$MYSQL_USER' with '$MYSQL_PASS' password.\e[0m"
    echo "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASS';" >> "$tempSqlFile"
    echo "GRANT ALL PRIVILEGES ON $MYSQL_DB.* TO '$MYSQL_USER'@'%' WITH GRANT OPTION;" >> "$tempSqlFile"
    echo 'FLUSH PRIVILEGES ;' >> "$tempSqlFile"
}

tempSqlFile='/tmp/mysql-first-time.sql'
create_database
create_user

exec "$@" --init-file="$tempSqlFile"