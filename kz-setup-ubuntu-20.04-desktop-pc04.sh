# shellcheck shell=bash
###############################################################################
# Instelbestand voor Ubuntu 20.04 LTS desktop op pc04.                        #
#                                                                             #
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.                         #
###############################################################################

#1 calibre (e-boekmanager)
kz-gset --addfavaft=calibre-gui
#3 Start Terminalvenster en voer uit:
#3    kz-gset --delfav=calibre-gui

#1 earth (verken de wereld)
kz-gset --addfavaft=google-earth-pro
#3 Start Terminalvenster en voer uit:
#3    kz-gset --delfav=google-earth

#1 gnome (bureaubladomgeving)
gsettings set org.gnome.desktop.background picture-uri file:///usr/share/backgrounds/Fleurs_de_Prunus_24_by_Jérôme_Boivin.jpg
#3 Start Terminalvenster en voer uit:
#3    gsettings reset org.gnome.desktop.background picture-uri
