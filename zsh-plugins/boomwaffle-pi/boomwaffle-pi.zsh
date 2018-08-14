#export PATH="${PATH}:~/code/boom-waffle/bin"

boom-build-all() {
  rad-yellow "Building all boom-waffle docker images"
  /home/pi/boom-waffle/docker/build_all.sh
}
