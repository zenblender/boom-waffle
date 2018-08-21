source "${0:a:h}/boomwaffle-dev-zaw.zsh"

export PATH="${PATH}:${BOOMWAFFLE_PATH}/bin"

export BOOMWAFFLE_PATH="${BOOMWAFFLE_PATH:-"${HOME}/code/boom-waffle"}"

### boom-ssh - adds the boomwaffle ssh key to your agent
### takes no arguments
boom-ssh() {
  eval $("${BOOMWAFFLE_PATH}/bin/add-ssh.sh")
}

### boom-watch - watches the boomwaffle directory for changes and rsyncs the repo to the raspberry pi
###
### Example: boom-watch your-boomwaffle-hostname
boom-watch() {
  "${BOOMWAFFLE_PATH}/bin/boom-watch.sh" "$@"
}

### boomwaffle-register - register your boomwaffle for boomwaffle-pi-zaw
### call this in your ~/.zshrc
###
### Example: boomwaffle-register your-boomwaffle-hostname
typeset -A BOOMWAFFLE_LIST
BOOMWAFFLE_LIST=()
boomwaffle-register() {
  # Make sure raspberrypi.local is always at the end of the list
  BOOMWAFFLE_LIST=("${BOOMWAFFLE_LIST[@]/raspberrypi.local}")
  BOOMWAFFLE_LIST+=($1)
  BOOMWAFFLE_LIST+=('raspberrypi.local')
}

boomwaffle-clear() {
  BOOMWAFFLE_LIST=('raspberrypi.local')
}

boomwaffle-list() {
  printf '%s\n' "${BOOMWAFFLE_LIST[@]}"
}

waffle-status() {
  "${BOOMWAFFLE_PATH}/bin/waffle-status.rb" $(boomwaffle-list)
}

### waffle-wait-for-pi - calls the wait-for-pi.sh script
### used by boomwaffle-dev-zaw
###
### Example: waffle-wait-for-pi your-boomwaffle-hostname
waffle-wait-for-pi() {
  "${BOOMWAFFLE_PATH}/bin/wait-for-pi.sh" $1
}
