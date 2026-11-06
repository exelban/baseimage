#!/sbin/tini /bin/sh

export TZ="${TIME_ZONE:-Etc/UTC}"

if [ -f "/srv/init.sh" ]; then
    echo "executing /srv/init.sh"
    if [ ! -x /srv/init.sh ]; then
        echo "init.sh must be executable"
        exit 1
    fi
    if [ "$(id -u)" -eq 0 ]; then
        su-exec "$USER" /srv/init.sh
    else
        /srv/init.sh
    fi
    if [ $? -ne 0 ]; then
        echo "init.sh failed"
        exit 1
    fi
fi

if [ $# -eq 0 ]; then
    echo "nothing to execute"
    exit 1
fi

echo "execute $*"
if [ "$(id -u)" -eq 0 ]; then
    exec su-exec "$USER" "$@"
fi
exec "$@"
