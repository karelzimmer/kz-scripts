# shellcheck shell=bash
###############################################################################
# SPDX-FileComment: Install file for Debian server
#
# SPDX-FileCopyrightText: Karel Zimmer <info@karelzimmer.nl>
# SPDX-License-Identifier: CC0-1.0
###############################################################################

########################## Execute this block first ###########################
# Install APP update HOST *
sudo apt-get update
sudo apt-get upgrade --yes
sudo snap refresh

# Remove APP update HOST *
: # No command.
########################## Execute this block first ###########################


# Install APP ansible HOST *
sudo apt-get install --yes ansible

# Remove APP ansible HOST *
sudo apt-get remove --yes ansible


# Install APP fwupd HOST -nohost
: # Disable the Firmware update daemon.
sudo systemctl stop fwupd.service
sudo systemctl disable fwupd.service
sudo systemctl mask fwupd.service

# Remove APP fwupd HOST -nohost
: # Enable the Firmware update daemon.
sudo systemctl unmask fwupd.service
sudo systemctl enable fwupd.service
sudo systemctl start fwupd.service


# Install APP locate HOST *
sudo apt-get install --yes locate
sudo updatedb

# Remove APP locate HOST *
sudo apt-get remove --yes locate


# Install APP repair-ntfs HOST -nohost
sudo apt-get install --yes ntfs-3g
: # Usage:
: # $ findmnt
: #   TARGET          SOURCE    FSTYPE OPTIONS
: #   /media/...      /dev/sdb2 ntfs3  rw,nosuid,nodev,relatime,uid=...
: # $ sudo ntfsfix /dev/sdb2

# Remove APP repair-ntfs HOST -nohost
sudo apt-get remove --yes ntfs-3g


# Install APP ssh HOST *
sudo apt-get install --yes ssh
sudo sed --in-place --expression='s/PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
: # Check for remote root access.
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


# Install APP users HOST *
: # Enable access to system monitoring tasks like read many log files in /var/log.
sudo usermod --append --groups adm "${SUDO_USER:-$USER}"

# Remove APP users HOST *
sudo deluser "${SUDO_USER:-$USER}" adm
