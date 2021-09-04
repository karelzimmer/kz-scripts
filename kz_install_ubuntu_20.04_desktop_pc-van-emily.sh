# shellcheck shell=bash
###############################################################################
# Installatiebestand voor Ubuntu 20.04 LTS desktop op pc-van-emily.
#
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.
###############################################################################
# RELEASE_YEAR=2020

# VERSION_NUMBER=03.01.00
# VERSION_DATE=2021-09-03


#1
#2 Printerbackend voor Canon BJNP-protocol (printerdriver) installeren
sudo apt-get install --yes cups-backend-bjnp
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes cups-backend-bjnp


#1 exiftool
#2 ExifTool (metadata lezen en schrijven) installeren
sudo apt-get install --yes libimage-exiftool-perl
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes libimage-exiftool-perl


# EOF
