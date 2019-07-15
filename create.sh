#!/bin/bash

set -e # Exit script if any statement returns a non-true value.
set -u # Exit script if using an uninitialized variable.

DOCKERFILE_LINTER="hadolint/hadolint:v1.13.0"
IMAGE="baxeno/embedded-tools"
VERSION="v0.2.0"
FULL_IMAGE="${IMAGE}:${VERSION}"

echo "### Dockerfile linting"
docker run -i --rm "${DOCKERFILE_LINTER}" < Dockerfile

echo "### Docker build"
docker build --tag "${FULL_IMAGE}" \
    --build-arg IMAGE_VERSION="${VERSION}" \
    --build-arg IMAGE_NAME="${IMAGE}" \
    --build-arg BUILD_DATE="$(date -u +'%Y-%m-%dT%H:%M:%SZ')" \
    --build-arg GIT_COMMIT="$(git log -1 --format=%H)" \
    --build-arg GIT_REMOTE="$(git remote get-url origin)" \
    --pull \
    --no-cache .

echo "### Docker push image to public hub"
docker login -u baxeno
docker push "${FULL_IMAGE}"
