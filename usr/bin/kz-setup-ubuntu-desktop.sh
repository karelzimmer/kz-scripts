# shellcheck shell=bash
###############################################################################
# SPDX-FileComment: Set up file for Ubuntu desktop
#
# SPDX-FileCopyrightText: Karel Zimmer <info@karelzimmer.nl>
# SPDX-License-Identifier: CC0-1.0
###############################################################################

# Setup anydesk -nouser
kz-gset --addfavaft=anydesk

# Reset anydesk -nouser
kz-gset --delfav=anydesk


# Setup calibre hugo@pc-van-hugo
kz-gset --addfavaft=calibre-gui

# Reset calibre hugo@pc-van-hugo
kz-gset --delfav=calibre-gui


# Setup cockpit karel@pc06
kz-gset --addfavaft=kz-cockpit

# Reset cockpit karel@pc06
kz-gset --delfav=kz-cockpit
rm --force --verbose "$HOME"/.local/share/applications/kz-cockpit.desktop


# Setup firefox monique@pc01 karel@pc01 marin@pc02 karel@pc06
kz-gset --delfav=firefox            # dpkg
kz-gset --delfav=firefox_firefox    # snap

# Reset firefox monique@pc01 karel@pc01 marin@pc02 karel@pc06
kz-gset --addfavbef=firefox         # dpkg
kz-gset --addfavbef=firefox_firefox # snap


# Setup gdebi *
xdg-mime default gdebi.desktop application/vnd.debian.binary-package

# Reset gdebi *
xdg-mime default snap-store_ubuntu-software-local-file.desktop application/vnd.debian.binary-package


# Setup gnome *
kz-gset --addappfolder=KZ
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
gsettings set org.gnome.nautilus.icon-view default-zoom-level 'large'
gsettings set org.gnome.nautilus.preferences click-policy 'single'
gsettings set org.gnome.nautilus.preferences open-folder-on-dnd-hover true
gsettings set org.gnome.nautilus.preferences show-create-link true
gsettings set org.gnome.nautilus.preferences show-image-thumbnails 'always'
gsettings set org.gnome.settings-daemon.peripherals.touchscreen orientation-lock true
gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
gsettings set org.gnome.settings-daemon.plugins.power idle-dim false
gsettings set org.gnome.settings-daemon.plugins.power power-button-action 'interactive'
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'nothing'
gsettings set org.gnome.shell.extensions.dash-to-dock apply-custom-theme true
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize-or-previews'
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 32
gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts-network false
gsettings set org.gnome.shell.extensions.ding show-home false
gsettings set org.gnome.Terminal.Legacy.Settings theme-variant 'light'

# Reset gnome *
kz-gset --delappfolder=KZ
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
gsettings reset org.gnome.nautilus.icon-view default-zoom-level
gsettings reset org.gnome.nautilus.preferences click-policy
gsettings reset org.gnome.nautilus.preferences open-folder-on-dnd-hover
gsettings reset org.gnome.nautilus.preferences show-create-link
gsettings reset org.gnome.nautilus.preferences show-image-thumbnails
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


# Setup google-chrome *
xdg-mime default google-chrome.desktop application/pdf

# Reset google-chrome *
xdg-mime default org.gnome.Evince.desktop application/pdf


# Setup google-chrome monique@pc01 karel@pc01 marin@pc02 karel@pc06
kz-gset --addfavbef=google-chrome

# Reset google-chrome monique@pc01 karel@pc01 marin@pc02 karel@pc06
kz-gset --delfav=google-chrome


# Setup handbrake emily@pc-van-emily
kz-gset --addfavaft=fr.handbrake.ghb

# Reset handbrake emily@pc-van-emily
kz-gset --delfav=fr.handbrake.ghb


# Setup kvm karel@pc06
kz-gset --addfavaft=virt-manager

# Reset kvm karel@pc06
kz-gset --delfav=virt-manager


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
kz-gset --addfavaft=kz-spotify

# Reset spotify monique@pc01 karel@pc01 marin@pc02 karel@pc06
kz-gset --delfav=kz-spotify


# Setup sound-juicer emily@pc-van-emily
kz-gset --addfavaft=org.gnome.SoundJuicer

# Reset sound-juicer emily@pc-van-emily
kz-gset --delfav=org.gnome.SoundJuicer


# Setup thunderbird monique@pc01 karel@pc01 marin@pc02 karel@pc06
kz-gset --delfav=thunderbird                # dpkg
kz-gset --delfav=thunderbird_thunderbird    # snap

# Reset thunderbird monique@pc01 karel@pc01 marin@pc02 karel@pc06
kz-gset --addfavbef=thunderbird             # dpkg
kz-gset --addfavbef=thunderbird_thunderbird # snap


# Setup teamviewer karel@pc06
kz-gset --addfavaft=com.teamviewer.TeamViewer

# Reset teamviewer karel@pc06
kz-gset --delfav=com.teamviewer.TeamViewer


# Setup telegram hugo@pc-van-hugo maria@maria-desktop
kz-gset --addfavaft=kz-telegram

# Reset telegram hugo@pc-van-hugo  maria@maria-desktop
kz-gset --delfav=kz-telegram


# Setup terminal karel@pc01 karel@pc06
kz-gset --addfavbef=org.gnome.Terminal
# Search forward in history (with Ctrl-S).
sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc
echo 'stty -ixon  # Enable fwd search history (i-search)' >> "$HOME"/.bashrc

# Reset terminal karel@pc01 karel@pc06
kz-gset --delfav=org.gnome.Terminal
sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc


# Setup ubuntu-desktop-installer *
kz-gset --delfav=ubuntu-desktop-installer_ubuntu-desktop-installer

# Reset ubuntu-desktop-installer *
kz-gset --addfavbef=ubuntu-desktop-installer_ubuntu-desktop-installer


# Setup virtualbox hugo@pc-van-hugo
kz-gset --addfavaft=virtualbox
kz-gset --addfavaft=kz-vm-hugowin732

# Reset virtualbox hugo@pc-van-hugo
kz-gset --delfav=virtualbox
kz-gset --delfav=kz-vm-hugowin732


# Setup vlc *
xdg-mime default vlc_vlc.desktop video/mp4
xdg-mime default vlc_vlc.desktop video/x-matroska
xdg-mime default vlc_vlc.desktop video/webm

# Reset vlc *
xdg-mime default org.gnome.Totem.desktop video/mp4
xdg-mime default org.gnome.Totem.desktop video/x-matroska
xdg-mime default org.gnome.Totem.desktop video/webm


# Setup vscode karel@pc01 karel@pc06
kz-gset --addfavbef=code_code
xdg-mime default code_code.desktop application/json
xdg-mime default code_code.desktop application/x-desktop
xdg-mime default code_code.desktop application/x-shellscript
xdg-mime default code_code.desktop application/xml
xdg-mime default code_code.desktop text/html
xdg-mime default code_code.desktop text/markdown
xdg-mime default code_code.desktop text/troff
xdg-mime default code_code.desktop text/x-python

# Reset vscode karel@pc01 karel@pc06
kz-gset --delfav=code_code
xdg-mime default org.gnome.gedit.desktop application/json
xdg-mime default org.gnome.gedit.desktop application/x-desktop
xdg-mime default org.gnome.gedit.desktop application/x-shellscript
xdg-mime default org.gnome.gedit.desktop application/xml
xdg-mime default org.gnome.gedit.desktop text/html
xdg-mime default org.gnome.gedit.desktop text/markdown
xdg-mime default org.gnome.gedit.desktop text/troff
xdg-mime default org.gnome.gedit.desktop text/x-python


# Setup whatsapp hugo@pc-van-hugo maria@maria-desktop
kz-gset --addfavaft=kz-whatsapp

# Reset whatsapp hugo@pc-van-hugo maria@maria-desktop
kz-gset --delfav=kz-whatsapp


# Setup zoom monique@pc01 karel@pc01
kz-gset --addfavaft=kz-zoom

# Reset zoom monique@pc01 karel@pc01
kz-gset --delfav=kz-zoom
