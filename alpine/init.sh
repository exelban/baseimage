#!/sbin/tini /bin/sh

if [ -f "init.sh" ]; then
    echo "executing ~/init.sh"
    chmod +x init.sh
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