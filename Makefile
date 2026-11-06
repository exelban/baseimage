GOLANG_TAG = "golang-1.27"
ALPINE_TAG = "alpine-3.24"
NODE_TAG = "node-26"
MONGOBACKUP_TAG = "mongobackup-9.0"

PLATFORMS = "linux/amd64,linux/arm64"
RELEASE_ID := $(shell git rev-parse HEAD)-$(shell uuidgen | tr '[:upper:]' '[:lower:]')

.SILENT: golang alpine node mongobackup
.PHONY: all build golang alpine node mongobackup

all: golang alpine node mongobackup
build: golang alpine node mongobackup

golang: TAG = $(GOLANG_TAG)
alpine: TAG = $(ALPINE_TAG)
node: TAG = $(NODE_TAG)
mongobackup: TAG = $(MONGOBACKUP_TAG)

golang alpine node mongobackup:
	docker buildx build --pull --push --platform ${PLATFORMS} \
		--tag exelban/baseimage:$(TAG) --tag exelban/baseimage:$@-latest \
		--tag ghcr.io/exelban/baseimage:$(TAG) --tag ghcr.io/exelban/baseimage:$@-latest \
		--tag exelban/baseimage:$@-sha-$(RELEASE_ID) --tag ghcr.io/exelban/baseimage:$@-sha-$(RELEASE_ID) ./$@/.
