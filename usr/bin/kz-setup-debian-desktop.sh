# shellcheck shell=bash
###############################################################################
# SPDX-FileComment: Set up file for Debian desktop
#
# SPDX-FileCopyrightText: Karel Zimmer <info@karelzimmer.nl>
# SPDX-License-Identifier: CC0-1.0
###############################################################################

# Setup APP dashtodock USER *
gnome-extensions enable dash-to-dock@micxgx.gmail.com
gsettings set org.gnome.shell.extensions.dash-to-dock apply-custom-theme true
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize-or-previews'
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 32
gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed true
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'LEFT'
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height true
gsettings set org.gnome.shell.extensions.dash-to-dock icon-size-fixed true
gsettings set org.gnome.shell disable-user-extensions false

# Reset APP dashtodock USER *
gnome-extensions disable dash-to-dock@micxgx.gmail.com
gsettings reset org.gnome.shell.extensions.dash-to-dock apply-custom-theme
gsettings reset org.gnome.shell.extensions.dash-to-dock click-action
gsettings reset org.gnome.shell.extensions.dash-to-dock dash-max-icon-size
gsettings reset org.gnome.shell.extensions.dash-to-dock dock-fixed
gsettings reset org.gnome.shell.extensions.dash-to-dock dock-position
gsettings reset org.gnome.shell.extensions.dash-to-dock extend-height
gsettings reset org.gnome.shell.extensions.dash-to-dock icon-size-fixed
gsettings reset org.gnome.shell disable-user-extensions


# Setup APP firefox USER karel@pc07
kz-gset --delfav=firefox-esr

# Reset APP firefox USER karel@pc07
kz-gset --addfavbef=firefox-esr


# Setup APP gdebi USER *
xdg-mime default gdebi.desktop application/vnd.debian.binary-package

# Reset APP gdebi USER *
xdg-mime default org.gnome.FileRoller.desktop application/vnd.debian.binary-package


# Setup APP gnome USER *
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

# Reset APP gnome USER *
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


# Setup APP google-chrome USER *
xdg-mime default google-chrome.desktop application/pdf

# Reset APP google-chrome USER *
xdg-mime default org.gnome.Evince.desktop application/pdf


# Setup APP google-chrome USER karel@pc07
kz-gset --addfavbef=google-chrome

# Reset APP google-chrome USER karel@pc07
kz-gset --delfav=google-chrome


# Setup APP kvm USER karel@pc07
kz-gset --addfavaft=virt-manager

# Reset APP kvm USER karel@pc07
kz-gset --delfav=virt-manager


# Setup APP lynis USER -nouser
git clone https://github.com/CISOfy/lynis /home/"$USER"/lynis || true
: # Usage:
: # $ cd ~/lynis
: # $ [sudo] ./lynis audit system

# Reset APP lynis USER -nouser
rm --force --verbose --recursive --verbose /home/"$USER"/lynis


# Setup APP nautilus-hide USER *
echo 'snap' > "$HOME"/.hidden

# Reset APP nautilus-hide USER *
rm --force --verbose "$HOME"/.hidden


# Setup APP recover-files-thumbnails USER -nouser
rm --force --verbose --recursive --verbose "$HOME"/.cache/thumbnails/

# Reset APP recover-files-thumbnails USER -nouser
: # nocmd

# Setup APP spotify USER karel@pc07
kz-gset --addfavaft=kz-spotify

# Reset APP spotify USER karel@pc07
kz-gset --delfav=kz-spotify


# Setup APP start-installer USER *
kz-gset --delfav=install-debian

# Reset APP start-installer USER *
kz-gset --addfavbef=install-debian


# Setup APP terminal USER karel@pc07
kz-gset --addfavbef=org.gnome.Terminal
: # # Turn on aliases.
sed --in-place --expression='s/#alias/alias/g' "$HOME"/.bashrc
: # Enable search forward in history (with Ctrl-S).
sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc
echo 'stty -ixon  # Enable fwd search history (i-search)' >> "$HOME"/.bashrc

# Reset APP terminal USER karel@pc07
kz-gset --delfav=org.gnome.Terminal
sed --in-place --expression='s/alias/#alias/g' "$HOME"/.bashrc
sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc


# Setup APP vlc USER *
xdg-mime default vlc_vlc.desktop video/mp4
xdg-mime default vlc_vlc.desktop video/x-matroska
xdg-mime default vlc_vlc.desktop video/webm

# Reset APP vlc USER *
xdg-mime default org.gnome.Totem.desktop video/mp4
xdg-mime default org.gnome.Totem.desktop video/x-matroska
xdg-mime default org.gnome.Totem.desktop video/webm


# Setup APP vscode USER karel@pc07
kz-gset --addfavbef=code_code
xdg-mime default code_code.desktop application/json
xdg-mime default code_code.desktop application/x-desktop
xdg-mime default code_code.desktop application/x-shellscript
xdg-mime default code_code.desktop application/xml
xdg-mime default code_code.desktop text/html
xdg-mime default code_code.desktop text/markdown
xdg-mime default code_code.desktop text/troff
xdg-mime default code_code.desktop text/x-python

# Reset APP vscode USER karel@pc07
kz-gset --delfav=code_code
xdg-mime default org.gnome.gedit.desktop application/json
xdg-mime default org.gnome.gedit.desktop application/x-desktop
xdg-mime default org.gnome.gedit.desktop application/x-shellscript
xdg-mime default org.gnome.gedit.desktop application/xml
xdg-mime default org.gnome.gedit.desktop text/html
xdg-mime default org.gnome.gedit.desktop text/markdown
xdg-mime default org.gnome.gedit.desktop text/troff
xdg-mime default org.gnome.gedit.desktop text/x-python


# Setup APP webmin USER karel@pc07
kz-gset --addfavaft=kz-webmin

# Reset APP webmin USER karel@pc07
kz-gset --delfav=kz-webmin
rm --force --verbose "$HOME"/.local/share/applications/kz-webmin.desktop
