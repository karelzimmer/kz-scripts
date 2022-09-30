# shellcheck shell=bash
###############################################################################
# Installatiebestand voor Ubuntu 22.04 desktop LTS op pc-van-emily.
#
# Geschreven door Karel Zimmer <info@karelzimmer.nl>, Publiek Domein Verklaring
# <http://creativecommons.org/publicdomain/zero/1.0/deed.nl>.
###############################################################################

#1-cups-backend-bjnp (printerbackend voor Canon BJNP-protocol printerdriver)
sudo apt-get install --yes cups-backend-bjnp
#2 sudo apt-get remove --yes cups-backend-bjnp

#1 handbrake (dvd-ripper)
sudo apt-get install --yes handbrake
#2 sudo apt-get remove --yes handbrake

#1 sound-juicer (cd-ripper)
sudo apt-get install --yes sound-juicer
#2 sudo apt-get remove --yes sound-juicer

#1 vlc (mediaspeler)
sudo snap install vlc
#2 sudo snap remove vlc
