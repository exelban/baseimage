GOLANG_TAG = "golang-1.22"
ALPINE_TAG = "alpine-3.19"
NODE_TAG = "node-20"

PLATFORMS = "linux/amd64,linux/arm64"

.SILENT: golang alpine node
.PHONY: golang alpine node

all: golang alpine node
build: golang alpine node

golang:
	docker buildx build --push --platform ${PLATFORMS} --tag exelban/baseimage:$(GOLANG_TAG) --tag exelban/baseimage:golang-latest ./golang/.

alpine:
	docker buildx build --push --platform ${PLATFORMS} --tag exelban/baseimage:$(ALPINE_TAG) --tag exelban/baseimage:alpine-latest ./alpine/.

node:
	docker buildx build --push --platform ${PLATFORMS} --tag exelban/baseimage:$(NODE_TAG) --tag exelban/baseimage:node-latest ./node/.