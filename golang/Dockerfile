FROM golang:1.22-alpine
MAINTAINER Serhiy Mitrovtsiy <mitrovtsiy@ukr.net>

ENV \
    TIME_ZONE=Etc/UTC \
    CGO_ENABLED=0 \
    GOOS=linux

RUN apk add --no-cache --update tzdata git && \
    ln -snf /usr/share/zoneinfo/${TIME_ZONE} /etc/localtime && \
    echo ${TIME_ZONE} > /etc/timezone && date && \
    rm -rf /var/cache/apk/*

ADD build_time.sh /script/build_time.sh
RUN chmod +x /script/build_time.sh