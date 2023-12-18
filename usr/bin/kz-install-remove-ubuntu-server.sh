# shellcheck shell=bash
###############################################################################
# Uninstaller file for Ubuntu server.
#
# Written by Karel Zimmer <info@karelzimmer.nl>, CC0 1.0 Universal
# <https://creativecommons.org/publicdomain/zero/1.0>, 2023.
###############################################################################


# APP ansible HOST *
sudo apt-get remove --purge --yes ansible
sudo apt-get autoremove --yes


# APP cloud-init HOST *
sudo rm --force /etc/cloud/cloud-init.disabled


# APP fwupd HOST
systemctl unmask fwupd.service
sudo systemctl enable fwupd.service
sudo systemctl start fwupd.service


# APP locate HOST *
sudo apt-get remove --purge --yes mlocate
sudo apt-get autoremove --yes


# APP repair-ntfs HOST
sudo apt-get remove --purge --yes ntfs-3g
sudo apt-get autoremove --yes


# APP ssh HOST *
sudo sed --in-place --expression='s/PermitRootLogin no/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config
sudo sed --in-place --expression='s/PermitRootLogin no/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config
sudo apt-get remove --purge --yes ssh
sudo apt-get autoremove --yes


# APP ufw HOST *
sudo ufw disable
sudo apt-get remove --purge --yes ufw
sudo apt-get autoremove --yes
