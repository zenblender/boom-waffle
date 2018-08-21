#!/bin/bash -el

image_name="brandonfryslie/shairport-sync"

docker build \
  -t "${image_name}" \
  .
