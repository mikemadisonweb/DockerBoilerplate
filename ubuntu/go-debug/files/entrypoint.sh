#!/usr/bin/env bash
GO_WORK_DIR=${GO_WORK_DIR:-$GOPATH/src}
cd ${GO_WORK_DIR}
dlv debug --headless --accept-multiclient --listen=:2345 --log --api-version=2