# shellcheck shell=bash
###############################################################################
# Installatiebestand voor Ubuntu 20.04 LTS desktop op pc-van-soe.             #
#                                                                             #
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.                         #
###############################################################################

#1 calibre
#2 Calibre - E-boekmanager
sudo apt-get install --yes calibre
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes calibre

#1 clamav
#1 ClamAV - Antivirus
sudo apt-get install --yes clamtk-gnome
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove clamtk-gnome
