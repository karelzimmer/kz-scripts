# shellcheck shell=bash
###############################################################################
# Instellingsbestand voor Ubuntu 20.04 LTS desktop op pc04.
#
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.
# Auteursrecht (c) 2020-2021 Karel Zimmer.
# GNU Algemene Publieke Licentie <https://www.gnu.org/licenses/gpl.html>.
#
# ReleaseNumber: 04.00.00
# DateOfRelease: 2021-08-08
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
kz_gset --addfavbottom --file='calibre-gui.desktop'
#4 Start Terminalvenster en voer uit:
#4    kz_gset --removefav --file='calibre-gui.desktop'


#1 google-earth
#2 Google Earth instellen
kz_gset --addfavbottom --file='google-earth.desktop'
#4 Start Terminalvenster en voer uit:
#4    kz_gset --removefav --file='google-earth.desktop'


# EOF
