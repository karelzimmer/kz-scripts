# shellcheck shell=bash
###############################################################################
# Installatiebestand voor Ubuntu 20.04 LTS desktop op pc-van-emily.
#
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.
# Auteursrecht (c) 2020-2021 Karel Zimmer.
# GNU Algemene Publieke Licentie <https://www.gnu.org/licenses/gpl.html>.
#
# ReleaseNumber: 02.06.01
# DateOfRelease: 2021-07-23
###############################################################################

#1 exiftool
#2 ExifTool installeren
sudo apt-get install --yes libimage-exiftool-perl
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes libimage-exiftool-perl


#1
#2 Printerbackend voor Canon BJNP-protocol installeren
if [[ $HOSTNAME = pc-van-emily ]]; then sudo apt-get install --yes cups-backend-bjnp; fi
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes cups-backend-bjnp


# EOF
