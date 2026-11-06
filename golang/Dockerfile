FROM golang:1.27-alpine3.24
LABEL maintainer="Serhiy Mitrovtsiy <mitrovtsiy@ukr.net>" \
      org.opencontainers.image.authors="Serhiy Mitrovtsiy <mitrovtsiy@ukr.net>" \
      org.opencontainers.image.source="https://github.com/exelban/baseimage" \
      org.opencontainers.image.title="baseimage:golang"

ENV \
    TIME_ZONE=Etc/UTC \
    CGO_ENABLED=0 \
    GOOS=linux

RUN apk add --no-cache tzdata git && \
    ln -snf /usr/share/zoneinfo/${TIME_ZONE} /etc/localtime && \
    echo ${TIME_ZONE} > /etc/timezone && date

COPY --from=golangci/golangci-lint:v2.15.0-alpine /usr/bin/golangci-lint /usr/local/bin/golangci-lint
COPY --chmod=755 build_time.sh /script/build_time.sh
