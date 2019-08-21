FROM node:8.16-alpine
MAINTAINER Serhiy Mitrovtsiy <mitrovtsiy@ukr.net>

ENV \
    NODE_PATH=.:/usr/lib/node_modules:/node_modules \
    TIME_ZONE=Etc/UTC

RUN apk add --no-cache --update git tzdata openssl curl ca-certificates && \
    ln -snf /usr/share/zoneinfo/${TIME_ZONE} /etc/localtime && \
    echo ${TIME_ZONE} > /etc/timezone && date && \
    rm -rf /var/cache/apk/*
