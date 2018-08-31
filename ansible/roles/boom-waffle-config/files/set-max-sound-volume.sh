#!/bin/bash -el

# set volume of onboard audio:
amixer -c 0 set -- PCM playback "-1.3dB" || true

# set volume of USB sound card (if present):
amixer -c 1 set -- Speaker playback "-6dB" || true
