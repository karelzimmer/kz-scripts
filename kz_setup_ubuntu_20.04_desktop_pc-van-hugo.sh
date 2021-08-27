# shellcheck shell=bash
###############################################################################
# Instellingsbestand voor Ubuntu 20.04 LST desktop op pc-van-hugo.
#
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.
###############################################################################
# RELEASE_YEAR=2020

# VERSION_NUMBER=04.00.02
# VERSION_DATE=2021-08-27


#1 gnome
#2 GNOME instellen
## Voor een beschrijving voer uit: gsettings describe SCHEMA KEY
gsettings set org.gnome.desktop.background picture-uri 'file:///usr/share/backgrounds/Cairn_by_Sylvain_Naudin.jpg'
gsettings set org.gnome.settings-daemon.plugins.power power-button-action 'suspend'
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
cp /usr/bin/kz_vm_hugowin732.sh "$HOME"
chmod u+x "$HOME"/kz_vm_hugowin732.sh
cp /usr/share/applications/kz_vm_hugowin732.desktop "$HOME"/.local/share/applications/
sed --in-place --expression='s/NoDisplay=true/NoDisplay=false/' "$HOME"/.local/share/applications/kz_vm_hugowin732.desktop
kz_gset --addfavbottom --file='kz_vm_hugowin732.desktop'
#3 1. Ga naar Apparaten > Installeren Guest Additions en volg de aanwijzingen op het scherm.
#3 2. Voor optimale netwerksnelheid kies bij Netwerk voor Gekoppeld aan Netwerk bridge adapter.
#3 3. Start Opstatoepassingen en voeg /home/hugo/kz_vm_hugowin732.sh toe.
#4 1. Verwijder map 'VirtualBox VMs' in de Persoonlijke map.
#4 2. Start Terminalvenster en voer uit:
#4    rm "$HOME"/.local/share/applications/kz_vm_hugowin732.desktop
#4    rm "$HOME"/kz_vm_hugowin732.sh
#4    kz_gset --removefav --file='virtualbox.desktop'
#4    kz_gset --removefav --file='kz_vm_hugowin732.desktop'


# EOF
