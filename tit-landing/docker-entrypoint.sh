#!/bin/sh

set -x

PORT="${PORT:="8000"}"

export ALLOWED_HOSTS="${ALLOWED_HOSTS:="127.0.0.1"}"

export DEBUG="${DEBUG}"

export SECRET_KEY="${SECRET_KEY}"

export STATIC_URL="${STATIC_URL:="http://127.0.0.1:8004"}"

export TIT_API_HOST="${TIT_API_HOST:="http://127.0.0.1:8003"}"

set +x

sed -i -e "s/PORT/${PORT}/" /var/www/tit-landing/uwsgi.ini

uwsgi --ini /var/www/tit-landing/uwsgi.ini
