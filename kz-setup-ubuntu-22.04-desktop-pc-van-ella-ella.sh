# shellcheck shell=bash
###############################################################################
# Instelbestand voor Ubuntu 22.04 LTS desktop op pc-van-ella voor ella.
#
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.
###############################################################################

#1 bitwarden (wachtwoordbeheer)
kz-gset --delfav=bitwarden_bitwarden
#2 kz-gset --addfavaft=bitwarden_bitwarden

#1 firefox (webbrowser)
## Zou er al moeten zijn, voor de zekerheid toegevoegd.
kz-gset --addfavbef=firefox_firefox
#2 kz-gset --delfav=firefox_firefox

#1 gnome (bureaubladomgeving)
gsettings set org.gnome.desktop.background picture-uri "file:///$HOME/kz-data/Achtergrond"
#2 gsettings reset org.gnome.desktop.background picture-uri

#1 google-chrome (webbrowser)
kz-gset --delfav=google-chrome
#2 kz-gset --addfavbef=google-chrome

#1 skype (beeldbellen)
kz-gset --delfav=skype_skypeforlinux
#2 kz-gset --addfavaft=skype_skypeforlinux

#1 spotify (muziekspeler)
kz-gset --delfav=spotify_spotify
#2 kz-gset --addfavaft=spotify_spotify

#1 teams (samenwerken)
kz-gset --delfav=teams
#2 kz-gset --addfavaft=teams

#1 zoom (samenwerken)
kz-gset --delfav=Zoom
#2 kz-gset --addfavaft=Zoom
