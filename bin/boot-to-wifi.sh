#!/bin/bash -el

cleanup() {
  local exit_code=$1
  local previous_command=$BASH_COMMAND
  [[ $exit_code -ne 0 ]] && echo "INFO: Script exited with code $exit_code from command $previous_command"
  exit $exit_code
}
trap 'cleanup $?' EXIT

script_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

usage() {
  echo "usage: ./bin/boot-to-wifi.sh --ssid <ssid> --wifi-password <wifi-password>"
}

[[ $# -lt 4 ]] && { usage; exit 1; }

# Parse options
while [[ $# -gt 0 ]]; do
  key="$1"

  case $key in
    --ssid) ssid="$2"; shift; shift;;
    --wifi-password) wifi_password="$2"; shift; shift;;
    *) echo "Unknown option: $1"; usage; exit 1;;
  esac
done

[[ -n $ssid ]] && [[ -n $wifi_password ]] || { usage; exit 1; }

cd $script_path/../ansible

ansible-playbook -i '127.0.0.1,' --extra-vars "ssid='${ssid}' wifi_password='${wifi_password}'" boot-to-wifi.yml
