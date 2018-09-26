#!/bin/bash -el

# if wlan1 (USB WiFi adaptor) is connected, disable onboard wlan0 until next boot
ifconfig | grep wlan1 && ifconfig wlan0 down
