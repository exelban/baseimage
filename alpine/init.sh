#!/sbin/tini /bin/sh

if [ -f "/srv/init.sh" ]; then
    echo "executing /srv/init.sh"
    chmod +x /srv/init.sh
    /srv/init.sh
    if [ "$?" -ne "0" ]; then
      echo "init.sh failed"
      exit 1
    fi
fi

if [ $# -eq 0 ]; then
    echo "nothing to execute"
    exit 1
fi

echo "execute $@"
$@