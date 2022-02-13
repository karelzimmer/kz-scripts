# shellcheck shell=bash
###############################################################################
# Installatiebestand voor Debian 11 LTS desktop op pc-van-emily.              #
#                                                                             #
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.                         #
###############################################################################

#1-(printerbackend voor Canon BJNP-protocol printerdriver)
sudo apt-get install --yes cups-backend-bjnp
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove --yes cups-backend-bjnp
