#!/bin/bash -el

# Setting this to 24 allows it to use the USB sound card when it is plugged in,
# otherwise it will use onboard sound
SOUNDCARD_ID=24

[[ -z "${HUB_HOSTNAME}" ]] && { echo 'Error: Must set $HUB_HOSTNAME'; exit 1; }

# If the environment variable USE_AVAHI is set, we will use avahi to resolve the hostname
if [[ "${USE_AVAHI}" == 'true' ]]; then
  hub_address="$(avahi-resolve-host-name -4 "${HUB_HOSTNAME}" | awk '{print $2}')"
else
  hub_address="${HUB_HOSTNAME}"
fi

echo "Starting snapcast client with hub: ${HUB_HOSTNAME}"
[[ "${USE_AVAHI}" == 'true' ]] && echo "Address resolved by avahi: ${hub_address}"

snapclient --soundcard "${SOUNDCARD_ID}" -h "${hub_address}"
