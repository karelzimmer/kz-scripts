# shellcheck shell=bash
###############################################################################
# SPDX-FileComment: Set up file for use with kz-setup script
#
# SPDX-FileCopyrightText: Karel Zimmer <info@karelzimmer.nl>
# SPDX-License-Identifier: CC0-1.0
###############################################################################
# For the format of the records in this file, see the kz setup man page.
# To manually running a command, first run the following: source kz_common.sh

# Setup anydesk for -nouser
# Remote Wayland display server is not supported.
kz-gnome --addaft=anydesk

# Reset anydesk for -nouser
kz-gnome --delete=anydesk

# Setup calibre for hugo@pc-van-hugo
kz-gnome --addaft=calibre-gui

# Reset calibre for hugo@pc-van-hugo
kz-gnome --delete=calibre-gui

# Setup cockpit for karel@pc06
kz-gnome --addaft=kz-cockpit

# Reset cockpit for karel@pc06
kz-gnome --delete=kz-cockpit
rm --force --verbose "$HOME/.local/share/applications/kz-cockpit.desktop"

# Setup evolution for karel@pc07
kz-gnome --delete=org.gnome.Evolution

# Reset evolution for karel@pc07
kz-gnome --addbef=org.gnome.Evolution

# Setup firefox for karel@pc07
kz-gnome --delete=firefox-esr

# Setup firefox for emily@pc-van-emily karel@pc01 karel@pc06 marin@pc02 monique@pc01
kz-gnome --delete=firefox

# Reset firefox for karel@pc07
kz-gnome --addbef=firefox-esr

# Reset firefox for emily@pc-van-emily karel@pc01 karel@pc06 marin@pc02 monique@pc01
kz-gnome --addbef=firefox

# Setup gdebi for *
if $DESKTOP_ENVIRONMENT && $APT; then xdg-mime default gdebi.desktop application/vnd.debian.binary-package; fi

# Reset gdebi for *
# There is no command available to reset gdebi.

# Setup gnome for *
if $GNOME; then gsettings set org.gnome.desktop.calendar show-weekdate true; fi
if $GNOME; then gsettings set org.gnome.desktop.interface clock-show-date true; fi
if $GNOME; then gsettings set org.gnome.desktop.interface clock-show-weekday true; fi
if $GNOME; then gsettings set org.gnome.desktop.interface show-battery-percentage true; fi
if $GNOME; then gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true; fi
if $GNOME; then gsettings set org.gnome.desktop.screensaver lock-enabled false; fi
if $GNOME; then gsettings set org.gnome.desktop.session idle-delay 900; fi
if $GNOME; then gsettings set org.gnome.desktop.sound allow-volume-above-100-percent true; fi
if $GNOME; then gsettings set org.gnome.desktop.wm.preferences button-layout ':minimize,maximize,close'; fi
if $GNOME; then gsettings set org.gnome.mutter center-new-windows true; fi
if $GNOME; then gsettings set org.gnome.nautilus.icon-view default-zoom-level 'large'; fi
if $GNOME; then gsettings set org.gnome.nautilus.preferences click-policy 'single'; fi
if $GNOME; then gsettings set org.gnome.nautilus.preferences open-folder-on-dnd-hover true; fi
if $GNOME; then gsettings set org.gnome.nautilus.preferences show-create-link true; fi
if $GNOME; then gsettings set org.gnome.nautilus.preferences show-image-thumbnails 'always'; fi
if $GNOME; then gsettings set org.gnome.settings-daemon.plugins.power power-button-action 'interactive'; fi
if $GNOME; then gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'; fi
if $GNOME; then gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'nothing'; fi

# Reset gnome for *
if $GNOME; then gsettings reset org.gnome.desktop.calendar show-weekdate; fi
if $GNOME; then gsettings reset org.gnome.desktop.interface clock-show-date; fi
if $GNOME; then gsettings reset org.gnome.desktop.interface clock-show-weekday; fi
if $GNOME; then gsettings reset org.gnome.desktop.interface show-battery-percentage; fi
if $GNOME; then gsettings reset org.gnome.desktop.peripherals.touchpad tap-to-click; fi
if $GNOME; then gsettings reset org.gnome.desktop.screensaver lock-enabled; fi
if $GNOME; then gsettings reset org.gnome.desktop.session idle-delay; fi
if $GNOME; then gsettings reset org.gnome.desktop.sound allow-volume-above-100-percent; fi
if $GNOME; then gsettings reset org.gnome.desktop.wm.preferences button-layout; fi
if $GNOME; then gsettings reset org.gnome.mutter center-new-windows; fi
if $GNOME; then gsettings reset org.gnome.nautilus.icon-view default-zoom-level; fi
if $GNOME; then gsettings reset org.gnome.nautilus.preferences click-policy; fi
if $GNOME; then gsettings reset org.gnome.nautilus.preferences open-folder-on-dnd-hover; fi
if $GNOME; then gsettings reset org.gnome.nautilus.preferences show-create-link; fi
if $GNOME; then gsettings reset org.gnome.nautilus.preferences show-image-thumbnails; fi
if $GNOME; then gsettings reset org.gnome.settings-daemon.plugins.power power-button-action; fi
if $GNOME; then gsettings reset org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type; fi
if $GNOME; then gsettings reset org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type; fi

# Setup google-chrome for *
if $DESKTOP_ENVIRONMENT; then kz-gnome --addbef=google-chrome; fi
if $DESKTOP_ENVIRONMENT; then xdg-mime default google-chrome.desktop application/pdf; fi

# Reset google-chrome for *
if $DESKTOP_ENVIRONMENT; then kz-gnome --delete=google-chrome; fi

# Setup handbrake for emily@pc-van-emily
kz-gnome --addaft=fr.handbrake.ghb

# Reset handbrake for emily@pc-van-emily
kz-gnome --delete=fr.handbrake.ghb

# Setup hide-files for *
if $DESKTOP_ENVIRONMENT; then echo 'snap' > "$HOME/.hidden"; fi
if $DESKTOP_ENVIRONMENT; then echo 'kz-backup' >> "$HOME/.hidden"; fi

# Reset hide-files for *
if $DESKTOP_ENVIRONMENT; then rm --force --verbose "$HOME/.hidden"; fi

# Setup kvm for karel@pc06 karel@pc07
kz-gnome --addaft=virt-manager

# Reset kvm for karel@pc06 karel@pc07
kz-gnome --delete=virt-manager

# Setup lynis for -nouser
git clone https://github.com/CISOfy/lynis "$HOME/lynis" || true
# Usage:
# $ cd ~/lynis
# $ [sudo] ./lynis audit system

# Reset lynis for -nouser
rm --force --recursive --verbose "$HOME/lynis"

# Setup restore-thumbnails for -nouser
rm --force --recursive --verbose "$HOME/.cache/thumbnails/"

# Reset restore-thumbnails for -nouser
# There is no command available to reset restored thumbnails.

# Setup private-home for *
chmod 750 "$HOME"

# Reset private-home for *
chmod 755 "$HOME"

# Setup sound-juicer for emily@pc-van-emily
kz-gnome --addaft=org.gnome.SoundJuicer

# Reset sound-juicer for emily@pc-van-emily
kz-gnome --delete=org.gnome.SoundJuicer

# Setup spotify for karel@pc01 karel@pc06 karel@pc07 marin@pc02 monique@pc01
kz-gnome --addaft=kz-spotify

# Reset spotify for karel@pc01 karel@pc06 karel@pc07 marin@pc02 monique@pc01
kz-gnome --delete=kz-spotify

# Setup teamviewer for karel@pc06
kz-gnome --addaft=com.teamviewer.TeamViewer

# Reset teamviewer for karel@pc06
kz-gnome --delete=com.teamviewer.TeamViewer

# Setup terminal for karel@pc01 karel@pc06 karel@pc07
kz-gnome --addbef=org.gnome.Terminal
# Turn on aliases.
sed --in-place --expression='s/#alias/alias/g' "$HOME/.bashrc"
# Enable search forward in history (with Ctrl-S).
sed --in-place --expression='/^stty -ixon/d' "$HOME/.bashrc"
echo 'stty -ixon  # Enable fwd search history (i-search)' >> "$HOME/.bashrc"

# Reset terminal for karel@pc01 karel@pc06 karel@pc07
kz-gnome --delete=org.gnome.Terminal
sed --in-place --expression='s/alias/#alias/g' "$HOME/.bashrc"
sed --in-place --expression='/^stty -ixon/d' "$HOME/.bashrc"

# Setup thunderbird for karel@pc01 karel@pc06 marin@pc02 monique@pc01
kz-gnome --delete=thunderbird

# Reset thunderbird for karel@pc01 karel@pc06 marin@pc02 monique@pc01
kz-gnome --addbef=thunderbird

# Setup virtualbox for hugo@pc-van-hugo
kz-gnome --addaft=virtualbox
kz-gnome --addaft=kz-vm-hugowin732

# Reset virtualbox for hugo@pc-van-hugo
kz-gnome --delete=virtualbox
kz-gnome --delete=kz-vm-hugowin732

# Setup vscode for karel@pc01 karel@pc06 karel@pc07
kz-gnome --addbef=code
xdg-mime default code.desktop application/json
xdg-mime default code.desktop application/x-desktop
xdg-mime default code.desktop application/x-shellscript
xdg-mime default code.desktop application/xml
xdg-mime default code.desktop text/html
xdg-mime default code.desktop text/markdown
xdg-mime default code.desktop text/plain
xdg-mime default code.desktop text/troff
xdg-mime default code.desktop text/x-python

# Reset vscode for karel@pc01 karel@pc06 karel@pc07
kz-gnome --delete=code

# Setup webmin for karel@pc07
kz-gnome --addaft=kz-webmin

# Reset webmin for karel@pc07
kz-gnome --delete=kz-webmin
rm --force --verbose "$HOME/.local/share/applications/kz-webmin.desktop"

# Setup whatsapp for hugo@pc-van-hugo maria@maria-desktop
kz-gnome --addaft=kz-whatsapp

# Reset whatsapp for hugo@pc-van-hugo maria@maria-desktop
kz-gnome --delete=kz-whatsapp

# Setup youtube-dl for emily@pc-van-emily
kz-gnome --addaft=youtubedl-gui

# Reset youtube-dl for emily@pc-van-emily
kz-gnome --delete=youtubedl-gui

# Setup zoom for monique@pc01 karel@pc01
kz-gnome --addaft=kz-zoom

# Reset zoom for monique@pc01 karel@pc01
kz-gnome --delete=kz-zoom

