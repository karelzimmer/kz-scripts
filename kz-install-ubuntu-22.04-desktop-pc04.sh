# shellcheck shell=bash
###############################################################################
# Installatiebestand voor Ubuntu 20.04 LTS desktop op pc04.                   #
#                                                                             #
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.                         #
###############################################################################

#1 calibre (e-boekmanager)
sudo apt-get install --yes calibre
#2 Start Terminalvenster en voer uit:
#2    sudo apt remove calibre

#1 dropbox (cloudopslag)
sudo apt-get install --yes nautilus-dropbox
#2 Start Terminalvenster en voer uit:
#2    sudo apt remove nautilus-dropbox

#1 google-earth (verken de wereld)
printf '%s\n' 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-earth.gpg] http://dl.google.com/linux/earth/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-earth.list
wget --no-verbose --output-document=- https://dl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmor --yes --output=/usr/share/keyrings/google-earth.gpg
sudo apt-get update
sudo apt-get install --yes google-earth-pro-stable
sudo apt-key del 7FAC5991 D38B4796
sudo rm --force /etc/apt/trusted.gpg.d/google-earth*
## Extra needed after first install.
printf '%s\n' 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-earth.gpg] http://dl.google.com/linux/earth/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-earth.list
#2 Start Terminalvenster en voer uit:
#2    sudo apt remove --yes google-earth-pro-stable
#2    sudo rm /etc/apt/sources.list.d/google-earth.list* /usr/share/keyrings/google-earth.gpg*
#2    sudo apt update

#1 wine (windowsapps op Linux)
sudo apt-get install --yes wine winetricks playonlinux
#2 Start Terminalvenster en voer uit:
#2    sudo apt remove wine winetricks playonlinux
