#!/bin/bash -el

for dir in shairport-sync snapcast-client snapcast-server; do
  cd $dir
  ./build.sh
  cd ..
done
