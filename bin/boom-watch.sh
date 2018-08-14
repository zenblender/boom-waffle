#!/bin/bash -el

script_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${script_path}/_shared-scripts.sh"

BOOMWAFFLE_PATH="$HOME/code/boom-waffle"

#fswatch -0 "${BOOMWAFFLE_PATH}" | while read -d "" event; do \
#  # do something with ${event}
#  echo "do something with ${event}"
#done

yellow "Watching path $(cyan "${BOOMWAFFLE_PATH}")"

fswatch -0 "${BOOMWAFFLE_PATH}" \
  -e ".git/" \
  -e ".idea/" \
  -e ".*___jb_tmp___" \
  -e ".*___jb_old___" \
  | while read -d "" event; do
    echo
    yellow "*** Rsync starting ***"
    "${BOOMWAFFLE_PATH}/bin/rsync-to-pi.sh" --hostname wafflemini-1.local
    yellow "*** Rsync finished ***"
    echo
done
