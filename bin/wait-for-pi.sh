#!/bin/bash -el

script_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${script_path}/_shared-scripts.sh"

do_ping() {
  local results
  results="$(ping -t 1 "$1")"
  return $?
}

# Wait for raspberri pi to start up
wait_for_pi() {
  local hostname=$1
  set +e
  local counter=0
  local max_tries=60

  yellow "Waiting for pi to start up at hostname: $(cyan hostname)"

  while true; do
    do_ping "${hostname}"
    if [[ $? == 0 ]]; then
      green "Was able to ping pi at hostname: $(cyan "${hostname}")"
      break
    elif [[ "${counter}" == "${max_tries}" ]]; then
      red "Raspberry Pi did not start up in ${counter}s.  Exiting"
      exit 1
    else
      ((counter++))
      yellow "Waiting for pi to start.  It's been ${counter}s"
    fi
  done
  set -e
}

usage() {
  yellow "usage: ./wait-for-pi.sh <hostname>"
}
[[ $# -ne 1 ]] && { usage; exit 1; }
wait_for_pi $1
