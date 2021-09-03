# shellcheck shell=bash
###############################################################################
# Installatiebestand voor Ubuntu 20.04 LTS desktop op pc-van-soe.
#
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.
###############################################################################
# RELEASE_YEAR=2021

# VERSION_NUMBER=01.02.00
# VERSION_DATE=2021-09-03


#1 calibre
#2 Calibre (e-boekmanager) installeren
sudo apt-get install --yes calibre
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes calibre


#1 clamav
#1 ClamAV (antivirus) installeren
sudo apt-get install --yes clamtk-gnome
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove clamtk-gnome


# EOF
