# boom-waffle

Boom-waffle is a synchronized multicast audio solution using raspberry pi,
shairport-sync, and snapcast.

This repo includes ansible playbooks for configuring the pi's, tools to build
docker images for running the software, and scripts to tie it all together.

## Setup

This repo is encrypted using [transcrypt](https://github.com/elasticdog/transcrypt).

The transcrypt executable is included in the bin folder, you can use it with `./bin/transcrypt <options>`

Transcrypt allows us to safely store SSH credentials for the pi's in the repo.

This only needs to be configured once after the repo is cloned.

## Playbooks

There are currently two playbooks:

### boot-to-wifi

This playbook should be run after the pi's SD card has been flashed with Raspbian Stretch,
but before putting the card into the pi and booting it up.  After flashing,
take the card out and reinsert it into your card reader so you can access the
card at `/Volumes/boot`.  The playbook will write the configuration to enable SSH
and to connect to your wifi network.

To run it: `./bin/boot-to-wifi.sh`

### config-raspberry-pi.yml

This playbook is run after the wifi is available on the network.  This installs
docker, syncs the repo to the pi, and adds an SSH private key to the pi for
passwordless logon.

To run it: `./bin/config-raspberry-pi-ansible.sh`

## Passwordless logon to the Pi's

**Make sure you have configured transcrypt properly**

Run: `eval $(./bin/add-ssh.sh)` to add the key to your keychain

Currently this needs to be done for each shell but it could be added to your
.zshrc or something if we always want it added.
