# shellcheck shell=bash
###############################################################################
# Standard uninstaller file for Ubuntu server.
#
# Written by Karel Zimmer <info@karelzimmer.nl>, CC0 1.0 Universal
# <https://creativecommons.org/publicdomain/zero/1.0>, 2023.
###############################################################################

# APP ansible *
sudo apt-get remove --yes ansible

# APP cloud-init *
sudo rm --force /etc/cloud/cloud-init.disabled

# APP locate *
sudo apt-get remove --yes mlocate

# APP ssh *
sudo sed --in-place --expression='s/PermitRootLogin no/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config
sudo sed --in-place --expression='s/PermitRootLogin no/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config
sudo apt-get remove --yes ssh

# APP ufw *
sudo ufw disable
sudo apt-get remove --yes ufw
