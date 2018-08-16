#export PATH="${PATH}:~/code/boom-waffle/bin"

source "${0:a:h}/boomwaffle-pi-zaw.zsh"

### boom-build-all - build all docker images
boom-build-all() {
  rad-yellow "Building all boom-waffle docker images"
  /home/pi/boom-waffle/docker/build_all.sh
}
