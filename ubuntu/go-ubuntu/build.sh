#!/usr/bin/env bash
set -ex
# SET THE FOLLOWING VARIABLES
# docker hub username
USERNAME=mikemadweb
# image name
IMAGE=go-ubuntu
docker build -t $USERNAME/$IMAGE:latest .
