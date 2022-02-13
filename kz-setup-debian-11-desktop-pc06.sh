# shellcheck shell=bash
###############################################################################
# Instellingsbestand voor Debian 11 LTS desktop op pc07.                      #
#                                                                             #
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.                         #
###############################################################################

#1 firefox (webbrowser)
kz-gset --removefav --file='firefox-esr.desktop'
#3 Start Terminalvenster en voer uit:
#3    kz-gset --addfavbegin --file='firefox-esr.desktop'

#1 gnome (bureaubladomgeving)
## Voor een beschrijving voer uit: gsettings describe SCHEMA KEY
gsettings set org.gnome.desktop.background picture-uri 'file:///usr/share/backgrounds/kz-gnome.png'
gsettings set org.gnome.desktop.screensaver picture-uri 'file:///usr/share/backgrounds/kz-gnome.png'
gsettings set org.gnome.desktop.sound allow-volume-above-100-percent true
gsettings set org.gnome.nautilus.preferences show-create-link true
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'
gsettings set org.gnome.shell.extensions.dash-to-dock apply-custom-theme true
gsettings set org.gnome.shell.extensions.dash-to-dock icon-size-fixed true
#3 Start Terminalvenster en voer uit:
#3    gsettings reset org.gnome.desktop.background picture-uri
#3    gsettings reset org.gnome.desktop.screensaver picture-uri
#3    gsettings reset org.gnome.desktop.sound allow-volume-above-100-percent
#3    gsettings reset org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type
#3    gsettings reset org.gnome.shell.extensions.dash-to-dock apply-custom-theme
#3    gsettings reset org.gnome.nautilus.preferences show-create-link
#3    gsettings reset org.gnome.shell.extensions.dash-to-dock icon-size-fixed

#1 kvm (virtualisatie)
## Beeldscherm 2048 x 1152 (16:9).
kz-gset --addfavend --file='virt-manager.desktop'
#3 Start Terminalvenster en voer uit:
#3    kz-gset --removefav --file='virt-manager.desktop'

#1 search (vooruit zoeken in history met Ctrl-S)
sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc
printf '%s\n' 'stty -ixon  # Enable fwd search history (i-search)' >> "$HOME"/.bashrc
#3 Start Terminalvenster en voer uit:
#3    sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc

#1 terminal (terminalvenster)
kz-gset --addfavbegin --file='org.gnome.Terminal.desktop'
#2 1. Klik op Activiteiten, typ 'snel'.
#2 2. Klik bij Instellingen op het pictogram Toetsenbord.
#2 3. Op scherm Toetsenbord scroll naar beneden en druk op +.
#2 4. Vul in bij Naam: Terminal
#2    en bij Opdracht: gnome-terminal
#2 5. Klik op 'Sneltoets' en druk toetsencombinatie: Ctrl + Alt + T
#2 6. Sluit Toetsenbord.
#3 Start Terminalvenster en voer uit:
#3    kz-gset --removefav --file='org.gnome.Terminal.desktop'

#1 thunderbird (e-mail)
kz-gset --removefav --file='thunderbird.desktop'
#3 Start Terminalvenster en voer uit:
#3    kz-gset --addfavbegin --file='thunderbird.desktop'

#1 vscode (Visual Studio Code editor)
kz-gset --addfavbegin --file='code_code.desktop'
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
