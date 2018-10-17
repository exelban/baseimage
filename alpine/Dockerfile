FROM alpine:3.8
MAINTAINER Serhiy Mitrovtsiy <mitrovtsiy@ukr.net>

ENV \
    USER=app \
    USER_UID=1001 \
    TINI_VERSION=v0.18.0 \
    TIME_ZONE=Etc/UTC \
    TERM=xterm-256color

COPY bash.sh /usr/bin/bash
COPY init.sh /

RUN chmod +x /usr/bin/bash /init.sh && \
    apk add --no-cache --update su-exec tzdata tini && \
    ln -s /sbin/su-exec /usr/local/bin/gosu && \
    mkdir -p /home/$USER && \
    adduser -s /bin/sh -D -u $USER_UID $USER && chown -R $USER:$USER /home/$USER && \
    delgroup ping && \
    addgroup -g 998 ping && addgroup -g 999 docker && addgroup ${USER} docker && \
    mkdir -p /srv && chown -R $USER:$USER /srv && \
    ln -snf /usr/share/zoneinfo/${TIME_ZONE} /etc/localtime && \
    echo ${TIME_ZONE} > /etc/timezone && date && \
    rm -rf /var/cache/apk/*

ENTRYPOINT ["/init.sh"]
