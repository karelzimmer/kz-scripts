# shellcheck shell=bash
###############################################################################
# Installatiebestand voor Ubuntu 20.04 LTS desktop op pc04.
#
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.
###############################################################################
# RELEASE_YEAR=2020

# VERSION_NUMBER=03.01.00
# VERSION_DATE=2021-09-03


#1 calibre
#2 Calibre (e-boekmanager) installeren
sudo apt-get install --yes calibre
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes calibre


#1 dropbox
#2 Dropbox (cloudopslag) installeren
sudo apt-get install --yes nautilus-dropbox
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes nautilus-dropbox


#1 google-earth
#2 Google Earth (verken de wereld) installeren
## Maakt zelf /etc/apt/sources.list.d/google-earth-pro.list aan, tenzij eerder
## zelf aangemaakt, dan /etc/default/google-earth-pro:repo_add_once="false".
wget --output-document=/tmp/google-earth-pro-stable_current_amd64.deb 'https://dl.google.com/dl/earth/client/current/google-earth-pro-stable_current_amd64.deb'
sudo apt-get install --yes /tmp/google-earth-pro-stable_current_amd64.deb
rm /tmp/google-earth-pro-stable_current_amd64.deb
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes google-earth-pro-stable


#1 wine
#2 Wine (Windowsapps op Linux) installeren
sudo apt-get install --yes wine winetricks playonlinux
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes wine winetricks playonlinux


# EOF
