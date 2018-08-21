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
      "deploy" \
      "logs" \
    )

    cand_descriptions=(\
      "build all images" \
      "deploy server" \
      "logs" \
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
    boom-build-all
  elif [[ $1 == 'deploy' ]]; then
    boom-deploy-server
  elif [[ $1 == 'logs' ]]; then
    boom-logs
  fi
}

zaw-register-src -n rad-boomwaffle-pi zaw-src-rad-boomwaffle-pi
