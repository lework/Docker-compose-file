#!/usr/bin/dumb-init /bin/sh
set -e

# Prevent core dumps
ulimit -c 0

NOMAD_DATA_DIR=${NOMAD_DATA_DIR:-"/nomad/data"}
NOMAD_CONFIG_DIR=${NOMAD_CONFIG_DIR:-"/nomad/config"}

if [ -n "$NOMAD_LOCAL_CONFIG" ]; then
    echo "$NOMAD_LOCAL_CONFIG" > "$NOMAD_CONFIG_DIR/local.json"
fi

if [ "${1:0:1}" = '-' ]; then
    set -- nomad "$@"
fi

# Look for Nomad subcommands.
if [ "$1" = 'agent' ]; then
    shift
    set -- nomad agent \
        -data-dir="$NOMAD_DATA_DIR" \
        -config="$NOMAD_CONFIG_DIR" \
        "$@"
elif [ "$1" = 'version' ]; then
    # This needs a special case because there's no help output.
    set -- nomad "$@"
elif nomad --help "$1" 2>&1 | grep -q "nomad $1"; then
    # We can't use the return code to check for the existence of a subcommand, so
    # we have to use grep to look for a pattern in the help output.
    set -- nomad "$@"
fi

# If we are running Nomad, make sure it executes as the proper user.
if [ "$1" = 'nomad' ]; then
    # If the data or config dirs are bind mounted then chown them.
    # Note: This checks for root ownership as that's the most common case.
    if [ "$(stat -c %u $NOMAD_DATA_DIR)" != "$(id -u root)" ]; then
        chown root:root $NOMAD_DATA_DIR
    fi
    if [ "$(stat -c %u $NOMAD_CONFIG_DIR)" != "$(id -u root)" ]; then
        chown root:root $NOMAD_CONFIG_DIR
    fi

    # If requested, set the capability to bind to privileged ports before
    # we drop to the non-root user. Note that this doesn't work with all
    # storage drivers (it won't work with AUFS).
    if [ ! -z ${NOMAD+x} ]; then
        setcap "cap_net_bind_service=+ep" /bin/nomad
    fi

    set -- su-exec root "$@"
fi


exec "$@"
