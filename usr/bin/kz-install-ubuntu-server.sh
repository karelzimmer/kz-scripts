# shellcheck shell=bash
###############################################################################
# Install file for Ubuntu server.
#
# Written by Karel Zimmer <info@karelzimmer.nl>, CC0 1.0 Universal
# <https://creativecommons.org/publicdomain/zero/1.0>, 2023-2024.
###############################################################################

#+ APP ansible HOST *
sudo apt-get install --yes ansible

#- APP ansible HOST *
sudo apt-get remove --yes ansible


#+ APP cloud-init HOST *
# To prevent extra lines from cloud-init printed in terminal at login.
sudo touch /etc/cloud/cloud-init.disabled

#- APP cloud-init HOST *
sudo rm --force --verbose /etc/cloud/cloud-init.disabled


#+ APP fwupd HOST
# Disable the Firmware update daemon
sudo systemctl stop fwupd.service       # Stop the service
sudo systemctl disable fwupd.service    # Disable automatic start upon boot
sudo systemctl mask fwupd.service       # Disable manual invoking

#- APP fwupd HOST
# Enable the Firmware update daemon
systemctl unmask fwupd.service
sudo systemctl enable fwupd.service
sudo systemctl start fwupd.service


#+ APP locate HOST *
sudo apt-get install --yes mlocate

#- APP locate HOST *
sudo apt-get remove --yes mlocate


#+ APP repair-ntfs HOST
# Usage:
# findmnt
# TARGET          SOURCE    FSTYPE OPTIONS
# /media/...      /dev/sdb2 ntfs3  rw,nosuid,nodev,relatime,uid=...
# sudo ntfsfix /dev/sdb2
sudo apt-get install --yes ntfs-3g

#- APP repair-ntfs HOST
sudo apt-get remove --yes ntfs-3g


#+ APP ssh HOST *
sudo apt-get install --yes ssh
sudo sed --in-place --expression='s/PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
# Check for remote root access
grep --quiet --regexp='PermitRootLogin no' /etc/ssh/sshd_config
sudo systemctl restart ssh.service

#- APP ssh HOST *
sudo sed --in-place --expression='s/PermitRootLogin no/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config
sudo sed --in-place --expression='s/PermitRootLogin no/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config
sudo apt-get remove --yes ssh


#+ APP ufw HOST *
sudo apt-get install --yes ufw
sudo ufw allow ssh
sudo ufw enable

#- APP ufw HOST *
sudo ufw disable
sudo apt-get remove --yes ufw
