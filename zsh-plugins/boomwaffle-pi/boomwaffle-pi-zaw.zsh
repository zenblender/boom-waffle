bindkey '^[W' zaw-rad-boomwaffle-pi

#### dhost zaw source
###
### provides a filterable list of your dhost aliases
###
### key: option + shift + H

function zaw-src-rad-boomwaffle-pi() {
    local title="actions"
    candidates=(\
      "build-all" \
      "deploy-server" \
      "deploy-client" \
      "logs-hub" \
      "logs-drone" \
    )

    cand_descriptions=(\
      "build all images" \
      "deploy (hub)" \
      "deploy (drone)" \
      "logs (hub)" \
      "logs (drone)" \
    )

    actions=(\
      "zaw-rad-boomwaffle-pi-run-command" \
      "zaw-rad-append-to-buffer" \
    )

    act_descriptions=(\
      "run command" \
      "append hostname to buffer"
    )

    options=(-t "$title" -m -k)
}

function zaw-rad-boomwaffle-pi-run-command() {
  if [[ $1 == 'build-all' ]]; then
    zaw-rad-buffer-action 'boom-build-all'
  elif [[ $1 == 'deploy-server' ]]; then
    zaw-rad-buffer-action 'boom-deploy-server'
  elif [[ $1 == 'deploy-client' ]]; then
    zaw-rad-buffer-action 'boom-deploy-client'
  elif [[ $1 == 'logs-hub' ]]; then
    zaw-rad-buffer-action 'boom-server-logs'
  elif [[ $1 == 'logs-drone' ]]; then
    zaw-rad-buffer-action 'boom-client-logs'
  fi
}

zaw-register-src -n rad-boomwaffle-pi zaw-src-rad-boomwaffle-pi
