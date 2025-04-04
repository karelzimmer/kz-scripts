# shellcheck shell=bash
###############################################################################
# SPDX-FileComment: Setup file for use with kz-setup script
#
# SPDX-FileCopyrightText: Karel Zimmer <info@karelzimmer.nl>
# SPDX-License-Identifier: CC0-1.0
###############################################################################
# Use "man kz-setup.sh" to learn more about the format of this file.

# The apps are listed in alphabetical order by app name.

# Setup anydesk on pc06 pc07
# Remote desktop.
# Web app: https://my.anydesk.com/v2
kz-desktop --addaft=anydesk

# Reset anydesk on pc06 pc07
# Remote desktop.
# Web app: https://my.anydesk.com/v2
kz-desktop --delete=anydesk


# Setup calibre on pc06 pc-van-hugo
# E-book manager.
kz-desktop --addaft=calibre-gui

# Reset calibre on pc06 pc-van-hugo
# E-book manager.
kz-desktop --delete=calibre-gui


# Setup cockpit on pc06
# Web console.
# Web app: https://localhost:9090
kz-desktop --addaft=kz-cockpit

# Reset cockpit on pc06
# Web console.
# Web app: https://localhost:9090
kz-desktop --delete=kz-cockpit


# Setup dash-to-dock on pc07
# Desktop dock.
if grep --quiet debian /etc/os-release && gnome-extensions info dash-to-dock@micxgx.gmail.com &> /dev/null; then gnome-extensions enable dash-to-dock@micxgx.gmail.com; fi
if grep --quiet debian /etc/os-release && gnome-extensions info dash-to-dock@micxgx.gmail.com &> /dev/null; then gsettings set org.gnome.shell.extensions.dash-to-dock disable-overview-on-startup true; fi

if grep --quiet rhel   /etc/os-release && gnome-extensions info dash-to-dock@gnome-shell-extensions.gcampax.github.com &> /dev/null; then gnome-extensions enable dash-to-dock@gnome-shell-extensions.gcampax.github.com; fi
if grep --quiet rhel   /etc/os-release && gnome-extensions info no-overview@fthx                                       &> /dev/null; then gnome-extensions enable no-overview@fthx; fi

if gsettings get org.gnome.shell disable-user-extensions                    &> /dev/null; then gsettings set org.gnome.shell disable-user-extensions false; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock apply-custom-theme &> /dev/null; then gsettings set org.gnome.shell.extensions.dash-to-dock apply-custom-theme true; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock click-action       &> /dev/null; then gsettings set org.gnome.shell.extensions.dash-to-dock click-action minimize-or-previews; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock dash-max-icon-size &> /dev/null; then gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 32; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock dock-fixed         &> /dev/null; then gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed true; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock dock-position      &> /dev/null; then gsettings set org.gnome.shell.extensions.dash-to-dock dock-position LEFT; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock extend-height      &> /dev/null; then gsettings set org.gnome.shell.extensions.dash-to-dock extend-height true; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock icon-size-fixed    &> /dev/null; then gsettings set org.gnome.shell.extensions.dash-to-dock icon-size-fixed true; fi

# Reset dash-to-dock on pc07
# Desktop dock.
if grep --quiet debian /etc/os-release && gnome-extensions info dash-to-dock@micxgx.gmail.com &> /dev/null; then gnome-extensions disable dash-to-dock@micxgx.gmail.com; fi
if grep --quiet debian /etc/os-release && gnome-extensions info dash-to-dock@micxgx.gmail.com &> /dev/null; then gsettings reset org.gnome.shell.extensions.dash-to-dock disable-overview-on-startup; fi

if grep --quiet rhel   /etc/os-release && gnome-extensions info dash-to-dock@gnome-shell-extensions.gcampax.github.com &> /dev/null; then gnome-extensions disable dash-to-dock@gnome-shell-extensions.gcampax.github.com; fi
if grep --quiet rhel   /etc/os-release && gnome-extensions info dash-to-dock@micxgx.gmail.com &> /dev/null; then gnome-extensions disable dash-to-dock@micxgx.gmail.com; fi

if gsettings get org.gnome.shell disable-user-extensions                    &> /dev/null; then gsettings reset org.gnome.shell disable-user-extensions; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock apply-custom-theme &> /dev/null; then gsettings reset org.gnome.shell.extensions.dash-to-dock apply-custom-theme; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock click-action       &> /dev/null; then gsettings reset org.gnome.shell.extensions.dash-to-dock click-action; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock dash-max-icon-size &> /dev/null; then gsettings reset org.gnome.shell.extensions.dash-to-dock dash-max-icon-size; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock dock-fixed         &> /dev/null; then gsettings reset org.gnome.shell.extensions.dash-to-dock dock-fixed; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock dock-position      &> /dev/null; then gsettings reset org.gnome.shell.extensions.dash-to-dock dock-position; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock extend-height      &> /dev/null; then gsettings reset org.gnome.shell.extensions.dash-to-dock extend-height; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock icon-size-fixed    &> /dev/null; then gsettings reset org.gnome.shell.extensions.dash-to-dock icon-size-fixed; fi


# Setup evolution on pc07
# E-mail and organizer.
kz-desktop --delete=org.gnome.Evolution

# Reset evolution on pc07
# E-mail and organizer.
kz-desktop --addbef=org.gnome.Evolution


# Setup firefox on pc01 pc02 pc06 pc07 pc-van-emily
# Web browser.
kz-desktop --delete=firefox
kz-desktop --delete=firefox-esr
kz-desktop --delete=firefox_firefox

# Reset firefox on pc01 pc02 pc06 pc07 pc-van-emily
# Web browser.
kz-desktop --addbef=firefox
kz-desktop --addbef=firefox-esr
kz-desktop --addbef=firefox_firefox


# Setup gdebi on *
# View and install deb files.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then xdg-mime default gdebi.desktop application/vnd.debian.binary-package; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then echo 'App gdebi is not available.'; fi

# Reset gdebi on *
# View and install deb files.
if [[ ${DISPLAY-} ]]; then echo 'App gdebi cannot be reset.'; fi


# Setup git on pc06 pc07
# Distributed revision control system.
# Web app: https://github.com
git config --global alias.logg 'log --decorate --graph --oneline --all'

# Reset git on pc06 pc07
# Distributed revision control system.
# Web app: https://github.com
git config --global --unset alias.logg


# Setup gnome on *
# Desktop environment.
if gsettings get org.gnome.desktop.calendar show-weekdate                            &> /dev/null; then gsettings set org.gnome.desktop.calendar show-weekdate true; fi
if gsettings get org.gnome.desktop.interface clock-show-date                         &> /dev/null; then gsettings set org.gnome.desktop.interface clock-show-date true; fi
if gsettings get org.gnome.desktop.interface clock-show-weekday                      &> /dev/null; then gsettings set org.gnome.desktop.interface clock-show-weekday true; fi
if gsettings get org.gnome.desktop.interface show-battery-percentage                 &> /dev/null; then gsettings set org.gnome.desktop.interface show-battery-percentage true; fi
if gsettings get org.gnome.desktop.peripherals.touchpad tap-to-click                 &> /dev/null; then gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true; fi
if gsettings get org.gnome.desktop.screensaver lock-enabled                          &> /dev/null; then gsettings set org.gnome.desktop.screensaver lock-enabled false; fi
if gsettings get org.gnome.desktop.session idle-delay                                &> /dev/null; then gsettings set org.gnome.desktop.session idle-delay 900; fi
if gsettings get org.gnome.desktop.sound allow-volume-above-100-percent              &> /dev/null; then gsettings set org.gnome.desktop.sound allow-volume-above-100-percent true; fi
if gsettings get org.gnome.desktop.wm.preferences button-layout                      &> /dev/null; then gsettings set org.gnome.desktop.wm.preferences button-layout :minimize,maximize,close; fi
if gsettings get org.gnome.mutter center-new-windows                                 &> /dev/null; then gsettings set org.gnome.mutter center-new-windows true; fi
if gsettings get org.gnome.nautilus.icon-view default-zoom-level                     &> /dev/null; then gsettings set org.gnome.nautilus.icon-view default-zoom-level large; fi
if gsettings get org.gnome.nautilus.preferences click-policy                         &> /dev/null; then gsettings set org.gnome.nautilus.preferences click-policy single; fi
if gsettings get org.gnome.nautilus.preferences open-folder-on-dnd-hover             &> /dev/null; then gsettings set org.gnome.nautilus.preferences open-folder-on-dnd-hover true; fi
if gsettings get org.gnome.nautilus.preferences show-create-link                     &> /dev/null; then gsettings set org.gnome.nautilus.preferences show-create-link true; fi
if gsettings get org.gnome.nautilus.preferences show-image-thumbnails                &> /dev/null; then gsettings set org.gnome.nautilus.preferences show-image-thumbnails always; fi
if gsettings get org.gnome.settings-daemon.plugins.power power-button-action         &> /dev/null; then gsettings set org.gnome.settings-daemon.plugins.power power-button-action interactive; fi
if gsettings get org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type      &> /dev/null; then gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type nothing; fi
if gsettings get org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type &> /dev/null; then gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type nothing; fi

# Reset gnome on *
# Desktop environment.
if gsettings get org.gnome.desktop.calendar show-weekdate                            &> /dev/null; then gsettings reset org.gnome.desktop.calendar show-weekdate; fi
if gsettings get org.gnome.desktop.interface clock-show-date                         &> /dev/null; then gsettings reset org.gnome.desktop.interface clock-show-date; fi
if gsettings get org.gnome.desktop.interface clock-show-weekday                      &> /dev/null; then gsettings reset org.gnome.desktop.interface clock-show-weekday; fi
if gsettings get org.gnome.desktop.interface show-battery-percentage                 &> /dev/null; then gsettings reset org.gnome.desktop.interface show-battery-percentage; fi
if gsettings get org.gnome.desktop.peripherals.touchpad tap-to-click                 &> /dev/null; then gsettings reset org.gnome.desktop.peripherals.touchpad tap-to-click; fi
if gsettings get org.gnome.desktop.screensaver lock-enabled                          &> /dev/null; then gsettings reset org.gnome.desktop.screensaver lock-enabled; fi
if gsettings get org.gnome.desktop.session idle-delay                                &> /dev/null; then gsettings reset org.gnome.desktop.session idle-delay; fi
if gsettings get org.gnome.desktop.sound allow-volume-above-100-percent              &> /dev/null; then gsettings reset org.gnome.desktop.sound allow-volume-above-100-percent; fi
if gsettings get org.gnome.desktop.wm.preferences button-layout                      &> /dev/null; then gsettings reset org.gnome.desktop.wm.preferences button-layout; fi
if gsettings get org.gnome.mutter center-new-windows                                 &> /dev/null; then gsettings reset org.gnome.mutter center-new-windows; fi
if gsettings get org.gnome.nautilus.icon-view default-zoom-level                     &> /dev/null; then gsettings reset org.gnome.nautilus.icon-view default-zoom-level; fi
if gsettings get org.gnome.nautilus.preferences click-policy                         &> /dev/null; then gsettings reset org.gnome.nautilus.preferences click-policy; fi
if gsettings get org.gnome.nautilus.preferences open-folder-on-dnd-hover             &> /dev/null; then gsettings reset org.gnome.nautilus.preferences open-folder-on-dnd-hover; fi
if gsettings get org.gnome.nautilus.preferences show-create-link                     &> /dev/null; then gsettings reset org.gnome.nautilus.preferences show-create-link; fi
if gsettings get org.gnome.nautilus.preferences show-image-thumbnails                &> /dev/null; then gsettings reset org.gnome.nautilus.preferences show-image-thumbnails; fi
if gsettings get org.gnome.settings-daemon.plugins.power power-button-action         &> /dev/null; then gsettings reset org.gnome.settings-daemon.plugins.power power-button-action; fi
if gsettings get org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type      &> /dev/null; then gsettings reset org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type; fi
if gsettings get org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type &> /dev/null; then gsettings reset org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type; fi


# Setup google-chrome on *
# Web browser.
kz-desktop --addbef=google-chrome
if [[ ${DISPLAY-} ]]; then xdg-mime default google-chrome.desktop application/pdf; fi

# Reset google-chrome on *
# Web browser.
kz-desktop --delete=google-chrome


# Setup handbrake on pc-van-emily
# Video-dvd ripper and transcoder.
kz-desktop --addaft=fr.handbrake.ghb

# Reset handbrake on pc-van-emily
# Video-dvd ripper and transcoder.
kz-desktop --delete=fr.handbrake.ghb


# Setup hide-files on *
# Hide files.
if [[ ${DISPLAY-} ]]; then echo 'snap' > ~/.hidden; fi

# Reset hide-files on *
# Hide files.
if [[ ${DISPLAY-} ]]; then rm --force --verbose ~/.hidden; fi


# Setup kvm on pc06 pc07
# Kernel-based Virtual Machine.
kz-desktop --addaft=virt-manager

# Reset kvm on pc06 pc07
# Kernel-based Virtual Machine.
kz-desktop --delete=virt-manager


# Setup lynis on -none-
# Security auditing.
if ! [[ -d ~/lynis ]]; then git clone https://github.com/CISOfy/lynis ~/lynis; fi
# Usage:
# $ cd ~/lynis
# $ [sudo] ./lynis audit system

# Reset lynis on -none-
# Security auditing.
rm --force --recursive ~/lynis


# Setup restore-thumbnails on -none-
# Restore thumbnails.
rm --force --recursive ~/.cache/thumbnails/

# Reset restore-thumbnails on -none-
# Restore thumbnails.
echo 'App restore-thumbnails cannot be reset.'


# Setup private-home on *
# Private home.
chmod 750 ~

# Reset private-home on *
# Private home.
chmod 755 ~


# Setup sound-juicer on pc-van-emily
# Audio-cd ripper and player.
kz-desktop --addaft=org.gnome.SoundJuicer

# Reset sound-juicer on pc-van-emily
# Audio-cd ripper and player.
kz-desktop --delete=org.gnome.SoundJuicer


# Setup spotify on pc01 pc02 pc06 pc07
# Music and podcasts.
# Web app: https://open.spotify.com
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then kz-desktop --addaft=spotify; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then kz-desktop --addaft=kz-spotify; fi

# Reset spotify on pc01 pc02 pc06 pc07
# Music and podcasts.
# Web app: https://open.spotify.com
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then kz-desktop --delete=spotify; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then kz-desktop --delete=kz-spotify; fi


# Setup teamviewer on *
# Remote desktop.
# Web app: https://web.teamviewer.com
kz-desktop --addaft=com.teamviewer.TeamViewer

# Reset teamviewer on *
# Remote desktop.
# Web app: https://web.teamviewer.com
kz-desktop --delete=com.teamviewer.TeamViewer


# Setup terminal on pc01 pc06 pc07
# Terminal emulator.
kz-desktop --addbef=org.gnome.Terminal
# Turn on aliases.
sed --in-place 's/#alias/alias/g'                           ~/.bashrc
# Enable search forward in history (with Ctrl-S).
sed --in-place '/^stty -ixon/d'                             ~/.bashrc
echo 'stty -ixon # Enable fwd search history (i-search)' >> ~/.bashrc

# Reset terminal on pc01 pc06 pc07
# Terminal emulator.
kz-desktop --delete=org.gnome.Terminal
sed --in-place 's/alias/#alias/g' ~/.bashrc
sed --in-place '/^stty -ixon/d'   ~/.bashrc


# Setup thunderbird on pc01 pc02 pc06
# E-mail and news.
kz-desktop --delete=thunderbird
kz-desktop --delete=thunderbird_thunderbird

# Reset thunderbird on pc01 pc02 pc06
# E-mail and news.
kz-desktop --addbef=thunderbird
kz-desktop --addbef=thunderbird_thunderbird


# Setup virtualbox on pc-van-hugo
# Virtualization.
kz-desktop --addaft=virtualbox
kz-desktop --addaft=kz-vm-hugowin732

# Reset virtualbox on pc-van-hugo
# Virtualization.
kz-desktop --delete=virtualbox
kz-desktop --delete=kz-vm-hugowin732


# Setup vscode on pc01 pc06 pc07
# Editor.
# Web app: https://vscode.dev
kz-desktop --addbef=code
if [[ ${DISPLAY-} ]]; then xdg-mime default code.desktop application/json; fi
if [[ ${DISPLAY-} ]]; then xdg-mime default code.desktop application/x-desktop; fi
if [[ ${DISPLAY-} ]]; then xdg-mime default code.desktop application/x-shellscript; fi
if [[ ${DISPLAY-} ]]; then xdg-mime default code.desktop application/xml; fi
if [[ ${DISPLAY-} ]]; then xdg-mime default code.desktop text/html; fi
if [[ ${DISPLAY-} ]]; then xdg-mime default code.desktop text/markdown; fi
if [[ ${DISPLAY-} ]]; then xdg-mime default code.desktop text/plain; fi
if [[ ${DISPLAY-} ]]; then xdg-mime default code.desktop text/troff; fi
if [[ ${DISPLAY-} ]]; then xdg-mime default code.desktop text/x-python; fi

# Reset vscode on pc01 pc06 pc07
# Editor.
# Web app: https://vscode.dev
kz-desktop --delete=code


# Setup webmin on pc07
# Web console.
# Web app: https://localhost:10000
kz-desktop --addaft=kz-webmin

# Reset webmin on pc07
# Web console.
# Web app: https://localhost:10000
kz-desktop --delete=kz-webmin


# Setup whatsapp on pc-van-hugo maria-desktop
# Instant messaging (IM) and voice-over-IP (VoIP).
kz-desktop --addaft=kz-whatsapp

# Reset whatsapp on pc-van-hugo maria-desktop
# Instant messaging (IM) and voice-over-IP (VoIP).
kz-desktop --delete=kz-whatsapp


# Setup youtube-dl on pc-van-emily
# Download videos.
kz-desktop --addaft=youtubedl-gui

# Reset youtube-dl on pc-van-emily
# Download videos.
kz-desktop --delete=youtubedl-gui


# Setup zoom on pc01
# Videoconferencing.
kz-desktop --addaft=kz-zoom

# Reset zoom on pc01
# Videoconferencing.
kz-desktop --delete=kz-zoom
