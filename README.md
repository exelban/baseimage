# baseimage

Personal docker base images I use across my projects.  

Published to [Docker Hub](https://hub.docker.com/r/exelban/baseimage) as `exelban/baseimage:<name>-latest` (plus versioned tags), built for `linux/amd64` and `linux/arm64`.

## Images

| Tag | Base | What's inside |
|---|---|---|
| `alpine-latest` | alpine | Minimal runtime image: [tini](https://github.com/krallin/tini), [su-exec](https://github.com/ncopa/su-exec), tzdata, openssl, curl, ca-certificates |
| `golang-latest` | golang alpine | Build image for Go projects: git, tzdata |
| `node-latest` | node slim | Build/runtime image for NodeJS projects: git, tzdata, openssl, curl, ca-certificates |
| `mongobackup-latest` | mongo | MongoDB tools plus rsync, git, python3 (pymongo) and AWS CLI for backup scripts |

## Alpine image behavior

The alpine image is the intended final stage for compiled apps:

- tini runs as PID 1, so processes start and stop cleanly.
- The main process runs as a non-root user `app` (UID 1001). Set `-e USER=root` if you really need root.
- Timezone defaults to UTC; override with `-e TIME_ZONE=<zone>`.
- If `/srv/init.sh` exists, it is executed (as the `app` user) before the main process — drop your own script there for custom initialization.
- Run `shell` to get an interactive shell inside the container:
  ```sh
  docker run --rm -it exelban/baseimage:alpine-latest shell
  ```

## Usage

Typical multi-stage build: compile in the golang image, run in the alpine image.

```dockerfile
FROM exelban/baseimage:golang-latest as build

WORKDIR /app
COPY . .
RUN go mod download && go build -o ./bin/main


FROM exelban/baseimage:alpine-latest

COPY --from=build /app/bin/main /srv/main

CMD ["/srv/main"]
```

NodeJS:

```dockerfile
FROM exelban/baseimage:node-latest

WORKDIR /usr/src/app
COPY . .
RUN npm ci

CMD ["npm", "start"]
```

## Building

Images are built and pushed by GitHub Actions on every push to master that touches an image folder (only the changed images are rebuilt), or manually via the Makefile:

```sh
make alpine golang node mongobackup
```

# License
[MIT License](https://github.com/exelban/baseimage/blob/master/LICENSE)
