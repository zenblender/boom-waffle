#!/bin/bash -el

script_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

for dir in access-point shairport-sync snapcast-client snapcast-server; do
  cd "${script_path}/${dir}"
  ./build.sh
  cd ..
done
