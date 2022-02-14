# shellcheck shell=bash
###############################################################################
# Installatiebestand voor Ubuntu 20.04 LTS desktop op pc04.                   #
#                                                                             #
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.                         #
###############################################################################

#1 calibre (e-boekmanager)
sudo apt-get install --yes calibre
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove --yes calibre

#1 dropbox (cloudopslag)
sudo apt-get install --yes nautilus-dropbox
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove --yes nautilus-dropbox

#1 google-earth (verken de wereld)
## Maakt zelf /etc/apt/sources.list.d/google-earth-pro.list aan, tenzij eerder
## zelf aangemaakt, dan /etc/default/google-earth-pro:repo_add_once="false".
wget --no-verbose --output-document=/tmp/google-earth-pro-stable_current_amd64.deb 'https://dl.google.com/dl/earth/client/current/google-earth-pro-stable_current_amd64.deb'
sudo apt-get install --yes /tmp/google-earth-pro-stable_current_amd64.deb
rm /tmp/google-earth-pro-stable_current_amd64.deb
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove --yes google-earth-pro-stable

#1 wine (windowsapps op Linux)
sudo apt-get install --yes wine winetricks playonlinux
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove --yes wine winetricks playonlinux
