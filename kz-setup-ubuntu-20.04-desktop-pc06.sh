# shellcheck shell=bash
###############################################################################
# Instellingsbestand voor Ubuntu 20.04 LST desktop op pc06.
#
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.
###############################################################################

#1 firefox
#2 Firefox - Webbrowser
kz-gset --removefav --file='firefox.desktop'
#4 Start Terminalvenster en voer uit:
#4    kz-gset --addfavtop --file='firefox.desktop'

#1 gnome
#2 GNOME - Bureaubladomgeving
## Voor een beschrijving voer uit: gsettings describe SCHEMA KEY
gsettings set org.gnome.desktop.background picture-uri 'file:///usr/share/backgrounds/kz-gnome.png'
gsettings set org.gnome.desktop.interface gtk-theme 'Yaru-light'
gsettings set org.gnome.desktop.sound allow-volume-above-100-percent true
gsettings set org.gnome.nautilus.preferences show-create-link true
#4 Start Terminalvenster en voer uit:
#4    gsettings reset org.gnome.desktop.background picture-uri
#4    gsettings reset org.gnome.desktop.interface gtk-theme
#4    gsettings reset org.gnome.desktop.sound allow-volume-above-100-percent
#4    gsettings reset org.gnome.nautilus.preferences show-create-link

#1 kvm
#2 KVM - Virtualisatie
## Beeldscherm 2048 x 1152 (16:9).
kz-gset --addfavbottom --file='virt-manager.desktop'
#4 Start Terminalvenster en voer uit:
#4    kz-gset --removefav --file='virt-manager.desktop'

#1 search
#2 Search - Vooruit zoeken in history met Ctrl-S
sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc
echo 'stty -ixon  # Enable fwd search history (i-search)' >> "$HOME"/.bashrc
#4 Start Terminalvenster en voer uit:
#4    sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc

#1 terminal
#2 GNOME Terminal - Terminalvenster
kz-gset --addfavtop --file='org.gnome.Terminal.desktop'
#3 1. Start Terminalvenster.
#3 2. Maximaliseer het Terminalvenster.
#3 3. Voer de volgende opdracht uit:
#3    echo "Terminalgrootte: $COLUMNS kolommen $LINES rijen"
#3 4. Ga naar ☰  > Voorkeuren.
#3 5. Onder Profielen klik op Naamloos.
#3 6. Vul in achter Oorspronkelijke afmeting van de terminal:
#3    COLUMNS kolommen en LINES rijen, en sluit Voorkeuren.
#4 Start Terminalvenster en voer uit:
#4    kz-gset --removefav --file='org.gnome.Terminal.desktop'\

#1 thunderbird
#2 Thunderbird - E-mail
kz-gset --removefav --file='thunderbird.desktop'
#4 Start Terminalvenster en voer uit:
#4    kz-gset --addfavtop --file='thunderbird.desktop'

#1 vscode
#2 Visual Studio Code - Editor
kz-gset --addfavtop --file='code_code.desktop'
xdg-mime default code_code.desktop application/x-shellscript    # Bash-script
xdg-mime default code_code.desktop application/x-desktop        # Bureaublad-configuratiebestand
xdg-mime default code_code.desktop application/xml              # PolicyKit actiedefinitiebestand
xdg-mime default code_code.desktop text/markdown                # Markdown document
xdg-mime default code_code.desktop text/troff                   # Man-pagina
xdg-mime default code_code.desktop text/html                    # Web-pagina
#3 1. Start Visual Studio Code.
#3 2. Ga naar File > Preferences > Settings (Ctrl+,).
#3 3. Zoek 'ruler'
#3 4. Klik op 'Text Editor'.
#3 5. Klik op 'Edit in settings.json'
#3 6. Klik op 'User' (tab).
#3 7. Voeg toe, of wijzig, tussen de { en }: "editor.rulers": [79]
#3 8. Sluit Settings.
#3 9. Installeer de volgende extensies:
#3    Code Runner
#3    HTML Preview
#3    Linux Desktop File Support
#3    Live Server
#3    Markdown Preview Enahnced
#3    ShellCheck
#3    TROFF Syntax
#4 Start Terminalvenster en voer uit:
#4    kz-gset --removefav --file='code_code.desktop'

# EOF
