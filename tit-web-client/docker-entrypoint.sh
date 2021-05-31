#!/bin/sh

set -x

export PORT="${PORT:="8001"}"

set +x

sed -i -e "s/PORT/${PORT}/" /etc/nginx/conf.d/default.conf

npm run build

mkdir -p /run/nginx

nginx -g "daemon off;"
