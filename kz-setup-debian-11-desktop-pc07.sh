# shellcheck shell=bash
###############################################################################
# Instellingsbestand voor Debian 11 LTS desktop op pc07.                      #
#                                                                             #
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.                         #
###############################################################################

#1 gnome
#2 GNOME (bureaubladomgeving) instellen
## Voor een beschrijving voer uit: gsettings describe SCHEMA KEY
gsettings set org.gnome.desktop.background picture-uri 'file:///usr/share/backgrounds/kz-gnome.png'
gsettings set org.gnome.desktop.screensaver picture-uri 'file:///usr/share/backgrounds/kz-gnome.png'
gsettings set org.gnome.desktop.sound allow-volume-above-100-percent true
gsettings set org.gnome.nautilus.preferences show-create-link true
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'
gsettings set org.gnome.shell.extensions.dash-to-dock apply-custom-theme true
gsettings set org.gnome.shell.extensions.dash-to-dock icon-size-fixed true
#4 Start Terminalvenster en voer uit:
#4    gsettings reset org.gnome.desktop.background picture-uri
#4    gsettings reset org.gnome.desktop.screensaver picture-uri
#4    gsettings reset org.gnome.desktop.sound allow-volume-above-100-percent
#4    gsettings reset org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type
#4    gsettings reset org.gnome.shell.extensions.dash-to-dock apply-custom-theme
#4    gsettings reset org.gnome.nautilus.preferences show-create-link
#4    gsettings reset org.gnome.shell.extensions.dash-to-dock icon-size-fixed

#1 kvm
#2 KVM (virtualisatie) instellen
## Beeldscherm 2048 x 1152 (16:9).
kz-gset --addfavbottom --file='virt-manager.desktop'
#4 Start Terminalvenster en voer uit:
#4    kz-gset --removefav --file='virt-manager.desktop'

#1 python
#2 Python (programmeertaal) instellen
kz-gset --addfavtop --file='idle.desktop'
#4 Start Terminalvenster en voer uit:
#4    kz-gset --removefav --file='idle.desktop'

#1 search
#2 Vooruit zoeken in history (Ctrl-S) instellen
sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc
echo 'stty -ixon  # Enable fwd search history (i-search)' >> "$HOME"/.bashrc
#4 Start Terminalvenster en voer uit:
#4    sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc

#1 terminal
#2 GNOME Terminal (terminalvenster) instellen
kz-gset --addfavtop --file='org.gnome.Terminal.desktop'
#3 1. Klik op Activiteiten, typ 'snel'.
#3 2. Klik bij Instellingen op het pictogram Toetsenbord.
#3 3. Op scherm Toetsenbord scroll naar beneden en druk op +.
#3 4. Vul in bij Naam: Terminal
#3    en bij Opdracht: gnome-terminal
#3 5. Klik op 'Sneltoets instellen' en druk toetsencombinatie: Ctrl + Alt + T
#3 6. Sluit Toetsenbord.
#4 Start Terminalvenster en voer uit:
#4    kz-gset --removefav --file='org.gnome.Terminal.desktop'

#1 vscode
#2 Visual Studio Code (editor) instellen
kz-gset --addfavtop --file='code_code.desktop'
#3 1. Start Visual Studio Code.
#3 2. Ga naar File > Preferences > Settings (Ctrl+,).
#3 3. Zoek 'ruler'
#3 4. Klik op 'Text Editor'.
#3 5. Klik op 'Edit in settings.json'
#3 6. Klik op 'User' (tab).
#3 7. Voeg toe tussen de { en }: "editor.rulers": [79]
#3 8. Sluit Settings.
#4 Start Terminalvenster en voer uit:
#4    kz-gset --removefav --file='code_code.desktop'
