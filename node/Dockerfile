FROM node:26-slim
LABEL maintainer="Serhiy Mitrovtsiy <mitrovtsiy@ukr.net>" \
      org.opencontainers.image.authors="Serhiy Mitrovtsiy <mitrovtsiy@ukr.net>" \
      org.opencontainers.image.source="https://github.com/exelban/baseimage" \
      org.opencontainers.image.title="baseimage:node"

ENV \
    NODE_PATH=/usr/lib/node_modules:/node_modules \
    TIME_ZONE=Etc/UTC

RUN apt-get update && \
    apt-get install -y --no-install-recommends git tzdata openssl curl ca-certificates tini && \
    ln -snf /usr/share/zoneinfo/${TIME_ZONE} /etc/localtime && \
    echo ${TIME_ZONE} > /etc/timezone && date && \
    rm -rf /var/lib/apt/lists/*

RUN npm install --global yarn@1.22.22 && \
    npm cache clean --force

ENTRYPOINT ["/usr/bin/tini", "-g", "--", "docker-entrypoint.sh"]
CMD ["node"]
