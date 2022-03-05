# shellcheck shell=bash
###############################################################################
# Instelbestand voor Debian 11 LTS desktop op pc07.                           #
#                                                                             #
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.                         #
###############################################################################

#1 evolution (e-mail)
kz-gset --delfav=org.gnome.Evolution.desktop
#3 Start Terminalvenster en voer uit:
#3    kz-gset --addfavbef=org.gnome.Evolution.desktop

#1 firefox (webbrowser)
kz-gset --delfav=firefox-esr.desktop
#3 Start Terminalvenster en voer uit:
#3    kz-gset --addfavbef=firefox-esr.desktop

#1 gnome (bureaubladomgeving)
## Voor een beschrijving voer uit: gsettings describe SCHEMA KEY
gsettings set org.gnome.desktop.background picture-uri file:///usr/share/backgrounds/kz-gnome.png
gsettings set org.gnome.desktop.screensaver picture-uri file:///usr/share/backgrounds/kz-gnome.png
gsettings set org.gnome.desktop.sound allow-volume-above-100-percent true
gsettings set org.gnome.nautilus.preferences show-create-link true
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type nothing
#3 Start Terminalvenster en voer uit:
#3    gsettings reset org.gnome.desktop.background picture-uri
#3    gsettings reset org.gnome.desktop.screensaver picture-uri
#3    gsettings reset org.gnome.desktop.sound allow-volume-above-100-percent
#3    gsettings reset org.gnome.nautilus.preferences show-create-link
#3    gsettings reset org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type

#1 kvm (virtualisatie)
## Beeldscherm 2048 x 1152 (16:9).
kz-gset --addfavaft=virt-manager.desktop
#3 Start Terminalvenster en voer uit:
#3    kz-gset --delfav=virt-manager.desktop

#1 search (vooruit zoeken in history met Ctrl-S)
sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc
printf '%s\n' 'stty -ixon  # Enable fwd search history (i-search)' >> "$HOME"/.bashrc
#3 Start Terminalvenster en voer uit:
#3    sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc

#1 terminal (terminalvenster)
kz-gset --addfavbef=org.gnome.Terminal.desktop
## Aliassen aanzetten
sed --in-place --expression='s/#alias/alias/g' "$HOME"/.bashrc
## search (vooruit zoeken in history met Ctrl-S)
sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc
printf '%s\n' 'stty -ixon  # Enable fwd search history - i-search)' >> "$HOME"/.bashrc
#2 1. Klik op Activiteiten, typ 'snel'.
#2 2. Klik bij Instellingen op het pictogram Toetsenbord.
#2 3. Op scherm Toetsenbord scroll naar beneden en druk op +.
#2 4. Vul in bij Naam: Terminal
#2    en bij Opdracht: gnome-terminal
#2 5. Klik op 'Sneltoets' en druk toetsencombinatie: Ctrl + Alt + T
#2 6. Sluit Toetsenbord.
#3 Start Terminalvenster en voer uit:
#3    kz-gset --delfav=org.gnome.Terminal.desktop
#3    sed --in-place --expression='s/alias/#alias/g' "$HOME"/.bashrc
#3    sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc

#1 vscode (Visual Studio Code editor)
kz-gset --addfavbef=code_code.desktop
#2 1. Start Visual Studio Code.
#2 2. Ga naar File > Preferences > Settings (Ctrl+,).
#2 3. Zoek 'ruler'
#2 4. Klik op 'Text Editor'.
#2 5. Klik op 'Edit in settings.json'
#2 6. Klik op 'User' (tab).
#2 7. Voeg toe tussen de { en }: "editor.rulers": [79]
#2 8. Sluit Settings.
#3 Start Terminalvenster en voer uit:
#3    kz-gset --delfav=code_code.desktop
