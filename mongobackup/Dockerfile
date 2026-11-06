FROM ubuntu:24.04 AS build

ARG TARGETARCH
ARG MONGODB_TOOLS_VERSION=100.20.1
ARG AWS_CLI_VERSION=2.39.5

RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates curl unzip python3-venv && \
    rm -rf /var/lib/apt/lists/*

RUN case "$TARGETARCH" in \
        amd64) mongo_arch=x86_64; aws_arch=x86_64; \
            mongo_sha256=20f43dcaa37f5a4841ac5a91da685a488a5ebbd81113c018e25a6b544cc350ea; \
            aws_sha256=fe0553306b3d001d162bc193d3b040027aab3466b9f910b50e702c122c0f3ff9 ;; \
        arm64) mongo_arch=arm64; aws_arch=aarch64; \
            mongo_sha256=7644e12e351bceea542921e60769e3ed658fc770dc09eed07bc5cc2a1ca2ca41; \
            aws_sha256=ce7b03ebceed1dc6a0a8f27134a41a9a3b5671f09c57ab2e7fc6d43710dbaef3 ;; \
        *) echo "unsupported architecture: $TARGETARCH"; exit 1 ;; \
    esac && \
    curl -fsSL "https://fastdl.mongodb.org/tools/db/mongodb-database-tools-ubuntu2404-${mongo_arch}-${MONGODB_TOOLS_VERSION}.tgz" -o /tmp/mongodb-tools.tgz && \
    echo "$mongo_sha256  /tmp/mongodb-tools.tgz" | sha256sum -c - && \
    tar -xzf /tmp/mongodb-tools.tgz -C /tmp && \
    cp /tmp/mongodb-database-tools-*/bin/* /usr/local/bin/ && \
    curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-${aws_arch}-${AWS_CLI_VERSION}.zip" -o /tmp/awscliv2.zip && \
    echo "$aws_sha256  /tmp/awscliv2.zip" | sha256sum -c - && \
    unzip -q /tmp/awscliv2.zip -d /tmp && \
    /tmp/aws/install && \
    rm -rf /tmp/mongodb-tools.tgz /tmp/mongodb-database-tools-* /tmp/awscliv2.zip /tmp/aws

RUN python3 -m venv /opt/venv && \
    printf '%s\n' \
        'pymongo==4.19.0 --hash=sha256:a5af9e52dfd18224474d5f54817ef2cbf06e313d100772a4a72aea8394037941 --hash=sha256:8f072289060739430d2ded949a196939c3e3ff8ba4469b40e4833b5f1d8b0943' \
        'dnspython==2.9.2 --hash=sha256:af15f7d385a6ae2fb35a796fde2138004c8c42c7389090e2addc83e3b3340fd8' > /tmp/requirements.txt && \
    /opt/venv/bin/pip install --no-cache-dir --only-binary=:all: --require-hashes -r /tmp/requirements.txt && \
    rm /tmp/requirements.txt

FROM ubuntu:24.04
LABEL maintainer="Serhiy Mitrovtsiy <mitrovtsiy@ukr.net>" \
      org.opencontainers.image.authors="Serhiy Mitrovtsiy <mitrovtsiy@ukr.net>" \
      org.opencontainers.image.source="https://github.com/exelban/baseimage" \
      org.opencontainers.image.title="baseimage:mongobackup"

ENV PATH=/opt/venv/bin:$PATH

RUN apt-get update && \
    apt-get install -y --no-install-recommends rsync curl git python3 ca-certificates libgssapi-krb5-2 && \
    rm -rf /var/lib/apt/lists/*

COPY --from=build /usr/local/bin/ /usr/local/bin/
COPY --from=build /usr/local/aws-cli/ /usr/local/aws-cli/
COPY --from=build /opt/venv/ /opt/venv/

CMD ["/bin/bash"]
