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
    --tags) ansible_tags_arg="--tags $2"; shift; shift;;
    *) red "Unknown option: $1"; exit 1;;
  esac
done

[[ -n $pi_hostname ]] || { usage; exit 1; }

yellow "Configuring pi with hostname: $(cyan "${pi_hostname}")"

yellow "Removing hostname from authorized_keys file"
ssh-keygen -R "${pi_hostname}" &>/dev/null

yellow "Adding boomwaffle ssh key to ssh-agent"
eval "$("${script_path}"/add-ssh.sh)"

extra_vars="host=${pi_hostname}"

ansible_args="-i ${pi_hostname},"

cd $script_path/../ansible

yellow "Running ansible playbook config-raspberry-pi.yml"
ansible-playbook ${ansible_args} --extra-vars "${extra_vars}" -u pi config-raspberry-pi.yml $ansible_tags_arg

green "Finished running config-raspberry-pi.yml playbook"

yellow "Rsyncing repo to pi"

"${script_path}/rsync-to-pi.sh" --hostname "${pi_hostname}"

green "Finished rsyncing repo to pi"
