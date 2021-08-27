# shellcheck shell=bash
###############################################################################
# Installatiebestand voor Ubuntu 20.04 LTS desktop op pc-van-emily.
#
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.
###############################################################################
# RELEASE_YEAR=2020

# VERSION_NUMBER=03.00.02
# VERSION_DATE=2021-08-27


#1
#2 Printerbackend voor Canon BJNP-protocol installeren
sudo apt-get install --yes cups-backend-bjnp
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes cups-backend-bjnp


#1 exiftool
#2 ExifTool installeren
sudo apt-get install --yes libimage-exiftool-perl
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes libimage-exiftool-perl


# EOF
