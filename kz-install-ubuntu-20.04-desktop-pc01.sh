# shellcheck shell=bash
###############################################################################
# Installatiebestand voor Ubuntu 20.04 LTS desktop op pc01.                   #
#                                                                             #
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.                         #
###############################################################################

#1 bluetooth (Externe bluetooth-adapter)
printf '%s\n' 'SUBSYSTEM=="usb", ATTRS{idVendor}=="413c", ATTRS{idProduct}=="8187", ATTR{authorized}="0"' | sudo tee /etc/udev/rules.d/81-bluetooth-hci.rules
#3 1. Start Terminalvenster en voer uit:
#3    sudo rm /etc/udev/rules.d/81-bluetooth-hci.rules

#1 exiftool (Metadata lezen en schrijven)
sudo apt-get install --yes libimage-exiftool-perl
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove --yes libimage-exiftool-perl

#1 git (Versiebeheersysteem)
sudo apt-get install --yes aspell-nl git
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove --yes git

#1 python (Programmeertaal)
sudo apt-get install --yes pycodestyle python3-pycodestyle python3-autopep8 python3-pip python-is-python3
sudo ln --force --relative --symbolic /usr/bin/pycodestyle /usr/bin/pep8
sudo ln --force --relative --symbolic /usr/bin/pip3 /usr/bin/pip
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove --yes pycodestyle python3-pycodestyle python3-autopep8 python3-pip python-is-python3
#3    sudo rm --force /usr/bin/pip

#1 vscode (Visual Studio Code editor)
sudo snap install --classic code
#3 Start Terminalvenster en voer uit:
#3    sudo snap remove code
