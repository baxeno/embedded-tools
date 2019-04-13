#!/bin/bash

function prop {
    grep "${1}" gradle.properties | cut -d'=' -f2
}

IMAGE=$(prop 'pipelineDockerImageName')
VERSION=$(prop 'pipelineDockerImageVersion')
HOME_DIR="/home/developer"

docker run \
  --rm \
  --workdir "${HOME_DIR}/git/${PWD##*/}" \
  --security-opt seccomp:unconfined \
  --interactive \
  --tty \
  --env DEVELOPER_USERID=$(id -u) \
  --env DEVELOPER_GROUPID=$(id -g) \
  --volume "${PWD}:${HOME_DIR}/git/${PWD##*/}:Z" \
  --volume "${HOME}/.m2:${HOME_DIR}/.m2:Z" \
  --volume "${HOME}/.gradle:${HOME_DIR}/.gradle:Z" \
  --volume "${HOME}/.gitconfig:${HOME_DIR}/.gitconfig:Z" \
  ${IMAGE}:${VERSION} \
  "/bin/bash" -l