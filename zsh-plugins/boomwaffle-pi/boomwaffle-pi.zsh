#export PATH="${PATH}:~/code/boom-waffle/bin"

source "${0:a:h}/boomwaffle-pi-zaw.zsh"

# Add Python binaries (docker-compose, etc) to path
PATH="$PATH:$HOME/.local/bin"

### boom-build-all - build all docker images
boom-build-all() {
  rad-yellow "Building all boom-waffle docker images"
  /home/pi/boom-waffle/docker/build_all.sh
}

### boom-deploy-server - depoy server
boom-deploy-server() {
  rad-yellow "Deploying server containers with deploy.sh script"
  /home/pi/boom-waffle/deploy/server/deploy.sh
}

### boom-logs - view container logs
boom-logs() {
  rad-yellow "Showing container logs"
  cd "/home/pi/boom-waffle/deploy/server/"
  docker-compose logs -f
}
