# shellcheck shell=bash
###############################################################################
# SPDX-FileComment: Set up file for Ubuntu desktop
#
# SPDX-FileCopyrightText: Karel Zimmer <info@karelzimmer.nl>
# SPDX-License-Identifier: CC0-1.0
###############################################################################

# Setup APP anydesk USER -nouser
kz-gset --addfavaft=anydesk

# Reset APP anydesk USER -nouser
kz-gset --delfav=anydesk


# Setup APP calibre USER hugo@pc-van-hugo
kz-gset --addfavaft=calibre-gui

# Reset APP calibre USER hugo@pc-van-hugo
kz-gset --delfav=calibre-gui


# Setup APP cockpit USER karel@pc06
kz-gset --addfavaft=kz-cockpit

# Reset APP cockpit USER karel@pc06
kz-gset --delfav=kz-cockpit
rm --force --verbose "$HOME"/.local/share/applications/kz-cockpit.desktop


# Setup APP firefox USER monique@pc01 karel@pc01 marin@pc02 karel@pc06
kz-gset --delfav=firefox_firefox

# Reset APP firefox USER monique@pc01 karel@pc01 marin@pc02 karel@pc06
kz-gset --addfavbef=firefox_firefox


# Setup APP gdebi USER *
xdg-mime default gdebi.desktop application/vnd.debian.binary-package

# Reset APP gdebi USER *
xdg-mime default snap-store_ubuntu-software-local-file.desktop application/vnd.debian.binary-package


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


# Setup APP google-chrome USER *
xdg-mime default google-chrome.desktop application/pdf

# Reset APP google-chrome USER *
xdg-mime default org.gnome.Evince.desktop application/pdf


# Setup APP google-chrome USER monique@pc01 karel@pc01 marin@pc02 karel@pc06
kz-gset --addfavbef=google-chrome

# Reset APP google-chrome USER monique@pc01 karel@pc01 marin@pc02 karel@pc06
kz-gset --delfav=google-chrome


# Setup APP handbrake USER emily@pc-van-emily
kz-gset --addfavaft=fr.handbrake.ghb

# Reset APP handbrake USER emily@pc-van-emily
kz-gset --delfav=fr.handbrake.ghb


# Setup APP kvm USER karel@pc06
kz-gset --addfavaft=virt-manager

# Reset APP kvm USER karel@pc06
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


# Setup APP spotify USER monique@pc01 karel@pc01 marin@pc02 karel@pc06
kz-gset --addfavaft=kz-spotify

# Reset APP spotify USER monique@pc01 karel@pc01 marin@pc02 karel@pc06
kz-gset --delfav=kz-spotify


# Setup APP start-installer USER *
kz-gset --delfav=ubuntu-desktop-installer_ubuntu-desktop-installer

# Reset APP start-installer USER *
kz-gset --addfavbef=ubuntu-desktop-installer_ubuntu-desktop-installer


# Setup APP sound-juicer USER emily@pc-van-emily
kz-gset --addfavaft=org.gnome.SoundJuicer

# Reset APP sound-juicer USER emily@pc-van-emily
kz-gset --delfav=org.gnome.SoundJuicer


# Setup APP thunderbird USER monique@pc01 karel@pc01 marin@pc02 karel@pc06
kz-gset --delfav=thunderbird

# Reset APP thunderbird USER monique@pc01 karel@pc01 marin@pc02 karel@pc06
kz-gset --addfavbef=thunderbird


# Setup APP teamviewer USER karel@pc06
kz-gset --addfavaft=com.teamviewer.TeamViewer

# Reset APP teamviewer USER karel@pc06
kz-gset --delfav=com.teamviewer.TeamViewer


# Setup APP telegram USER hugo@pc-van-hugo maria@maria-desktop
kz-gset --addfavaft=kz-telegram

# Reset APP telegram USER hugo@pc-van-hugo  maria@maria-desktop
kz-gset --delfav=kz-telegram


# Setup APP terminal USER karel@pc01 karel@pc06
kz-gset --addfavbef=org.gnome.Terminal
: # Search forward in history (with Ctrl-S).
sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc
echo 'stty -ixon  # Enable fwd search history (i-search)' >> "$HOME"/.bashrc

# Reset APP terminal USER karel@pc01 karel@pc06
kz-gset --delfav=org.gnome.Terminal
sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc


# Setup APP virtualbox USER hugo@pc-van-hugo
kz-gset --addfavaft=virtualbox
kz-gset --addfavaft=kz-vm-hugowin732

# Reset APP virtualbox USER hugo@pc-van-hugo
kz-gset --delfav=virtualbox
kz-gset --delfav=kz-vm-hugowin732


# Setup APP vlc USER *
xdg-mime default vlc_vlc.desktop video/mp4
xdg-mime default vlc_vlc.desktop video/x-matroska
xdg-mime default vlc_vlc.desktop video/webm

# Reset APP vlc USER *
xdg-mime default org.gnome.Totem.desktop video/mp4
xdg-mime default org.gnome.Totem.desktop video/x-matroska
xdg-mime default org.gnome.Totem.desktop video/webm


# Setup APP vscode USER karel@pc01 karel@pc06
kz-gset --addfavbef=code_code
xdg-mime default code_code.desktop application/json
xdg-mime default code_code.desktop application/x-desktop
xdg-mime default code_code.desktop application/x-shellscript
xdg-mime default code_code.desktop application/xml
xdg-mime default code_code.desktop text/html
xdg-mime default code_code.desktop text/markdown
xdg-mime default code_code.desktop text/troff
xdg-mime default code_code.desktop text/x-python

# Reset APP vscode USER karel@pc01 karel@pc06
kz-gset --delfav=code_code
xdg-mime default org.gnome.gedit.desktop application/json
xdg-mime default org.gnome.gedit.desktop application/x-desktop
xdg-mime default org.gnome.gedit.desktop application/x-shellscript
xdg-mime default org.gnome.gedit.desktop application/xml
xdg-mime default org.gnome.gedit.desktop text/html
xdg-mime default org.gnome.gedit.desktop text/markdown
xdg-mime default org.gnome.gedit.desktop text/troff
xdg-mime default org.gnome.gedit.desktop text/x-python


# Setup APP whatsapp USER hugo@pc-van-hugo maria@maria-desktop
kz-gset --addfavaft=kz-whatsapp

# Reset APP whatsapp USER hugo@pc-van-hugo maria@maria-desktop
kz-gset --delfav=kz-whatsapp


# Setup APP zoom USER monique@pc01 karel@pc01
kz-gset --addfavaft=kz-zoom

# Reset APP zoom USER monique@pc01 karel@pc01
kz-gset --delfav=kz-zoom
