#!/bin/bash -el

script_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${script_path}/_shared-scripts.sh"

BOOMWAFFLE_PATH="$HOME/code/boom-waffle"

[[ -n $1 ]] || { yellow "usage: ./bin/boom-watch.sh <hostname>"; exit 1; }
hostname=$1

yellow "Watching path $(cyan "${BOOMWAFFLE_PATH}")"
yellow "Rsyncing to host $(cyan "${hostname}")"

fswatch -0 "${BOOMWAFFLE_PATH}" \
  -e ".git/" \
  -e ".idea/" \
  -e ".*___jb_tmp___" \
  -e ".*___jb_old___" \
  | while read -d "" event; do
    echo
    yellow "*** Rsync starting ***"
    "${BOOMWAFFLE_PATH}/bin/rsync-to-pi.sh" --hostname "${hostname}"
    yellow "*** Rsync finished ***"
    echo
done
