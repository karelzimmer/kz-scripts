# shellcheck shell=bash
# #############################################################################
# SPDX-FileComment: Setup file for use with kz-setup script
#
# SPDX-FileCopyrightText: Karel Zimmer <info@karelzimmer.nl>
# SPDX-License-Identifier: CC0-1.0
# #############################################################################

# =============================================================================
# Use "man kz setup.sh" to learn more about the format of this file.
# =============================================================================

# setup calibre on pc06
# -----------------------------------------------------------------------------
# E-book manager.
# -----------------------------------------------------------------------------
kz-desktop --addaft=calibre-gui

# reset calibre on pc06
# -----------------------------------------------------------------------------
# E-book manager.
# -----------------------------------------------------------------------------
kz-desktop --delete=calibre-gui

# setup cockpit on pc06
# -----------------------------------------------------------------------------
# Web console.
# Web app: https://localhost:9090
# -----------------------------------------------------------------------------
kz-desktop --addaft=kz-cockpit

# reset cockpit on pc06
# -----------------------------------------------------------------------------
# Web console.
# Web app: https://localhost:9090
# -----------------------------------------------------------------------------
kz-desktop --delete=kz-cockpit

# setup dash-to-dock on *
# -----------------------------------------------------------------------------
# Desktop dock like Ubuntu's dash.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release && gnome-extensions info dash-to-dock@micxgx.gmail.com                         ; then gnome-extensions enable dash-to-dock@micxgx.gmail.com; fi
if grep --quiet rhel   /etc/os-release && gnome-extensions info dash-to-dock@gnome-shell-extensions.gcampax.github.com; then gnome-extensions enable dash-to-dock@gnome-shell-extensions.gcampax.github.com; fi
if grep --quiet rhel   /etc/os-release && gnome-extensions info dash-to-dock@micxgx.gmail.com                         ; then gnome-extensions enable dash-to-dock@micxgx.gmail.com; fi
if grep --quiet rhel   /etc/os-release && gnome-extensions info no-overview@fthx                                      ; then gnome-extensions enable no-overview@fthx; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock apply-custom-theme         ; then gsettings set org.gnome.shell.extensions.dash-to-dock apply-custom-theme true; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock click-action               ; then gsettings set org.gnome.shell.extensions.dash-to-dock click-action minimize-or-previews; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock dash-max-icon-size         ; then gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 32; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock disable-overview-on-startup; then gsettings set org.gnome.shell.extensions.dash-to-dock disable-overview-on-startup true; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock dock-fixed                 ; then gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed true; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock dock-position              ; then gsettings set org.gnome.shell.extensions.dash-to-dock dock-position LEFT; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock extend-height              ; then gsettings set org.gnome.shell.extensions.dash-to-dock extend-height true; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock icon-size-fixed            ; then gsettings set org.gnome.shell.extensions.dash-to-dock icon-size-fixed true; fi
if gsettings get org.gnome.shell disable-user-extensions                            ; then gsettings set org.gnome.shell disable-user-extensions false; fi

# reset dash-to-dock on *
# -----------------------------------------------------------------------------
# Desktop dock like Ubuntu's dash.
# -----------------------------------------------------------------------------
if gsettings get org.gnome.shell disable-user-extensions                            ; then gsettings reset org.gnome.shell disable-user-extensions; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock apply-custom-theme         ; then gsettings reset org.gnome.shell.extensions.dash-to-dock apply-custom-theme; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock click-action               ; then gsettings reset org.gnome.shell.extensions.dash-to-dock click-action; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock dash-max-icon-size         ; then gsettings reset org.gnome.shell.extensions.dash-to-dock dash-max-icon-size; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock disable-overview-on-startup; then gsettings reset org.gnome.shell.extensions.dash-to-dock disable-overview-on-startup; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock dock-fixed                 ; then gsettings reset org.gnome.shell.extensions.dash-to-dock dock-fixed; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock dock-position              ; then gsettings reset org.gnome.shell.extensions.dash-to-dock dock-position; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock extend-height              ; then gsettings reset org.gnome.shell.extensions.dash-to-dock extend-height; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock icon-size-fixed            ; then gsettings reset org.gnome.shell.extensions.dash-to-dock icon-size-fixed; fi
if grep --quiet debian /etc/os-release && gnome-extensions info dash-to-dock@micxgx.gmail.com                         ; then gnome-extensions disable dash-to-dock@micxgx.gmail.com; fi
if grep --quiet rhel   /etc/os-release && gnome-extensions info no-overview@fthx                                      ; then gnome-extensions disable no-overview@fthx; fi
if grep --quiet rhel   /etc/os-release && gnome-extensions info dash-to-dock@gnome-shell-extensions.gcampax.github.com; then gnome-extensions disable dash-to-dock@gnome-shell-extensions.gcampax.github.com; fi
if grep --quiet rhel   /etc/os-release && gnome-extensions info dash-to-dock@micxgx.gmail.com                         ; then gnome-extensions disable dash-to-dock@micxgx.gmail.com; fi

# setup evolution on pc01 pc06 pc07
# -----------------------------------------------------------------------------
# E-mail and organizer.
# -----------------------------------------------------------------------------
kz-desktop --delete=org.gnome.Evolution

# reset evolution on pc01 pc06 pc07
# -----------------------------------------------------------------------------
# E-mail and organizer.
# -----------------------------------------------------------------------------
kz-desktop --addbef=org.gnome.Evolution

# setup firefox on pc01 pc02 pc06 pc07
# -----------------------------------------------------------------------------
# Web browser.
# -----------------------------------------------------------------------------
kz-desktop --delete=firefox
kz-desktop --delete=firefox-esr
kz-desktop --delete=firefox_firefox

# reset firefox on pc01 pc02 pc06 pc07
# -----------------------------------------------------------------------------
# Web browser.
# -----------------------------------------------------------------------------
kz-desktop --addbef=firefox
kz-desktop --addbef=firefox-esr
kz-desktop --addbef=firefox_firefox

# setup gdebi on *
# -----------------------------------------------------------------------------
# View and install deb files.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then xdg-mime default gdebi.desktop application/vnd.debian.binary-package; fi
if grep --quiet rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then echo 'App gdebi is not available.'; fi

# reset gdebi on *
# -----------------------------------------------------------------------------
# View and install deb files.
# -----------------------------------------------------------------------------
if [[ -n ${DISPLAY-} ]]; then echo 'App gdebi cannot be reset.'; fi

# setup git on pc06 pc07
# -----------------------------------------------------------------------------
# Distributed revision control system.
# Web app: https://github.com
# -----------------------------------------------------------------------------
git config --global alias.logg 'log --decorate --graph --oneline --all'

# reset git on pc06 pc07
# -----------------------------------------------------------------------------
# Distributed revision control system.
# Web app: https://github.com
# -----------------------------------------------------------------------------
git config --global --unset alias.logg

# setup gnome on *
# -----------------------------------------------------------------------------
# Desktop environment.
# -----------------------------------------------------------------------------
if gsettings get org.gnome.desktop.calendar show-weekdate                           ; then gsettings set org.gnome.desktop.calendar show-weekdate true; fi
if gsettings get org.gnome.desktop.interface clock-show-date                        ; then gsettings set org.gnome.desktop.interface clock-show-date true; fi
if gsettings get org.gnome.desktop.interface clock-show-weekday                     ; then gsettings set org.gnome.desktop.interface clock-show-weekday true; fi
if gsettings get org.gnome.desktop.interface show-battery-percentage                ; then gsettings set org.gnome.desktop.interface show-battery-percentage true; fi
if gsettings get org.gnome.desktop.peripherals.touchpad tap-to-click                ; then gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true; fi
if gsettings get org.gnome.desktop.screensaver lock-enabled                         ; then gsettings set org.gnome.desktop.screensaver lock-enabled false; fi
if gsettings get org.gnome.desktop.session idle-delay                               ; then gsettings set org.gnome.desktop.session idle-delay 900; fi
if gsettings get org.gnome.desktop.sound allow-volume-above-100-percent             ; then gsettings set org.gnome.desktop.sound allow-volume-above-100-percent true; fi
if gsettings get org.gnome.desktop.wm.preferences button-layout                     ; then gsettings set org.gnome.desktop.wm.preferences button-layout :minimize,maximize,close; fi
if gsettings get org.gnome.mutter center-new-windows                                ; then gsettings set org.gnome.mutter center-new-windows true; fi
if gsettings get org.gnome.nautilus.icon-view default-zoom-level                    ; then gsettings set org.gnome.nautilus.icon-view default-zoom-level large; fi
if gsettings get org.gnome.nautilus.preferences click-policy                        ; then gsettings set org.gnome.nautilus.preferences click-policy single; fi
if gsettings get org.gnome.nautilus.preferences open-folder-on-dnd-hover            ; then gsettings set org.gnome.nautilus.preferences open-folder-on-dnd-hover true; fi
if gsettings get org.gnome.nautilus.preferences show-create-link                    ; then gsettings set org.gnome.nautilus.preferences show-create-link true; fi
if gsettings get org.gnome.nautilus.preferences show-image-thumbnails               ; then gsettings set org.gnome.nautilus.preferences show-image-thumbnails always; fi
if gsettings get org.gnome.settings-daemon.plugins.power power-button-action        ; then gsettings set org.gnome.settings-daemon.plugins.power power-button-action interactive; fi
if gsettings get org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type     ; then gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type nothing; fi
if gsettings get org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type; then gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type nothing; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock show-mounts                ; then gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts true; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock show-mounts-network        ; then gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts-network false; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock show-mounts-only-mounted   ; then gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts-only-mounted true; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock show-trash                 ; then gsettings set org.gnome.shell.extensions.dash-to-dock show-trash false; fi
if gsettings get org.gnome.shell.extensions.ding show-home                          ; then gsettings set org.gnome.shell.extensions.ding show-home false; fi

# reset gnome on *
# -----------------------------------------------------------------------------
# Desktop environment.
# -----------------------------------------------------------------------------
if gsettings get org.gnome.desktop.calendar show-weekdate                           ; then gsettings reset org.gnome.desktop.calendar show-weekdate; fi
if gsettings get org.gnome.desktop.interface clock-show-date                        ; then gsettings reset org.gnome.desktop.interface clock-show-date; fi
if gsettings get org.gnome.desktop.interface clock-show-weekday                     ; then gsettings reset org.gnome.desktop.interface clock-show-weekday; fi
if gsettings get org.gnome.desktop.interface show-battery-percentage                ; then gsettings reset org.gnome.desktop.interface show-battery-percentage; fi
if gsettings get org.gnome.desktop.peripherals.touchpad tap-to-click                ; then gsettings reset org.gnome.desktop.peripherals.touchpad tap-to-click; fi
if gsettings get org.gnome.desktop.screensaver lock-enabled                         ; then gsettings reset org.gnome.desktop.screensaver lock-enabled; fi
if gsettings get org.gnome.desktop.session idle-delay                               ; then gsettings reset org.gnome.desktop.session idle-delay; fi
if gsettings get org.gnome.desktop.sound allow-volume-above-100-percent             ; then gsettings reset org.gnome.desktop.sound allow-volume-above-100-percent; fi
if gsettings get org.gnome.desktop.wm.preferences button-layout                     ; then gsettings reset org.gnome.desktop.wm.preferences button-layout; fi
if gsettings get org.gnome.mutter center-new-windows                                ; then gsettings reset org.gnome.mutter center-new-windows; fi
if gsettings get org.gnome.nautilus.icon-view default-zoom-level                    ; then gsettings reset org.gnome.nautilus.icon-view default-zoom-level; fi
if gsettings get org.gnome.nautilus.preferences click-policy                        ; then gsettings reset org.gnome.nautilus.preferences click-policy; fi
if gsettings get org.gnome.nautilus.preferences open-folder-on-dnd-hover            ; then gsettings reset org.gnome.nautilus.preferences open-folder-on-dnd-hover; fi
if gsettings get org.gnome.nautilus.preferences show-create-link                    ; then gsettings reset org.gnome.nautilus.preferences show-create-link; fi
if gsettings get org.gnome.nautilus.preferences show-image-thumbnails               ; then gsettings reset org.gnome.nautilus.preferences show-image-thumbnails; fi
if gsettings get org.gnome.settings-daemon.plugins.power power-button-action        ; then gsettings reset org.gnome.settings-daemon.plugins.power power-button-action; fi
if gsettings get org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type     ; then gsettings reset org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type; fi
if gsettings get org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type; then gsettings reset org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock show-mounts                ; then gsettings reset org.gnome.shell.extensions.dash-to-dock show-mounts; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock show-mounts-network        ; then gsettings reset org.gnome.shell.extensions.dash-to-dock show-mounts-network; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock show-mounts-only-mounted   ; then gsettings reset org.gnome.shell.extensions.dash-to-dock show-mounts-only-mounted; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock show-trash                 ; then gsettings reset org.gnome.shell.extensions.dash-to-dock show-trash; fi
if gsettings get org.gnome.shell.extensions.ding show-home                          ; then gsettings reset org.gnome.shell.extensions.ding show-home; fi

# setup google-chrome on *
# -----------------------------------------------------------------------------
# Web browser.
# -----------------------------------------------------------------------------
kz-desktop --addbef=google-chrome
if [[ -n ${DISPLAY-} ]]; then xdg-mime default google-chrome.desktop application/pdf; fi

# reset google-chrome on *
# -----------------------------------------------------------------------------
# Web browser.
# -----------------------------------------------------------------------------
kz-desktop --delete=google-chrome

# setup handbrake on #none
# -----------------------------------------------------------------------------
# Video-dvd ripper and transcoder.
# -----------------------------------------------------------------------------
kz-desktop --addaft=fr.handbrake.ghb

# reset handbrake on #none
# -----------------------------------------------------------------------------
# Video-dvd ripper and transcoder.
# -----------------------------------------------------------------------------
kz-desktop --delete=fr.handbrake.ghb

# setup kvm on pc06 pc07
# -----------------------------------------------------------------------------
# Kernel-based Virtual Machine.
# -----------------------------------------------------------------------------
kz-desktop --addaft=virt-manager

# reset kvm on pc06 pc07
# -----------------------------------------------------------------------------
# Kernel-based Virtual Machine.
# -----------------------------------------------------------------------------
kz-desktop --delete=virt-manager

# setup libreoffice on *
# -----------------------------------------------------------------------------
# Office suite.
# -----------------------------------------------------------------------------
kz-desktop --addaft=libreoffice-writer

# reset libreoffice on *
# -----------------------------------------------------------------------------
# Office suite.
# -----------------------------------------------------------------------------
kz-desktop --delete=libreoffice-writer

# setup lynis on #none
# -----------------------------------------------------------------------------
# Security auditing.
# -----------------------------------------------------------------------------
if ! [[ -d ~/lynis ]]; then git clone https://github.com/CISOfy/lynis ~/lynis; fi
# -----------------------------------------------------------------------------
# Usage:
# $ cd ~/lynis
# $ [sudo] ./lynis audit system
# -----------------------------------------------------------------------------

# reset lynis on #none
# -----------------------------------------------------------------------------
# Security auditing.
# -----------------------------------------------------------------------------
rm --force --recursive ~/lynis

# setup restore-thumbnails on #none
# -----------------------------------------------------------------------------
# Restore thumbnails.
# -----------------------------------------------------------------------------
rm --force --recursive ~/.cache/thumbnails/

# reset restore-thumbnails on #none
# -----------------------------------------------------------------------------
# Restore thumbnails.
# -----------------------------------------------------------------------------
echo 'App restore-thumbnails cannot be reset.'

# setup private-home on *
# -----------------------------------------------------------------------------
# Private home.
# -----------------------------------------------------------------------------
chmod 750 ~

# reset private-home on *
# -----------------------------------------------------------------------------
# Private home.
# -----------------------------------------------------------------------------
chmod 755 ~

# setup sound-juicer on #none
# -----------------------------------------------------------------------------
# Audio-cd ripper and player.
# -----------------------------------------------------------------------------
kz-desktop --addaft=org.gnome.SoundJuicer

# reset sound-juicer on #none
# -----------------------------------------------------------------------------
# Audio-cd ripper and player.
# -----------------------------------------------------------------------------
kz-desktop --delete=org.gnome.SoundJuicer

# setup spotify on pc01 pc02 pc06 pc07
# -----------------------------------------------------------------------------
# Music and podcasts.
# Web app: https://open.spotify.com
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then kz-desktop --addaft=spotify; fi
if grep --quiet rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then kz-desktop --addaft=kz-spotify; fi

# reset spotify on pc01 pc02 pc06 pc07
# -----------------------------------------------------------------------------
# Music and podcasts.
# Web app: https://open.spotify.com
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then kz-desktop --delete=spotify; fi
if grep --quiet rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then kz-desktop --delete=kz-spotify; fi

# setup teamviewer on pc06 pc07
# -----------------------------------------------------------------------------
# Remote desktop.
# Web app: https://web.teamviewer.com
# -----------------------------------------------------------------------------
kz-desktop --addaft=com.teamviewer.TeamViewer

# reset teamviewer on pc06 pc07
# -----------------------------------------------------------------------------
# Remote desktop.
# Web app: https://web.teamviewer.com
# -----------------------------------------------------------------------------
kz-desktop --delete=com.teamviewer.TeamViewer

# setup terminal on *
# -----------------------------------------------------------------------------
# Terminal emulator.
# -----------------------------------------------------------------------------
# Enable aliases.
# -----------------------------------------------------------------------------
sed --in-place 's/#alias/alias/g'    ~/.bashrc
sed --in-place 's/# alias/alias/g'   ~/.bashrc # For example, Debian user root.
sed --in-place 's/# export/export/g' ~/.bashrc # For example, Debian user root.
sed --in-place 's/# eval/eval/g'     ~/.bashrc # For example, Debian user root.
# -----------------------------------------------------------------------------
# Enable search forward in history (with Ctrl-S).
# -----------------------------------------------------------------------------
sed --in-place '/^stty -ixon/d'      ~/.bashrc
echo 'stty -ixon # Enable fwd search history (i-search)' >> ~/.bashrc

# reset terminal on *
# -----------------------------------------------------------------------------
# Terminal emulator.
# -----------------------------------------------------------------------------
sed --in-place 's/alias/#alias/g'   ~/.bashrc
sed --in-place 's/export/#export/g' ~/.bashrc # For example, Debian user root.
sed --in-place 's/eval/#eval/g'     ~/.bashrc # For example, Debian user root.
sed --in-place '/^stty -ixon/d'     ~/.bashrc

# setup terminal on pc06 pc07
# -----------------------------------------------------------------------------
# Terminal emulator.
# -----------------------------------------------------------------------------
kz-desktop --addbef=org.gnome.Terminal

# reset terminal on pc06 pc07
# -----------------------------------------------------------------------------
# Terminal emulator.
# -----------------------------------------------------------------------------
kz-desktop --delete=org.gnome.Terminal

# setup thunderbird on pc01 pc02 pc06
# -----------------------------------------------------------------------------
# E-mail and news.
# -----------------------------------------------------------------------------
kz-desktop --delete=thunderbird
kz-desktop --delete=thunderbird_thunderbird

# reset thunderbird on pc01 pc02 pc06
# -----------------------------------------------------------------------------
# E-mail and news.
# -----------------------------------------------------------------------------
kz-desktop --addbef=thunderbird
kz-desktop --addbef=thunderbird_thunderbird

# setup virtualbox on #none
# -----------------------------------------------------------------------------
# Virtualization.
# -----------------------------------------------------------------------------
kz-desktop --addaft=virtualbox
kz-desktop --addaft=kz-vm-hugowin732

# reset virtualbox on #none
# -----------------------------------------------------------------------------
# Virtualization.
# -----------------------------------------------------------------------------
kz-desktop --delete=virtualbox
kz-desktop --delete=kz-vm-hugowin732

# setup vscode on pc06 pc07
# -----------------------------------------------------------------------------
# Editor.
# Web app: https://vscode.dev
# -----------------------------------------------------------------------------
kz-desktop --addbef=code
if [[ -n ${DISPLAY-} ]]; then xdg-mime default code.desktop application/json; fi
if [[ -n ${DISPLAY-} ]]; then xdg-mime default code.desktop application/x-desktop; fi
if [[ -n ${DISPLAY-} ]]; then xdg-mime default code.desktop application/x-shellscript; fi
if [[ -n ${DISPLAY-} ]]; then xdg-mime default code.desktop application/xml; fi
if [[ -n ${DISPLAY-} ]]; then xdg-mime default code.desktop text/html; fi
if [[ -n ${DISPLAY-} ]]; then xdg-mime default code.desktop text/markdown; fi
if [[ -n ${DISPLAY-} ]]; then xdg-mime default code.desktop text/plain; fi
if [[ -n ${DISPLAY-} ]]; then xdg-mime default code.desktop text/troff; fi
if [[ -n ${DISPLAY-} ]]; then xdg-mime default code.desktop text/x-python; fi

# reset vscode on pc06 pc07
# -----------------------------------------------------------------------------
# Editor.
# Web app: https://vscode.dev
# -----------------------------------------------------------------------------
kz-desktop --delete=code

# setup webmin on pc07
# -----------------------------------------------------------------------------
# Web console.
# Web app: https://localhost:10000
# -----------------------------------------------------------------------------
kz-desktop --addaft=kz-webmin

# reset webmin on pc07
# -----------------------------------------------------------------------------
# Web console.
# Web app: https://localhost:10000
# -----------------------------------------------------------------------------
kz-desktop --delete=kz-webmin

# setup whatsapp on #none
# -----------------------------------------------------------------------------
# Instant messaging (IM) and voice-over-IP (VoIP).
# -----------------------------------------------------------------------------
kz-desktop --addaft=kz-whatsapp

# reset whatsapp on #none
# -----------------------------------------------------------------------------
# Instant messaging (IM) and voice-over-IP (VoIP).
# -----------------------------------------------------------------------------
kz-desktop --delete=kz-whatsapp

# setup youtube-dl on #none
# -----------------------------------------------------------------------------
# Download videos.
# -----------------------------------------------------------------------------
kz-desktop --addaft=youtubedl-gui

# reset youtube-dl on #none
# -----------------------------------------------------------------------------
# Download videos.
# -----------------------------------------------------------------------------
kz-desktop --delete=youtubedl-gui

# setup zoom on pc01
# -----------------------------------------------------------------------------
# Videoconferencing.
# -----------------------------------------------------------------------------
kz-desktop --addaft=kz-zoom

# reset zoom on pc01
# -----------------------------------------------------------------------------
# Videoconferencing.
# -----------------------------------------------------------------------------
kz-desktop --delete=kz-zoom
