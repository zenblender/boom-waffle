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

### boom-deploy-server - depoy server
boom-deploy-client() {
  rad-yellow "Deploying client containers with deploy.sh script"
  /home/pi/boom-waffle/deploy/client/deploy.sh
}

### boom-server-logs - view container logs
boom-server-logs() {
  rad-yellow "Showing server logs"
  cd "/home/pi/boom-waffle/deploy/server/"
  docker-compose logs -f
}

### boom-client-logs - view container logs
boom-client-logs() {
  rad-yellow "Showing client logs"
  cd "/home/pi/boom-waffle/deploy/client/"
  docker-compose logs -f
}
