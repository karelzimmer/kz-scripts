# shellcheck shell=bash
###############################################################################
# Installatiebestand voor Ubuntu 20.04 desktop op pc04.                       #
#                                                                             #
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.                         #
###############################################################################

#1 calibre (e-boekmanager)
sudo apt-get install --yes calibre
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove calibre

#1 dropbox (cloudopslag)
sudo apt-get install --yes nautilus-dropbox
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove nautilus-dropbox

#1 earth (verken de wereld)
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-earth.gpg] http://dl.google.com/linux/earth/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-earth-pro.list
wget --no-verbose --output-document=- https://dl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmor --yes --output=/usr/share/keyrings/google-earth.gpg
sudo apt-get update
sudo apt-get install --yes google-earth-pro-stable
sudo apt-key del 7FAC5991 D38B4796
sudo rm --force /etc/apt/trusted.gpg.d/google-earth*
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove --yes google-earth-pro-stable
#3    sudo rm /etc/apt/sources.list.d/google-earth.list* /usr/share/keyrings/google-earth.gpg*
#3    sudo apt update

#1 wine (windowsapps op Linux)
sudo apt-get install --yes wine winetricks playonlinux
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove wine winetricks playonlinux
