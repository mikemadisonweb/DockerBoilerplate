#!/bin/bash
set -e

SPHINX_CONF=${SPHINX_CONF:="/etc/sphinx/sphinx.conf"}
set -- "$@" --config ${SPHINX_CONF} --safetrace --nodetach
exec "$@"