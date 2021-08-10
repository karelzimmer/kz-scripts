# shellcheck shell=bash
###############################################################################
# Instellingsbestand voor Ubuntu 20.04 LST desktop op pc-van-hugo.
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
if [[ $HOSTNAME = pc-van-hugo && $USER = hugo ]]; then gsettings set org.gnome.desktop.background picture-uri 'file:///usr/share/backgrounds/Cairn_by_Sylvain_Naudin.jpg'; fi
if [[ $HOSTNAME = pc-van-hugo && $USER = hugo ]]; then gsettings set org.gnome.settings-daemon.plugins.power power-button-action 'suspend'; fi
#4 Start Terminalvenster en voer uit:
#4    gsettings reset org.gnome.desktop.background picture-uri
#4    gsettings reset org.gnome.settings-daemon.plugins.power power-button-action


#1 telegram-desktop
#2 Telegram Desktop instellen
kz_gset --addfavbottom --file='telegram-desktop_telegram-desktop.desktop'
#4 Start Terminalvenster en voer uit:
#4    kz_gset --removefav --file='telegram-desktop_telegram-desktop.desktop'


#1 virtualbox
#2 VirtualBox instellen
kz_gset --addfavbottom --file='virtualbox.desktop'
if [[ $HOSTNAME = pc-van-hugo && $USER = hugo ]]; then cp /usr/share/applications/kz_vm_hugowin732.desktop "$HOME"/.local/share/applications/; fi
if [[ $HOSTNAME = pc-van-hugo && $USER = hugo ]]; then sed --in-place --expression='s/NoDisplay=true/NoDisplay=false/' "$HOME"/.local/share/applications/kz_vm_hugowin732.desktop; fi
if [[ $HOSTNAME = pc-van-hugo && $USER = hugo ]]; then kz_gset --addfavbottom --file='kz_vm_hugowin732.desktop'; fi
#3 1. Ga naar Apparaten > Installeren Guest Additions en volg de aanwijzingen op het scherm.
#3 2. Voor optimale netwerksnelheid kies bij Netwerk voor Gekoppeld aan Netwerk bridge adapter.
#4 1. Verwijder map 'VirtualBox VMs' in de Persoonlijke map.
#4 2. Start Terminalvenster en voer uit:
#4    rm "$HOME"/.local/share/applications/kz_vm_hugowin732.desktop
#4    kz_gset --removefav --file='virtualbox.desktop'


# EOF
