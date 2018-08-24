#!/bin/bash -el

# rsyncs the current repo to the ~/boom-waffle directory on the pi

# This script should be replaced with the ansible playbook, but the ansible
# playbook isn't updating the files correctly so this must still be used

# This is the path to the directory containing this script
script_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Parse options
while [[ $# -gt 0 ]]; do
  key="$1"

  case $key in
    --hostname) pi_hostname="$2"; shift; shift;;
    --new-hostname) new_hostname="$2"; shift; shift;;
    *) echo "Unknown option: $1"; exit 1;;
  esac
done

[[ -n "${pi_hostname}" ]] || { echo "usage: ./bin/rsync-to-pi.sh --hostname <pi hostname>"; exit 1; }

boomwaffle_path="${script_path}/.."
rsync -e "ssh -o StrictHostKeyChecking=no" --exclude '.idea' --exclude '.git' --exclude '.cache' -avzru "${boomwaffle_path}" "pi@${pi_hostname}:/home/pi/boom-waffle"
