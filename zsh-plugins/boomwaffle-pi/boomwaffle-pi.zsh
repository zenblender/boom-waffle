
export PATH="${PATH}:~/code/boom-waffle/bin"

# Add your boomwaffle ssh key to the ssh agent
boomwaffle-ssh() {
  eval $(~/code/boom-waffle/bin/add-ssh.sh)
}
