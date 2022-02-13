# shellcheck shell=bash
###############################################################################
# Installatiebestand voor Ubuntu 20.04 LTS desktop op pc-van-soe.             #
#                                                                             #
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.                         #
###############################################################################

#1 calibre (e-boekmanager)
sudo apt-get install --yes calibre
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove --yes calibre

#1 clamav (antivirus)
sudo apt-get install --yes clamtk-gnome
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove clamtk-gnome
