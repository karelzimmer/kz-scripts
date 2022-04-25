# shellcheck shell=bash
###############################################################################
# Instelbestand voor Debian 11 LTS desktop op pc07.                           #
#                                                                             #
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.                         #
###############################################################################

#1 evolution (e-mail)
kz-gset --delfav=org.gnome.Evolution
#2 kz-gset --addfavbef=org.gnome.Evolution

#1 firefox (webbrowser)
kz-gset --delfav=firefox-esr
#2 kz-gset --addfavbef=firefox-esr

#1 gnome (bureaubladomgeving)
gsettings set org.gnome.desktop.background picture-uri file:///usr/share/backgrounds/kz-gnome.png
gsettings set org.gnome.desktop.screensaver picture-uri file:///usr/share/backgrounds/kz-gnome.png
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

#1 search (vooruit zoeken in history met Ctrl-S)
sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc
echo 'stty -ixon  # Enable fwd search history (i-search)' >> "$HOME"/.bashrc
#2 sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc

#1 terminal (terminalvenster)
kz-gset --addfavbef=org.gnome.Terminal
## Aliassen aanzetten.
sed --in-place --expression='s/#alias/alias/g' "$HOME"/.bashrc
## Search (vooruit zoeken in history met Ctrl-S).
sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc
echo 'stty -ixon  # Enable fwd search history - i-search)' >> "$HOME"/.bashrc
#2 kz-gset --delfav=org.gnome.Terminal
#2 sed --in-place --expression='s/alias/#alias/g' "$HOME"/.bashrc
#2 sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc

#1 vscode (editor)
kz-gset --addfavbef=code_code
#2 kz-gset --delfav=code_code

#1 webmin (browsergebaseerd beheer)
## https://localhost:10000
cp /usr/share/applications/kz-webmin.desktop "$HOME"/.local/share/applications/
sed --in-place --expression='s/NoDisplay=true/NoDisplay=false/' "$HOME"/.local/share/applications/kz-webmin.desktop
kz-gset --addfavaft=kz-webmin
#2 kz-gset --delfav=kz-webmin
