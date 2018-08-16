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

## Workflow for creating a new boom-waffle

### Setup

- This repo must be cloned, transcrypt set up, etc
- Put the Pi SD card into a card reader attached to your computer
- Have an available wifi network w/o a hidden SSID (pi's have problems with hidden ssid's)
- These instructions only work with MacOS

### Flash the SD card and configure WiFi

- Run `diskutil list` to determine which device you want to flash
  - e.g., `/dev/disk3`
  - Make sure you pick the correct disk!
- Run: `./bin/0-boot-to-wifi.sh --disk <your device> --ssid <your ssid> --wifi-password <your wifi password>` 
  - This will: 
    - Flash the Debian Stretch image using the etcher-cli
    - Mount the disk again after flashing
    - Run the `boot-to-wifi.yml` playbook
    - Unmount the disk so it can be safely removed

- You should now be able to connect to connect to the raspbarry pi on the network at `raspberrypi.local`
- If not, figure out what went wrong and try again ;)

### First boot configuration

- This will set the hostname and configure SSH keys
- Run: `./bin/1-first-boot.sh --new-hostname <new pi hostname>`
  - You will be required to enter the password for the `pi` user, which is `raspberry`
  - Your desired hostname will have .local appended to it by some sort of mDNS magic
- The pi will restart after this step and come back online with the new hostname

### Fully configure the Pi

- Once you can successfully SSH into the pi using its new hostname, you can run the main configuration
- Make sure to source the ssh key in this repo for passwordless login
  - Run: `eval $(./bin/add-ssh.sh)`
- Run `./bin/2-full-config.sh --hostname <pi hostname>` to configure the pi
- This will:
  - Install docker and docker-compose
  - Install zsh, git, and rad-shell
- After this, your pi will have all the necessary pieces ready to configure it

## Zsh Plugins

There are two plugins, one for your development machine and one that will be
installed on the pi.

[boomwaffle-local-dev readme](./zsh-plugins/boomwaffle-local-dev/README.md)
[boomwaffle-pi readme](./zsh-plugins/boomwaffle-pi/README.md)
