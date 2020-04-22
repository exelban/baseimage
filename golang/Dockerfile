FROM golang:1.14-alpine
MAINTAINER Serhiy Mitrovtsiy <mitrovtsiy@ukr.net>

ENV \
    TIME_ZONE=Etc/UTC \
    CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64 \
    GOLANGCI=1.24.0

RUN apk add --no-cache --update tzdata git && \
    ln -snf /usr/share/zoneinfo/${TIME_ZONE} /etc/localtime && \
    echo ${TIME_ZONE} > /etc/timezone && date && \
    rm -rf /var/cache/apk/*

RUN wget -O- -nv https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s v${GOLANGCI} && \
    golangci-lint --version
