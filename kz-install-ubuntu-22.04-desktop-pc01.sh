# shellcheck shell=bash
###############################################################################
# Installatiebestand voor Ubuntu 22.04 LTS desktop op pc01.                   #
#                                                                             #
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.                         #
###############################################################################

#1-bluetooth (externe bluetooth-adapter)
printf '%s\n' 'SUBSYSTEM=="usb", ATTRS{idVendor}=="413c", ATTRS{idProduct}=="8187", ATTR{authorized}="0"' | sudo tee /etc/udev/rules.d/81-bluetooth-hci.rules
#2 sudo rm /etc/udev/rules.d/81-bluetooth-hci.rules

#1 exiftool (metadata lezen en schrijven)
sudo apt-get install --yes libimage-exiftool-perl
#2 sudo apt remove --yes libimage-exiftool-perl

#1 git (versiebeheersysteem)
sudo apt-get install --yes aspell-nl git
#2 sudo apt remove --yes git

#1 gnome-gmail (Gmail als de favoriete e-mailtoepassing in GNOME)
sudo apt-get install --yes gnome-gmail
#2 sudo apt remove --yes gnome-gmail

#1 python (programmeertaal)
sudo apt-get install --yes pycodestyle python3-pycodestyle python3-autopep8 python3-pip python-is-python3
sudo ln --force --relative --symbolic /usr/bin/pycodestyle /usr/bin/pep8
sudo ln --force --relative --symbolic /usr/bin/pip3 /usr/bin/pip
#2 sudo apt remove --yes pycodestyle python3-pycodestyle python3-autopep8 python3-pip python-is-python3
#2 sudo rm /usr/bin/pip

#1 vscode (editor)
sudo snap install --classic code
#2 sudo snap remove code
