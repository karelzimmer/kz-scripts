# shellcheck shell=bash
###############################################################################
# Instellingsbestand voor Ubuntu 20.04 LTS desktop op pc07.                   #
#                                                                             #
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.                         #
###############################################################################

#1 gnome (Bureaubladomgeving)
## Voor een beschrijving voer uit: gsettings describe SCHEMA KEY
gsettings set org.gnome.desktop.background picture-uri 'file:///usr/share/backgrounds/kz-gnome.png'
gsettings set org.gnome.desktop.sound allow-volume-above-100-percent true
gsettings set org.gnome.nautilus.preferences show-create-link true
#3 Start Terminalvenster en voer uit:
#3    gsettings reset org.gnome.desktop.background picture-uri
#3    gsettings reset org.gnome.desktop.sound allow-volume-above-100-percent
#3    gsettings reset org.gnome.nautilus.preferences show-create-link

#1 kvm (Virtualisatie)
## Beeldscherm 2048 x 1152 (16:9).
kz-gset --addfavbottom --file='virt-manager.desktop'
#3 Start Terminalvenster en voer uit:
#3    kz-gset --removefav --file='virt-manager.desktop'

#1 python (Programmeertaal)
kz-gset --addfavtop --file='idle.desktop'
#3 Start Terminalvenster en voer uit:
#3    kz-gset --removefav --file='idle.desktop'

#1 search (Vooruit zoeken in history met Ctrl-S)
#2 Vooruit zoeken in history met Ctrl-S)
sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc
printf '%s\n' 'stty -ixon  # Enable fwd search history (i-search)' >> "$HOME"/.bashrc
#3 Start Terminalvenster en voer uit:
#3    sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc

#1 terminal (Terminalvenster)
kz-gset --addfavtop --file='org.gnome.Terminal.desktop'
#3 Start Terminalvenster en voer uit:
#3    kz-gset --removefav --file='org.gnome.Terminal.desktop'

#1 vscode (Visual Studio Code editor)
#kz-gset --addfavtop --file='code_code.desktop'
:
#2 1. Start Visual Studio Code.
#2 2. Ga naar File > Preferences > Settings (Ctrl+,).
#2 3. Zoek 'ruler'
#2 4. Klik op 'Text Editor'.
#2 5. Klik op 'Edit in settings.json'
#2 6. Klik op 'User' (tab).
#2 7. Voeg toe tussen de { en }: "editor.rulers": [79]
#2 8. Sluit Settings.
#3 Start Terminalvenster en voer uit:
#3    kz-gset --removefav --file='code_code.desktop'
