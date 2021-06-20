#!/bin/sh

set -x

export PORT="${PORT:="8004"}"

set +x

sed -i -e "s/PORT/${PORT}/" /etc/nginx/conf.d/default.conf

mkdir -p /run/nginx

nginx -g "daemon off;"
