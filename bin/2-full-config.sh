#!/bin/bash -el

script_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${script_path}/_shared-scripts.sh"

export ANSIBLE_HOST_KEY_CHECKING=false

usage() {
  yellow "usage: 2-full-config.sh --hostname <pi hostname>"
}

# Parse options
while [[ $# -gt 0 ]]; do
  key="$1"

  case $key in
    --hostname) pi_hostname="$2"; shift; shift;;
    -p) ask_password=true; shift;; # This only needs to be used once and then it will configure ssh keys
    *) red "Unknown option: $1"; exit 1;;
  esac
done

[[ -n $pi_hostname ]] || { usage; exit 1; }

yellow "Configuring pi with hostname: $(cyan "${pi_hostname}")"

yellow "Removing hostname from authorized_keys file"
ssh-keygen -R "${pi_hostname}" &>/dev/null

extra_vars="host=${pi_hostname}"

ansible_args="-i ${pi_hostname},"

# If we pass -p, ask for password
[[ $ask_password == 'true' ]] && ansible_args+=' --ask-pass --ask-sudo'

cd $script_path/../ansible

yellow "Running ansible playbook config-raspberry-pi.yml"
#echo ansible-playbook "${ansible_args}" -u pi ansible/config-raspberry-pi.yml
ansible-playbook ${ansible_args} --extra-vars "${extra_vars}" -u pi config-raspberry-pi.yml

green "Finished running config-raspberry-pi.yml playbook"

yellow "Rsyncing repo to pi"

"${script_path}/rsync-to-pi.sh" --hostname "${pi_hostname}"

green "Finished rsyncing repo to pi"
