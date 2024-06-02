# shellcheck shell=bash
###############################################################################
# SPDX-FileComment: Set up file for Debian desktop
#
# SPDX-FileCopyrightText: Karel Zimmer <info@karelzimmer.nl>
# SPDX-License-Identifier: CC0-1.0
###############################################################################

# Setup dashtodock for *
gnome-extensions enable dash-to-dock@micxgx.gmail.com
! type gnome-session &> /dev/null || gsettings set org.gnome.shell disable-user-extensions false
! type gnome-session &> /dev/null || gsettings set org.gnome.shell.extensions.dash-to-dock apply-custom-theme true
! type gnome-session &> /dev/null || gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize-or-previews'
! type gnome-session &> /dev/null || gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 32
! type gnome-session &> /dev/null || gsettings set org.gnome.shell.extensions.dash-to-dock disable-overview-on-startup true
! type gnome-session &> /dev/null || gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed true
! type gnome-session &> /dev/null || gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'LEFT'
! type gnome-session &> /dev/null || gsettings set org.gnome.shell.extensions.dash-to-dock extend-height true
! type gnome-session &> /dev/null || gsettings set org.gnome.shell.extensions.dash-to-dock icon-size-fixed true

# Reset dashtodock for *
gnome-extensions disable dash-to-dock@micxgx.gmail.com
! type gnome-session &> /dev/null || gsettings reset org.gnome.shell disable-user-extensions
! type gnome-session &> /dev/null || gsettings reset org.gnome.shell.extensions.dash-to-dock apply-custom-theme
! type gnome-session &> /dev/null || gsettings reset org.gnome.shell.extensions.dash-to-dock click-action
! type gnome-session &> /dev/null || gsettings reset org.gnome.shell.extensions.dash-to-dock dash-max-icon-size
! type gnome-session &> /dev/null || gsettings reset org.gnome.shell.extensions.dash-to-dock disable-overview-on-startup
! type gnome-session &> /dev/null || gsettings reset org.gnome.shell.extensions.dash-to-dock dock-fixed
! type gnome-session &> /dev/null || gsettings reset org.gnome.shell.extensions.dash-to-dock dock-position
! type gnome-session &> /dev/null || gsettings reset org.gnome.shell.extensions.dash-to-dock extend-height
! type gnome-session &> /dev/null || gsettings reset org.gnome.shell.extensions.dash-to-dock icon-size-fixed

# Setup debian-desktop-installer for *
kz-gset --delete=install-debian

# Reset debian-desktop-installer for *
kz-gset --addbef=install-debian

# Setup evolution for karel@pc07
kz-gset --delete=org.gnome.Evolution

# Reset evolution for karel@pc07
kz-gset --addbef=org.gnome.Evolution

# Setup firefox for karel@pc07
kz-gset --delete=firefox-esr

# Reset firefox for karel@pc07
kz-gset --addbef=firefox-esr

# Setup gdebi for *
xdg-mime default gdebi.desktop application/vnd.debian.binary-package

# Reset gdebi for *
xdg-mime default org.gnome.FileRoller.desktop application/vnd.debian.binary-package

# Setup gnome for *
! type gnome-session &> /dev/null || gsettings set org.gnome.desktop.calendar show-weekdate true
! type gnome-session &> /dev/null || gsettings set org.gnome.desktop.interface clock-show-date true
! type gnome-session &> /dev/null || gsettings set org.gnome.desktop.interface clock-show-weekday true
! type gnome-session &> /dev/null || gsettings set org.gnome.desktop.interface locate-pointer true
! type gnome-session &> /dev/null || gsettings set org.gnome.desktop.interface show-battery-percentage true
! type gnome-session &> /dev/null || gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
! type gnome-session &> /dev/null || gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
! type gnome-session &> /dev/null || gsettings set org.gnome.desktop.screensaver lock-enabled false
! type gnome-session &> /dev/null || gsettings set org.gnome.desktop.session idle-delay 900
! type gnome-session &> /dev/null || gsettings set org.gnome.desktop.sound allow-volume-above-100-percent true
! type gnome-session &> /dev/null || gsettings set org.gnome.desktop.wm.preferences button-layout ':minimize,maximize,close'
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
! type gnome-session &> /dev/null || gsettings set org.gnome.shell disable-user-extensions false
! type gnome-session &> /dev/null || gsettings set org.gnome.Terminal.Legacy.Settings theme-variant 'light'

# Reset gnome for *
! type gnome-session &> /dev/null || gsettings reset org.gnome.desktop.calendar show-weekdate
! type gnome-session &> /dev/null || gsettings reset org.gnome.desktop.interface clock-show-date
! type gnome-session &> /dev/null || gsettings reset org.gnome.desktop.interface clock-show-weekday
! type gnome-session &> /dev/null || gsettings reset org.gnome.desktop.interface locate-pointer
! type gnome-session &> /dev/null || gsettings reset org.gnome.desktop.interface show-battery-percentage
! type gnome-session &> /dev/null || gsettings reset org.gnome.desktop.peripherals.touchpad tap-to-click
! type gnome-session &> /dev/null || gsettings reset org.gnome.desktop.peripherals.touchpad tap-to-click
! type gnome-session &> /dev/null || gsettings reset org.gnome.desktop.screensaver lock-enabled
! type gnome-session &> /dev/null || gsettings reset org.gnome.desktop.session idle-delay
! type gnome-session &> /dev/null || gsettings reset org.gnome.desktop.sound allow-volume-above-100-percent
! type gnome-session &> /dev/null || gsettings reset org.gnome.desktop.wm.preferences button-layout
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
! type gnome-session &> /dev/null || gsettings reset org.gnome.shell disable-user-extensions
! type gnome-session &> /dev/null || gsettings reset org.gnome.Terminal.Legacy.Settings theme-variant

# Setup google-chrome for *
xdg-mime default google-chrome.desktop application/pdf

# Setup google-chrome for karel@pc07
kz-gset --addbef=google-chrome

# Reset google-chrome for *
xdg-mime default org.gnome.Evince.desktop application/pdf

# Reset google-chrome for karel@pc07
kz-gset --delete=google-chrome

# Setup hide-files for *
echo 'snap' > "$HOME"/.hidden

# Reset hide-files for *
rm --force --verbose "$HOME"/.hidden

# Setup kvm for karel@pc07
kz-gset --addaft=virt-manager

# Reset kvm for karel@pc07
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
# Setup spotify for karel@pc07
kz-gset --addaft=kz-spotify

# Reset spotify for karel@pc07
kz-gset --delete=kz-spotify

# Setup terminal for karel@pc07
kz-gset --addbef=org.gnome.Terminal
# Turn on aliases.
sed --in-place --expression='s/#alias/alias/g' "$HOME"/.bashrc
# Enable search forward in history (with Ctrl-S).
sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc
echo 'stty -ixon  # Enable fwd search history (i-search)' >> "$HOME"/.bashrc

# Reset terminal for karel@pc07
kz-gset --delete=org.gnome.Terminal
sed --in-place --expression='s/alias/#alias/g' "$HOME"/.bashrc
sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc

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

# Setup vscode for karel@pc07
kz-gset --addbef=code_code
xdg-mime default code_code.desktop application/json
xdg-mime default code_code.desktop application/x-desktop
xdg-mime default code_code.desktop application/x-shellscript
xdg-mime default code_code.desktop application/xml
xdg-mime default code_code.desktop text/html
xdg-mime default code_code.desktop text/markdown
xdg-mime default code_code.desktop text/troff
xdg-mime default code_code.desktop text/x-python

# Reset vscode for karel@pc07
kz-gset --delete=code_code
xdg-mime default org.gnome.gedit.desktop application/json
xdg-mime default org.gnome.gedit.desktop application/x-desktop
xdg-mime default org.gnome.gedit.desktop application/x-shellscript
xdg-mime default org.gnome.gedit.desktop application/xml
xdg-mime default org.gnome.gedit.desktop text/html
xdg-mime default org.gnome.gedit.desktop text/markdown
xdg-mime default org.gnome.gedit.desktop text/troff
xdg-mime default org.gnome.gedit.desktop text/x-python

# Setup webmin for karel@pc07
kz-gset --addaft=kz-webmin

# Reset webmin for karel@pc07
kz-gset --delete=kz-webmin
rm --force --verbose "$HOME"/.local/share/applications/kz-webmin.desktop
