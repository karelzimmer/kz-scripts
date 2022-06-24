# shellcheck shell=bash
###############################################################################
# Instelbestand voor Debian 11 LTS desktop op pc07 voor karel.
#
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.
###############################################################################

#1 evolution (e-mail)
kz-gset --delfav=org.gnome.Evolution
#2 kz-gset --addfavbef=org.gnome.Evolution

#1 firefox (webbrowser)
kz-gset --delfav=firefox-esr
#2 kz-gset --addfavbef=firefox-esr

#1 gnome (bureaubladomgeving)
gsettings set org.gnome.desktop.background picture-uri 'file:///home/karel/kz-data/Achtergrond'
gsettings set org.gnome.desktop.screensaver picture-uri 'file:///home/karel/kz-data/Achtergrond'
gsettings set org.gnome.desktop.sound allow-volume-above-100-percent true
gsettings set org.gnome.nautilus.preferences show-create-link true
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type nothing
#2 gsettings reset org.gnome.background picture-uri
#2 gsettings reset org.gnome.screensaver picture-uri
#2 gsettings reset org.gnome.sound allow-volume-above-100-percent
#2 gsettings reset org.gnome.nautilus.preferences show-create-link
#2 gsettings reset org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type

#1 kvm (virtualisatie)
kz-gset --addfavaft=virt-manager
#2 kz-gset --delfav=virt-manager

#1 terminal (terminalvenster)
kz-gset --addfavbef=org.gnome.Terminal
## Aliassen aanzetten.
sed --in-place --expression='s/#alias/alias/g' "$HOME"/.bashrc
## Vooruit zoeken in history met Ctrl-S).
sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc
echo 'stty -ixon  # Enable fwd search history (i-search)' >> "$HOME"/.bashrc
## Gebruiksvriendelijke viewer voor Info-documenten (en man-pagina's).
sed --in-place --expression='/^alias info=/d' "$HOME"/.bashrc
echo 'alias info=pinfo # Gebruiksvriendelijke viewer voor Info-documenten' >> "$HOME"/.bashrc
#2 kz-gset --delfav=org.gnome.Terminal
#2 sed --in-place --expression='s/alias/#alias/g' "$HOME"/.bashrc
#2 sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc
#2 sed --in-place --expression='/^alias info=/d' "$HOME"/.bashrc

#1 vscode (editor)
kz-gset --addfavbef=code_code
xdg-mime default code_code.desktop application/json             # JSON document
xdg-mime default code_code.desktop application/x-desktop        # Bureaublad-configuratiebestand
xdg-mime default code_code.desktop application/x-shellscript    # Bash-script
xdg-mime default code_code.desktop application/xml              # PolicyKit actiedefinitiebestand
xdg-mime default code_code.desktop text/html                    # Web-pagina
xdg-mime default code_code.desktop text/markdown                # Markdown document
xdg-mime default code_code.desktop text/troff                   # Man-pagina
#2 kz-gset --delfav=code_code

#1 webmin (browsergebaseerd beheer)
## https://localhost:10000
cp /usr/share/applications/kz-webmin.desktop "$HOME"/.local/share/applications/
sed --in-place --expression='s/NoDisplay=true/NoDisplay=false/' "$HOME"/.local/share/applications/kz-webmin.desktop
kz-gset --addfavaft=kz-webmin
#2 kz-gset --delfav=kz-webmin
