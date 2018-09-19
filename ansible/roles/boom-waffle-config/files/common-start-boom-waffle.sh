#!/bin/bash -el

script_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

"${script_path}/disable-wifi-power-saving.sh"
"${script_path}/set-max-sound-volume.sh"
