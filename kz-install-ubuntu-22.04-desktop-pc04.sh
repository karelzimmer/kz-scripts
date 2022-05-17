# shellcheck shell=bash
###############################################################################
# Installatiebestand voor Ubuntu 22.04 LTS desktop op pc04.                   #
#                                                                             #
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.                         #
###############################################################################

#1 calibre (e-boekmanager)
sudo apt-get install --yes calibre
#2 sudo apt-get remove --yes calibre

#1 gnome-gmail (Gmail als de favoriete e-mailtoepassing in GNOME)
sudo apt-get install --yes gnome-gmail
#2 sudo apt-get remove --yes gnome-gmail

#1 google-earth (verken de wereld)
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-earth.gpg] http://dl.google.com/linux/earth/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-earth-pro.list
wget --no-verbose --output-document=- https://dl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmor --yes --output=/usr/share/keyrings/google-earth.gpg
sudo apt-get update
sudo apt-get install --yes google-earth-pro-stable
## Extra nodig na installatie.
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-earth.gpg] http://dl.google.com/linux/earth/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-earth-pro.list
#2 sudo apt-get remove --yes google-earth-pro-stable
#2 sudo rm /etc/apt/sources.list.d/google-earth-pro.list* /usr/share/keyrings/google-earth.gpg*
#2 sudo apt update

#1 lidswitch (negeer sluiten laptopdesksel)
sudo sed --in-place --expression='/^HandleLidSwitch=/d' /etc/systemd/logind.conf
echo 'HandleLidSwitch=ignore' | sudo tee --append /etc/systemd/logind.conf
#2 sudo sed --in-place --expression='/^HandleLidSwitch=/d' /etc/systemd/logind.conf

#1 ros (Robot Operating System)
:

#1 wine (windowsapps op Linux)
sudo apt-get install --yes wine winetricks playonlinux
#2 sudo apt-get remove --yes wine winetricks playonlinux
