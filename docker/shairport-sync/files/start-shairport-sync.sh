#!/bin/bash -el

service dbus start
service avahi-daemon start

cd /root/shairport-sync

./shairport-sync -vv
