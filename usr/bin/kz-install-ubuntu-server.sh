# shellcheck shell=bash
###############################################################################
# Install file for Ubuntu server.
#
# Written by Karel Zimmer <info@karelzimmer.nl>
# CC0 1.0 <https://creativecommons.org/publicdomain/zero/1.0>.
###############################################################################

# Install APP ansible HOST *
sudo apt-get install --yes ansible

# Remove APP ansible HOST *
sudo apt-get remove --yes ansible


# Install APP cloud-init HOST *
# To prevent extra lines from cloud-init printed in terminal at login.
sudo touch /etc/cloud/cloud-init.disabled

# Remove APP cloud-init HOST *
sudo rm --force --verbose /etc/cloud/cloud-init.disabled


# Install APP fwupd HOST
# Disable the Firmware update daemon
sudo systemctl stop fwupd.service       # Stop the service
sudo systemctl disable fwupd.service    # Disable automatic start upon boot
sudo systemctl mask fwupd.service       # Disable manual invoking

# Remove APP fwupd HOST
# Enable the Firmware update daemon
systemctl unmask fwupd.service
sudo systemctl enable fwupd.service
sudo systemctl start fwupd.service


# Install APP locate HOST *
sudo apt-get install --yes mlocate

# Remove APP locate HOST *
sudo apt-get remove --yes mlocate


# Install APP repair-ntfs HOST
# Usage:
# findmnt
# TARGET          SOURCE    FSTYPE OPTIONS
# /media/...      /dev/sdb2 ntfs3  rw,nosuid,nodev,relatime,uid=...
# sudo ntfsfix /dev/sdb2
sudo apt-get install --yes ntfs-3g

# Remove APP repair-ntfs HOST
sudo apt-get remove --yes ntfs-3g


# Install APP ssh HOST *
sudo apt-get install --yes ssh
sudo sed --in-place --expression='s/PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
# Check for remote root access
grep --quiet --regexp='PermitRootLogin no' /etc/ssh/sshd_config
sudo systemctl restart ssh.service

# Remove APP ssh HOST *
sudo sed --in-place --expression='s/PermitRootLogin no/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config
sudo sed --in-place --expression='s/PermitRootLogin no/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config
sudo apt-get remove --yes ssh


# Install APP ufw HOST *
sudo apt-get install --yes ufw
sudo ufw allow ssh
sudo ufw enable

# Remove APP ufw HOST *
sudo ufw disable
sudo apt-get remove --yes ufw
