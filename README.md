# baseimage

Personal docker base images I use across my projects.  

Published to [Docker Hub](https://hub.docker.com/r/exelban/baseimage) as `exelban/baseimage:<name>-latest` (plus versioned tags), built for `linux/amd64` and `linux/arm64`.

## Images

| Tag | Base | What's inside |
|---|---|---|
| `alpine-latest` | alpine | Minimal runtime image: [tini](https://github.com/krallin/tini), [su-exec](https://github.com/ncopa/su-exec), tzdata, openssl, curl, ca-certificates |
| `golang-latest` | golang alpine | Build image for Go projects: golangci-lint, git, tzdata |
| `node-latest` | node slim | Build/runtime image for NodeJS projects: Tini, Yarn Classic 1.22.22, git, tzdata, openssl, curl, ca-certificates |
| `mongobackup-latest` | ubuntu 24.04 | MongoDB Database Tools, rsync, curl, git, python3 (pymongo) and AWS CLI for backup scripts |

## Alpine image behavior

The alpine image is the intended final stage for compiled apps:

- tini runs as PID 1, so processes start and stop cleanly.
- The main process runs as a non-root user `app` (UID 1001). Set `-e USER=root` if you really need root.
- No Docker socket group is created. Supply the host group at deployment time with `--user 1001:1001 --group-add <host-gid>` when needed.
- Timezone defaults to UTC; override with `-e TIME_ZONE=<zone>`. The entrypoint exports `TZ`, including when running non-root or with a read-only filesystem.
- If `/srv/init.sh` exists, it must be executable and is run before the main process. The hook and main process use `USER` (default `app`) when the container starts as root, or the current user when started non-root with `docker run --user`. Read-only hook mounts are supported; a failed hook stops startup.
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

Tini runs as PID 1 and forwards signals to the process group. The upstream Node entrypoint is preserved, including support for arguments such as `-e`. Builds start as root so downstream images can install packages; switch to the existing `node` user for the application:

```dockerfile
FROM exelban/baseimage:node-latest

WORKDIR /usr/src/app
COPY . .
RUN npm ci && chown -R node:node /usr/src/app

USER node
CMD ["npm", "start"]
```

## Backup image

The backup image contains Database Tools 100.20.1 and AWS CLI 2.39.5, with architecture-specific SHA-256 checksums verified before installation. PyMongo 4.19.0 and dnspython 2.9.2 use pinned, hash-checked wheels in `/opt/venv`. Invoke `python3` through `PATH` (or `/opt/venv/bin/python3`) to use those dependencies.

MongoDB Server and `mongosh` are not included. The `mongobackup-9.0` tag identifies the MongoDB server line tested in CI; Database Tools have their own version. CI checks a compressed backup/restore round trip against MongoDB 9.0 on both client architectures, including BSON values, indexes, and empty collections.

Measured uncompressed image sizes before and after removing the server:

| Architecture | Previous image | Tools-only image | Reduction |
|---|---|---|---|
| amd64 | 1,505 MB | 643 MB | 57.3% |
| arm64 | 1,486 MB | 651 MB | 56.2% |

To update a pinned tool or Python dependency, update its version and checksums together in `mongobackup/Dockerfile`. OS packages continue receiving updates through rebuilds.

## Building

GitHub Actions builds changed images on pushes to master, and all images when the Makefile or deployment workflow changes, on manual runs, and every Monday at 04:00 UTC. Builds pull fresh base images; weekly builds also bypass the build cache to refresh installed packages. Both architectures pass smoke tests and vulnerability scans before publishing. Fixable HIGH or CRITICAL vulnerabilities block publication.

Each CI build also publishes `<name>-sha-<full-commit>-<run-id>-<attempt>` tags, plus architecture-specific variants. These unique tags retain earlier builds when the version and `latest` aliases move, including weekly rebuilds of the same commit. Pin a release tag or image digest in downstream projects to reproduce a build or roll back.

Dependabot does not propose Docker major-version upgrades, MongoDB minor-version upgrades, or Ubuntu interim releases. Node stays on the selected LTS major, and the backup base stays on Ubuntu 24.04 LTS until deliberately changed. MongoDB server versions used in the workflow are changed manually.

The Makefile pulls fresh base images and publishes directly to Docker Hub and GHCR, without the CI checks. It also publishes `<name>-sha-<full-commit>-<uuid>` tags so separate local builds retain distinct tags:

```sh
make alpine golang node mongobackup
```

# License
[MIT License](https://github.com/exelban/baseimage/blob/master/LICENSE)
