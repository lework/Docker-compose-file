#!/usr/bin/dumb-init /bin/sh

set -e

while ping -c1 consul_init &>/dev/null; do sleep 1;echo "Wait Container"; done

echo "Container consul_init finished!"

exec /usr/local/bin/docker-entrypoint.sh "$@"
