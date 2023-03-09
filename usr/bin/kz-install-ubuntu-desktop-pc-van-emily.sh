# shellcheck shell=bash
###############################################################################
# Install file for Ubuntu desktop on pc-van-emily.
#
# Written in 2016 by Karel Zimmer <info@karelzimmer.nl>, Creative Commons
# Public Domain Dedication <https://creativecommons.org/publicdomain/zero/1.0>.
###############################################################################

#1-cups-backend-bjnp
## Printerbackend Canon BJNP-protocol
sudo apt-get install --yes cups-backend-bjnp
#2 sudo apt-get remove --yes cups-backend-bjnp

#1 handbrake
## DVD ripper
sudo apt-get install --yes handbrake
#2 sudo apt-get remove --yes handbrake

#1 sound-juicer
## CD ripper
sudo apt-get install --yes sound-juicer
#2 sudo apt-get remove --yes sound-juicer
