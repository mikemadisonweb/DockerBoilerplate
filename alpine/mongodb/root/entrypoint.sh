#!/usr/bin/env bash

# User-provided env variables
MONGO_ROOT_USER=${MONGO_ROOT_USER:="root"}
MONGO_ROOT_PASS=${MONGO_ROOT_PASS:-$(pwgen -s 12 1)}
MONGO_USER=${MONGO_USER:="user"}
MONGO_PASS=${MONGO_PASS:="pass"}
MONGO_DATABASE=${MONGO_DATABASE:="db"}
AUTH=${AUTH:="no"}

set -m

function initdb() {
    # Wait for MongoDB to boot
    RET=1
    while [[ RET -ne 0 ]]; do
        echo "=> Waiting for confirmation of MongoDB service startup..."
        sleep 5
        mongo admin --eval "help" >/dev/null 2>&1
        RET=$?
    done

    # Create the admin user
    echo "=> Creating '${MONGO_ROOT_USER}' admin user with '${MONGO_ROOT_PASS}' password in MongoDB"
    mongo admin --eval "db.createUser({user: '${MONGO_ROOT_USER}', pwd: '${MONGO_ROOT_PASS}', roles:[{role:'root',db:'admin'}]});"
    sleep 3

    # If we've defined the MONGO_DATABASE environment variable and it's a different database
    # than admin, then create the user for that database.
    if [ "$MONGO_DATABASE" != "admin" ]; then
        echo "=> Creating '${MONGO_DATABASE}' database in MongoDB"
        echo "=> Creating '${MONGO_USER}' user with '${MONGO_PASS}' password in MongoDB"
        mongo admin -u ${MONGO_ROOT_USER} -p ${MONGO_ROOT_PASS} << EOF
    echo "Using ${MONGO_DATABASE} database"
    use ${MONGO_DATABASE}
    db.createUser({user: '${MONGO_USER}', pwd: '${MONGO_PASS}', roles:[{role:'dbOwner', db:'${MONGO_DATABASE}'}]})
    use admin;
    db.shutdownServer()
EOF
    fi
    sleep 1

    # If everything went well, add a file as a flag so we know in the future to not re-create the
    # users if we're recreating the container (provided we're using some persistent storage)
    touch /data/.mongodb_password_set
    echo "MongoDB configured successfully. Database will restart."
    exit 1
}

cmd="$@"
if [ ! -f /data/.mongodb_password_set ]; then
    $cmd &
    initdb
else
    if [ "$AUTH" == "yes" ]; then
        cmd="$cmd --auth"
    fi

    exec $cmd;
fi