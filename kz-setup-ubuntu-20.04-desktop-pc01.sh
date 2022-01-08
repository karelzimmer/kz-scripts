# shellcheck shell=bash
###############################################################################
# Instellingsbestand voor Ubuntu 20.04 LTS desktop op pc01.                   #
#                                                                             #
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.                         #
###############################################################################

#1 firefox
#2 Firefox - Webbrowser
kz-gset --removefav --file='firefox.desktop'
#4 Start Terminalvenster en voer uit:
#4    kz-gset --addfavtop --file='firefox.desktop'

#1 gnome
#2 GNOME - Bureaubladomgeving
## Voor een beschrijving voer uit: gsettings describe SCHEMA KEY
if [[ $USER = karel ]]; then gsettings set org.gnome.desktop.background picture-uri 'file:///usr/share/backgrounds/kz-gnome.png'; fi
if [[ $USER = monique ]]; then gsettings set org.gnome.desktop.background picture-uri 'file:///usr/share/backgrounds/kz-olifanten.jpg'; fi
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 32
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM'
#4 Start Terminalvenster en voer uit:
#4    gsettings reset org.gnome.desktop.background picture-uri
#4    gsettings reset org.gnome.shell.extensions.dash-to-dock dash-max-icon-size
#4    gsettings reset org.gnome.shell.extensions.dash-to-dock dock-position

#1 search
#2 Search - Vooruit zoeken in history met Ctrl-S
sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc
echo 'stty -ixon  # Enable fwd search history - i-search)' >> "$HOME"/.bashrc
#4 Start Terminalvenster en voer uit:
#4    sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc

#1 terminal
#2 GNOME Terminal - Terminalvenster
if [[ $USER = karel ]]; then kz-gset --addfavtop --file='org.gnome.Terminal.desktop'; fi
#4 Start Terminalvenster en voer uit:
#4    kz-gset --removefav --file='org.gnome.Terminal.desktop'

#1 thunderbird
#2 Thunderbird - E-mail
kz-gset --removefav --file='thunderbird.desktop'
#4 Start Terminalvenster en voer uit:
#4    kz-gset --addfavtop --file='thunderbird.desktop'

#1 vscode
#2 Visual Studio Code - Editor
if [[ $USER = karel ]]; then kz-gset --addfavtop --file='code_code.desktop'; fi
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
#3 6. Klik op 'User' - tab).
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

#1 zga-ehrm
#2 Zga eHRM - Starter eHRM Zorggroep Almere
if [[ $USER = monique ]]; then cp /usr/share/applications/kz-zga-ehrm.desktop "$HOME"/.local/share/applications/; fi
if [[ $USER = monique ]]; then sed --in-place --expression='s/NoDisplay=true/NoDisplay=false/' "$HOME"/.local/share/applications/kz-zga-ehrm.desktop; fi
if [[ $USER = monique ]]; then kz-gset --addfavtop --file='kz-zga-ehrm.desktop'; fi
#4 Start Terminalvenster en voer uit:
#4    rm "$HOME"/.local/share/applications/kz-zga-ehrm.desktop
#4    kz-gset --removefav --file='kz-zga-ehrm.desktop'

#1 zga-intranet
#2 Zga Intranet - Starter Intranet Zorggroep Almere
if [[ $USER = monique ]]; then cp /usr/share/applications/kz-zga-intranet.desktop "$HOME"/.local/share/applications/; fi
if [[ $USER = monique ]]; then sed --in-place --expression='s/NoDisplay=true/NoDisplay=false/' "$HOME"/.local/share/applications/kz-zga-intranet.desktop; fi
if [[ $USER = monique ]]; then kz-gset --addfavtop --file='kz-zga-intranet.desktop'; fi
#4 Start Terminalvenster en voer uit:
#4    rm "$HOME"/.local/share/applications/kz-zga-intranet.desktop
#4    kz-gset --removefav --file='kz-zga-intranet.desktop'

#1 zga-monaco
#2 Zga Monaco - Starter Monaco Zorggroep Almere
if [[ $USER = monique ]]; then cp /usr/share/applications/kz-zga-monaco.desktop "$HOME"/.local/share/applications/; fi
if [[ $USER = monique ]]; then sed --in-place --expression='s/NoDisplay=true/NoDisplay=false/' "$HOME"/.local/share/applications/kz-zga-monaco.desktop; fi
if [[ $USER = monique ]]; then kz-gset --addfavtop --file='kz-zga-monaco.desktop'; fi
#4 Start Terminalvenster en voer uit:
#4    rm "$HOME"/.local/share/applications/kz-zga-monaco.desktop
#4    kz-gset --removefav --file='kz-zga-monaco.desktop'

#1 zga-webmail
#2 Zga WebMail - Starter
if [[ $USER = monique ]]; then cp /usr/share/applications/kz-zga-webmail.desktop "$HOME"/.local/share/applications/; fi
if [[ $USER = monique ]]; then sed --in-place --expression='s/NoDisplay=true/NoDisplay=false/' "$HOME"/.local/share/applications/kz-zga-webmail.desktop; fi
if [[ $USER = monique ]]; then kz-gset --addfavtop --file='kz-zga-webmail.desktop'; fi
#4 Start Terminalvenster en voer uit:
#4    rm "$HOME"/.local/share/applications/kz-zga-webmail.desktop
#4    kz-gset --removefav --file='kz-zga-webmail.desktop'
