# shellcheck shell=bash
###############################################################################
# Installatiebestand voor Debian 11 LTS desktop op debian (Live-sessie).
#
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.
###############################################################################

#1 gnome-gmail (Gmail als e-mailtoepassing in GNOME)
sudo apt-get install --yes gnome-gmail
#2 sudo apt-get remove --yes gnome-gmail

#1 locate (bestanden snel zoeken op naam)
sudo apt-get install --yes mlocate
#2 sudo apt-get remove --yes mlocate

#1 pinfo (gebruiksvriendelijke viewer voor Info-documenten)
sudo apt-get install --yes pinfo
#2 sudo apt-get remove --yes pinfo

#1 vscode (editor)
sudo snap install --classic code
#2 sudo snap remove code
