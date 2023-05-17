# shellcheck shell=bash
###############################################################################
# Setup file for Ubuntu desktop on pc-van-hugo for hugo.
#
# Written by Karel Zimmer <info@karelzimmer.nl>, CC0 1.0 Universal
# <https://creativecommons.org/publicdomain/zero/1.0>, 2013-2023.
###############################################################################

#1-gnome
gsettings set org.gnome.settings-daemon.plugins.power power-button-action 'suspend'
#2 gsettings reset org.gnome.settings-daemon.plugins.power power-button-action

#1 telegram
kz-gset --addfavaft=kz-telegram
#2 kz-gset --delfav=kz-telegram

#1-virtualbox
kz-gset --addfavaft=virtualbox
kz-gset --addfavaft=kz-vm-hugowin732
#2 rm --force "$HOME"/.local/share/applications/kz-vm-hugowin732.desktop
#2 rm --force "$HOME"/kz-vm-hugowin732.sh
#2 kz-gset --delfav=virtualbox
#2 kz-gset --delfav=kz-vm-hugowin732

#1 whatsapp
kz-gset --addfavaft=kz-whatsapp
#2 kz-gset --delfav=kz-whatsapp
