# shellcheck shell=bash
###############################################################################
# Instelbestand voor Ubuntu 20.04 LTS desktop op pc01.                        #
#                                                                             #
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.                         #
###############################################################################

#1 firefox (webbrowser)
kz-gset --delfav=firefox
#2 Start Terminalvenster en voer uit:
#2    kz-gset --addfavbef=firefox

#1 gnome (bureaubladomgeving)
gsettings set org.gnome.desktop.background picture-uri file:///usr/share/backgrounds/kz-olifanten.jpg
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 32
#2 Start Terminalvenster en voer uit:
#2    gsettings reset org.gnome.desktop.background picture-uri
#2    gsettings reset org.gnome.shell.extensions.dash-to-dock dash-max-icon-size

#1 search (vooruit zoeken in history met Ctrl-S)
sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc
printf '%s\n' 'stty -ixon  # Enable fwd search history - i-search)' >> "$HOME"/.bashrc
#2 Start Terminalvenster en voer uit:
#2    sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc

#1 thunderbird (e-mail)
kz-gset --delfav=thunderbird
#2 Start Terminalvenster en voer uit:
#2    kz-gset --addfavbef=thunderbird

#1 vscode (editor)
xdg-mime default code_code.desktop application/x-shellscript    # Bash-script
xdg-mime default code_code.desktop application/x-desktop        # Bureaublad-configuratiebestand
xdg-mime default code_code.desktop application/xml              # PolicyKit actiedefinitiebestand
xdg-mime default code_code.desktop text/markdown                # Markdown document
xdg-mime default code_code.desktop text/troff                   # Man-pagina
xdg-mime default code_code.desktop text/html                    # Web-pagina

#1 zgaehrm (starter eHRM Zorggroep Almere)
cp /usr/share/applications/kz-zga-ehrm.desktop "$HOME"/.local/share/applications/
sed --in-place --expression='s/NoDisplay=true/NoDisplay=false/' "$HOME"/.local/share/applications/kz-zga-ehrm.desktop
kz-gset --addfavbef=kz-zga-ehrm
#2 Start Terminalvenster en voer uit:
#2    rm "$HOME"/.local/share/applications/kz-zga-ehrm.desktop
#2    kz-gset --delfav=kz-zga-ehrm

#1 zgaintranet (starter Intranet Zorggroep Almere)
cp /usr/share/applications/kz-zga-intranet.desktop "$HOME"/.local/share/applications/
sed --in-place --expression='s/NoDisplay=true/NoDisplay=false/' "$HOME"/.local/share/applications/kz-zga-intranet.desktop
kz-gset --addfavbef=kz-zga-intranet
#2 Start Terminalvenster en voer uit:
#2    rm "$HOME"/.local/share/applications/kz-zga-intranet.desktop
#2    kz-gset --delfav=kz-zga-intranet

#1 zgamonaco (starter Monaco Zorggroep Almere)
cp /usr/share/applications/kz-zga-monaco.desktop "$HOME"/.local/share/applications/
sed --in-place --expression='s/NoDisplay=true/NoDisplay=false/' "$HOME"/.local/share/applications/kz-zga-monaco.desktop
kz-gset --addfavbef=kz-zga-monaco
#2 Start Terminalvenster en voer uit:
#2    rm "$HOME"/.local/share/applications/kz-zga-monaco.desktop
#2    kz-gset --delfav=kz-zga-monaco

#1 zgawebmail (starter WebMail Zorggroep Almere)
cp /usr/share/applications/kz-zga-webmail.desktop "$HOME"/.local/share/applications/
sed --in-place --expression='s/NoDisplay=true/NoDisplay=false/' "$HOME"/.local/share/applications/kz-zga-webmail.desktop
kz-gset --addfavbef=kz-zga-webmail
#2 Start Terminalvenster en voer uit:
#2    rm "$HOME"/.local/share/applications/kz-zga-webmail.desktop
#2    kz-gset --delfav=kz-zga-webmail
