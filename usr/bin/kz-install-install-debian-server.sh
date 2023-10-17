# shellcheck shell=bash
###############################################################################
# Standard installation file for Debian server.
#
# Written by Karel Zimmer <info@karelzimmer.nl>, CC0 1.0 Universal
# <https://creativecommons.org/publicdomain/zero/1.0>, 2023.
###############################################################################

# APP ansible *
sudo apt-get install --yes ansible


# APP locate *
sudo apt-get install --yes mlocate


# APP add-user-to-group *
# Enable access to system monitoring tasks like read many log files in /var/log.
sudo adduser "${SUDO_USER:-$USER}" adm


# APP ssh *
sudo apt-get install --yes ssh
sudo sed --in-place --expression='s/PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
# Check for remote root access
grep --quiet --regexp='PermitRootLogin no' /etc/ssh/sshd_config
sudo systemctl restart ssh.service


# APP ufw *
sudo apt-get install --yes ufw
sudo ufw allow ssh
sudo ufw enable
