#!/bin/bash -el

script_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${script_path}/_shared-scripts.sh"

export ANSIBLE_HOST_KEY_CHECKING=false

usage() {
  yellow "usage: 1-first-boot.sh --new-hostname <new pi hostname>"
  yellow "Configures SSH credentials and changes the pi hostname"
}

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

  yellow "Waiting for pi to start up at hostname: ${hostname}"

  while true; do
    do_ping "${hostname}"
    if [[ $? == 0 ]]; then
      green "Pi started successfully"
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

# Parse options
while [[ $# -gt 0 ]]; do
  key="$1"

  case $key in
    --new-hostname) new_hostname="$2"; shift; shift;;
    *) red "Unknown option: $1"; exit 1;;
  esac
done

[[ -n $new_hostname ]] || { usage; exit 1; }

pi_hostname='raspberrypi.local'

yellow "Configuring pi with hostname: $(cyan "${new_hostname}")"

yellow "Removing hostname from authorized_keys file"
ssh-keygen -R "${pi_hostname}" &>/dev/null

extra_vars="host='${pi_hostname}' new_hostname='${new_hostname}'"

cd $script_path/../ansible

yellow "Running ansible playbook first-boot.yml"
ansible-playbook -i "${pi_hostname}," --ask-pass --ask-sudo --extra-vars "${extra_vars}" -u pi first-boot.yml

green "Finished running first-boot.yml playbook"

# Take into account the .local
new_hostname_full="${new_hostname}.local"
wait_for_pi "${new_hostname_full}"

echo
green "Your pi is now available at hostname: $(cyan "${new_hostname_full}")"
