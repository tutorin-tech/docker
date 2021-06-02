#!/bin/sh

set -x

export PORT="${PORT:="8002"}"

export SECRET_KEY="${SECRET_KEY}"

export TIT_API_HOST="${TIT_API_HOST:="http://127.0.0.1:8003"}"

set +x

python3 server.py --allow-mock-token --token-key="${SECRET_KEY}" --port="${PORT}" --logging=debug
