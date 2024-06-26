# shellcheck shell=bash
###############################################################################
# SPDX-FileComment: Set up file for a desktop
#
# SPDX-FileCopyrightText: Karel Zimmer <info@karelzimmer.nl>
# SPDX-License-Identifier: CC0-1.0
###############################################################################

# Setup anydesk for -nouser
#
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

# Setup dashtodock for *
if type gnome-session &> /dev/null; then gnome-extensions enable dash-to-dock@micxgx.gmail.com || true; fi # Not every GNOME machine has this extension installed.
if type gnome-session &> /dev/null; then gsettings set org.gnome.shell disable-user-extensions false; fi
if type gnome-session &> /dev/null; then gsettings set org.gnome.shell.extensions.dash-to-dock apply-custom-theme true; fi
if type gnome-session &> /dev/null; then gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize-or-previews'; fi
if type gnome-session &> /dev/null; then gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 32; fi
if type gnome-session &> /dev/null; then gsettings set org.gnome.shell.extensions.dash-to-dock disable-overview-on-startup true || true; fi # Not every GNOME machine has this key.
if type gnome-session &> /dev/null; then gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed true; fi
if type gnome-session &> /dev/null; then gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'LEFT'; fi
if type gnome-session &> /dev/null; then gsettings set org.gnome.shell.extensions.dash-to-dock extend-height true; fi
if type gnome-session &> /dev/null; then gsettings set org.gnome.shell.extensions.dash-to-dock icon-size-fixed true; fi

# Reset dashtodock for *
if type gnome-session &> /dev/null; then gnome-extensions disable dash-to-dock@micxgx.gmail.com || true; fi # Not every GNOME machine has this installed.
if type gnome-session &> /dev/null; then gsettings reset org.gnome.shell disable-user-extensions; fi
if type gnome-session &> /dev/null; then gsettings reset org.gnome.shell.extensions.dash-to-dock apply-custom-theme; fi
if type gnome-session &> /dev/null; then gsettings reset org.gnome.shell.extensions.dash-to-dock click-action; fi
if type gnome-session &> /dev/null; then gsettings reset org.gnome.shell.extensions.dash-to-dock dash-max-icon-size; fi
if type gnome-session &> /dev/null; then gsettings reset org.gnome.shell.extensions.dash-to-dock disable-overview-on-startup || true; fi # Not every GNOME machine has this key.
if type gnome-session &> /dev/null; then gsettings reset org.gnome.shell.extensions.dash-to-dock dock-fixed; fi
if type gnome-session &> /dev/null; then gsettings reset org.gnome.shell.extensions.dash-to-dock dock-position; fi
if type gnome-session &> /dev/null; then gsettings reset org.gnome.shell.extensions.dash-to-dock extend-height; fi
if type gnome-session &> /dev/null; then gsettings reset org.gnome.shell.extensions.dash-to-dock icon-size-fixed; fi

# Setup debian-desktop-installer for *
if [[ $(lsb_release --id --short) = 'Debian' ]]; then kz-gset --delete=install-debian; fi

# Reset debian-desktop-installer for *
if [[ $(lsb_release --id --short) = 'Debian' ]]; then kz-gset --addbef=install-debian; fi

# Setup evolution for karel@pc07
kz-gset --delete=org.gnome.Evolution

# Reset evolution for karel@pc07
kz-gset --addbef=org.gnome.Evolution

# Setup firefox for karel@pc07
kz-gset --delete=firefox-esr

# Setup firefox for emily@pc-van-emily karel@pc01 karel@pc06 marin@pc02 monique@pc01
kz-gset --delete=firefox

# Reset firefox for karel@pc07
kz-gset --addbef=firefox-esr

# Reset firefox for emily@pc-van-emily karel@pc01 karel@pc06 marin@pc02 monique@pc01
kz-gset --addbef=firefox

# Setup gdebi for *
xdg-mime default gdebi.desktop application/vnd.debian.binary-package

# Reset gdebi for *
xdg-mime default org.gnome.FileRoller.desktop application/vnd.debian.binary-package

# Setup gnome for *
if type gnome-session &> /dev/null; then gsettings set org.gnome.desktop.calendar show-weekdate true; fi
if type gnome-session &> /dev/null; then gsettings set org.gnome.desktop.interface clock-show-date true; fi
if type gnome-session &> /dev/null; then gsettings set org.gnome.desktop.interface clock-show-weekday true; fi
if type gnome-session &> /dev/null; then gsettings set org.gnome.desktop.interface locate-pointer true; fi
if type gnome-session &> /dev/null; then gsettings set org.gnome.desktop.interface show-battery-percentage true; fi
if type gnome-session &> /dev/null; then gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true; fi
if type gnome-session &> /dev/null; then gsettings set org.gnome.desktop.screensaver lock-enabled false; fi
if type gnome-session &> /dev/null; then gsettings set org.gnome.desktop.session idle-delay 900; fi
if type gnome-session &> /dev/null; then gsettings set org.gnome.desktop.sound allow-volume-above-100-percent true; fi
if type gnome-session &> /dev/null; then gsettings set org.gnome.desktop.wm.preferences button-layout ':minimize,maximize,close'; fi
if type gnome-session &> /dev/null; then gsettings set org.gnome.mutter center-new-windows true; fi
if type gnome-session &> /dev/null; then gsettings set org.gnome.nautilus.icon-view default-zoom-level 'large'; fi
if type gnome-session &> /dev/null; then gsettings set org.gnome.nautilus.preferences click-policy 'single'; fi
if type gnome-session &> /dev/null; then gsettings set org.gnome.nautilus.preferences open-folder-on-dnd-hover true; fi
if type gnome-session &> /dev/null; then gsettings set org.gnome.nautilus.preferences show-create-link true; fi
if type gnome-session &> /dev/null; then gsettings set org.gnome.nautilus.preferences show-image-thumbnails 'always'; fi
if type gnome-session &> /dev/null; then gsettings set org.gnome.settings-daemon.peripherals.touchscreen orientation-lock true; fi
if type gnome-session &> /dev/null; then gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true; fi
if type gnome-session &> /dev/null; then gsettings set org.gnome.settings-daemon.plugins.power idle-dim false; fi
if type gnome-session &> /dev/null; then gsettings set org.gnome.settings-daemon.plugins.power power-button-action 'interactive'; fi
if type gnome-session &> /dev/null; then gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'; fi
if type gnome-session &> /dev/null; then gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'nothing'; fi
if type gnome-session &> /dev/null; then gsettings set org.gnome.shell disable-user-extensions false; fi
if type gnome-session &> /dev/null; then gsettings set org.gnome.shell.extensions.dash-to-dock apply-custom-theme true; fi
if type gnome-session &> /dev/null; then gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize-or-previews'; fi
if type gnome-session &> /dev/null; then gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 32; fi
if type gnome-session &> /dev/null; then gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts-network false || true; fi # Not every GNOME machine has this key.
if type gnome-session &> /dev/null; then gsettings set org.gnome.shell.extensions.ding show-home false || true; fi # Not every GNOME machine has this key.
if type gnome-session &> /dev/null; then gsettings set org.gnome.Terminal.Legacy.Settings theme-variant 'light'; fi

# Reset gnome for *
if type gnome-session &> /dev/null; then gsettings reset org.gnome.desktop.calendar show-weekdate; fi
if type gnome-session &> /dev/null; then gsettings reset org.gnome.desktop.interface clock-show-date; fi
if type gnome-session &> /dev/null; then gsettings reset org.gnome.desktop.interface clock-show-weekday; fi
if type gnome-session &> /dev/null; then gsettings reset org.gnome.desktop.interface locate-pointer; fi
if type gnome-session &> /dev/null; then gsettings reset org.gnome.desktop.interface show-battery-percentage; fi
if type gnome-session &> /dev/null; then gsettings reset org.gnome.desktop.peripherals.touchpad tap-to-click; fi
if type gnome-session &> /dev/null; then gsettings reset org.gnome.desktop.screensaver lock-enabled; fi
if type gnome-session &> /dev/null; then gsettings reset org.gnome.desktop.session idle-delay; fi
if type gnome-session &> /dev/null; then gsettings reset org.gnome.desktop.sound allow-volume-above-100-percent; fi
if type gnome-session &> /dev/null; then gsettings reset org.gnome.desktop.wm.preferences button-layout; fi
if type gnome-session &> /dev/null; then gsettings reset org.gnome.mutter center-new-windows; fi
if type gnome-session &> /dev/null; then gsettings reset org.gnome.nautilus.icon-view default-zoom-level; fi
if type gnome-session &> /dev/null; then gsettings reset org.gnome.nautilus.preferences click-policy; fi
if type gnome-session &> /dev/null; then gsettings reset org.gnome.nautilus.preferences open-folder-on-dnd-hover; fi
if type gnome-session &> /dev/null; then gsettings reset org.gnome.nautilus.preferences show-create-link; fi
if type gnome-session &> /dev/null; then gsettings reset org.gnome.nautilus.preferences show-image-thumbnails; fi
if type gnome-session &> /dev/null; then gsettings reset org.gnome.settings-daemon.peripherals.touchscreen orientation-lock; fi
if type gnome-session &> /dev/null; then gsettings reset org.gnome.settings-daemon.plugins.color night-light-enabled; fi
if type gnome-session &> /dev/null; then gsettings reset org.gnome.settings-daemon.plugins.power idle-dim; fi
if type gnome-session &> /dev/null; then gsettings reset org.gnome.settings-daemon.plugins.power power-button-action; fi
if type gnome-session &> /dev/null; then gsettings reset org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type; fi
if type gnome-session &> /dev/null; then gsettings reset org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type; fi
if type gnome-session &> /dev/null; then gsettings reset org.gnome.shell disable-user-extensions; fi
if type gnome-session &> /dev/null; then gsettings reset org.gnome.shell.extensions.dash-to-dock apply-custom-theme; fi
if type gnome-session &> /dev/null; then gsettings reset org.gnome.shell.extensions.dash-to-dock click-action; fi
if type gnome-session &> /dev/null; then gsettings reset org.gnome.shell.extensions.dash-to-dock dash-max-icon-size; fi
if type gnome-session &> /dev/null; then gsettings reset org.gnome.shell.extensions.dash-to-dock show-mounts-network || true; fi # Not every GNOME machine has this key.
if type gnome-session &> /dev/null; then gsettings reset org.gnome.shell.extensions.ding show-home || true; fi # Not every GNOME machine has this key.
if type gnome-session &> /dev/null; then gsettings reset org.gnome.Terminal.Legacy.Settings theme-variant; fi

# Setup google-chrome for *
xdg-mime default google-chrome.desktop application/pdf

# Setup google-chrome for emily@pc-van-emily karel@pc01 karel@pc06 karel@pc07 marin@pc02 monique@pc01
kz-gset --addbef=google-chrome

# Reset google-chrome for *
xdg-mime default org.gnome.Evince.desktop application/pdf

# Reset google-chrome for emily@pc-van-emily karel@pc01 karel@pc06 karel@pc07 marin@pc02 monique@pc01
kz-gset --delete=google-chrome

# Setup handbrake for emily@pc-van-emily
kz-gset --addaft=fr.handbrake.ghb

# Reset handbrake for emily@pc-van-emily
kz-gset --delete=fr.handbrake.ghb

# Setup hide-files for *
echo 'snap' > "$HOME"/.hidden

# Reset hide-files for *
rm --force --verbose "$HOME"/.hidden

# Setup kvm for karel@pc06 karel@pc07
kz-gset --addaft=virt-manager

# Reset kvm for karel@pc06 karel@pc07
kz-gset --delete=virt-manager

# Setup lynis for -nouser
git clone https://github.com/CISOfy/lynis /home/"$USER"/lynis || true
#
# Usage:
# $ cd ~/lynis
# $ [sudo] ./lynis audit system

# Reset lynis for -nouser
rm --force --verbose --recursive --verbose /home/"$USER"/lynis

# Setup restore-thumbnails for -nouser
rm --force --verbose --recursive --verbose "$HOME"/.cache/thumbnails/

# Reset restore-thumbnails for -nouser
# There is no command available to reset restored thumbnails.

# Setup sound-juicer for emily@pc-van-emily
kz-gset --addaft=org.gnome.SoundJuicer

# Reset sound-juicer for emily@pc-van-emily
kz-gset --delete=org.gnome.SoundJuicer

# Setup spotify for karel@pc01 karel@pc06 karel@pc07 marin@pc02 monique@pc01
kz-gset --addaft=kz-spotify

# Reset spotify for karel@pc01 karel@pc06 karel@pc07 marin@pc02 monique@pc01
kz-gset --delete=kz-spotify

# Setup teamviewer for karel@pc06
kz-gset --addaft=com.teamviewer.TeamViewer

# Reset teamviewer for karel@pc06
kz-gset --delete=com.teamviewer.TeamViewer

# Setup telegram for hugo@pc-van-hugo maria@maria-desktop
kz-gset --addaft=kz-telegram

# Reset telegram for hugo@pc-van-hugo maria@maria-desktop
kz-gset --delete=kz-telegram

# Setup terminal for karel@pc01 karel@pc06 karel@pc07
kz-gset --addbef=org.gnome.Terminal
#
# Turn on aliases.
sed --in-place --expression='s/#alias/alias/g' "$HOME"/.bashrc
#
# Enable search forward in history (with Ctrl-S).
sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc
echo 'stty -ixon  # Enable fwd search history (i-search)' >> "$HOME"/.bashrc

# Reset terminal for karel@pc01 karel@pc06 karel@pc07
kz-gset --delete=org.gnome.Terminal
sed --in-place --expression='s/alias/#alias/g' "$HOME"/.bashrc
sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc

# Setup thunderbird for karel@pc01 karel@pc06 marin@pc02 monique@pc01
kz-gset --delete=thunderbird

# Reset thunderbird for karel@pc01 karel@pc06 marin@pc02 monique@pc01
kz-gset --addbef=thunderbird

# Setup ubuntu-desktop-installer for *
if [[ $(lsb_release --id --short) = 'Ubuntu' ]]; then kz-gset --delete=ubuntu-desktop-installer_ubuntu-desktop-installer; fi

# Reset ubuntu-desktop-installer for *
if [[ $(lsb_release --id --short) = 'Ubuntu' ]]; then kz-gset --addbef=ubuntu-desktop-installer_ubuntu-desktop-installer; fi

# Setup virtualbox for hugo@pc-van-hugo
kz-gset --addaft=virtualbox
kz-gset --addaft=kz-vm-hugowin732

# Reset virtualbox for hugo@pc-van-hugo
kz-gset --delete=virtualbox
kz-gset --delete=kz-vm-hugowin732

# Setup vlc for *
xdg-mime default vlc.desktop video/mp4
xdg-mime default vlc.desktop video/x-matroska
xdg-mime default vlc.desktop video/webm

# Reset vlc for *
xdg-mime default org.gnome.Totem.desktop video/mp4
xdg-mime default org.gnome.Totem.desktop video/x-matroska
xdg-mime default org.gnome.Totem.desktop video/webm

# Setup vscode for karel@pc01 karel@pc06 karel@pc07
kz-gset --addbef=code
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
kz-gset --delete=code
xdg-mime default org.gnome.gedit.desktop application/json
xdg-mime default org.gnome.gedit.desktop application/x-desktop
xdg-mime default org.gnome.gedit.desktop application/x-shellscript
xdg-mime default org.gnome.gedit.desktop application/xml
xdg-mime default org.gnome.gedit.desktop text/html
xdg-mime default org.gnome.gedit.desktop text/markdown
xdg-mime default org.gnome.gedit.desktop text/plain
xdg-mime default org.gnome.gedit.desktop text/troff
xdg-mime default org.gnome.gedit.desktop text/x-python

# Setup webmin for karel@pc07
kz-gset --addaft=kz-webmin

# Reset webmin for karel@pc07
kz-gset --delete=kz-webmin
rm --force --verbose "$HOME"/.local/share/applications/kz-webmin.desktop

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

