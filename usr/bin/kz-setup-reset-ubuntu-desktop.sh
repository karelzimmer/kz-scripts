# shellcheck shell=bash
###############################################################################
# Reset apps file for Ubuntu desktop.
#
# This script file is used by script kz-setup.
# See the kz-setup man page for details of how to make use of this script file.
#
# Written by Karel Zimmer <info@karelzimmer.nl>, CC0 1.0 Universal
# <https://creativecommons.org/publicdomain/zero/1.0>, 2013-2023.
###############################################################################

#  APP calibre
# USER nina@pc04
kz-gset --delfav=calibre-gui

#  APP cockpit
# USER karel@pc06
# Web App: https://localhost:9090
kz-gset --delfav=kz-cockpit
rm --force "$HOME"/.local/share/applications/kz-cockpit.desktop

#  APP gnome
# USER *
kz-gset --delappfolder=KZ
gsettings reset org.gnome.desktop.app-folders folder-children
gsettings reset org.gnome.desktop.calendar show-weekdate
gsettings reset org.gnome.desktop.interface clock-show-date
gsettings reset org.gnome.desktop.interface clock-show-weekday
gsettings reset org.gnome.desktop.interface show-battery-percentage
gsettings reset org.gnome.desktop.peripherals.touchpad tap-to-click
gsettings reset org.gnome.desktop.screensaver lock-enabled
gsettings reset org.gnome.desktop.session idle-delay
gsettings reset org.gnome.mutter center-new-windows
gsettings reset org.gnome.nautilus.icon-view default-zoom-level
gsettings reset org.gnome.nautilus.preferences click-policy
gsettings reset org.gnome.nautilus.preferences open-folder-on-dnd-hover
gsettings reset org.gnome.settings-daemon.peripherals.touchscreen orientation-lock
gsettings reset org.gnome.settings-daemon.plugins.color night-light-enabled
gsettings reset org.gnome.settings-daemon.plugins.power idle-dim
gsettings reset org.gnome.settings-daemon.plugins.power power-button-action
gsettings reset org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type
gsettings reset org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type
gsettings reset org.gnome.shell.extensions.dash-to-dock apply-custom-theme
gsettings reset org.gnome.shell.extensions.dash-to-dock click-action
gsettings reset org.gnome.shell.extensions.dash-to-dock dash-max-icon-size
gsettings reset org.gnome.shell.extensions.dash-to-dock dock-fixed
gsettings reset org.gnome.shell.extensions.dash-to-dock extend-height
gsettings reset org.gnome.shell.extensions.dash-to-dock icon-size-fixed
gsettings reset org.gnome.shell.extensions.dash-to-dock show-mounts-network
gsettings reset org.gnome.shell.extensions.ding show-home
gsettings reset org.gnome.Terminal.Legacy.Settings theme-variant

#  APP gnome
# USER hugo@pc-van-hugo
gsettings reset org.gnome.settings-daemon.plugins.power power-button-action

#  APP gnome
# USER karel@pc06
gsettings reset org.gnome.desktop.sound allow-volume-above-100-percent
gsettings reset org.gnome.nautilus.preferences show-create-link

#  APP google-chrome
# USER *
kz-gset --delfav=google-chrome

#  APP kvm
# USER karel@pc06
kz-gset --delfav=virt-manager

#  APP libreoffice-calc
# USER nina@pc04
kz-gset --delfav=libreoffice-calc

#  APP nautilus-hide
# USER *
rm --force "$HOME"/.hidden

#  APP skype
# USER *
kz-gset --delfav=kz-skype

#  APP spotify
# USER *
kz-gset --delfav=kz-spotify

#  APP start-install
# USER *
kz-gset --addfavbef=ubuntu-desktop-installer_ubuntu-desktop-installer

#  APP teams
# USER karel@pc06
kz-gset --delfav=kz-teams

#  APP telegram
# USER hugo@pc-van-hugo
kz-gset --delfav=kz-telegram

#  APP terminal
# USER karel@pc06
kz-gset --delfav=org.gnome.Terminal
sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc

#  APP virtualbox
# USER hugo@pc-van-hugo
kz-gset --delfav=virtualbox
kz-gset --delfav=kz-vm-hugowin732

#  APP vscode
# USER karel@pc01 karel@pc06
kz-gset --delfav=code_code

#  APP whatsapp
# USER hugo@pc-van-hugo
kz-gset --delfav=kz-whatsapp

#  APP zoom
# USER karel@pc01 monique@pc01
kz-gset --delfav=kz-zoom
