#!/bin/bash

set -x

STATIC_PORT="${STATIC_PORT:="7999"}"

BACKEND_PORT="${BACKEND_PORT:="8003"}"

TYPE="${TYPE:=backend}"

export ALLOWED_HOSTS="${ALLOWED_HOSTS:="127.0.0.1"}"

export DEBUG="${DEBUG}"

export DEFAULT_FROM_EMAIL="${DEFAULT_FROM_EMAIL:="info@tutorin.tech"}"

export EMAIL_HOST="${EMAIL_HOST}"

export EMAIL_PORT="${EMAIL_PORT:="587"}"

export EMAIL_HOST_USER="${EMAIL_HOST_USER}"

export EMAIL_HOST_PASSWORD="${EMAIL_HOST_PASSWORD}"

export EMAIL_USE_TLS="${EMAIL_USE_TLS:="true"}"

export PG_NAME="${PG_NAME:="tit-api"}"

export PG_USER="${PG_USER:="postgres"}"

export PG_PASSWORD="${PG_PASSWORD:="secret"}"

export PG_HOST="${PG_HOST:="localhost"}"

export PG_PORT="${PG_PORT:="5432"}"

export POSTGRES_PASSWORD="${POSTGRES_PASSWORD:="secret"}"

export ROCKET_CHAT_DOMAIN="${ROCKET_CHAT_DOMAIN:="https://rc.cusdeb.com/"}"

export ROCKET_CHAT_USERNAME="${ROCKET_CHAT_USERNAME}"

export ROCKET_CHAT_PASSWORD="${ROCKET_CHAT_PASSWORD}"

export ROCKET_CHAT_ROOM="${ROCKET_CHAT_ROOM:="tit-contact-us"}"

export SECRET_KEY="${SECRET_KEY}"

set +x

case "${TYPE}" in
static)
    sed -i -e "s/PORT/${STATIC_PORT}/" /etc/nginx/conf.d/default.conf

    mkdir -p /run/nginx

    nginx -g "daemon off;"

    ;;
backend)
    >&2 echo "Waiting for PostgreSQL"

    ./wait-for-it.sh -h "${PG_HOST}" -p "${PG_PORT}" -t 90 -- >&2 echo "PostgreSQL is ready"

    output="$(PGPASSWORD="${POSTGRES_PASSWORD}" psql -h "${PG_HOST}" -p "${PG_PORT}" -U "${PG_USER}" -lqt | cut -d \| -f 1 | grep "${PG_NAME}")"

    if [ "${output}" ]; then
        >&2 echo "Database ${PG_NAME} exists"
    else
        >&2 echo "Creating the ${PG_NAME} database"

        PGPASSWORD="${PG_PASSWORD}" createdb -h "${PG_HOST}" -p "${PG_PORT}" -U "${PG_USER}" "${PG_NAME}"
    fi

    python3 manage.py migrate

    sed -i -e "s/PORT/${BACKEND_PORT}/" /var/www/tit-api/uwsgi.ini

    uwsgi --ini /var/www/tit-api/uwsgi.ini

    ;;
*)
    >&2 echo "Unknown ${TYPE} service type"
    exit 1
    ;;
esac
