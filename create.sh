#!/bin/bash

set -e # Exit script if any statement returns a non-true value.
set -u # Exit script if using an uninitialized variable.

DOCKERFILE_LINTER="hadolint/hadolint:v1.13.0"
IMAGE="baxeno/embedded-tools"
VERSION="v0.1.0"
FULL_IMAGE="${IMAGE}:${VERSION}"

docker run -i --rm "${DOCKERFILE_LINTER}" < Dockerfile

docker build --tag "${FULL_IMAGE}" \
    --build-arg IMAGE_VERSION="${VERSION}" \
    --build-arg IMAGE_NAME="${IMAGE}" \
    --build-arg BUILD_DATE="$(date -u +'%Y-%m-%dT%H:%M:%SZ')" \
    --build-arg GIT_COMMIT="$(git log -1 --format=%H)" \
    --build-arg GIT_REMOTE="$(git remote get-url origin)" \
    --pull \
    --no-cache .

docker push "${FULL_IMAGE}"