# baseimage
[![Travis build status](https://travis-ci.org/exelban/baseimage.svg?branch=master)](https://travis-ci.org/exelban/baseimage)
[![DockerHub build status](https://img.shields.io/docker/build/exelban/baseimage.svg)](https://hub.docker.com/r/exelban/baseimage/builds/)  

Docker images for golang and nodeJS projects.

# Images
## Alpine
Minimalistic alpine image for docker.  
Based on alpine:3.8.  

Using tzdata for setting local time (by default: Etc/UTC, +0).  
For properly starting and killing process using [tini](https://github.com/krallin/tini).

Main process will be started as non root user with UID 1001.

If for some reason you want to run sh, just run in image command: bash.
```$xslt
run docker --rm -it exelban/baseimage:alpine-latest bash
```

As entrypoint in image using init.sh script. But if you need own configuration just upload your own init.sh to /svr.
```$xslt
COPY ./init.sh /srv/
```
And this script will be entrypoint in image.

### Size
Compressed: 3MB   
Uncompressed: 5.57MB + application size

## Golang
Image based on golang:1.11.0-alpine3.7.  
Added tzdata git packages for time and fetching projects from git.

Installed tools:
* dep

### Size
Compressed: 180MB  
Uncompressed: 379MB

## NodeJS
TODO


# Usage

## Golang
```$xslt
FROM exelban/baseimage:golang-latest as build

WORKDIR /go/src/example/
ADD . /go/src/example/

RUN dep ensure

RUN echo "Started compiling..."
RUN go build -o ./bin/main
RUN echo "Compiling compete. Output: ./bin/main"


FROM exelban/baseimage:alpine-latest

COPY --from=build /go/src/example/bin /

CMD ["./main"]
```

## NodeJS
TODO


# License
[MIT License](https://github.com/exelban/baseimage/blob/master/LICENSE)
