# shellcheck shell=bash
###############################################################################
# Installatiebestand voor Ubuntu 20.04 LTS desktop op pc01.                   #
#                                                                             #
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.                         #
###############################################################################

#1 bluetooth
#2 Bluetooth - Externe bluetooth-adapter
echo 'SUBSYSTEM=="usb", ATTRS{idVendor}=="413c", ATTRS{idProduct}=="8187", ATTR{authorized}="0"' | sudo tee /etc/udev/rules.d/81-bluetooth-hci.rules
#4 1. Start Terminalvenster en voer uit:
#4    sudo rm /etc/udev/rules.d/81-bluetooth-hci.rules

#1 exiftool
#2 ExifTool - Metadata lezen en schrijven
sudo apt-get install --yes libimage-exiftool-perl
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes libimage-exiftool-perl

#1 git
#2 Git - Versiebeheersysteem
sudo apt-get install --yes aspell-nl git gitg
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes git gitg

#1 karel
#2 Karel - Systeemgebruiker
## Voor toegang op afstand en systeembeheer.
sudo useradd --create-home --shell=/usr/bin/bash --comment='Karel Zimmer' --groups=sudo karel || true
sudo cp /var/lib/AccountsService/users/{gdm,karel}
#3 Start Terminalvenster en voer uit:
#3    sudo passwd karel
#4 Start Terminalvenster en voer uit:
#4    sudo userdel --remove karel

#1 openssh
#2 OpenSSH - Toegang op afstand
sudo apt-get install --yes ssh
sudo sed --in-place --expression='s/PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
## Check op remote root-toegang.
grep --quiet --regexp='PermitRootLogin no' /etc/ssh/sshd_config
sudo systemctl restart ssh.service
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes ssh

#1 python
#2 Python - Programmeertaal
sudo apt-get install --yes pycodestyle python3-pycodestyle python3-autopep8 python3-pip python-is-python3
sudo ln --force --relative --symbolic /usr/bin/pycodestyle /usr/bin/pep8
sudo ln --force --relative --symbolic /usr/bin/pip3 /usr/bin/pip
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes pycodestyle python3-pycodestyle python3-autopep8 python3-pip python-is-python3
#4    sudo rm --force /usr/bin/pip

#1 vscode
#2 Visual Studio Code - Editor
sudo snap install --classic code
#4 Start Terminalvenster en voer uit:
#4    sudo snap remove code
