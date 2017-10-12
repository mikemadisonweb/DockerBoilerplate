#!/usr/bin/env sh

GO_WORK_DIR=${GO_WORK_DIR:-$GOPATH/src}
cd ${GO_WORK_DIR}
sleep 1

set -e
exec "$@"