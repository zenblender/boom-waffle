source "${0:a:h}/boomwaffle-dev-zaw.zsh"

export PATH="${PATH}:${BOOMWAFFLE_PATH}/bin"

export BOOMWAFFLE_PATH="${BOOMWAFFLE_PATH:-"${HOME}/code/boom-waffle"}"

# Add your boomwaffle ssh key to the ssh agent
boom-ssh() {
  eval $("${BOOMWAFFLE_PATH}/bin/add-ssh.sh")
}

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
  BOOMWAFFLE_LIST+=($1)
}

boomwaffle-clear() {
  BOOMWAFFLE_LIST=()
}

boomwaffle-list() {
  printf '%s\n' "${BOOMWAFFLE_LIST[@]}"
}

waffle-status() {
  "${BOOMWAFFLE_PATH}/bin/waffle-status.rb" $(boomwaffle-list)
}
