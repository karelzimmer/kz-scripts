# shellcheck shell=bash
###############################################################################
# Uninstall file for Ubuntu server.
#
# Written by Karel Zimmer <info@karelzimmer.nl>, CC0 1.0 Universal
# <https://creativecommons.org/publicdomain/zero/1.0>, 2023-2024.
###############################################################################


# APP ansible HOST *
sudo apt-get remove --yes ansible


# APP cloud-init HOST *
sudo rm --force --verbose /etc/cloud/cloud-init.disabled


# APP fwupd HOST
# Enable the Firmware update daemon
systemctl unmask fwupd.service
sudo systemctl enable fwupd.service
sudo systemctl start fwupd.service


# APP locate HOST *
sudo apt-get remove --yes mlocate


# APP repair-ntfs HOST
sudo apt-get remove --yes ntfs-3g


# APP ssh HOST *
sudo sed --in-place --expression='s/PermitRootLogin no/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config
sudo sed --in-place --expression='s/PermitRootLogin no/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config
sudo apt-get remove --yes ssh


# APP ufw HOST *
sudo ufw disable
sudo apt-get remove --yes ufw
