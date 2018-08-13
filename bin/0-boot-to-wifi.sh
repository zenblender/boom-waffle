#!/bin/bash -el

script_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${script_path}/_shared-scripts.sh"

cleanup() {
  local exit_code=$1
  local previous_command=$BASH_COMMAND
  [[ $exit_code -ne 0 ]] && echo "INFO: Script exited with code $exit_code from command $previous_command"
  exit $exit_code
}
trap 'cleanup $?' EXIT

usage() {
  yellow "usage: ./bin/0-boot-to-wifi.sh --ssid <ssid> --wifi-password <wifi-password> [--disk <disk to flash>]"
  yellow "Flashes Raspbian Stretch to an SD card (optional), enables SSH, and configures wifi"
  yellow "If you omit the --disk option, it will not flash the card (this assumes you have already flashed the SD card)"
  yellow "Find your device with 'diskutil list'.  It will be something like '/dev/disk2' (don't pick the wrong one!)"
}

get_cache_path() {
  local component=$1
  local cache_path="${script_path}/../.cache/${component}"
  mkdir -p "${cache_path}"
#  cyan "made cache path ${cache_path}"
  printf "${cache_path}\n"
}

get_etcher_bin_path() {
  printf "$(get_cache_path etcher)/etcher-cli-1.4.4-darwin-x64-dist/etcher"
}

ensure_etcher_cli_available() {
  local etcher_cache_path="$(get_cache_path etcher)"
  local etcher_tar_filename="etcher-cli-1.4.4-darwin-x64.tar.gz"

  yellow "Ensuring etcher-cli is available"
  if [[ ! -f "${etcher_cache_path}/${etcher_tar_filename}" ]]; then
    yellow "Downloading etcher to ${etcher_cache_path}/${etcher_tar_filename}"
    curl -Lo "${etcher_cache_path}/${etcher_tar_filename}" "https://github.com/resin-io/etcher/releases/download/v1.4.4/${etcher_tar_filename}"
  fi

  local etcher_bin_path="$(get_etcher_bin_path)"

  if [[ ! -f "${etcher_bin_path}" ]]; then
    yellow "Extracting etcher tar.gz to ${etcher_cache_path}"
    tar -xzf "${etcher_cache_path}/${etcher_tar_filename}" -C "${etcher_cache_path}"
  fi

  if [[ -f "${etcher_bin_path}" ]]; then
    green "Etcher is available at ${etcher_bin_path}"
  fi
}

get_raspbian_img_path() {
  local raspbian_cache_path="$(get_cache_path raspbian)"
  printf "${raspbian_cache_path}/raspbian_lite_latest.zip"
}

download_raspbian() {
  local raspbian_cache_path="$(get_cache_path raspbian)"
  yellow "Downloading Raspbian image"
  curl -Lo "$(get_raspbian_img_path)" https://downloads.raspberrypi.org/raspbian_lite_latest
}

ensure_raspbian_is_available() {
  set +e
  [[ ! -f "$(get_raspbian_img_path)" ]] && {
    yellow "Raspbian is not downloaded"
    download_raspbian
  }
  set -e
}

flash_sd_card() {
  local etcher_cache_path="${script_path}/../.cache/etcher"
  local etcher_bin_path="$(get_etcher_bin_path)"
  local disk_id=$1

  ensure_etcher_cli_available

  ensure_raspbian_is_available

  yellow "Flashing Raspbian to disk: $(cyan "${disk_id}")"
  diskutil info "${disk_id}"
  yellow "If this info looks correct, enter your password to continue"
  sudo "${etcher_bin_path}" --drive "${disk_id}" "$(get_raspbian_img_path)"
}

[[ $# -lt 4 ]] && { usage; exit 1; }

# Parse options
while [[ $# -gt 0 ]]; do
  key="$1"

  case $key in
    --ssid) ssid="$2"; shift; shift;;
    --wifi-password) wifi_password="$2"; shift; shift;;
    --disk) disk_to_flash="$2"; shift; shift;;
    *) echo "Unknown option: $1"; usage; exit 1;;
  esac
done

[[ -n $ssid ]] && [[ -n $wifi_password ]] || { usage; exit 1; }
[[ -n "${disk_to_flash}" ]] && {
  flash_sd_card "${disk_to_flash}"

  green "Finished flashing SD card"
  diskutil mountDisk "${disk_to_flash}"
}

cd $script_path/../ansible

yellow "Running playbook boot-to-wifi.yml"

ansible-playbook -i '127.0.0.1,' --extra-vars "ssid='${ssid}' wifi_password='${wifi_password}'" boot-to-wifi.yml


green "Finished running playbook boot-to-wifi.yml"

diskutil unmountDisk "${disk_to_flash}"
green "Device ${disk_to_flash} was unmounted.  You can remove it now"
