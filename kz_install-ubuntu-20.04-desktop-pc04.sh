# shellcheck shell=bash
###############################################################################
# Installatiebestand voor Ubuntu 20.04 LTS desktop op pc04.
#
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.
# Auteursrecht (c) 2020-2021 Karel Zimmer.
# GNU Algemene Publieke Licentie <https://www.gnu.org/licenses/gpl.html>.
#
# ReleaseNumber: 03.00.00
# DateOfRelease: 2021-08-08
###############################################################################

#1 calibre
#2 Calibre installeren
sudo apt-get install --yes calibre
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes calibre


#1 dropbox
#2 Dropbox installeren
sudo apt-get install --yes nautilus-dropbox
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes nautilus-dropbox


#1 google-earth
#2 Google Earth installeren
## Maakt zelf /etc/apt/sources.list.d/google-earth-pro.list aan, tenzij eerder
## zelf aangemaakt, dan /etc/default/google-earth-pro:repo_add_once="false".
wget --output-document=/tmp/google-earth-pro-stable_current_amd64.deb 'https://dl.google.com/dl/earth/client/current/google-earth-pro-stable_current_amd64.deb'
sudo apt-get install --yes /tmp/google-earth-pro-stable_current_amd64.deb
rm /tmp/google-earth-pro-stable_current_amd64.deb
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes google-earth-pro-stable


#1 wine
#2 Wine installeren
sudo apt-get install --yes wine winetricks playonlinux
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes wine winetricks playonlinux


# EOF
