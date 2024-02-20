# shellcheck shell=bash
###############################################################################
# Install file for Debian server.
#
# Written by Karel Zimmer <info@karelzimmer.nl>, CC0 1.0 Universal
# <https://creativecommons.org/publicdomain/zero/1.0>, 2023-2024.
###############################################################################

# install APP ansible HOST *
sudo apt-get install --yes ansible

# remove APP ansible HOST *
sudo apt-get remove --yes ansible


# install APP locate HOST *
sudo apt-get install --yes mlocate

# remove APP locate HOST *
sudo apt-get remove --yes mlocate


# install APP repair-ntfs HOST
# Usage:
# findmnt
# TARGET          SOURCE    FSTYPE OPTIONS
# /media/...      /dev/sdb2 ntfs3  rw,nosuid,nodev,relatime,uid=...
# sudo ntfsfix /dev/sdb2
sudo apt-get install --yes ntfs-3g

# remove APP repair-ntfs HOST
sudo apt-get remove --yes ntfs-3g


# install APP ssh HOST *
sudo apt-get install --yes ssh
sudo sed --in-place --expression='s/PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
# Check for remote root access
grep --quiet --regexp='PermitRootLogin no' /etc/ssh/sshd_config
sudo systemctl restart ssh.service

# remove APP ssh HOST *
sudo sed --in-place --expression='s/PermitRootLogin no/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config
sudo sed --in-place --expression='s/PermitRootLogin no/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config
sudo apt-get remove --yes ssh


# install APP ufw HOST *
sudo apt-get install --yes ufw
sudo ufw allow ssh
sudo ufw enable

# remove APP ufw HOST *
sudo ufw disable
sudo apt-get remove --yes ufw


# install APP users HOST *
# Enable access to system monitoring tasks like read many log files in /var/log.
sudo usermod --append --groups adm "${SUDO_USER:-$USER}"

# remove APP users HOST *
sudo deluser "${SUDO_USER:-$USER}" adm
