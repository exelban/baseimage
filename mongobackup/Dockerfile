FROM mongo:7.0
LABEL maintainer="Serhiy Mitrovtsiy <mitrovtsiy@ukr.net>" \
      org.opencontainers.image.authors="Serhiy Mitrovtsiy <mitrovtsiy@ukr.net>" \
      org.opencontainers.image.source="https://github.com/exelban/baseimage" \
      org.opencontainers.image.title="baseimage:mongobackup"

RUN apt-get update && \
    apt-get install -y --no-install-recommends rsync curl git unzip python3 python3-pip && \
    pip3 install --no-cache-dir pymongo && \
    curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-$(uname -m).zip" -o /tmp/awscliv2.zip && \
    unzip -q /tmp/awscliv2.zip -d /tmp && \
    /tmp/aws/install && \
    rm -rf /tmp/awscliv2.zip /tmp/aws /var/lib/apt/lists/*
