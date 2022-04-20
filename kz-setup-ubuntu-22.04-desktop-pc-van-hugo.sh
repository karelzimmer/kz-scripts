# shellcheck shell=bash
###############################################################################
# Instelbestand voor Ubuntu 20.04 LTS desktop op pc-van-hugo.                 #
#                                                                             #
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.                         #
###############################################################################

#1 gnome (bureaubladomgeving)
gsettings set org.gnome.desktop.background picture-uri file:///usr/share/backgrounds/Cairn_by_Sylvain_Naudin.jpg
gsettings set org.gnome.settings-daemon.plugins.power power-button-action 'suspend'
#2 Start Terminalvenster en voer uit:
#2    gsettings reset org.gnome.desktop.background picture-uri
#2    gsettings reset org.gnome.settings-daemon.plugins.power power-button-action

#1 telegram (privéberichtenapp)
kz-gset --addfavaft=telegram-desktop_telegram-desktop
#2 Start Terminalvenster en voer uit:
#2    kz-gset --delfav=telegram-desktop_telegram-desktop

#1 virtualbox (virtualisatie)
kz-gset --addfavaft=virtualbox
cp /usr/bin/kz-vm-hugowin732.sh "$HOME"
chmod u+x "$HOME"/kz-vm-hugowin732.sh
cp /usr/share/applications/kz-vm-hugowin732.desktop "$HOME"/.local/share/applications/
sed --in-place --expression='s/NoDisplay=true/NoDisplay=false/' "$HOME"/.local/share/applications/kz-vm-hugowin732.desktop
kz-gset --addfavaft=kz-vm-hugowin732
#2 1. Verwijder map 'VirtualBox VMs' in de Persoonlijke map.
#2 2. Start Terminalvenster en voer uit:
#2    rm "$HOME"/.local/share/applications/kz-vm-hugowin732.desktop
#2    rm "$HOME"/kz-vm-hugowin732.sh
#2    kz-gset --delfav=virtualbox
#2    kz-gset --delfav=kz-vm-hugowin732
