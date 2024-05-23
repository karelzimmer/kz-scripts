# shellcheck shell=bash
###############################################################################
# SPDX-FileComment: Install file for Debian server
#
# SPDX-FileCopyrightText: Karel Zimmer <info@karelzimmer.nl>
# SPDX-License-Identifier: CC0-1.0
###############################################################################

# Install update-system *
# Do this first.
# Update the system.
sudo apt-get update
sudo apt-get upgrade --yes
sudo snap refresh

# Remove  update-system *
# Do this first.
# There is no command available to remove update system.


# Install ansible *
sudo apt-get install --yes ansible

# Remove  ansible *
sudo apt-get remove --yes ansible


# Install fwupd -nohost
# Disable the Firmware update daemon.
sudo systemctl stop fwupd.service
sudo systemctl disable fwupd.service
sudo systemctl mask fwupd.service

# Remove  fwupd -nohost
# Enable the Firmware update daemon.
sudo systemctl unmask fwupd.service
sudo systemctl enable fwupd.service
sudo systemctl start fwupd.service


# Install locate *
sudo apt-get install --yes locate
sudo updatedb

# Remove  locate *
sudo apt-get remove --yes locate


# Install repair-ntfs -nohost
sudo apt-get install --yes ntfs-3g
# Usage:
# $ findmnt
#   TARGET          SOURCE    FSTYPE OPTIONS
#   /media/...      /dev/sdb2 ntfs3  rw,nosuid,nodev,relatime,uid=...
# $ sudo ntfsfix /dev/sdb2

# Remove  repair-ntfs -nohost
sudo apt-get remove --yes ntfs-3g


# Install ssh *
sudo apt-get install --yes ssh
sudo sed --in-place --expression='s/PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
# Check for remote root access.
grep --quiet --regexp='PermitRootLogin no' /etc/ssh/sshd_config
sudo systemctl restart ssh.service

# Remove  ssh *
sudo sed --in-place --expression='s/PermitRootLogin no/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config
sudo sed --in-place --expression='s/PermitRootLogin no/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config
sudo apt-get remove --yes ssh


# Install ufw *
sudo apt-get install --yes ufw
sudo ufw allow ssh
sudo ufw enable

# Remove  ufw *
sudo ufw disable
sudo apt-get remove --yes ufw


# Install users *
# Enable access to system monitoring tasks like read many log files in /var/log.
sudo usermod --append --groups adm "${SUDO_USER:-$USER}"

# Remove  users *
sudo deluser "${SUDO_USER:-$USER}" adm
