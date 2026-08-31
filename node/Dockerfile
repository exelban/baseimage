FROM node:24-slim
LABEL maintainer="Serhiy Mitrovtsiy <mitrovtsiy@ukr.net>" \
      org.opencontainers.image.authors="Serhiy Mitrovtsiy <mitrovtsiy@ukr.net>" \
      org.opencontainers.image.source="https://github.com/exelban/baseimage" \
      org.opencontainers.image.title="baseimage:node"

ENV \
    NODE_PATH=/usr/lib/node_modules:/node_modules \
    TIME_ZONE=Etc/UTC

RUN apt-get update && \
    apt-get install -y --no-install-recommends git tzdata openssl curl ca-certificates && \
    ln -snf /usr/share/zoneinfo/${TIME_ZONE} /etc/localtime && \
    echo ${TIME_ZONE} > /etc/timezone && date && \
    rm -rf /var/lib/apt/lists/*
