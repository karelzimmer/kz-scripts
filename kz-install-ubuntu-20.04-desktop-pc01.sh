# shellcheck shell=bash
###############################################################################
# Installatiebestand voor Ubuntu 20.04 LTS desktop op pc01.
#
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.
###############################################################################
# RELEASE_YEAR=2020

# VERSION_NUMBER=03.01.03
# VERSION_DATE=2021-10-17


#1 bluetooth
#2 Externe Bluetooth (bluetooth-adapter) installeren
echo 'SUBSYSTEM=="usb", ATTRS{idVendor}=="413c", ATTRS{idProduct}=="8187", ATTR{authorized}="0"' | sudo tee /etc/udev/rules.d/81-bluetooth-hci.rules
#4 1. Start Terminalvenster en voer uit:
#4    sudo rm /etc/udev/rules.d/81-bluetooth-hci.rules


#1 gast
#2 Gastgebruiker (gast) installeren
sudo useradd --create-home --shell /bin/bash --comment 'Gast' gast || true
sudo chmod 0750 /home/gast
sudo passwd --delete gast
#4 Start Terminalvenster en voer uit:
#4    sudo userdel --remove gast


#1 exiftool
#2 ExifTool (metadata lezen en schrijven) installeren
sudo apt-get install --yes libimage-exiftool-perl
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes libimage-exiftool-perl


#1 gedit
#2 Gedit (editor) installeren
sudo apt-get install --yes gedit-plugins
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes gedit-plugins


#1 git
#2 Git (versiebeheersysteem) installeren
sudo apt-get install --yes aspell-nl git gitg
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes git gitg


#1 karel
#2 Systeemgebruiker (karel) installeren
## Voor toegang op afstand en systeembeheer.
sudo useradd --create-home --shell=/bin/bash --comment='Karel Zimmer' --groups=sudo karel || true
sudo cp /var/lib/AccountsService/users/{gdm,karel}
#3 Start Terminalvenster en voer uit:
#3    sudo passwd karel
#4 Start Terminalvenster en voer uit:
#4    sudo userdel --remove karel


#1 openssh
#2 OpenSSH (toegang op afstand) installeren
sudo apt-get install --yes ssh
sudo sed --in-place --expression='s/PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
## Check op remote root-toegang.
grep --quiet --regexp='PermitRootLogin no' /etc/ssh/sshd_config
sudo systemctl restart ssh.service
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes ssh


#1 python
#2 Python (programmeertaal) installeren
sudo apt-get install --yes idle pycodestyle python3-pycodestyle python3-autopep8 python3-pip python-is-python3
sudo ln --force --relative --symbolic /usr/bin/pip3 /usr/bin/pip
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes idle pycodestyle python3-pycodestyle python3-autopep8 python3-pip python-is-python3
#4    sudo rm --force /usr/bin/pip


# EOF
