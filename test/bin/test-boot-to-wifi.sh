#!/bin/bash -el

colorize() { CODE=$1; shift; echo -e '\033[0;'"${CODE}"'m'"$*"'\033[0m'; }
red() { echo -e "$(colorize '1;31' "$@")"; }
green() { echo -e "$(colorize 32 "$@")"; }
yellow() { echo -e "$(colorize 33 "$@")"; }
cyan() { echo -e "$(colorize 36 "$@")"; }

script_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

usage() {
  echo "usage: ./test/test-boot-to-wifi.sh"
}

[[ $1 == '-h' ]] || [[ $1 == '--help' ]] && { usage; exit 0; }

bin_path="${script_path}/../../bin"

test_ssid="nvkdjnawe34234r"
test_password="somepassword"

yellow "Running boot-to-wifi playbook"
echo
yellow "***********************"
$bin_path/boot-to-wifi.sh --ssid $test_ssid --wifi-password $test_password
yellow "***********************"
echo

cd $script_path/../ansible

yellow "Running test-boot-to-wifi playbook"
echo
yellow "***********************"
echo
set +e
ansible-playbook -i '127.0.0.1,' --extra-vars "test_ssid=${test_ssid} test_password=${test_password}" test-boot-to-wifi.yml "$@"
test_exit_code=$?
set -e
yellow "***********************"
echo

[[ $test_exit_code == 0 ]] && green "Success" || red "Test failures"
