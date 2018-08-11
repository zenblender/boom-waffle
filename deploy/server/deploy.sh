#/bin/bash -el

SCRIPT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Killing all docker containers"
docker ps -a | awk '{print $1}' | xargs docker rm -fv

echo "Starting services"
docker-compose -f "$SCRIPT_PATH/docker-compose.yml" up $@
