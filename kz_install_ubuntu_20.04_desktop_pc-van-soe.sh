# shellcheck shell=bash
###############################################################################
# Installatiebestand voor Ubuntu 20.04 LTS desktop op pc-van-soe.
#
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.
# Auteursrecht (c) 2021 Karel Zimmer.
# GNU Algemene Publieke Licentie <https://www.gnu.org/licenses/gpl.html>.
#
# ReleaseNumber: 01.01.00
# DateOfRelease: 2021-08-16
###############################################################################

#1 calibre
#2 Calibre installeren
sudo apt-get install --yes calibre
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes calibre


#1 clamav
#1 ClamAV installeren
sudo apt-get install --yes clamtk-gnome
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove clamtk-gnome


# EOF
