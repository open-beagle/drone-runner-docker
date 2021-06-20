#!/bin/sh

export CGO_ENABLED=0

set -ex

REPO="github.com/drone-runners/drone-runner-docker"

# compile the server using the cgo
GOARCH=amd64
go build -o release/linux/${GOARCH}/drone-runner-docker ${REPO}/

GOARCH=arm64
go build -o release/linux/${GOARCH}/drone-runner-docker ${REPO}/

GOARCH=ppc64le
go build -o release/linux/${GOARCH}/drone-runner-docker ${REPO}/
