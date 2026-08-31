FROM alpine:3.24
LABEL maintainer="Serhiy Mitrovtsiy <mitrovtsiy@ukr.net>" \
      org.opencontainers.image.authors="Serhiy Mitrovtsiy <mitrovtsiy@ukr.net>" \
      org.opencontainers.image.source="https://github.com/exelban/baseimage" \
      org.opencontainers.image.title="baseimage:alpine"

ENV \
    USER=app \
    USER_UID=1001 \
    TIME_ZONE=Etc/UTC \
    TERM=xterm-256color

COPY --chmod=755 shell.sh /usr/local/bin/shell
COPY --chmod=755 init.sh /

RUN apk add --no-cache su-exec tzdata tini openssl curl ca-certificates && \
    ln -s /sbin/su-exec /usr/local/bin/gosu && \
    mkdir -p /home/$USER && \
    adduser -s /bin/sh -D -u $USER_UID $USER && chown -R $USER:$USER /home/$USER && \
    delgroup ping && \
    addgroup -g 998 ping && addgroup -g 999 docker && addgroup ${USER} docker && \
    mkdir -p /srv && chown -R $USER:$USER /srv && \
    ln -snf /usr/share/zoneinfo/${TIME_ZONE} /etc/localtime && \
    echo ${TIME_ZONE} > /etc/timezone && date

ENTRYPOINT ["/init.sh"]
