# shellcheck shell=bash
###############################################################################
# Instelbestand voor Ubuntu desktop op pc01 voor karel.
#
# Geschreven in 2013 door Karel Zimmer <info@karelzimmer.nl>, Creative Commons
# Publiek Domein Verklaring <http://creativecommons.org/publicdomain/zero/1.0>.
###############################################################################

#1-gnome (bureaubladomgeving [Ubuntu pc01])
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 32
#2 gsettings reset org.gnome.shell.extensions.dash-to-dock dash-max-icon-size

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

#1 zoom (samenwerken)
kz-gset --addfavaft=zoom-client_zoom-client
#2 kz-gset --delfav=zoom-client_zoom-client
