#!/bin/bash -el

# We need a path entry that isn't available without this
export PATH="$PATH:/home/pi/.local/bin"

script_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${script_path}/../../bin/_shared-scripts.sh"

echo "Running compose down"
docker-compose -f "$script_path/docker-compose.yml" down -v

echo "Starting services"
docker-compose -f "$script_path/docker-compose.yml" up -d $@
