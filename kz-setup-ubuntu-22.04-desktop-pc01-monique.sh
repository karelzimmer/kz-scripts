# shellcheck shell=bash
###############################################################################
# Instelbestand voor Ubuntu 22.04 LTS desktop op pc01 voor monique.
#
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.
###############################################################################

#1 firefox (webbrowser)
kz-gset --delfav=firefox_firefox
#2 kz-gset --addfavbef=firefox_firefox

#1 gnome (bureaubladomgeving)
gsettings set org.gnome.desktop.background picture-uri 'file:///usr/share/backgrounds/kz-olifanten.jpg'
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 32
#2 gsettings reset org.gnome.desktop.background picture-uri
#2 gsettings reset org.gnome.shell.extensions.dash-to-dock dash-max-icon-size

#1 thunderbird (e-mail)
kz-gset --delfav=thunderbird
#2 kz-gset --addfavbef=thunderbird
