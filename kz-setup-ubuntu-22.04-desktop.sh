# shellcheck shell=bash
###############################################################################
# Instelbestand voor Ubuntu 22.04 LTS desktop.
#
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.
###############################################################################

#1 bitwarden (wachtwoordbeheer)
kz-gset --addfavaft=bitwarden_bitwarden
#2 kz-gset --delfav=bitwarden_bitwarden

#1 citrix (telewerken)
## Aka Citrix Workspace app, Citrix Receiver, ICA Client.
xdg-mime default wfica.desktop application/x-ica

#1 google-chrome (webbrowser)
kz-gset --addfavbef=google-chrome
#2 kz-gset --delfav=google-chrome

#1 snap (snap verbergen in Persoonlijke map)
printf '%s\n' 'snap' > "$HOME"/.hidden
#2 rm --force "$HOME"/.hidden

#1 skype (beeldbellen)
kz-gset --addfavaft=skype_skypeforlinux
#2 kz-gset --delfav=skype_skypeforlinux

#1 spotify (muziekspeler)
kz-gset --addfavaft=spotify_spotify
#2 kz-gset --delfav=spotify_spotify

#1 teams (samenwerken)
kz-gset --addfavaft=teams
#2 kz-gset --delfav=teams

#1 zoom (samenwerken)
kz-gset --addfavaft=Zoom
#2 kz-gset --delfav=Zoom

#1 gnome (bureaubladomgeving)
kz-gset --addappfolder='KZ Scripts'
[[ -e $HOME/kz-data/Achtergrond ]] && gsettings set org.gnome.desktop.background picture-uri "file://$HOME/kz-data/Achtergrond" || true
[[ -e $HOME/kz-data/Favorieten ]] && gsettings set org.gnome.shell favorite-apps "$(cat "$HOME"/kz-data/Favorieten)" || true
gsettings set org.gnome.desktop.calendar show-weekdate true
gsettings set org.gnome.desktop.interface clock-show-date true
gsettings set org.gnome.desktop.interface clock-show-weekday true
gsettings set org.gnome.desktop.interface show-battery-percentage true
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
gsettings set org.gnome.desktop.screensaver lock-enabled false
gsettings set org.gnome.desktop.session idle-delay 600
gsettings set org.gnome.nautilus.icon-view default-zoom-level 'large'
gsettings set org.gnome.nautilus.preferences click-policy 'single'
gsettings set org.gnome.settings-daemon.peripherals.touchscreen orientation-lock true
gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
gsettings set org.gnome.settings-daemon.plugins.power idle-dim false
gsettings set org.gnome.settings-daemon.plugins.power power-button-action 'interactive'
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'nothing'
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize-or-previews'
gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts-network false
gsettings set org.gnome.shell.extensions.ding show-home false
gsettings set org.gnome.Terminal.Legacy.Settings theme-variant light
#2 kz-gset --delappfolder='KZ Scripts'
#2 gsettings reset org.gnome.desktop.app-folders folder-children
#2 gsettings reset org.gnome.desktop.background picture-uri
#2 gsettings reset org.gnome.desktop.calendar show-weekdate
#2 gsettings reset org.gnome.desktop.interface clock-show-date
#2 gsettings reset org.gnome.desktop.interface clock-show-weekday
#2 gsettings reset org.gnome.desktop.interface show-battery-percentage
#2 gsettings reset org.gnome.desktop.peripherals.touchpad tap-to-click
#2 gsettings reset org.gnome.desktop.screensaver lock-enabled
#2 gsettings reset org.gnome.desktop.session idle-delay
#2 gsettings reset org.gnome.nautilus.icon-view default-zoom-level
#2 gsettings reset org.gnome.nautilus.preferences click-policy
#2 gsettings reset org.gnome.settings-daemon.peripherals.touchscreen orientation-lock
#2 gsettings reset org.gnome.settings-daemon.plugins.color night-light-enabled
#2 gsettings reset org.gnome.settings-daemon.plugins.power idle-dim
#2 gsettings reset org.gnome.settings-daemon.plugins.power power-button-action
#2 gsettings reset org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type
#2 gsettings reset org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type
#2 gsettings reset org.gnome.shell favorite-apps
#2 gsettings reset org.gnome.shell.extensions.dash-to-dock click-action
#2 gsettings reset org.gnome.shell.extensions.dash-to-dock show-mounts-network
#2 gsettings reset org.gnome.shell.extensions.ding show-home
#2 gsettings reset org.gnome.Terminal.Legacy.Settings theme-variant
