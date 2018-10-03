#!/sbin/tini /bin/sh

if [ -f "/app/init.sh" ]; then
    echo "executing /app/init.sh"
    chmod +x /app/init.sh
    /app/init.sh
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