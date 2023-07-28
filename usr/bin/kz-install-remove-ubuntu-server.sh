# shellcheck shell=bash
###############################################################################
# Standard uninstaller file for Ubuntu server.
#
# This script file is used by script kz-install.
# Use 'man kz install' for more information.
#
# Written by Karel Zimmer <info@karelzimmer.nl>, CC0 1.0 Universal
# <https://creativecommons.org/publicdomain/zero/1.0>, 2023.
###############################################################################

#  APP ansible
# HOST *
sudo apt-get remove --yes ansible

#  APP locate
# HOST *
sudo apt-get remove --yes mlocate

#  APP ssh
# HOST *
sudo sed --in-place --expression='s/PermitRootLogin no/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config
sudo sed --in-place --expression='s/PermitRootLogin no/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config
sudo apt-get remove --yes ssh

#  APP ufw
# HOST *
sudo ufw disable
sudo apt-get remove --yes ufw
