#!/usr/bin/env bash
set -x
WAIT_FOR=${WAIT_FOR:=""}
WAIT_SLEEP=${WAIT_SLEEP:="2"}
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

# Database Name to backup
MONGO_DATABASE=${MONGO_DATABASE:="widgets"}
# Database host name
MONGO_HOST=${MONGO_HOST:="mongodb"}
# Database port
MONGO_PORT=${MONGO_PORT:="27017"}
# Backup directory
BACKUPS_DIR=${BACKUPS_DIR:="/var/backups/${MONGO_DATABASE}"}
# Database user name
MONGO_USERNAME=${MONGO_USERNAME:="widgets"}
# Database password
MONGO_PASSWORD=${MONGO_PASSWORD:="widgets"}
# Authentication database name
MONGO_AUTH_DB=${MONGO_AUTH_DB:="widgets"}
# FTP storage hostname
FTP_HOST=${FTP_HOST:="ftp-storage"}
# FTP user name
FTP_USERNAME=${FTP_USERNAME:="ftp-user"}
# FTP password
FTP_PASSWORD=${FTP_PASSWORD:="ftp-pass"}
# FTP directory
FTP_DIR=${FTP_DIR:="/widgets"}
# Days to keep the backup
DAYS_TO_STORE_BACKUP=${DAYS_TO_STORE_BACKUP:="14"}
#=====================================================================
TIMESTAMP=`date +%F-%H%M`
BACKUP_NAME="${MONGO_DATABASE}-${TIMESTAMP}"

echo "Performing backup of ${MONGO_DATABASE}"
echo "--------------------------------------------"
# Create backup directory
if ! mkdir -p ${BACKUPS_DIR}; then
  echo "Can't create backup directory in ${BACKUPS_DIR}. Go and fix it!" 1>&2
  exit 1;
fi;
# Create dump
mongodump --host ${MONGO_HOST} --port ${MONGO_PORT} --username ${MONGO_USERNAME} --password ${MONGO_PASSWORD} --authenticationDatabase ${MONGO_AUTH_DB} --db ${MONGO_DATABASE} --out ${BACKUP_NAME}
# Compress backup
tar -zcvf ${BACKUPS_DIR}/${BACKUP_NAME}.tar.gz ${BACKUP_NAME}
echo "Backup ${BACKUP_NAME}.tar.gz has been successfully created"
# Delete uncompressed backup
rm ${BACKUP_NAME}
echo "Removing files older than ${DAYS_TO_STORE_BACKUP} days on local machine"
find ${BACKUPS_DIR} -type f -mtime +${DAYS_TO_STORE_BACKUP} -exec rm {} +
echo "--------------------------------------------"
echo "Sending backup to persistent storage using FTP"
cd ${BACKUPS_DIR}
# Get directory listing from remote source
ftp -i -n -p ${FTP_HOST} <<END_SCRIPT
quote USER ${FTP_USERNAME}
quote PASS ${FTP_PASSWORD}
binary
cd ${FTP_DIR}
put ${BACKUP_NAME}.tar.gz
quit
END_SCRIPT
echo "--------------------------------------------"
echo "Removing files older than ${DAYS_TO_STORE_BACKUP} days on remote machine"
LIST=`ftp -i -n -p ${FTP_HOST} <<END_SCRIPT
quote USER ${FTP_USERNAME}
quote PASS ${FTP_PASSWORD}
cd ${FTP_DIR}
ls -1
quit
END_SCRIPT`
echo "Before: ${LIST}"
for FILE in ${LIST};
do
	if [[ ${FILE} != '.'* ]]; then
		PARTS=($(echo "${FILE}" | tr '-' '\n'))
		if [ $(date -d "${PARTS[1]}-${PARTS[2]}-${PARTS[3]}" +%s) -lt $(date -d "${DAYS_TO_STORE_BACKUP} days ago" +%s) ]; then
			echo "Removing ${FILE}"
			ftp -i -n -p ${FTP_HOST} <<END_SCRIPT
			quote USER ${FTP_USERNAME}
			quote PASS ${FTP_PASSWORD}
			cd ${FTP_DIR}
			delete ${FILE}
			quit
END_SCRIPT
		fi
	fi
done;
echo "After: ${LIST}"
echo "--------------------------------------------"
echo "MongoDB backup complete!"