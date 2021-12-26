# shellcheck shell=bash
###############################################################################
# Instellingsbestand voor Ubuntu 20.04 LST desktop op pc-van-hugo.
#
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.
###############################################################################

#1 gnome
#2 GNOME - Bureaubladomgeving
## Voor een beschrijving voer uit: gsettings describe SCHEMA KEY
gsettings set org.gnome.desktop.background picture-uri 'file:///usr/share/backgrounds/Cairn_by_Sylvain_Naudin.jpg'
gsettings set org.gnome.settings-daemon.plugins.power power-button-action 'suspend'
#4 Start Terminalvenster en voer uit:
#4    gsettings reset org.gnome.desktop.background picture-uri
#4    gsettings reset org.gnome.settings-daemon.plugins.power power-button-action

#1 telegram
#2 Telegram - Privéberichtenapp
kz-gset --addfavbottom --file='telegram-desktop_telegram-desktop.desktop'
#4 Start Terminalvenster en voer uit:
#4    kz-gset --removefav --file='telegram-desktop_telegram-desktop.desktop'

#1 virtualbox
#2 VirtualBox - Virtualisatie
kz-gset --addfavbottom --file='virtualbox.desktop'
cp /usr/bin/kz-vm-hugowin732.sh "$HOME"
chmod u+x "$HOME"/kz-vm-hugowin732.sh
cp /usr/share/applications/kz-vm-hugowin732.desktop "$HOME"/.local/share/applications/
sed --in-place --expression='s/NoDisplay=true/NoDisplay=false/' "$HOME"/.local/share/applications/kz-vm-hugowin732.desktop
kz-gset --addfavbottom --file='kz-vm-hugowin732.desktop'
#3 1. Ga naar Apparaten > Installeren Guest Additions en volg de aanwijzingen op het scherm.
#3 2. Voor optimale netwerksnelheid kies bij Netwerk voor Gekoppeld aan Netwerk bridge adapter.
#4 1. Verwijder map 'VirtualBox VMs' in de Persoonlijke map.
#4 2. Start Terminalvenster en voer uit:
#4    rm "$HOME"/.local/share/applications/kz-vm-hugowin732.desktop
#4    rm "$HOME"/kz-vm-hugowin732.sh
#4    kz-gset --removefav --file='virtualbox.desktop'
#4    kz-gset --removefav --file='kz-vm-hugowin732.desktop'

