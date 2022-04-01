# shellcheck shell=bash
###############################################################################
# Instelbestand voor Ubuntu 20.04 desktop op pc01.                            #
#                                                                             #
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.                         #
###############################################################################

#1 firefox (webbrowser)
kz-gset --delfav=firefox
#3 Start Terminalvenster en voer uit:
#3    kz-gset --addfavbef=firefox

#1 gnome (bureaubladomgeving)
gsettings set org.gnome.desktop.background picture-uri file:///usr/share/backgrounds/kz-olifanten.jpg
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 32
#3 Start Terminalvenster en voer uit:
#3    gsettings reset org.gnome.desktop.background picture-uri
#3    gsettings reset org.gnome.shell.extensions.dash-to-dock dash-max-icon-size

#1 search (vooruit zoeken in history met Ctrl-S)
sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc
echo 'stty -ixon  # Enable fwd search history - i-search)' >> "$HOME"/.bashrc
#3 Start Terminalvenster en voer uit:
#3    sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc

#1 thunderbird (e-mail)
kz-gset --delfav=thunderbird
#3 Start Terminalvenster en voer uit:
#3    kz-gset --addfavbef=thunderbird

#1 vscode (editor)
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

#1 zgaehrm (starter eHRM Zorggroep Almere)
cp /usr/share/applications/kz-zga-ehrm.desktop "$HOME"/.local/share/applications/
sed --in-place --expression='s/NoDisplay=true/NoDisplay=false/' "$HOME"/.local/share/applications/kz-zga-ehrm.desktop
kz-gset --addfavbef=kz-zga-ehrm
#3 Start Terminalvenster en voer uit:
#3    rm "$HOME"/.local/share/applications/kz-zga-ehrm.desktop
#3    kz-gset --delfav=kz-zga-ehrm

#1 zgaintranet (starter Intranet Zorggroep Almere)
cp /usr/share/applications/kz-zga-intranet.desktop "$HOME"/.local/share/applications/
sed --in-place --expression='s/NoDisplay=true/NoDisplay=false/' "$HOME"/.local/share/applications/kz-zga-intranet.desktop
kz-gset --addfavbef=kz-zga-intranet
#3 Start Terminalvenster en voer uit:
#3    rm "$HOME"/.local/share/applications/kz-zga-intranet.desktop
#3    kz-gset --delfav=kz-zga-intranet

#1 zgamonaco (starter Monaco Zorggroep Almere)
cp /usr/share/applications/kz-zga-monaco.desktop "$HOME"/.local/share/applications/
sed --in-place --expression='s/NoDisplay=true/NoDisplay=false/' "$HOME"/.local/share/applications/kz-zga-monaco.desktop
kz-gset --addfavbef=kz-zga-monaco
#3 Start Terminalvenster en voer uit:
#3    rm "$HOME"/.local/share/applications/kz-zga-monaco.desktop
#3    kz-gset --delfav=kz-zga-monaco

#1 zgawebmail (starter WebMail Zorggroep Almere)
cp /usr/share/applications/kz-zga-webmail.desktop "$HOME"/.local/share/applications/
sed --in-place --expression='s/NoDisplay=true/NoDisplay=false/' "$HOME"/.local/share/applications/kz-zga-webmail.desktop
kz-gset --addfavbef=kz-zga-webmail
#3 Start Terminalvenster en voer uit:
#3    rm "$HOME"/.local/share/applications/kz-zga-webmail.desktop
#3    kz-gset --delfav=kz-zga-webmail
