#!/bin/bash -el

SNAPCAST_VERSION="0.15.0"

docker build \
  -t snapcast-client \
  --build-arg SNAPCAST_VERSION=${SNAPCAST_VERSION} \
  .
