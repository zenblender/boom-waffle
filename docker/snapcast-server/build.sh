#!/bin/bash -el

SNAPCAST_VERSION="0.15.0"
image_name="brandonfryslie/snapcast-server"

docker build \
  -t "${image_name}" \
  --build-arg SNAPCAST_VERSION=${SNAPCAST_VERSION} \
  .
