FROM golang:1.13-alpine
MAINTAINER Serhiy Mitrovtsiy <mitrovtsiy@ukr.net>

ENV \
    TIME_ZONE=Etc/UTC \
    CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64

RUN apk add --no-cache --update tzdata git && \
    ln -snf /usr/share/zoneinfo/${TIME_ZONE} /etc/localtime && \
    echo ${TIME_ZONE} > /etc/timezone && date && \
    rm -rf /var/cache/apk/*

RUN go get -u github.com/golang/dep/cmd/dep
