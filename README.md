# naming
## Golang
exelban/baseimage:golang-build-latest
exelban/baseimage:golang-run-latest

## NodeJS
exelban/baseimage:nodejs-build-latest
exelban/baseimage:nodejs-run-latest

# Building
docker build -t baseimage:golang-run-latest .

# See output
docker images baseimage:golang-run-latest