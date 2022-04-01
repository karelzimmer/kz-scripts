# shellcheck shell=bash
###############################################################################
# Installatiebestand voor Ubuntu 20.04 desktop op pc-van-emily.               #
#                                                                             #
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.                         #
###############################################################################

#1-(printerbackend voor Canon BJNP-protocol printerdriver)
sudo apt-get install --yes cups-backend-bjnp
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove cups-backend-bjnp
