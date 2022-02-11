# shellcheck shell=bash
###############################################################################
# Instellingsbestand voor Ubuntu 20.04 LTS desktop op pc01.                   #
#                                                                             #
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.                         #
###############################################################################

#1 firefox (Webbrowser)
kz-gset --removefav --file='firefox.desktop'
#3 Start Terminalvenster en voer uit:
#3    kz-gset --addfavbegin --file='firefox.desktop'

#1 gnome (Bureaubladomgeving)
## Voor een beschrijving voer uit: gsettings describe SCHEMA KEY
gsettings set org.gnome.desktop.background picture-uri 'file:///usr/share/backgrounds/kz-olifanten.jpg'
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 32
#3 Start Terminalvenster en voer uit:
#3    gsettings reset org.gnome.desktop.background picture-uri
#3    gsettings reset org.gnome.shell.extensions.dash-to-dock dash-max-icon-size

#1 search (Vooruit zoeken in history met Ctrl-S)
sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc
printf '%s\n' 'stty -ixon  # Enable fwd search history - i-search)' >> "$HOME"/.bashrc
#3 Start Terminalvenster en voer uit:
#3    sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc

#1 thunderbird (E-mail)
kz-gset --removefav --file='thunderbird.desktop'
#3 Start Terminalvenster en voer uit:
#3    kz-gset --addfavbegin --file='thunderbird.desktop'

#1 vscode (Visual Studio Code editor)
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
#2 6. Klik op 'User' - tab).
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

#1 zga-ehrm (Starter eHRM Zorggroep Almere)
cp /usr/share/applications/kz-zga-ehrm.desktop "$HOME"/.local/share/applications/
sed --in-place --expression='s/NoDisplay=true/NoDisplay=false/' "$HOME"/.local/share/applications/kz-zga-ehrm.desktop
kz-gset --addfavbegin --file='kz-zga-ehrm.desktop'
#3 Start Terminalvenster en voer uit:
#3    rm "$HOME"/.local/share/applications/kz-zga-ehrm.desktop
#3    kz-gset --removefav --file='kz-zga-ehrm.desktop'

#1 zga-intranet (Starter Intranet Zorggroep Almere)
cp /usr/share/applications/kz-zga-intranet.desktop "$HOME"/.local/share/applications/
sed --in-place --expression='s/NoDisplay=true/NoDisplay=false/' "$HOME"/.local/share/applications/kz-zga-intranet.desktop
kz-gset --addfavbegin --file='kz-zga-intranet.desktop'
#3 Start Terminalvenster en voer uit:
#3    rm "$HOME"/.local/share/applications/kz-zga-intranet.desktop
#3    kz-gset --removefav --file='kz-zga-intranet.desktop'

#1 zga-monaco (Starter Monaco Zorggroep Almere)
cp /usr/share/applications/kz-zga-monaco.desktop "$HOME"/.local/share/applications/
sed --in-place --expression='s/NoDisplay=true/NoDisplay=false/' "$HOME"/.local/share/applications/kz-zga-monaco.desktop
kz-gset --addfavbegin --file='kz-zga-monaco.desktop'
#3 Start Terminalvenster en voer uit:
#3    rm "$HOME"/.local/share/applications/kz-zga-monaco.desktop
#3    kz-gset --removefav --file='kz-zga-monaco.desktop'

#1 zga-webmail (Starter WebMail Zorggroep Almere)
cp /usr/share/applications/kz-zga-webmail.desktop "$HOME"/.local/share/applications/
sed --in-place --expression='s/NoDisplay=true/NoDisplay=false/' "$HOME"/.local/share/applications/kz-zga-webmail.desktop
kz-gset --addfavbegin --file='kz-zga-webmail.desktop'
#3 Start Terminalvenster en voer uit:
#3    rm "$HOME"/.local/share/applications/kz-zga-webmail.desktop
#3    kz-gset --removefav --file='kz-zga-webmail.desktop'
