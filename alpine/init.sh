#!/sbin/tini /bin/sh

if [ -f "/srv/init.sh" ]; then
    echo "executing /srv/init.sh"
    chmod +x /srv/init.sh
    if ! su-exec "$USER" /srv/init.sh; then
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
