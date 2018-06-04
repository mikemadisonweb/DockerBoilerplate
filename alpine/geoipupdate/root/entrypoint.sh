#!/usr/bin/env bash

DATABASE_DIR=${DATABASE_DIR:-/geo}
CONFIG_FILE=${CONFIG_FILE:-${DATABASE_DIR}/geoip.conf}

# Taken from Maxmind documentation: http://dev.maxmind.com/geoip/geoipupdate/
GEOIP_USER_ID=${GEOIP_USER_ID}
GEOIP_LICENSE_KEY=${GEOIP_LICENSE_KEY}
GEOIP_PRODUCT_IDS=${GEOIP_PRODUCT_IDS:-"GeoIP2-City"}

cat << EOF > ${CONFIG_FILE}
UserId ${GEOIP_USER_ID}
LicenseKey ${GEOIP_LICENSE_KEY}
ProductIds ${GEOIP_PRODUCT_IDS}
DatabaseDirectory ${DATABASE_DIR}
EOF

$@ -v -f ${CONFIG_FILE} -d ${DATABASE_DIR}