# shellcheck shell=bash
###############################################################################
# SPDX-FileComment: Set up file for Debian desktop
#
# SPDX-FileCopyrightText: Karel Zimmer <info@karelzimmer.nl>
# SPDX-License-Identifier: CC0-1.0
###############################################################################

# Setup dashtodock for *
gnome-extensions enable dash-to-dock@micxgx.gmail.com
gsettings set org.gnome.shell disable-user-extensions false
gsettings set org.gnome.shell.extensions.dash-to-dock apply-custom-theme true
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize-or-previews'
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 32
gsettings set org.gnome.shell.extensions.dash-to-dock disable-overview-on-startup true
gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed true
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'LEFT'
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height true
gsettings set org.gnome.shell.extensions.dash-to-dock icon-size-fixed true

# Reset dashtodock for *
gnome-extensions disable dash-to-dock@micxgx.gmail.com
gsettings reset org.gnome.shell disable-user-extensions
gsettings reset org.gnome.shell.extensions.dash-to-dock apply-custom-theme
gsettings reset org.gnome.shell.extensions.dash-to-dock click-action
gsettings reset org.gnome.shell.extensions.dash-to-dock dash-max-icon-size
gsettings reset org.gnome.shell.extensions.dash-to-dock disable-overview-on-startup
gsettings reset org.gnome.shell.extensions.dash-to-dock dock-fixed
gsettings reset org.gnome.shell.extensions.dash-to-dock dock-position
gsettings reset org.gnome.shell.extensions.dash-to-dock extend-height
gsettings reset org.gnome.shell.extensions.dash-to-dock icon-size-fixed

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
gsettings set org.gnome.desktop.calendar show-weekdate true
gsettings set org.gnome.desktop.interface clock-show-date true
gsettings set org.gnome.desktop.interface clock-show-weekday true
gsettings set org.gnome.desktop.interface locate-pointer true
gsettings set org.gnome.desktop.interface show-battery-percentage true
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
gsettings set org.gnome.desktop.screensaver lock-enabled false
gsettings set org.gnome.desktop.session idle-delay 900
gsettings set org.gnome.desktop.sound allow-volume-above-100-percent true
gsettings set org.gnome.desktop.wm.preferences button-layout ':minimize,maximize,close'
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
gsettings set org.gnome.shell disable-user-extensions false
gsettings set org.gnome.Terminal.Legacy.Settings theme-variant 'light'

# Reset gnome for *
gsettings reset org.gnome.desktop.app-folders folder-children
gsettings reset org.gnome.desktop.calendar show-weekdate
gsettings reset org.gnome.desktop.interface clock-show-date
gsettings reset org.gnome.desktop.interface clock-show-weekday
gsettings reset org.gnome.desktop.interface locate-pointer
gsettings reset org.gnome.desktop.interface show-battery-percentage
gsettings reset org.gnome.desktop.peripherals.touchpad tap-to-click
gsettings reset org.gnome.desktop.peripherals.touchpad tap-to-click
gsettings reset org.gnome.desktop.screensaver lock-enabled
gsettings reset org.gnome.desktop.session idle-delay
gsettings reset org.gnome.desktop.sound allow-volume-above-100-percent
gsettings reset org.gnome.desktop.wm.preferences button-layout
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
gsettings reset org.gnome.shell disable-user-extensions
gsettings reset org.gnome.Terminal.Legacy.Settings theme-variant

# Setup google-chrome for *
xdg-mime default google-chrome.desktop application/pdf

# Setup google-chrome for karel@pc07
kz-gset --addbef=google-chrome

# Reset google-chrome for *
xdg-mime default org.gnome.Evince.desktop application/pdf

# Reset google-chrome for karel@pc07
kz-gset --delete=google-chrome

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

# Setup nautilus-hide for *
echo 'snap' > "$HOME"/.hidden

# Reset nautilus-hide for *
rm --force --verbose "$HOME"/.hidden

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
