# shellcheck shell=bash
###############################################################################
# SPDX-FileComment: Setup file for use with kz-setup script
#
# SPDX-FileCopyrightText: Karel Zimmer <info@karelzimmer.nl>
# SPDX-License-Identifier: CC0-1.0
###############################################################################
# Use "man kz setup.sh" to learn more about the format of this file.

# Setup app anydesk on host pc06 pc07
# Remote desktop.
# Web app: https://my.anydesk.com/v2
kz-desktop --addaft=anydesk

# Reset app anydesk on host pc06 pc07
# Remote desktop.
# Web app: https://my.anydesk.com/v2
kz-desktop --delete=anydesk

# Setup app calibre on host pc06
# E-book manager.
kz-desktop --addaft=calibre-gui

# Reset app calibre on host pc06
# E-book manager.
kz-desktop --delete=calibre-gui

# Setup app cockpit on host pc06
# Web console.
# Web app: https://localhost:9090
kz-desktop --addaft=kz-cockpit

# Reset app cockpit on host pc06
# Web console.
# Web app: https://localhost:9090
kz-desktop --delete=kz-cockpit

# Setup app dash-to-dock on host pc07
# Desktop dock.
if grep --quiet debian /etc/os-release && gnome-extensions info dash-to-dock@micxgx.gmail.com &> /dev/null; then gnome-extensions enable dash-to-dock@micxgx.gmail.com; fi
if grep --quiet debian /etc/os-release && gnome-extensions info dash-to-dock@micxgx.gmail.com &> /dev/null; then gsettings set org.gnome.shell.extensions.dash-to-dock disable-overview-on-startup true; fi
if grep --quiet rhel   /etc/os-release && gnome-extensions info dash-to-dock@gnome-shell-extensions.gcampax.github.com &> /dev/null; then gnome-extensions enable dash-to-dock@gnome-shell-extensions.gcampax.github.com; fi
if grep --quiet rhel   /etc/os-release && gnome-extensions info no-overview@fthx                                       &> /dev/null; then gnome-extensions enable no-overview@fthx; fi
if gsettings get org.gnome.shell disable-user-extensions                          &> /dev/null; then gsettings set org.gnome.shell disable-user-extensions false; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock apply-custom-theme       &> /dev/null; then gsettings set org.gnome.shell.extensions.dash-to-dock apply-custom-theme true; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock click-action             &> /dev/null; then gsettings set org.gnome.shell.extensions.dash-to-dock click-action minimize-or-previews; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock dash-max-icon-size       &> /dev/null; then gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 32; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock dock-fixed               &> /dev/null; then gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed true; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock dock-position            &> /dev/null; then gsettings set org.gnome.shell.extensions.dash-to-dock dock-position LEFT; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock extend-height            &> /dev/null; then gsettings set org.gnome.shell.extensions.dash-to-dock extend-height true; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock icon-size-fixed          &> /dev/null; then gsettings set org.gnome.shell.extensions.dash-to-dock icon-size-fixed true; fi

# Reset app dash-to-dock on host pc07
# Desktop dock.
if grep --quiet debian /etc/os-release && gnome-extensions info dash-to-dock@micxgx.gmail.com &> /dev/null; then gnome-extensions disable dash-to-dock@micxgx.gmail.com; fi
if grep --quiet debian /etc/os-release && gnome-extensions info dash-to-dock@micxgx.gmail.com &> /dev/null; then gsettings reset org.gnome.shell.extensions.dash-to-dock disable-overview-on-startup; fi
if grep --quiet rhel   /etc/os-release && gnome-extensions info dash-to-dock@gnome-shell-extensions.gcampax.github.com &> /dev/null; then gnome-extensions disable dash-to-dock@gnome-shell-extensions.gcampax.github.com; fi
if grep --quiet rhel   /etc/os-release && gnome-extensions info dash-to-dock@micxgx.gmail.com &> /dev/null; then gnome-extensions disable dash-to-dock@micxgx.gmail.com; fi
if gsettings get org.gnome.shell disable-user-extensions                          &> /dev/null; then gsettings reset org.gnome.shell disable-user-extensions; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock apply-custom-theme       &> /dev/null; then gsettings reset org.gnome.shell.extensions.dash-to-dock apply-custom-theme; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock click-action             &> /dev/null; then gsettings reset org.gnome.shell.extensions.dash-to-dock click-action; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock dash-max-icon-size       &> /dev/null; then gsettings reset org.gnome.shell.extensions.dash-to-dock dash-max-icon-size; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock dock-fixed               &> /dev/null; then gsettings reset org.gnome.shell.extensions.dash-to-dock dock-fixed; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock dock-position            &> /dev/null; then gsettings reset org.gnome.shell.extensions.dash-to-dock dock-position; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock extend-height            &> /dev/null; then gsettings reset org.gnome.shell.extensions.dash-to-dock extend-height; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock icon-size-fixed          &> /dev/null; then gsettings reset org.gnome.shell.extensions.dash-to-dock icon-size-fixed; fi

# Setup app evolution on host pc07
# E-mail and organizer.
kz-desktop --delete=org.gnome.Evolution

# Reset app evolution on host pc07
# E-mail and organizer.
kz-desktop --addbef=org.gnome.Evolution

# Setup app firefox on host pc01 pc02 pc06 pc07
# Web browser.
kz-desktop --delete=firefox
kz-desktop --delete=firefox-esr
kz-desktop --delete=firefox_firefox

# Reset app firefox on host pc01 pc02 pc06 pc07
# Web browser.
kz-desktop --addbef=firefox
kz-desktop --addbef=firefox-esr
kz-desktop --addbef=firefox_firefox

# Setup app gdebi on host *
# View and install deb files.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then xdg-mime default gdebi.desktop application/vnd.debian.binary-package; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then echo 'App gdebi is not available.'; fi

# Reset app gdebi on host *
# View and install deb files.
if [[ ${DISPLAY-} ]]; then echo 'App gdebi cannot be reset.'; fi

# Setup app git on host pc06 pc07
# Distributed revision control system.
# Web app: https://github.com
git config --global alias.logg 'log --decorate --graph --oneline --all'

# Reset app git on host pc06 pc07
# Distributed revision control system.
# Web app: https://github.com
git config --global --unset alias.logg

# Setup app gnome on host *
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
if gsettings get org.gnome.shell.extensions.dash-to-dock show-mounts                 &> /dev/null; then gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts true; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock show-mounts-network         &> /dev/null; then gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts-network false; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock show-mounts-only-mounted    &> /dev/null; then gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts-only-mounted true; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock show-trash                  &> /dev/null; then gsettings set org.gnome.shell.extensions.dash-to-dock show-trash false; fi
if gsettings get org.gnome.shell.extensions.ding show-home                           &> /dev/null; then gsettings set org.gnome.shell.extensions.ding show-home false; fi

# Reset app gnome on host *
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
if gsettings get org.gnome.shell.extensions.dash-to-dock show-mounts                 &> /dev/null; then gsettings reset org.gnome.shell.extensions.dash-to-dock show-mounts; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock show-mounts-network         &> /dev/null; then gsettings reset org.gnome.shell.extensions.dash-to-dock show-mounts-network; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock show-mounts-only-mounted    &> /dev/null; then gsettings reset org.gnome.shell.extensions.dash-to-dock show-mounts-only-mounted; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock show-trash                  &> /dev/null; then gsettings reset org.gnome.shell.extensions.dash-to-dock show-trash; fi
if gsettings get org.gnome.shell.extensions.ding show-home                           &> /dev/null; then gsettings reset org.gnome.shell.extensions.ding show-home; fi

# Setup app google-chrome on host *
# Web browser.
kz-desktop --addbef=google-chrome
if [[ ${DISPLAY-} ]]; then xdg-mime default google-chrome.desktop application/pdf; fi

# Reset app google-chrome on host *
# Web browser.
kz-desktop --delete=google-chrome

# Setup app handbrake on host #none
# Video-dvd ripper and transcoder.
kz-desktop --addaft=fr.handbrake.ghb

# Reset app handbrake on host #none
# Video-dvd ripper and transcoder.
kz-desktop --delete=fr.handbrake.ghb

# Setup app hide-files on host *
# Hide files.
if [[ ${DISPLAY-} ]]; then echo 'snap' > ~/.hidden; fi

# Reset app hide-files on host *
# Hide files.
if [[ ${DISPLAY-} ]]; then rm --force --verbose ~/.hidden; fi

# Setup app kvm on host pc06 pc07
# Kernel-based Virtual Machine.
kz-desktop --addaft=virt-manager

# Reset app kvm on host pc06 pc07
# Kernel-based Virtual Machine.
kz-desktop --delete=virt-manager

# Setup app lynis on host #none
# Security auditing.
if ! [[ -d ~/lynis ]]; then git clone https://github.com/CISOfy/lynis ~/lynis; fi
# Usage:
# $ cd ~/lynis
# $ [sudo] ./lynis audit system

# Reset app lynis on host #none
# Security auditing.
rm --force --recursive ~/lynis

# Setup app restore-thumbnails on host #none
# Restore thumbnails.
rm --force --recursive ~/.cache/thumbnails/

# Reset app restore-thumbnails on host #none
# Restore thumbnails.
echo 'App restore-thumbnails cannot be reset.'

# Setup app private-home on host *
# Private home.
chmod 750 ~

# Reset app private-home on host *
# Private home.
chmod 755 ~

# Setup app sound-juicer on host #none
# Audio-cd ripper and player.
kz-desktop --addaft=org.gnome.SoundJuicer

# Reset app sound-juicer on host #none
# Audio-cd ripper and player.
kz-desktop --delete=org.gnome.SoundJuicer

# Setup app spotify on host pc01 pc02 pc06 pc07
# Music and podcasts.
# Web app: https://open.spotify.com
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then kz-desktop --addaft=spotify; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then kz-desktop --addaft=kz-spotify; fi

# Reset app spotify on host pc01 pc02 pc06 pc07
# Music and podcasts.
# Web app: https://open.spotify.com
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then kz-desktop --delete=spotify; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then kz-desktop --delete=kz-spotify; fi

# Setup app teamviewer on host *
# Remote desktop.
# Web app: https://web.teamviewer.com
kz-desktop --addaft=com.teamviewer.TeamViewer

# Reset app teamviewer on host *
# Remote desktop.
# Web app: https://web.teamviewer.com
kz-desktop --delete=com.teamviewer.TeamViewer

# Setup app terminal on host pc01 pc06 pc07
# Terminal emulator.
kz-desktop --addbef=org.gnome.Terminal
# Enable aliases.
sed --in-place 's/#alias/alias/g'                           ~/.bashrc
# Enable search forward in history (with Ctrl-S).
sed --in-place '/^stty -ixon/d'                             ~/.bashrc
echo 'stty -ixon # Enable fwd search history (i-search)' >> ~/.bashrc

# Reset app terminal on host pc01 pc06 pc07
# Terminal emulator.
kz-desktop --delete=org.gnome.Terminal
sed --in-place 's/alias/#alias/g' ~/.bashrc
sed --in-place '/^stty -ixon/d'   ~/.bashrc

# Setup app thunderbird on host pc01 pc02 pc06
# E-mail and news.
kz-desktop --delete=thunderbird
kz-desktop --delete=thunderbird_thunderbird

# Reset app thunderbird on host pc01 pc02 pc06
# E-mail and news.
kz-desktop --addbef=thunderbird
kz-desktop --addbef=thunderbird_thunderbird

# Setup app virtualbox on host #none
# Virtualization.
kz-desktop --addaft=virtualbox
kz-desktop --addaft=kz-vm-hugowin732

# Reset app virtualbox on host #none
# Virtualization.
kz-desktop --delete=virtualbox
kz-desktop --delete=kz-vm-hugowin732

# Setup app vscode on host pc01 pc06 pc07
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

# Reset app vscode on host pc01 pc06 pc07
# Editor.
# Web app: https://vscode.dev
kz-desktop --delete=code

# Setup app webmin on host pc07
# Web console.
# Web app: https://localhost:10000
kz-desktop --addaft=kz-webmin

# Reset app webmin on host pc07
# Web console.
# Web app: https://localhost:10000
kz-desktop --delete=kz-webmin

# Setup app whatsapp on host #none
# Instant messaging (IM) and voice-over-IP (VoIP).
kz-desktop --addaft=kz-whatsapp

# Reset app whatsapp on host #none
# Instant messaging (IM) and voice-over-IP (VoIP).
kz-desktop --delete=kz-whatsapp

# Setup app youtube-dl on host #none
# Download videos.
kz-desktop --addaft=youtubedl-gui

# Reset app youtube-dl on host #none
# Download videos.
kz-desktop --delete=youtubedl-gui

# Setup app zoom on host pc01
# Videoconferencing.
kz-desktop --addaft=kz-zoom

# Reset app zoom on host pc01
# Videoconferencing.
kz-desktop --delete=kz-zoom
