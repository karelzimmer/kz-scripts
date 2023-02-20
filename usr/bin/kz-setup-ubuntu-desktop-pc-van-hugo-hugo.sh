# shellcheck shell=bash
###############################################################################
# Instelbestand voor Ubuntu desktop op pc-van-hugo voor hugo.
#
# Written in 2013 by Karel Zimmer <info@karelzimmer.nl>, Creative Commons
# Public Domain Dedication <http://creativecommons.org/publicdomain/zero/1.0>.
###############################################################################

#1-gnome (bureaubladomgeving)
gsettings set org.gnome.settings-daemon.plugins.power power-button-action 'suspend'
#2 gsettings reset org.gnome.settings-daemon.plugins.power power-button-action

#1 telegram (privéberichtenapp)
kz-gset --addfavaft=telegram-desktop_telegram-desktop
#2 kz-gset --delfav=telegram-desktop_telegram-desktop

#1-virtualbox (virtualisatie)
kz-gset --addfavaft=virtualbox
cp /usr/bin/kz-vm-hugowin732.sh "$HOME"
chmod u+x "$HOME"/kz-vm-hugowin732.sh
cp /usr/share/applications/kz-vm-hugowin732.desktop "$HOME"/.local/share/applications/
sed --in-place --expression='s/NoDisplay=true/NoDisplay=false/' "$HOME"/.local/share/applications/kz-vm-hugowin732.desktop
kz-gset --addfavaft=kz-vm-hugowin732
#2 rm --force "$HOME"/.local/share/applications/kz-vm-hugowin732.desktop
#2 rm --force "$HOME"/kz-vm-hugowin732.sh
#2 kz-gset --delfav=virtualbox
#2 kz-gset --delfav=kz-vm-hugowin732
