#!/bin/bash -el

# disable power saving for any wlan0 / wlan1 that is available:
iw dev wlan0 set power_save off || true
iw dev wlan1 set power_save off || true
