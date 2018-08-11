#/bin/bash -el

SCRIPT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

docker-compose() {
  docker run \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v "$PWD:/rootfs/$PWD" \
    -w="/rootfs/$PWD" \
    docker/compose:1.13.0 "$@"
}

docker-compose -f "$SCRIPT_PATH/docker-compose.yml"
