# shellcheck shell=bash
###############################################################################
# Setup file for Ubuntu desktop on pc01 for karel.
#
# Written in 2013 by Karel Zimmer <info@karelzimmer.nl>, Creative Commons
# Public Domain Dedication <http://creativecommons.org/publicdomain/zero/1.0>.
###############################################################################

#1-gnome
## Desktop environment
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 32
#2 gsettings reset org.gnome.shell.extensions.dash-to-dock dash-max-icon-size

#1 terminal
## Terminal
kz-gset --addfavbef=org.gnome.Terminal
## Search forward in history (with Ctrl-S).
sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc
echo 'stty -ixon  # Enable fwd search history (i-search)' >> "$HOME"/.bashrc
#2 kz-gset --delfav=org.gnome.Terminal
#2 sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc

#1 vscode
## Editor
kz-gset --addfavbef=code_code
xdg-mime default code_code.desktop application/json             # JSON document
xdg-mime default code_code.desktop application/x-desktop        # Bureaublad-configuratiebestand
xdg-mime default code_code.desktop application/x-shellscript    # Bash-script
xdg-mime default code_code.desktop application/xml              # PolicyKit actiedefinitiebestand
xdg-mime default code_code.desktop text/html                    # Web-pagina
xdg-mime default code_code.desktop text/markdown                # Markdown document
xdg-mime default code_code.desktop text/troff                   # Man-pagina
#2 kz-gset --delfav=code_code

#1 zoom
## Collaborate
kz-gset --addfavaft=zoom-client_zoom-client
#2 kz-gset --delfav=zoom-client_zoom-client
