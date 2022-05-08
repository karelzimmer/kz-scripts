# shellcheck shell=bash
###############################################################################
# Instelbestand voor Ubuntu 22.04 LTS desktop op pc04 voor nina.              #
#                                                                             #
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.                         #
###############################################################################

#1 calibre (e-boekmanager)
kz-gset --addfavaft=calibre-gui
#2 kz-gset --delfav=calibre-gui

#1 gnome (bureaubladomgeving)
gsettings set org.gnome.desktop.background picture-uri file:///usr/share/backgrounds/Fleurs_de_Prunus_24_by_Jérôme_Boivin.jpg
#2 gsettings reset org.gnome.desktop.background picture-uri

#1 libreoffice-calc (spreadsheet van LibreOffice)
kz-gset --addfavaft=libreoffice-calc
#2 kz-gset --delfav=libreoffice-calc

#1 thunderbird (e-mail)
kz-gset --delfav=thunderbird
#2 kz-gset --addfavbef=thunderbird
