FROM mongo:4.4.2
MAINTAINER Serhiy Mitrovtsiy <mitrovtsiy@ukr.net>

RUN apt-get update && apt-get install -y software-properties-common && \
    add-apt-repository universe && \
    apt-get update && apt-get install -y curl git python3 python3-pip && \
    pip3 install --no-cache-dir pymongo awscli && \
    rm -rf /var/cache/apk/*