# shellcheck shell=bash
###############################################################################
# Instellingsbestand voor Ubuntu 20.04 LST desktop op pc06.                   #
#                                                                             #
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.                         #
###############################################################################

#1 firefox (Webbrowser)
kz-gset --removefav --file='firefox.desktop'
#3 Start Terminalvenster en voer uit:
#3    kz-gset --addfavbegin --file='firefox.desktop'

#1 gnome (Bureaubladomgeving)
## Voor een beschrijving voer uit: gsettings describe SCHEMA KEY
gsettings set org.gnome.desktop.background picture-uri 'file:///usr/share/backgrounds/kz-gnome.png'
gsettings set org.gnome.desktop.interface gtk-theme 'Yaru-light'
gsettings set org.gnome.desktop.sound allow-volume-above-100-percent true
gsettings set org.gnome.nautilus.preferences show-create-link true
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 32
gsettings set org.gnome.Terminal.Legacy.Settings theme-variant 'light'
#3 Start Terminalvenster en voer uit:
#3    gsettings reset org.gnome.desktop.background picture-uri
#3    gsettings reset org.gnome.desktop.interface gtk-theme
#3    gsettings reset org.gnome.desktop.sound allow-volume-above-100-percent
#3    gsettings reset org.gnome.nautilus.preferences show-create-link
#3    gsettings reset org.gnome.shell.extensions.dash-to-dock dash-max-icon-size
#3    gsettings reset org.gnome.Terminal.Legacy.Settings theme-variant

#1 kvm (Virtualisatie)
## Beeldscherm 2048 x 1152 (16:9).
kz-gset --addfavend --file='virt-manager.desktop'
#3 Start Terminalvenster en voer uit:
#3    kz-gset --removefav --file='virt-manager.desktop'

#1 search (Vooruit zoeken in history met Ctrl-S)
sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc
printf '%s\n' 'stty -ixon  # Enable fwd search history (i-search)' >> "$HOME"/.bashrc
#3 Start Terminalvenster en voer uit:
#3    sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc

#1 terminal (Terminalvenster)
kz-gset --addfavbegin --file='org.gnome.Terminal.desktop'
#2 1. Start Terminalvenster.
#2 2. Maximaliseer het Terminalvenster.
#2 3. Voer de volgende opdracht uit:
#2    printf '%s\n' "Terminalgrootte: $COLUMNS kolommen $LINES rijen"
#2 4. Ga naar ☰  > Voorkeuren.
#2 5. Onder Profielen klik op Naamloos.
#2 6. Vul in achter Oorspronkelijke afmeting van de terminal:
#2    COLUMNS kolommen en LINES rijen, en sluit Voorkeuren.
#3 Start Terminalvenster en voer uit:
#3    kz-gset --removefav --file='org.gnome.Terminal.desktop'\

#1 thunderbird (E-mail)
kz-gset --removefav --file='thunderbird.desktop'
#3 Start Terminalvenster en voer uit:
#3    kz-gset --addfavbegin --file='thunderbird.desktop'

#1 vscode (Visual Studio Code editor)
kz-gset --addfavbegin --file='code_code.desktop'
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
#3    kz-gset --removefav --file='code_code.desktop'
