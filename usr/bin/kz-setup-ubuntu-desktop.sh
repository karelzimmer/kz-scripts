# shellcheck shell=bash
###############################################################################
# Setup file for Ubuntu desktop.
#
# Written by Karel Zimmer <info@karelzimmer.nl>, CC0 1.0 Universal
# <https://creativecommons.org/publicdomain/zero/1.0>, 2013-2023.
###############################################################################

#1 gnome
kz-gset --addappfolder='Kz-scripts'
gsettings set org.gnome.desktop.calendar show-weekdate true
gsettings set org.gnome.desktop.interface clock-show-date true
gsettings set org.gnome.desktop.interface clock-show-weekday true
gsettings set org.gnome.desktop.interface show-battery-percentage true
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
gsettings set org.gnome.desktop.screensaver lock-enabled false
gsettings set org.gnome.desktop.session idle-delay 900
gsettings set org.gnome.mutter center-new-windows true
gsettings set org.gnome.nautilus.icon-view default-zoom-level 'large'
gsettings set org.gnome.nautilus.preferences click-policy 'single'
gsettings set org.gnome.nautilus.preferences open-folder-on-dnd-hover true
gsettings set org.gnome.settings-daemon.peripherals.touchscreen orientation-lock true
gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
gsettings set org.gnome.settings-daemon.plugins.power idle-dim false
gsettings set org.gnome.settings-daemon.plugins.power power-button-action 'interactive'
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'nothing'
gsettings set org.gnome.shell.extensions.dash-to-dock apply-custom-theme true
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize-or-previews'
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 32
gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed true
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height true
gsettings set org.gnome.shell.extensions.dash-to-dock icon-size-fixed true
gsettings set org.gnome.Terminal.Legacy.Settings theme-variant light
#2 kz-gset --delappfolder='Kz-scripts'
#2 gsettings reset org.gnome.desktop.app-folders folder-children
#2 gsettings reset org.gnome.desktop.calendar show-weekdate
#2 gsettings reset org.gnome.desktop.interface clock-show-date
#2 gsettings reset org.gnome.desktop.interface clock-show-weekday
#2 gsettings reset org.gnome.desktop.interface show-battery-percentage
#2 gsettings reset org.gnome.desktop.peripherals.touchpad tap-to-click
#2 gsettings reset org.gnome.desktop.screensaver lock-enabled
#2 gsettings reset org.gnome.desktop.session idle-delay
#2 gsettings reset org.gnome.mutter center-new-windows
#2 gsettings reset org.gnome.nautilus.icon-view default-zoom-level
#2 gsettings reset org.gnome.nautilus.preferences click-policy
#2 gsettings reset org.gnome.nautilus.preferences open-folder-on-dnd-hover
#2 gsettings reset org.gnome.settings-daemon.peripherals.touchscreen orientation-lock
#2 gsettings reset org.gnome.settings-daemon.plugins.color night-light-enabled
#2 gsettings reset org.gnome.settings-daemon.plugins.power idle-dim
#2 gsettings reset org.gnome.settings-daemon.plugins.power power-button-action
#2 gsettings reset org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type
#2 gsettings reset org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type
#2 gsettings reset org.gnome.shell.extensions.dash-to-dock apply-custom-theme
#2 gsettings reset org.gnome.shell.extensions.dash-to-dock click-action
#2 gsettings reset org.gnome.shell.extensions.dash-to-dock dash-max-icon-size
#2 gsettings reset org.gnome.shell.extensions.dash-to-dock dock-fixed
#2 gsettings reset org.gnome.shell.extensions.dash-to-dock extend-height
#2 gsettings reset org.gnome.shell.extensions.dash-to-dock icon-size-fixed
#2 gsettings reset org.gnome.Terminal.Legacy.Settings theme-variant

#1-gnome
## Desktop environment Ubuntu-only
gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts-network false
gsettings set org.gnome.shell.extensions.ding show-home false
#2 gsettings reset org.gnome.shell.extensions.dash-to-dock show-mounts-network
#2 gsettings reset org.gnome.shell.extensions.ding show-home

#1 google-chrome
kz-gset --addfavbef=google-chrome
#2 kz-gset --delfav=google-chrome

#1 hide
## Hide folders in Home folder
echo 'snap' > "$HOME"/.hidden
#2 rm --force "$HOME"/.hidden

#1 skype
kz-gset --addfavaft=kz-skype
#2 kz-gset --delfav=kz-skype

#1 spotify
kz-gset --addfavaft=kz-spotify
#2 kz-gset --delfav=kz-spotify

#1-start-install
kz-gset --delfav=ubuntu-desktop-installer_ubuntu-desktop-installer
#2 kz-gset --addfavbef=ubuntu-desktop-installer_ubuntu-desktop-installer
