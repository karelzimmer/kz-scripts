# shellcheck shell=bash
###############################################################################
# Instelbestand voor Ubuntu 20.04 LTS desktop op pc06.                        #
#                                                                             #
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.                         #
###############################################################################

#1 cockpit (browsergebaseerd beheer)
cp /usr/share/applications/kz-cockpit.desktop "$HOME"/.local/share/applications/
sed --in-place --expression='s/NoDisplay=true/NoDisplay=false/' "$HOME"/.local/share/applications/kz-cockpit.desktop
kz-gset --addfavaft=kz-cockpit
#2 1. Start een browser en ga naar: https://localhost:9090 en log in.
#2 2. Klik op Limited access (Beperkte toegang) en geef het wachtwoord
#2 3. Ga naar Session > Display language (Sessie > Schemtaal), selecteer
#2    Nederlands, en klik op Select (Selecteren).
#3 Start Terminalvenster en voer uit:
#3    rm "$HOME"/.local/share/applications/kz-cockpit.desktop
#3    kz-gset --delfav=kz-cockpit

#1 firefox (webbrowser)
kz-gset --delfav=firefox_firefox
#3 Start Terminalvenster en voer uit:
#3    kz-gset --addfavbef=firefox_firefox

#1 gnome (bureaubladomgeving)
gsettings set org.gnome.desktop.background picture-uri file:///usr/share/backgrounds/kz-gnome.png
gsettings set org.gnome.desktop.interface gtk-theme Yaru-light
gsettings set org.gnome.desktop.sound allow-volume-above-100-percent true
gsettings set org.gnome.nautilus.preferences show-create-link true
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 32
gsettings set org.gnome.Terminal.Legacy.Settings theme-variant light
#3 Start Terminalvenster en voer uit:
#3    gsettings reset org.gnome.desktop.background picture-uri
#3    gsettings reset org.gnome.desktop.interface gtk-theme
#3    gsettings reset org.gnome.desktop.sound allow-volume-above-100-percent
#3    gsettings reset org.gnome.nautilus.preferences show-create-link
#3    gsettings reset org.gnome.shell.extensions.dash-to-dock dash-max-icon-size
#3    gsettings reset org.gnome.Terminal.Legacy.Settings theme-variant

#1 kvm (virtualisatie)
kz-gset --addfavaft=virt-manager
#2 1. Start KVM.
#2 2. Zet beeldscherm op: 2048 x 1152 (16:9).
#2 3. Start Terminalvenster en voer uit:
#2    sudo apt install spice-vdagent
#3 Start Terminalvenster en voer uit:
#3    kz-gset --delfav=virt-manager

#1 search (vooruit zoeken in history met Ctrl-S)
sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc
echo 'stty -ixon  # Enable fwd search history (i-search)' >> "$HOME"/.bashrc
#3 Start Terminalvenster en voer uit:
#3    sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc

#1 terminal (terminalvenster)
kz-gset --addfavbef=org.gnome.Terminal
#2 1. Start Terminalvenster.
#2 2. Maximaliseer het Terminalvenster.
#2 3. Voer de volgende opdracht uit:
#2    echo "Terminalgrootte: $COLUMNS kolommen $LINES rijen"
#2 4. Ga naar ☰  > Voorkeuren.
#2 5. Onder Profielen klik op Naamloos.
#2 6. Vul in achter Oorspronkelijke afmeting van de terminal:
#2    COLUMNS kolommen en LINES rijen, en sluit Voorkeuren.
#3 Start Terminalvenster en voer uit:
#3    kz-gset --delfav=org.gnome.Terminal

#1 thunderbird (e-mail)
kz-gset --delfav=thunderbird
#3 Start Terminalvenster en voer uit:
#3    kz-gset --addfavbef=thunderbird

#1 vscode (editor)
kz-gset --addfavbef=code_code
xdg-mime default code_code.desktop application/x-shellscript    # Bash-script
xdg-mime default code_code.desktop application/x-desktop        # Bureaublad-configuratiebestand
xdg-mime default code_code.desktop application/xml              # PolicyKit actiedefinitiebestand
xdg-mime default code_code.desktop text/markdown                # Markdown document
xdg-mime default code_code.desktop text/troff                   # Man-pagina
xdg-mime default code_code.desktop text/html                    # Web-pagina
#2 1. Start Visual Studio Code.
#2 2. Ga naar File > Preferences > Settings (Ctrl+,).
#2 3. Zoek 'ruler'
#2 4. Klik op 'Text Editor'.
#2 5. Klik op 'Edit in settings.json'
#2 6. Klik op 'User' (tab).
#2 7. Voeg toe, of wijzig, tussen de { en }: "editor.rulers": [79]
#2 8. Sluit Settings.
#2 9. Installeer de volgende extensies:
#2    Code Runner
#2    HTML Preview
#2    Linux Desktop File Support
#2    Live Server
#2    Markdown Preview Enahnced
#2    ShellCheck
#2    TROFF Syntax
#3 Start Terminalvenster en voer uit:
#3    kz-gset --delfav=code_code
