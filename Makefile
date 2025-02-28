GOLANG_TAG = "golang-1.24"
ALPINE_TAG = "alpine-3.19"
NODE_TAG = "node-20"
MONGOBACKUP_TAG = "mongobackup-7.0.16"

PLATFORMS = "linux/amd64,linux/arm64"

.SILENT: golang alpine node mongobackup
.PHONY: golang alpine node mongobackup

all: golang alpine node mongobackup
build: golang alpine node mongobackup

golang:
	docker buildx build --push --platform ${PLATFORMS} --tag exelban/baseimage:$(GOLANG_TAG) --tag exelban/baseimage:golang-latest ./golang/.

alpine:
	docker buildx build --push --platform ${PLATFORMS} --tag exelban/baseimage:$(ALPINE_TAG) --tag exelban/baseimage:alpine-latest ./alpine/.

node:
	docker buildx build --push --platform ${PLATFORMS} --tag exelban/baseimage:$(NODE_TAG) --tag exelban/baseimage:node-latest ./node/.

mongobackup:
	docker buildx build --push --platform ${PLATFORMS} --tag exelban/baseimage:$(MONGOBACKUP_TAG) --tag exelban/baseimage:mongobackup-latest ./mongobackup/.