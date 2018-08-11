#!/bin/bash -el

SCRIPT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

export ANSIBLE_HOST_KEY_CHECKING=false

# Parse options
while [[ $# -gt 0 ]]; do
  key="$1"

  case $key in
    --hostname) pi_hostname="$2"; shift; shift;;
    --new-hostname) new_hostname="$2"; shift; shift;;
    -p) ask_password=true; shift;; # This only needs to be used once and then it will configure ssh keys
    *) echo "Unknown option: $1"; exit 1;;
  esac
done

echo "Running playbook with hostname: ${pi_hostname}"

[[ -n $pi_hostname ]] || { echo "Pi Hostname not specified, using raspberrypi.local"; pi_hostname='raspberrypi.local'; }

extra_vars="host=${pi_hostname}"

# Define the new hostname for the pi if specified
[[ -n $new_hostname ]] && extra_vars+=" new_hostname=${new_hostname}"

ansible_args="-i ${pi_hostname},"

# If we pass -p, ask for password
[[ $ask_password == 'true' ]] && ansible_args+=' --ask-pass --ask-sudo'

cd $SCRIPT_PATH/../ansible

#echo ansible-playbook "${ansible_args}" -u pi ansible/config-raspberry-pi.yml
ansible-playbook ${ansible_args} --extra-vars "${extra_vars}" -u pi config-raspberry-pi.yml
