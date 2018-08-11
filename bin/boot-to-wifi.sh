#!/bin/bash -el

SCRIPT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

usage() {
  echo "usage: ./bin/boot-to-wifi.sh --ssid <ssid> --wifi-password <wifi-password>"
}

# Parse options
while [[ $# -gt 0 ]]; do
  key="$1"

  case $key in
    --ssid) ssid="$2"; shift; shift;;
    --wifi_password) wifi_password="$2"; shift; shift;;
    *) echo "Unknown option: $1"; usage; exit 1;;
  esac
done

[[ -n $ssid ]] && [[ -n $wifi_password ]] || { usage; exit 1; }

cd $SCRIPT_PATH/../ansible

ansible-playbook -i --extra-vars "ssid=${ssid} wifi_password=${wifi_password}" hosts boot-to-wifi.yml
