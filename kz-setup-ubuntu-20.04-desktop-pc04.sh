# shellcheck shell=bash
###############################################################################
# Instellingsbestand voor Ubuntu 20.04 LTS desktop op pc04.
#
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.
# Auteursrecht (c) 2020-2021 Karel Zimmer.
# GNU Algemene Publieke Licentie <https://www.gnu.org/licenses/gpl.html>.
#
# ReleaseNumber: 03.01.01
# DateOfRelease: 2021-07-23
###############################################################################

#1
#2 GNOME instellen
## Voor een beschrijving voer uit: gsettings describe SCHEMA KEY
if [[ $HOSTNAME = pc04 && $USER = nina ]]; then gsettings set org.gnome.desktop.background picture-uri 'file:///usr/share/backgrounds/Fleurs_de_Prunus_24_by_Jérôme_Boivin.jpg'; fi
if [[ $HOSTNAME = pc04 && $USER = nina ]]; then gsettings set org.gnome.desktop.screensaver lock-enabled true; fi
#4 Start Terminalvenster en voer uit:
#4    gsettings reset org.gnome.desktop.background picture-uri
#4    gsettings set org.gnome.desktop.screensaver lock-enabled false


#1 calibre
#2 Calibre instellen
kzgset --addfavbottom --file='calibre-gui.desktop'
#4 Start Terminalvenster en voer uit:
#4    kzgset --removefav --file='calibre-gui.desktop'


#1 google-earth
#2 Google Earth instellen
kzgset --addfavbottom --file='google-earth.desktop'
#4 Start Terminalvenster en voer uit:
#4    kzgset --removefav --file='google-earth.desktop'


# EOF
