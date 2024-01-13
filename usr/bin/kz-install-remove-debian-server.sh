# shellcheck shell=bash
###############################################################################
# Uninstall file for Debian server.
#
# Written by Karel Zimmer <info@karelzimmer.nl>, CC0 1.0 Universal
# <https://creativecommons.org/publicdomain/zero/1.0>, 2023-2024.
###############################################################################


# APP ansible HOST *
sudo apt-get remove --purge --yes ansible


# APP locate HOST *
sudo apt-get remove --purge --yes mlocate


# APP repair-ntfs HOST
sudo apt-get remove --purge --yes ntfs-3g


# APP ssh HOST *
sudo sed --in-place --expression='s/PermitRootLogin no/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config
sudo sed --in-place --expression='s/PermitRootLogin no/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config
sudo apt-get remove --purge --yes ssh


# APP ufw HOST *
sudo ufw disable
sudo apt-get remove --purge --yes ufw


# APP users HOST *
sudo deluser "${SUDO_USER:-$USER}" adm
