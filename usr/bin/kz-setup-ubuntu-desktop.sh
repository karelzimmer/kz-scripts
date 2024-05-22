# shellcheck shell=bash
###############################################################################
# SPDX-FileComment: Set up file for Ubuntu desktop
#
# SPDX-FileCopyrightText: Karel Zimmer <info@karelzimmer.nl>
# SPDX-License-Identifier: CC0-1.0
###############################################################################

# Setup anydesk -nouser
# Remote Wayland display server is not supported.
kz-gset --addaft=anydesk

# Reset anydesk -nouser
kz-gset --delete=anydesk


# Setup calibre hugo@pc-van-hugo
kz-gset --addaft=calibre-gui

# Reset calibre hugo@pc-van-hugo
kz-gset --delete=calibre-gui


# Setup cockpit karel@pc06
kz-gset --addaft=kz-cockpit

# Reset cockpit karel@pc06
kz-gset --delete=kz-cockpit
rm --force --verbose "$HOME"/.local/share/applications/kz-cockpit.desktop


# Setup firefox monique@pc01 karel@pc01 marin@pc02 karel@pc06 emily@pc-van-emily
kz-gset --delete=firefox            # dpkg
kz-gset --delete=firefox_firefox    # snap

# Reset firefox monique@pc01 karel@pc01 marin@pc02 karel@pc06 emily@pc-van-emily
kz-gset --addbef=firefox         # dpkg
kz-gset --addbef=firefox_firefox # snap


# Setup gdebi *
xdg-mime default gdebi.desktop application/vnd.debian.binary-package

# Reset gdebi *
xdg-mime default snap-store_ubuntu-software-local-file.desktop application/vnd.debian.binary-package


# Setup gnome *
gsettings set org.gnome.desktop.calendar show-weekdate true
gsettings set org.gnome.desktop.interface clock-show-date true
gsettings set org.gnome.desktop.interface clock-show-weekday true
gsettings set org.gnome.desktop.interface locate-pointer true
gsettings set org.gnome.desktop.interface show-battery-percentage true
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
gsettings set org.gnome.desktop.screensaver lock-enabled false
gsettings set org.gnome.desktop.session idle-delay 900
gsettings set org.gnome.desktop.sound allow-volume-above-100-percent true
gsettings set org.gnome.mutter center-new-windows true
gsettings set org.gnome.settings-daemon.peripherals.touchscreen orientation-lock true
gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
gsettings set org.gnome.settings-daemon.plugins.power idle-dim false
gsettings set org.gnome.settings-daemon.plugins.power power-button-action 'interactive'
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'nothing'
# *** The following GSettings configuration tool commands only for machines running GNOME, e.g. not for Lubuntu, uses LXQt, and Xubuntu, uses Xfce ***
if type gnome-session &> /dev/null; then gsettings set org.gnome.nautilus.icon-view default-zoom-level 'large'; fi
if type gnome-session &> /dev/null; then gsettings set org.gnome.nautilus.preferences click-policy 'single'; fi
if type gnome-session &> /dev/null; then gsettings set org.gnome.nautilus.preferences open-folder-on-dnd-hover true; fi
if type gnome-session &> /dev/null; then gsettings set org.gnome.nautilus.preferences show-create-link true; fi
if type gnome-session &> /dev/null; then gsettings set org.gnome.nautilus.preferences show-image-thumbnails 'always'; fi
if type gnome-session &> /dev/null; then gsettings set org.gnome.shell.extensions.dash-to-dock apply-custom-theme true; fi
if type gnome-session &> /dev/null; then gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize-or-previews'; fi
if type gnome-session &> /dev/null; then gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 32; fi
if type gnome-session &> /dev/null; then gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts-network false; fi
if type gnome-session &> /dev/null; then gsettings set org.gnome.shell.extensions.ding show-home false; fi
if type gnome-session &> /dev/null; then gsettings set org.gnome.Terminal.Legacy.Settings theme-variant 'light'; fi

# Reset gnome *
gsettings reset org.gnome.desktop.app-folders folder-children
gsettings reset org.gnome.desktop.calendar show-weekdate
gsettings reset org.gnome.desktop.interface clock-show-date
gsettings reset org.gnome.desktop.interface clock-show-weekday
gsettings reset org.gnome.desktop.interface locate-pointer
gsettings reset org.gnome.desktop.interface show-battery-percentage
gsettings reset org.gnome.desktop.peripherals.touchpad tap-to-click
gsettings reset org.gnome.desktop.screensaver lock-enabled
gsettings reset org.gnome.desktop.session idle-delay
gsettings reset org.gnome.desktop.sound allow-volume-above-100-percent
gsettings reset org.gnome.mutter center-new-windows
gsettings reset org.gnome.settings-daemon.peripherals.touchscreen orientation-lock
gsettings reset org.gnome.settings-daemon.plugins.color night-light-enabled
gsettings reset org.gnome.settings-daemon.plugins.power idle-dim
gsettings reset org.gnome.settings-daemon.plugins.power power-button-action
gsettings reset org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type
gsettings reset org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type
# *** The following GSettings configuration tool commands only for machines running GNOME, e.g. not for Lubuntu, uses LXQt, and Xubuntu, uses Xfce ***
if type gnome-session &> /dev/null; then gsettings reset org.gnome.nautilus.icon-view default-zoom-level; fi
if type gnome-session &> /dev/null; then gsettings reset org.gnome.nautilus.preferences click-policy; fi
if type gnome-session &> /dev/null; then gsettings reset org.gnome.nautilus.preferences show-image-thumbnails; fi
if type gnome-session &> /dev/null; then gsettings reset org.gnome.shell.extensions.dash-to-dock apply-custom-theme; fi
if type gnome-session &> /dev/null; then gsettings reset org.gnome.shell.extensions.dash-to-dock click-action; fi
if type gnome-session &> /dev/null; then gsettings reset org.gnome.shell.extensions.dash-to-dock dash-max-icon-size; fi
if type gnome-session &> /dev/null; then gsettings reset org.gnome.shell.extensions.dash-to-dock show-mounts-network; fi
if type gnome-session &> /dev/null; then gsettings reset org.gnome.shell.extensions.ding show-home; fi
if type gnome-session &> /dev/null; then gsettings reset org.gnome.Terminal.Legacy.Settings theme-variant; fi
if type gnome-session &> /dev/null; then gsettings reset org.gnome.nautilus.preferences open-folder-on-dnd-hover; fi
if type gnome-session &> /dev/null; then gsettings reset org.gnome.nautilus.preferences show-create-link; fi


# Setup google-chrome *
xdg-mime default google-chrome.desktop application/pdf

# Reset google-chrome *
xdg-mime default org.gnome.Evince.desktop application/pdf


# Setup google-chrome monique@pc01 karel@pc01 marin@pc02 karel@pc06 emily@pc-van-emily
kz-gset --addbef=google-chrome

# Reset google-chrome monique@pc01 karel@pc01 marin@pc02 karel@pc06 emily@pc-van-emily
kz-gset --delete=google-chrome


# Setup handbrake emily@pc-van-emily
kz-gset --addaft=fr.handbrake.ghb

# Reset handbrake emily@pc-van-emily
kz-gset --delete=fr.handbrake.ghb


# Setup kvm karel@pc06
kz-gset --addaft=virt-manager

# Reset kvm karel@pc06
kz-gset --delete=virt-manager


# Setup lynis -nouser
git clone https://github.com/CISOfy/lynis /home/"$USER"/lynis || true
# Usage:
# $ cd ~/lynis
# $ [sudo] ./lynis audit system

# Reset lynis -nouser
rm --force --verbose --recursive --verbose /home/"$USER"/lynis


# Setup nautilus-hide *
echo 'snap' > "$HOME"/.hidden

# Reset nautilus-hide *
rm --force --verbose "$HOME"/.hidden


# Setup restore-thumbnails -nouser
rm --force --verbose --recursive --verbose "$HOME"/.cache/thumbnails/

# Reset restore-thumbnails -nouser
# There is no command available to reset restored thumbnails.

# Setup spotify monique@pc01 karel@pc01 marin@pc02 karel@pc06
kz-gset --addaft=kz-spotify

# Reset spotify monique@pc01 karel@pc01 marin@pc02 karel@pc06
kz-gset --delete=kz-spotify


# Setup sound-juicer emily@pc-van-emily
kz-gset --addaft=org.gnome.SoundJuicer

# Reset sound-juicer emily@pc-van-emily
kz-gset --delete=org.gnome.SoundJuicer


# Setup thunderbird monique@pc01 karel@pc01 marin@pc02 karel@pc06
kz-gset --delete=thunderbird                # dpkg
kz-gset --delete=thunderbird_thunderbird    # snap

# Reset thunderbird monique@pc01 karel@pc01 marin@pc02 karel@pc06
kz-gset --addbef=thunderbird             # dpkg
kz-gset --addbef=thunderbird_thunderbird # snap


# Setup teamviewer karel@pc06
kz-gset --addaft=com.teamviewer.TeamViewer

# Reset teamviewer karel@pc06
kz-gset --delete=com.teamviewer.TeamViewer


# Setup telegram hugo@pc-van-hugo maria@maria-desktop
kz-gset --addaft=kz-telegram

# Reset telegram hugo@pc-van-hugo  maria@maria-desktop
kz-gset --delete=kz-telegram


# Setup terminal karel@pc01 karel@pc06
kz-gset --addbef=org.gnome.Terminal
# Search forward in history (with Ctrl-S).
sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc
echo 'stty -ixon  # Enable fwd search history (i-search)' >> "$HOME"/.bashrc

# Reset terminal karel@pc01 karel@pc06
kz-gset --delete=org.gnome.Terminal
sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc


# Setup ubuntu-desktop-installer *
kz-gset --delete=ubuntu-desktop-installer_ubuntu-desktop-installer

# Reset ubuntu-desktop-installer *
kz-gset --addbef=ubuntu-desktop-installer_ubuntu-desktop-installer


# Setup virtualbox hugo@pc-van-hugo
kz-gset --addaft=virtualbox
kz-gset --addaft=kz-vm-hugowin732

# Reset virtualbox hugo@pc-van-hugo
kz-gset --delete=virtualbox
kz-gset --delete=kz-vm-hugowin732


# Setup vlc *
xdg-mime default vlc.desktop video/mp4              # dpkg
xdg-mime default vlc.desktop video/x-matroska       # dpkg
xdg-mime default vlc.desktop video/webm             # dpkg
xdg-mime default vlc_vlc.desktop video/mp4          # snap
xdg-mime default vlc_vlc.desktop video/x-matroska   # snap
xdg-mime default vlc_vlc.desktop video/webm         # snap

# Reset vlc *
xdg-mime default org.gnome.Totem.desktop video/mp4
xdg-mime default org.gnome.Totem.desktop video/x-matroska
xdg-mime default org.gnome.Totem.desktop video/webm


# Setup vscode karel@pc01 karel@pc06
kz-gset --addbef=code_code
xdg-mime default code_code.desktop application/json
xdg-mime default code_code.desktop application/x-desktop
xdg-mime default code_code.desktop application/x-shellscript
xdg-mime default code_code.desktop application/xml
xdg-mime default code_code.desktop text/html
xdg-mime default code_code.desktop text/markdown
xdg-mime default code_code.desktop text/troff
xdg-mime default code_code.desktop text/x-python

# Reset vscode karel@pc01 karel@pc06
kz-gset --delete=code_code
xdg-mime default org.gnome.gedit.desktop application/json
xdg-mime default org.gnome.gedit.desktop application/x-desktop
xdg-mime default org.gnome.gedit.desktop application/x-shellscript
xdg-mime default org.gnome.gedit.desktop application/xml
xdg-mime default org.gnome.gedit.desktop text/html
xdg-mime default org.gnome.gedit.desktop text/markdown
xdg-mime default org.gnome.gedit.desktop text/troff
xdg-mime default org.gnome.gedit.desktop text/x-python


# Setup whatsapp hugo@pc-van-hugo maria@maria-desktop
kz-gset --addaft=kz-whatsapp

# Reset whatsapp hugo@pc-van-hugo maria@maria-desktop
kz-gset --delete=kz-whatsapp


# Setup zoom monique@pc01 karel@pc01
kz-gset --addaft=kz-zoom

# Reset zoom monique@pc01 karel@pc01
kz-gset --delete=kz-zoom
