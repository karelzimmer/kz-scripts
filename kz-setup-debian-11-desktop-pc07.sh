# shellcheck shell=bash
###############################################################################
# Instelbestand voor Debian 11 LTS desktop op pc07.                           #
#                                                                             #
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.                         #
###############################################################################

#1 evolution (e-mail)
kz-gset --delfav=org.gnome.Evolution
#3 Start Terminalvenster en voer uit:
#3    kz-gset --addfavbef=org.gnome.Evolution

#1 firefox (webbrowser)
kz-gset --delfav=firefox-esr
#3 Start Terminalvenster en voer uit:
#3    kz-gset --addfavbef=firefox-esr

#1 gnome (bureaubladomgeving)
gsettings set org.gnome.desktop.background picture-uri file:///usr/share/backgrounds/kz-gnome.png
gsettings set org.gnome.desktop.screensaver picture-uri file:///usr/share/backgrounds/kz-gnome.png
gsettings set org.gnome.desktop.sound allow-volume-above-100-percent true
gsettings set org.gnome.nautilus.preferences show-create-link true
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type nothing
#3 Start Terminalvenster en voer uit:
#3    gsettings reset org.gnome.background picture-uri
#3    gsettings reset org.gnome.screensaver picture-uri
#3    gsettings reset org.gnome.sound allow-volume-above-100-percent
#3    gsettings reset org.gnome.nautilus.preferences show-create-link
#3    gsettings reset org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type

#1 kvm (virtualisatie)
kz-gset --addfavaft=virt-manager
#2 1. Start KVM.
#2 2. Zet beeldscherm op: 2048 x 1152 (16:9).
#3 Start Terminalvenster en voer uit:
#3    kz-gset --delfav=virt-manager

#1 search (vooruit zoeken in history met Ctrl-S)
sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc
echo 'stty -ixon  # Enable fwd search history (i-search)' >> "$HOME"/.bashrc
#3 Start Terminalvenster en voer uit:
#3    sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc

#1 terminal (terminalvenster)
kz-gset --addfavbef=org.gnome.Terminal
## Aliassen aanzetten.
sed --in-place --expression='s/#alias/alias/g' "$HOME"/.bashrc
## Search (vooruit zoeken in history met Ctrl-S).
sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc
echo 'stty -ixon  # Enable fwd search history - i-search)' >> "$HOME"/.bashrc
#2 1. Klik op Activiteiten, typ 'snel'.
#2 2. Klik bij Instellingen op het pictogram Toetsenbord.
#2 3. Op scherm Toetsenbord scroll naar beneden en druk op +.
#2 4. Vul in bij Naam: Terminal
#2    en bij Opdracht: gnome-terminal
#2 5. Klik op 'Sneltoets' en druk toetsencombinatie: Ctrl + Alt + T
#2 6. Sluit Toetsenbord.
#3 Start Terminalvenster en voer uit:
#3    kz-gset --delfav=org.gnome.Terminal
#3    sed --in-place --expression='s/alias/#alias/g' "$HOME"/.bashrc
#3    sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc

#1 vscode (editor)
kz-gset --addfavbef=code_code
#2 1. Start Visual Studio Code.
#2 2. Ga naar File > Preferences > Settings (Ctrl+,).
#2 3. Zoek 'ruler'
#2 4. Klik op 'Text Editor'.
#2 5. Klik op 'Edit in settings.json'
#2 6. Klik op 'User' (tab).
#2 7. Voeg toe tussen de { en }: "editor.rulers": [79]
#2 8. Sluit Settings.
#3 Start Terminalvenster en voer uit:
#3    kz-gset --delfav=code_code

#1 webmin (browsergebaseerd beheer)
cp /usr/share/applications/kz-webmin.desktop "$HOME"/.local/share/applications/
sed --in-place --expression='s/NoDisplay=true/NoDisplay=false/' "$HOME"/.local/share/applications/kz-webmin.desktop
kz-gset --addfavaft=kz-webmin
#2 1. Start een browser en ga naar: https://localhost:10000 en log in
#2 2. Ga naar Webmin > Change Language and Theme (Wijzigen van Taal en Thema).
#2 3. Klik op Personal choice (Persoonlijke keuze) en selecteer
#2    Nederlands.
#2 4. Klik op Make Changes (Wijzigingen Toepassen).
#3 Start Terminalvenster en voer uit:
#3    kz-gset --delfav=kz-webmin
