# shellcheck shell=bash
###############################################################################
# Instellingsbestand voor Ubuntu 20.04 LTS desktop op pc04.
#
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.
###############################################################################
# RELEASE_YEAR=2020

# VERSION_NUMBER=04.02.00
# VERSION_DATE=2021-11-19


#1 calibre
#2 Calibre - E-boekmanager
kz-gset --addfavbottom --file='calibre-gui.desktop'
#4 Start Terminalvenster en voer uit:
#4    kz-gset --removefav --file='calibre-gui.desktop'


#1 gnome
#2 GNOME - Bureaubladomgeving
## Voor een beschrijving voer uit: gsettings describe SCHEMA KEY
gsettings set org.gnome.desktop.background picture-uri 'file:///usr/share/backgrounds/Fleurs_de_Prunus_24_by_Jérôme_Boivin.jpg'
#4 Start Terminalvenster en voer uit:
#4    gsettings reset org.gnome.desktop.background picture-uri


#1 google-earth
#2 Google Earth - Verken de wereld
kz-gset --addfavbottom --file='google-earth.desktop'
#4 Start Terminalvenster en voer uit:
#4    kz-gset --removefav --file='google-earth.desktop'


# EOF
