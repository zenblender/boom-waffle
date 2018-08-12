# boom-waffle tests

This directory contains some experimental tests against the playbooks.  The tests
themselves are playbooks written in Ansible that verify our scripts work how we
expect.

To run the tests, run `./test/bin/<test to run>.sh`,
e.g.: `./test/bin/test-boot-to-wifi.sh`

**Important: These tests are destructive and run the playbooks against your actual
hardware!**

For example, running `./test/bin/test-boot-to-wifi.sh` will write files
to the directory `/Volume/boot` and assert against the files that get written
