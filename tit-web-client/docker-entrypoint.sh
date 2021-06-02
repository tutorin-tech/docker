#!/bin/sh

set -x

export PORT="${PORT:="8001"}"

export REACT_APP_TIT_RPC_SERVER_URL="${REACT_APP_TIT_RPC_SERVER_URL}"

set +x

sed -i -e "s/PORT/${PORT}/" /etc/nginx/conf.d/default.conf

npm run build

mkdir -p /run/nginx

nginx -g "daemon off;"
