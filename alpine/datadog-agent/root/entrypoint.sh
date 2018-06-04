#!/usr/bin/env bash
export MONGO_HOST=${MONGO_HOST:="mongodb"}
export MONGO_PORT=${MONGO_PORT:="27017"}
export MONGO_USER=${MONGO_USER:="root"}
export MONGO_PASS=${MONGO_PASS:="widgets"}
export MONGO_DB=${MONGO_DB:="admin"}

export ELASTIC_HOST=${ELASTIC_HOST:="elasticsearch"}
export ELASTIC_PORT=${ELASTIC_PORT:="9200"}

export REDIS_HOST=${REDIS_HOST:="redis"}
export REDIS_PORT=${REDIS_PORT:="6379"}
export REDIS_PASS=${REDIS_PASS:="widgets"}

config_path=/etc/datadog-agent/conf.d
files=${config_path}/*.yaml.tpl
for f in ${files}
do
  base=$(basename ${f} .yaml.tpl)
  echo "Processing ${base} file..."
  envsubst < ${config_path}/${base}.yaml.tpl > ${config_path}/${base}.yaml
done
exec "$@"