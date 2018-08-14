export PATH="${PATH}:~/code/boom-waffle/bin"

export BOOM_WAFFLE_PATH="${BOOM_WAFFLE_PATH:-"${HOME}/code/boom-waffle"}"

# Add your boomwaffle ssh key to the ssh agent
boom-ssh() {
  eval $("${BOOM_WAFFLE_PATH}/bin/add-ssh.sh")
}

boom-watch() {
  "${BOOM_WAFFLE_PATH}/bin/boom-watch.sh"
}
