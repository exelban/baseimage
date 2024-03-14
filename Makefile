GOLANG_TAG = "golang-1.21"
ALPINE_TAG = "alpine-3.19"
NODE_TAG = "node-20"

PLATFORMS = "linux/arm64,linux/amd64"

.SILENT: golang alpine node
.PHONY: golang alpine node

all: golang alpine node
build: golang alpine node

golang:
	docker buildx build --push --platform ${PLATFORMS} --tag exelban/baseimage:$(GOLANG_TAG) ./golang/.
	docker buildx build --push --platform ${PLATFORMS} --tag exelban/baseimage:golang-latest ./golang/.

alpine:
	docker buildx build --push --platform ${PLATFORMS} --tag exelban/baseimage:$(ALPINE_TAG) ./alpine/.
	docker buildx build --push --platform ${PLATFORMS} --tag exelban/baseimage:alpine-latest ./alpine/.

node:
	docker buildx build --push --platform ${PLATFORMS} --tag exelban/baseimage:$(NODE_TAG) ./node/.
	docker buildx build --push --platform ${PLATFORMS} --tag exelban/baseimage:node-latest ./node/.