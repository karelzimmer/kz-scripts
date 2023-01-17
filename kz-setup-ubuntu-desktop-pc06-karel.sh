# shellcheck shell=bash
###############################################################################
# Instelbestand voor Ubuntu desktop op pc06 voor karel.
#
# Geschreven in 2013 door Karel Zimmer <info@karelzimmer.nl>, Creative Commons
# Publiek Domein Verklaring <http://creativecommons.org/publicdomain/zero/1.0>.
###############################################################################

#1 cockpit (browsergebaseerd beheer)
## https://localhost:9090
cp /usr/share/applications/kz-cockpit.desktop "$HOME"/.local/share/applications/
sed --in-place --expression='s/NoDisplay=true/NoDisplay=false/' "$HOME"/.local/share/applications/kz-cockpit.desktop
kz-gset --addfavaft=kz-cockpit
#2 rm --force "$HOME"/.local/share/applications/kz-cockpit.desktop
#2 kz-gset --delfav=kz-cockpit

#1-gnome (bureaubladomgeving) [Ubuntu pc06]
gsettings set org.gnome.desktop.sound allow-volume-above-100-percent true
gsettings set org.gnome.nautilus.preferences show-create-link true
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 32
#2 gsettings reset org.gnome.desktop.sound allow-volume-above-100-percent
#2 gsettings reset org.gnome.nautilus.preferences show-create-link
#2 gsettings reset org.gnome.shell.extensions.dash-to-dock dash-max-icon-size

#1 kvm (virtualisatie)
kz-gset --addfavaft=virt-manager
#2 kz-gset --delfav=virt-manager

#1 teams (samenwerken)
kz-gset --addfavaft=teams_teams
#2 kz-gset --delfav=teams_teams

#1 terminal (terminalvenster)
kz-gset --addfavbef=org.gnome.Terminal
## Vooruit zoeken in history met Ctrl-S).
sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc
echo 'stty -ixon  # Enable fwd search history (i-search)' >> "$HOME"/.bashrc
#2 kz-gset --delfav=org.gnome.Terminal
#2 sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc

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
