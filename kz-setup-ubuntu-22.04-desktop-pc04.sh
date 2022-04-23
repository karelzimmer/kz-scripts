# shellcheck shell=bash
###############################################################################
# Instelbestand voor Ubuntu 22.04 LTS desktop op pc04.                        #
#                                                                             #
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.                         #
###############################################################################

#1 calibre (e-boekmanager)
kz-gset --addfavaft=calibre-gui
#2 kz-gset --delfav=calibre-gui

#1 gnome (bureaubladomgeving)
gsettings set org.gnome.desktop.background picture-uri file:///usr/share/backgrounds/Fleurs_de_Prunus_24_by_Jérôme_Boivin.jpg
#2 gsettings reset org.gnome.desktop.background picture-uri

#1 google-earth (verken de wereld)
kz-gset --addfavaft=google-earth-pro
#2 kz-gset --delfav=google-earth

#1 hulp (Ubuntu-bureaubladhandleiding)
kz-gset --delfav=yelp
#2 kz-gset --addfavaft=yelp

#1 skype (beeldbellen)
kz-gset --delfav=skype_skypeforlinux
#2 kz-gset --addfavaft=skype_skypeforlinux

#1 teams (samenwerken)
kz-gset --delfav=teams
#2 kz-gset --addfavaft=teams

#1 thunderbird (e-mail)
kz-gset --delfav=thunderbird
#2 kz-gset --addfavbef=thunderbird

#1 zoom (samenwerken)
kz-gset --delfav=Zoom
#2 kz-gset --addfavaft=Zoom
