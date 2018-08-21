#export PATH="${PATH}:~/code/boom-waffle/bin"

source "${0:a:h}/boomwaffle-pi-zaw.zsh"

# Add Python binaries (docker-compose, etc) to path
PATH="$PATH:$HOME/.local/bin"

### boom-build-all - build all docker images
boom-build-all() {
  rad-yellow "Building all boom-waffle docker images"
  /home/pi/boom-waffle/docker/build_all.sh
}
