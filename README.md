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

### Initial configuration (connecting to wireless network)

- Use Etcher to flash the latest Raspbian Stretch OS image to the card
- Afterwards, remove the card and put it back into the so you have it mounted at `/Volumes/boot`
- Run `./bin/boot-to-wifi.sh --ssid <your ssid> --wifi-password <your wifi password>`
  - This enables SSH and sets the wifi credentials
- Safely remove the SD card, put it in the pi, and plugin the pi into power
- You should now be able to connect to connect to the raspbarry pi on the network at `raspberrypi.local`
- If not, figure out what went wrong and try again ;)

### Release the Boomwaffle!

- Once you can successfully SSH into the pi, you can run the main configuration
- Run `./bin/config-raspberry-pi-ansible.sh -p --hostname raspberrypi.local` to configure the pi
  - Use `./bin/config-raspberry-pi-ansible.sh --hostname raspberrypi.local --new-hostname <your desired hostname>`
    to set the hostname on the pi (only takes effect after a reboot)
  - The `-p` option is required the first time you run the playbook, and will ask the raspberry pi password
  - After the first time, this is not required as long as you run `eval $(./bin/add-ssh.sh)` from the repo directory to add the ssh-key
- This installs docker and docker-compose, and copies the repo to the pi
- After this, your pi will have all the necessary pieces ready to configure it
