# shellcheck shell=bash
###############################################################################
# Instellingsbestand voor Ubuntu 20.04 LTS desktop op pc-van-emily.
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
if [[ $HOSTNAME = pc-van-emily && $USER = emily ]]; then gsettings set org.gnome.desktop.background picture-uri 'file:///usr/share/backgrounds/kz-caramel.jpg'; fi
#4 Start Terminalvenster en voer uit:
#4    gsettings reset org.gnome.desktop.background picture-uri


# EOF
