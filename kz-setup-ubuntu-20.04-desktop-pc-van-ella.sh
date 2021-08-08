# shellcheck shell=bash
###############################################################################
# Instellingsbestand voor Ubuntu 20.04 LTS desktop op pc-van-ella.
#
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.
# Auteursrecht (c) 2020-2021 Karel Zimmer.
# GNU Algemene Publieke Licentie <https://www.gnu.org/licenses/gpl.html>.
#
# ReleaseNumber: 03.00.00
# DateOfRelease: 2021-08-08
###############################################################################

#1
#2 GNOME instellen
## Voor een beschrijving voer uit: gsettings describe SCHEMA KEY
if [[ $HOSTNAME = pc-van-ella && $USER = ella ]]; then gsettings set org.gnome.desktop.background picture-uri 'file:///usr/share/backgrounds/Fleurs_de_Prunus_24_by_Jérôme_Boivin.jpg'; fi
#4 Start Terminalvenster en voer uit:
#4    gsettings reset org.gnome.desktop.background picture-uri


# EOF
