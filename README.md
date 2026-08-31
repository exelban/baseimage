# baseimage
[![Deploy to github hub](https://github.com/exelban/baseimage/workflows/Deploy%20to%20docker%20hub/badge.svg)](https://github.com/exelban/baseimage/actions)

Docker images for golang and nodeJS projects.

# Images
## Alpine
Minimalistic alpine image for docker.
Based on alpine:3.24.

Using tzdata for setting local time (by default: Etc/UTC, +0).
For properly starting and killing process using [tini](https://github.com/krallin/tini).

The main process is started as a non-root user (`app`, UID 1001) via [su-exec](https://github.com/ncopa/su-exec).
If you really need to run as root, set the `USER` env variable to `root`:
```sh
docker run --rm -e USER=root exelban/baseimage:alpine-latest ./main
```

If you want a shell inside the image, run the `shell` command:
```sh
docker run --rm -it exelban/baseimage:alpine-latest shell
```

As entrypoint in image using init.sh script. If you need your own initialization logic,
add your own init.sh to /srv and it will be executed (as the `app` user) before the main process:
```dockerfile
COPY ./init.sh /srv/
```

## Golang
Image based on golang:1.27-alpine.
Added tzdata and git packages for time and fetching dependencies from git.

## NodeJS
Image based on node:24-slim.
Added git, tzdata, openssl, curl and ca-certificates packages.

## Mongobackup
Image based on mongo:7.0.
Added rsync, git, python3 (with pymongo) and AWS CLI v2 for backup scripts.

# Usage

## Golang
```dockerfile
FROM exelban/baseimage:golang-latest as build

WORKDIR /app
COPY . .

RUN go mod download
RUN go build -o ./bin/main


FROM exelban/baseimage:alpine-latest

COPY --from=build /app/bin/main /srv/main

ENTRYPOINT ["/init.sh"]
CMD ["/srv/main"]
```

## NodeJS
```dockerfile
FROM exelban/baseimage:node-latest as build

WORKDIR /usr/src/app

COPY . .

RUN npm ci

CMD [ "npm", "start" ]
```

# License
[MIT License](https://github.com/exelban/baseimage/blob/master/LICENSE)
