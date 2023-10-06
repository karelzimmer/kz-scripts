# shellcheck shell=bash
###############################################################################
# Standard reset file for Ubuntu desktop.
#
# Written by Karel Zimmer <info@karelzimmer.nl>, CC0 1.0 Universal
# <https://creativecommons.org/publicdomain/zero/1.0>, 2013-2023.
###############################################################################

# APP calibre hugo@pc-van-hugo nina@pc04 karel@pc06
kz-gset --delfav=calibre-gui


# APP cockpit karel@pc06
# Web app: https://localhost:9090
kz-gset --delfav=kz-cockpit
rm --force "$HOME"/.local/share/applications/kz-cockpit.desktop


# APP gnome *
kz-gset --delappfolder=KZ
gsettings reset org.gnome.desktop.app-folders folder-children
gsettings reset org.gnome.desktop.calendar show-weekdate
gsettings reset org.gnome.desktop.interface clock-show-date
gsettings reset org.gnome.desktop.interface clock-show-weekday
gsettings reset org.gnome.desktop.interface show-battery-percentage
gsettings reset org.gnome.desktop.peripherals.touchpad tap-to-click
gsettings reset org.gnome.desktop.screensaver lock-enabled
gsettings reset org.gnome.desktop.session idle-delay
gsettings reset org.gnome.desktop.sound allow-volume-above-100-percent
gsettings reset org.gnome.mutter center-new-windows
gsettings reset org.gnome.nautilus.icon-view default-zoom-level
gsettings reset org.gnome.nautilus.preferences click-policy
gsettings reset org.gnome.nautilus.preferences open-folder-on-dnd-hover
gsettings reset org.gnome.nautilus.preferences show-create-link
gsettings reset org.gnome.settings-daemon.peripherals.touchscreen orientation-lock
gsettings reset org.gnome.settings-daemon.plugins.color night-light-enabled
gsettings reset org.gnome.settings-daemon.plugins.power idle-dim
gsettings reset org.gnome.settings-daemon.plugins.power power-button-action
gsettings reset org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type
gsettings reset org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type
gsettings reset org.gnome.shell.extensions.dash-to-dock apply-custom-theme
gsettings reset org.gnome.shell.extensions.dash-to-dock click-action
gsettings reset org.gnome.shell.extensions.dash-to-dock dash-max-icon-size
gsettings reset org.gnome.shell.extensions.dash-to-dock show-mounts-network
gsettings reset org.gnome.shell.extensions.ding show-home
gsettings reset org.gnome.Terminal.Legacy.Settings theme-variant


# APP google-chrome *
kz-gset --delfav=google-chrome


# APP kvm karel@pc06
kz-gset --delfav=virt-manager


# APP libreoffice-calc nina@pc04
kz-gset --delfav=libreoffice-calc


# APP nautilus-hide *
rm --force "$HOME"/.hidden


# APP skype *
kz-gset --delfav=kz-skype


# APP spotify *
kz-gset --delfav=kz-spotify


# APP start-install *
kz-gset --addfavbef=ubuntu-desktop-installer_ubuntu-desktop-installer


# APP teams karel@pc06
kz-gset --delfav=kz-teams


# APP teamviewer karel@pc06
kz-gset --delfav=com.teamviewer.TeamViewer


# APP telegram hugo@pc-van-hugo
kz-gset --delfav=kz-telegram


# APP terminal karel@pc06
kz-gset --delfav=org.gnome.Terminal
sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc


# APP virtualbox hugo@pc-van-hugo
kz-gset --delfav=virtualbox
kz-gset --delfav=kz-vm-hugowin732


# APP vscode karel@pc01 karel@pc06
kz-gset --delfav=code_code


# APP whatsapp hugo@pc-van-hugo
kz-gset --delfav=kz-whatsapp


# APP zoom karel@pc01 monique@pc01
kz-gset --delfav=kz-zoom
