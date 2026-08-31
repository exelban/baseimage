#!/bin/sh

cd /srv || exit 1

if [ "$(id -u)" -ne 0 ]; then
    exec /bin/sh
fi

exec su-exec "${USER:-app}" /bin/sh
