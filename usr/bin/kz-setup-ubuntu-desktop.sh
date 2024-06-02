# shellcheck shell=bash
###############################################################################
# SPDX-FileComment: Set up file for Ubuntu desktop
#
# SPDX-FileCopyrightText: Karel Zimmer <info@karelzimmer.nl>
# SPDX-License-Identifier: CC0-1.0
###############################################################################

# Setup anydesk for -nouser
# Remote Wayland display server is not supported.
kz-gset --addaft=anydesk

# Reset anydesk for -nouser
kz-gset --delete=anydesk

# Setup calibre for hugo@pc-van-hugo
kz-gset --addaft=calibre-gui

# Reset calibre for hugo@pc-van-hugo
kz-gset --delete=calibre-gui

# Setup cockpit for karel@pc06
kz-gset --addaft=kz-cockpit

# Reset cockpit for karel@pc06
kz-gset --delete=kz-cockpit
rm --force --verbose "$HOME"/.local/share/applications/kz-cockpit.desktop

# Setup firefox for monique@pc01 karel@pc01 marin@pc02 karel@pc06 emily@pc-van-emily
kz-gset --delete=firefox            # dpkg
kz-gset --delete=firefox_firefox    # snap

# Reset firefox for monique@pc01 karel@pc01 marin@pc02 karel@pc06 emily@pc-van-emily
kz-gset --addbef=firefox         # dpkg
kz-gset --addbef=firefox_firefox # snap

# Setup gdebi for *
xdg-mime default gdebi.desktop application/vnd.debian.binary-package

# Reset gdebi for *
xdg-mime default snap-store_ubuntu-software-local-file.desktop application/vnd.debian.binary-package

# Setup gnome for *
! type gnome-session &> /dev/null || gsettings set org.gnome.desktop.calendar show-weekdate true
! type gnome-session &> /dev/null || gsettings set org.gnome.desktop.interface clock-show-date true
! type gnome-session &> /dev/null || gsettings set org.gnome.desktop.interface clock-show-weekday true
! type gnome-session &> /dev/null || gsettings set org.gnome.desktop.interface locate-pointer true
! type gnome-session &> /dev/null || gsettings set org.gnome.desktop.interface show-battery-percentage true
! type gnome-session &> /dev/null || gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
! type gnome-session &> /dev/null || gsettings set org.gnome.desktop.screensaver lock-enabled false
! type gnome-session &> /dev/null || gsettings set org.gnome.desktop.session idle-delay 900
! type gnome-session &> /dev/null || gsettings set org.gnome.desktop.sound allow-volume-above-100-percent true
! type gnome-session &> /dev/null || gsettings set org.gnome.mutter center-new-windows true
! type gnome-session &> /dev/null || gsettings set org.gnome.nautilus.icon-view default-zoom-level 'large'
! type gnome-session &> /dev/null || gsettings set org.gnome.nautilus.preferences click-policy 'single'
! type gnome-session &> /dev/null || gsettings set org.gnome.nautilus.preferences open-folder-on-dnd-hover true
! type gnome-session &> /dev/null || gsettings set org.gnome.nautilus.preferences show-create-link true
! type gnome-session &> /dev/null || gsettings set org.gnome.nautilus.preferences show-image-thumbnails 'always'
! type gnome-session &> /dev/null || gsettings set org.gnome.settings-daemon.peripherals.touchscreen orientation-lock true
! type gnome-session &> /dev/null || gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
! type gnome-session &> /dev/null || gsettings set org.gnome.settings-daemon.plugins.power idle-dim false
! type gnome-session &> /dev/null || gsettings set org.gnome.settings-daemon.plugins.power power-button-action 'interactive'
! type gnome-session &> /dev/null || gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'
! type gnome-session &> /dev/null || gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'nothing'
! type gnome-session &> /dev/null || gsettings set org.gnome.shell.extensions.dash-to-dock apply-custom-theme true
! type gnome-session &> /dev/null || gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize-or-previews'
! type gnome-session &> /dev/null || gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 32
! type gnome-session &> /dev/null || gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts-network false
! type gnome-session &> /dev/null || gsettings set org.gnome.shell.extensions.ding show-home false
! type gnome-session &> /dev/null || gsettings set org.gnome.Terminal.Legacy.Settings theme-variant 'light'

# Reset gnome for *
! type gnome-session &> /dev/null || gsettings reset org.gnome.desktop.calendar show-weekdate
! type gnome-session &> /dev/null || gsettings reset org.gnome.desktop.interface clock-show-date
! type gnome-session &> /dev/null || gsettings reset org.gnome.desktop.interface clock-show-weekday
! type gnome-session &> /dev/null || gsettings reset org.gnome.desktop.interface locate-pointer
! type gnome-session &> /dev/null || gsettings reset org.gnome.desktop.interface show-battery-percentage
! type gnome-session &> /dev/null || gsettings reset org.gnome.desktop.peripherals.touchpad tap-to-click
! type gnome-session &> /dev/null || gsettings reset org.gnome.desktop.screensaver lock-enabled
! type gnome-session &> /dev/null || gsettings reset org.gnome.desktop.session idle-delay
! type gnome-session &> /dev/null || gsettings reset org.gnome.desktop.sound allow-volume-above-100-percent
! type gnome-session &> /dev/null || gsettings reset org.gnome.mutter center-new-windows
! type gnome-session &> /dev/null || gsettings reset org.gnome.nautilus.icon-view default-zoom-level
! type gnome-session &> /dev/null || gsettings reset org.gnome.nautilus.preferences click-policy
! type gnome-session &> /dev/null || gsettings reset org.gnome.nautilus.preferences open-folder-on-dnd-hover
! type gnome-session &> /dev/null || gsettings reset org.gnome.nautilus.preferences show-create-link
! type gnome-session &> /dev/null || gsettings reset org.gnome.nautilus.preferences show-image-thumbnails
! type gnome-session &> /dev/null || gsettings reset org.gnome.settings-daemon.peripherals.touchscreen orientation-lock
! type gnome-session &> /dev/null || gsettings reset org.gnome.settings-daemon.plugins.color night-light-enabled
! type gnome-session &> /dev/null || gsettings reset org.gnome.settings-daemon.plugins.power idle-dim
! type gnome-session &> /dev/null || gsettings reset org.gnome.settings-daemon.plugins.power power-button-action
! type gnome-session &> /dev/null || gsettings reset org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type
! type gnome-session &> /dev/null || gsettings reset org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type
! type gnome-session &> /dev/null || gsettings reset org.gnome.shell.extensions.dash-to-dock apply-custom-theme
! type gnome-session &> /dev/null || gsettings reset org.gnome.shell.extensions.dash-to-dock click-action
! type gnome-session &> /dev/null || gsettings reset org.gnome.shell.extensions.dash-to-dock dash-max-icon-size
! type gnome-session &> /dev/null || gsettings reset org.gnome.shell.extensions.dash-to-dock show-mounts-network
! type gnome-session &> /dev/null || gsettings reset org.gnome.shell.extensions.ding show-home
! type gnome-session &> /dev/null || gsettings reset org.gnome.Terminal.Legacy.Settings theme-variant

# Setup google-chrome for *
xdg-mime default google-chrome.desktop application/pdf

# Setup google-chrome for monique@pc01 karel@pc01 marin@pc02 karel@pc06 emily@pc-van-emily
kz-gset --addbef=google-chrome

# Reset google-chrome for *
xdg-mime default org.gnome.Evince.desktop application/pdf

# Reset google-chrome for monique@pc01 karel@pc01 marin@pc02 karel@pc06 emily@pc-van-emily
kz-gset --delete=google-chrome

# Setup handbrake for emily@pc-van-emily
kz-gset --addaft=fr.handbrake.ghb

# Reset handbrake for emily@pc-van-emily
kz-gset --delete=fr.handbrake.ghb

# Setup hide-files for *
echo 'snap' > "$HOME"/.hidden

# Reset hide-files for *
rm --force --verbose "$HOME"/.hidden

# Setup kvm for karel@pc06
kz-gset --addaft=virt-manager

# Reset kvm for karel@pc06
kz-gset --delete=virt-manager

# Setup lynis for -nouser
git clone https://github.com/CISOfy/lynis /home/"$USER"/lynis || true
# Usage:
# $ cd ~/lynis
# $ [sudo] ./lynis audit system

# Reset lynis for -nouser
rm --force --verbose --recursive --verbose /home/"$USER"/lynis

# Setup restore-thumbnails for -nouser
rm --force --verbose --recursive --verbose "$HOME"/.cache/thumbnails/

# Reset restore-thumbnails for -nouser
# There is no command available to reset restored thumbnails.
# Setup spotify for monique@pc01 karel@pc01 marin@pc02 karel@pc06
kz-gset --addaft=kz-spotify

# Reset spotify for monique@pc01 karel@pc01 marin@pc02 karel@pc06
kz-gset --delete=kz-spotify

# Setup sound-juicer for emily@pc-van-emily
kz-gset --addaft=org.gnome.SoundJuicer

# Reset sound-juicer for emily@pc-van-emily
kz-gset --delete=org.gnome.SoundJuicer

# Setup thunderbird for monique@pc01 karel@pc01 marin@pc02 karel@pc06
kz-gset --delete=thunderbird                # dpkg
kz-gset --delete=thunderbird_thunderbird    # snap

# Reset thunderbird for monique@pc01 karel@pc01 marin@pc02 karel@pc06
kz-gset --addbef=thunderbird             # dpkg
kz-gset --addbef=thunderbird_thunderbird # snap

# Setup teamviewer for karel@pc06
kz-gset --addaft=com.teamviewer.TeamViewer

# Reset teamviewer for karel@pc06
kz-gset --delete=com.teamviewer.TeamViewer

# Setup telegram for hugo@pc-van-hugo maria@maria-desktop
kz-gset --addaft=kz-telegram

# Reset telegram for hugo@pc-van-hugo  maria@maria-desktop
kz-gset --delete=kz-telegram

# Setup terminal for karel@pc01 karel@pc06
kz-gset --addbef=org.gnome.Terminal
# Search forward in history (with Ctrl-S).
sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc
echo 'stty -ixon  # Enable fwd search history (i-search)' >> "$HOME"/.bashrc

# Reset terminal for karel@pc01 karel@pc06
kz-gset --delete=org.gnome.Terminal
sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc

# Setup ubuntu-desktop-installer for *
kz-gset --delete=ubuntu-desktop-installer_ubuntu-desktop-installer

# Reset ubuntu-desktop-installer for *
kz-gset --addbef=ubuntu-desktop-installer_ubuntu-desktop-installer

# Setup virtualbox for hugo@pc-van-hugo
kz-gset --addaft=virtualbox
kz-gset --addaft=kz-vm-hugowin732

# Reset virtualbox for hugo@pc-van-hugo
kz-gset --delete=virtualbox
kz-gset --delete=kz-vm-hugowin732

# Setup vlc for *
xdg-mime default vlc.desktop video/mp4              # dpkg
xdg-mime default vlc.desktop video/x-matroska       # dpkg
xdg-mime default vlc.desktop video/webm             # dpkg
xdg-mime default vlc_vlc.desktop video/mp4          # snap
xdg-mime default vlc_vlc.desktop video/x-matroska   # snap
xdg-mime default vlc_vlc.desktop video/webm         # snap

# Reset vlc for *
xdg-mime default org.gnome.Totem.desktop video/mp4
xdg-mime default org.gnome.Totem.desktop video/x-matroska
xdg-mime default org.gnome.Totem.desktop video/webm

# Setup vscode for karel@pc01 karel@pc06
kz-gset --addbef=code_code
xdg-mime default code_code.desktop application/json
xdg-mime default code_code.desktop application/x-desktop
xdg-mime default code_code.desktop application/x-shellscript
xdg-mime default code_code.desktop application/xml
xdg-mime default code_code.desktop text/html
xdg-mime default code_code.desktop text/markdown
xdg-mime default code_code.desktop text/troff
xdg-mime default code_code.desktop text/x-python

# Reset vscode for karel@pc01 karel@pc06
kz-gset --delete=code_code
xdg-mime default org.gnome.gedit.desktop application/json
xdg-mime default org.gnome.gedit.desktop application/x-desktop
xdg-mime default org.gnome.gedit.desktop application/x-shellscript
xdg-mime default org.gnome.gedit.desktop application/xml
xdg-mime default org.gnome.gedit.desktop text/html
xdg-mime default org.gnome.gedit.desktop text/markdown
xdg-mime default org.gnome.gedit.desktop text/troff
xdg-mime default org.gnome.gedit.desktop text/x-python

# Setup whatsapp for hugo@pc-van-hugo maria@maria-desktop
kz-gset --addaft=kz-whatsapp

# Reset whatsapp for hugo@pc-van-hugo maria@maria-desktop
kz-gset --delete=kz-whatsapp

# Setup youtube-dl for emily@pc-van-emily
kz-gset --addaft=youtubedl-gui

# Reset youtube-dl for emily@pc-van-emily
kz-gset --delete=youtubedl-gui

# Setup zoom for monique@pc01 karel@pc01
kz-gset --addaft=kz-zoom

# Reset zoom for monique@pc01 karel@pc01
kz-gset --delete=kz-zoom
