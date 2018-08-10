#!/bin/bash

sudo rm /usr/local/bin/shairport-sync
cd ~
sudo apt-get --yes install build-essential git xmltoman autoconf automake libtool libdaemon-dev libpopt-dev libconfig-dev libasound2-dev avahi-daemon libavahi-client-dev libssl-dev
git clone https://github.com/mikebrady/shairport-sync.git shairport-sync-auto
cd shairport-sync-auto
autoreconf -fi
./configure --sysconfdir=/etc --with-alsa --with-avahi --with-ssl=openssl --with-systemd --with-pipe
make
sudo make install
