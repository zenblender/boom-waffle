#!/bin/bash -el

script_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

sentinel_value="$(cat $script_path/../.sentinel)"

[[ $sentinel_value != 'sentinel' ]] && { echo "Error: Transcrypt not configured correctly"; exit 1; }

echo ssh-add $script_path/../secrets/id_rsa
