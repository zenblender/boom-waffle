#!/bin/bash -el

SCRIPT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

sentinel_value="$(cat $SCRIPT_PATH/../.sentinel)"

[[ $sentinel_value != 'sentinel' ]] && { echo "Error: Transcrypt not configured correctly"; exit 1; }

echo ssh-add $SCRIPT_PATH/../secrets/id_rsa
