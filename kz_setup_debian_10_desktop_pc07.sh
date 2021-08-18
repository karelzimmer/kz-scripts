# shellcheck shell=bash
###############################################################################
# Instellingsbestand voor Debian 10 LTS desktop op pc07.
#
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.
# Auteursrecht (c) 2021 Karel Zimmer.
# GNU Algemene Publieke Licentie <https://www.gnu.org/licenses/gpl.html>.
#
# ReleaseNumber: 02.00.01
# DateOfRelease: 2021-08-18
###############################################################################

#1
#2 GNOME instellen
## Voor een beschrijving voer uit: gsettings describe SCHEMA KEY
if [[ $HOSTNAME = pc07 && $USER = karel ]]; then gsettings set org.gnome.desktop.background picture-uri 'file:///usr/share/backgrounds/kz_gnome.png'; fi
if [[ $HOSTNAME = pc07 && $USER = karel ]]; then gsettings set org.gnome.desktop.screensaver picture-uri 'file:///usr/share/backgrounds/kz_gnome.png'; fi
if [[ $HOSTNAME = pc07 && $USER = karel ]]; then gsettings set org.gnome.desktop.sound allow-volume-above-100-percent true; fi
if [[ $HOSTNAME = pc07 && $USER = karel ]]; then gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'; fi
if [[ $HOSTNAME = pc07 && $USER = karel ]]; then gsettings set org.gnome.shell.extensions.dash-to-dock apply-custom-theme true; fi
if [[ $HOSTNAME = pc07 && $USER = karel ]]; then gsettings set org.gnome.nautilus.preferences show-create-link true; fi
#4 Start Terminalvenster en voer uit:
#4    gsettings reset org.gnome.desktop.background picture-uri
#4    gsettings reset org.gnome.desktop.screensaver picture-uri
#4    gsettings reset org.gnome.desktop.sound allow-volume-above-100-percent
#4    gsettings reset org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type
#4    gsettings reset org.gnome.shell.extensions.dash-to-dock apply-custom-theme
#4    gsettings reset org.gnome.nautilus.preferences show-create-link


#1
#2 Google Chrome instellen
if [[ $HOSTNAME = pc07 && $USER = karel ]]; then kz_gset --removefav --file='firefox-esr.desktop'; fi
if [[ $HOSTNAME = pc07 && $USER = karel ]]; then kz_gset --removefav --file='org.gnome.Evolution.desktop'; fi
#3 1. Start Standaardtoepassingen.
#3 2. Kies bij E-mail voor Gnome Gmail.


#1
#2 Vooruit zoeken in history instellen
if [[ $HOSTNAME = pc07 && $USER = karel ]]; then sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc; fi
if [[ $HOSTNAME = pc07 && $USER = karel ]]; then echo 'stty -ixon  # Enable fwd search history (i-search)' >> "$HOME"/.bashrc; fi
#4 Start Terminalvenster en voer uit:
#4    sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc


#1 bluefish
#2 Bluefish instellen
kz_gset --addfavbottom --file='bluefish.desktop'
#3 1. Start Bluefish.
#3 2. Zet via Bewerken > Voorkeuren > Initiele document instellingen de Tab breedte op 4 en
#3    vink aan Gebruik spaties voor inspringen, geen tabs.
#4 Start Terminalvenster en voer uit:
#4    kz_gset --removefav --file='bluefish.desktop'


#1 gedit
#2 Gedit instellen
gsettings set org.gnome.gedit.plugins active-plugins "['sort','spell','smartspaces','changecase','zeitgeistplugin','filebrowser','docinfo','time','codecomment','modelines']"
gsettings set org.gnome.gedit.preferences.editor auto-indent false
gsettings set org.gnome.gedit.preferences.editor bracket-matching true
gsettings set org.gnome.gedit.preferences.editor display-line-numbers true
gsettings set org.gnome.gedit.preferences.editor display-right-margin true
gsettings set org.gnome.gedit.preferences.editor highlight-current-line true
gsettings set org.gnome.gedit.preferences.editor insert-spaces true
gsettings set org.gnome.gedit.preferences.editor right-margin-position 79
gsettings set org.gnome.gedit.preferences.editor tabs-size 4
gsettings set org.gnome.gedit.preferences.editor wrap-last-split-mode 'char'
gsettings set org.gnome.gedit.preferences.editor wrap-mode 'char'
gsettings set org.gnome.gedit.preferences.print print-header true
gsettings set org.gnome.gedit.preferences.print print-line-numbers 1
gsettings set org.gnome.gedit.preferences.print print-syntax-highlighting true
gsettings set org.gnome.gedit.preferences.print print-wrap-mode 'char'
kz_gset --addfavtop --file='org.gnome.gedit.desktop'
#4 Start Terminalvenster en voer uit:
#4    gsettings reset org.gnome.gedit.plugins active-plugins
#4    gsettings reset org.gnome.gedit.preferences.editor auto-indent
#4    gsettings reset org.gnome.gedit.preferences.editor bracket-matching
#4    gsettings reset org.gnome.gedit.preferences.editor display-line-numbers
#4    gsettings reset org.gnome.gedit.preferences.editor display-right-margin
#4    gsettings reset org.gnome.gedit.preferences.editor highlight-current-line
#4    gsettings reset org.gnome.gedit.preferences.editor insert-spaces
#4    gsettings reset org.gnome.gedit.preferences.editor right-margin-position
#4    gsettings reset org.gnome.gedit.preferences.editor tabs-size
#4    gsettings reset org.gnome.gedit.preferences.editor wrap-last-split-mode
#4    gsettings reset org.gnome.gedit.preferences.editor wrap-mode
#4    gsettings reset org.gnome.gedit.preferences.print print-header
#4    gsettings reset org.gnome.gedit.preferences.print print-line-numbers
#4    gsettings reset org.gnome.gedit.preferences.print print-syntax-highlighting
#4    gsettings reset org.gnome.gedit.preferences.print print-wrap-mode
#4    kz_gset --removefav --file='org.gnome.gedit.desktop'


#1 kvm
#2 KVM instellen
## Beeldscherm 2048 x 1152 (16:9).
kz_gset --addfavbottom --file='virt-manager.desktop'
#4 Start Terminalvenster en voer uit:
#4    kz_gset --removefav --file='virt-manager.desktop'


#1 python
#2 Python instellen
kz_gset --addfavtop --file='idle.desktop'
#4 Start Terminalvenster en voer uit:
#4    kz_gset --removefav --file='idle.desktop'


#1 terminal
#2 GNOME Terminal instellen
kz_gset --addfavtop --file='org.gnome.Terminal.desktop'
#3 1. Klik op Activiteiten, typ 'snel'.
#3 2. Klik bij Instellingen op het pictogram Toetsenbord.
#3 3. Op scherm Toetsenbord scroll naar beneden en druk op +.
#3 4. Vul in bij Naam: Terminal
#3    en bij Opdracht: gnome-terminal
#3 5. Klik op 'Sneltoets instellen' en druk toetsencombinatie: Ctrl + Alt + T
#3 6. Sluit Toetsenbord.
#4 Start Terminalvenster en voer uit:
#4    kz_gset --removefav --file='org.gnome.Terminal.desktop'


#1 vscode
#2 Visual Studio Code instellen
#kz_gset --addfavtop --file='code_code.desktop'
:
#3 1. Start Visual Studio Code.
#3 2. Ga naar File > Preferences > Settings (Ctrl+,).
#3 3. Zoek 'ruler'
#3 4. Klik op 'Text Editor'.
#3 5. Klik op 'Edit in settings.json'
#3 6. Klik op 'User' (tab).
#3 7. Voeg toe tussen de { en }: "editor.rulers": [79]
#3 8. Sluit Settings.
#4 Start Terminalvenster en voer uit:
#4    kz_gset --removefav --file='code_code.desktop'


# EOF
