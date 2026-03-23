# shellcheck shell=bash disable=SC2034
# #############################################################################
# SPDX-FileComment: Settings file for use with kz setup
#
# SPDX-FileCopyrightText: Karel Zimmer <info@karelzimmer.nl>
# SPDX-License-Identifier: CC0-1.0
# #############################################################################

# =============================================================================
# Use "man kz setup.sh" and "man kz setup.sh.gpg" to learn more about the
# format of this file.
# =============================================================================

# SETUP bitwarden *
# -----------------------------------------------------------------------------
# Password manager.
# -----------------------------------------------------------------------------
kz-desktop --addaft=com.bitwarden.desktop

# RESET bitwarden *
# -----------------------------------------------------------------------------
# Password manager.
# -----------------------------------------------------------------------------
kz-desktop --delete=com.bitwarden.desktop

# SETUP cinnamon-settings *
# -----------------------------------------------------------------------------
# Desktop environment.
# -----------------------------------------------------------------------------
if gsettings get org.nemo.preferences click-policy; then gsettings set org.nemo.preferences click-policy 'single'; fi

# RESET cinnamon-settings *
# -----------------------------------------------------------------------------
# Desktop environment.
# -----------------------------------------------------------------------------
if gsettings get org.nemo.preferences click-policy; then gsettings reset org.nemo.preferences click-policy; fi

# SETUP cockpit pc06
# -----------------------------------------------------------------------------
# Web console.
# -----------------------------------------------------------------------------
# Web app: https://localhost:9090
# -----------------------------------------------------------------------------
kz-desktop --addaft=kz-cockpit

# RESET cockpit pc06
# -----------------------------------------------------------------------------
# Web console.
# -----------------------------------------------------------------------------
# Web app: https://localhost:9090
# -----------------------------------------------------------------------------
kz-desktop --delete=kz-cockpit

# SETUP dash-to-dock *
# -----------------------------------------------------------------------------
# Move the dash out of the overview transforming it in a dock.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release && gnome-extensions info dash-to-dock@micxgx.gmail.com ; then gnome-extensions enable dash-to-dock@micxgx.gmail.com; fi
#
if grep --quiet rhel /etc/os-release && gnome-extensions info dash-to-dock@gnome-shell-extensions.gcampax.github.com; then gnome-extensions enable dash-to-dock@gnome-shell-extensions.gcampax.github.com; fi
if grep --quiet rhel /etc/os-release && gnome-extensions info dash-to-dock@micxgx.gmail.com ; then gnome-extensions enable dash-to-dock@micxgx.gmail.com; fi
if grep --quiet rhel /etc/os-release && gnome-extensions info no-overview@fthx ; then gnome-extensions enable no-overview@fthx; fi
#
if gsettings get org.gnome.shell.extensions.dash-to-dock apply-custom-theme ; then gsettings set org.gnome.shell.extensions.dash-to-dock apply-custom-theme true; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock click-action ; then gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize-or-previews'; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock custom-theme-shrink ; then gsettings set org.gnome.shell.extensions.dash-to-dock custom-theme-shrink true; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock dash-max-icon-size ; then gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 32; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock disable-overview-on-startup ; then gsettings set org.gnome.shell.extensions.dash-to-dock disable-overview-on-startup true; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock dock-fixed ; then gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed true; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock dock-position ; then gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM'; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock extend-height ; then gsettings set org.gnome.shell.extensions.dash-to-dock extend-height true; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock icon-size-fixed ; then gsettings set org.gnome.shell.extensions.dash-to-dock icon-size-fixed true; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock show-mounts ; then gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts true; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock show-mounts-network ; then gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts-network false; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock show-mounts-only-mounted ; then gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts-only-mounted true; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock show-trash ; then gsettings set org.gnome.shell.extensions.dash-to-dock show-trash false; fi
if gsettings get org.gnome.shell disable-user-extensions ; then gsettings set org.gnome.shell disable-user-extensions false; fi
#
LOGOUT=true

# RESET dash-to-dock *
# -----------------------------------------------------------------------------
# Move the dash out of the overview transforming it in a dock.
# -----------------------------------------------------------------------------
if gsettings get org.gnome.shell.extensions.dash-to-dock apply-custom-theme ; then gsettings reset org.gnome.shell.extensions.dash-to-dock apply-custom-theme; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock click-action ; then gsettings reset org.gnome.shell.extensions.dash-to-dock click-action; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock custom-theme-shrink ; then gsettings reset org.gnome.shell.extensions.dash-to-dock custom-theme-shrink; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock dash-max-icon-size ; then gsettings reset org.gnome.shell.extensions.dash-to-dock dash-max-icon-size; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock disable-overview-on-startup ; then gsettings reset org.gnome.shell.extensions.dash-to-dock disable-overview-on-startup; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock dock-fixed ; then gsettings reset org.gnome.shell.extensions.dash-to-dock dock-fixed; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock dock-position ; then gsettings reset org.gnome.shell.extensions.dash-to-dock dock-position; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock extend-height ; then gsettings reset org.gnome.shell.extensions.dash-to-dock extend-height; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock icon-size-fixed ; then gsettings reset org.gnome.shell.extensions.dash-to-dock icon-size-fixed; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock show-mounts ; then gsettings reset org.gnome.shell.extensions.dash-to-dock show-mounts; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock show-mounts-network ; then gsettings reset org.gnome.shell.extensions.dash-to-dock show-mounts-network; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock show-mounts-only-mounted ; then gsettings reset org.gnome.shell.extensions.dash-to-dock show-mounts-only-mounted; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock show-trash ; then gsettings reset org.gnome.shell.extensions.dash-to-dock show-trash; fi
#
if grep --quiet debian /etc/os-release && gnome-extensions info dash-to-dock@micxgx.gmail.com ; then gnome-extensions disable dash-to-dock@micxgx.gmail.com; fi
#
if grep --quiet rhel /etc/os-release && gnome-extensions info no-overview@fthx ; then gnome-extensions disable no-overview@fthx; fi
if grep --quiet rhel /etc/os-release && gnome-extensions info dash-to-dock@gnome-shell-extensions.gcampax.github.com; then gnome-extensions disable dash-to-dock@gnome-shell-extensions.gcampax.github.com; fi
if grep --quiet rhel /etc/os-release && gnome-extensions info dash-to-dock@micxgx.gmail.com ; then gnome-extensions disable dash-to-dock@micxgx.gmail.com; fi
#
LOGOUT=true

# SETUP evolution *
# -----------------------------------------------------------------------------
# E-mail, calendar, contacts, and task management.
# -----------------------------------------------------------------------------
kz-desktop --delete=org.gnome.Evolution

# RESET evolution *
# -----------------------------------------------------------------------------
# E-mail, calendar, contacts, and task management.
# -----------------------------------------------------------------------------
kz-desktop --addbef=org.gnome.Evolution

# SETUP evolution pc06 pc07
# -----------------------------------------------------------------------------
# E-mail, calendar, contacts, and task management.
# -----------------------------------------------------------------------------
kz-desktop --addaft=org.gnome.Evolution

# RESET evolution pc06 pc07
# -----------------------------------------------------------------------------
# E-mail, calendar, contacts, and task management.
# -----------------------------------------------------------------------------
kz-desktop --delete=org.gnome.Evolution

# SETUP git pc06 pc07
# -----------------------------------------------------------------------------
# Distributed revision control system.
# -----------------------------------------------------------------------------
# Web app: https://github.com
# -----------------------------------------------------------------------------
git config --global alias.logg 'log --decorate --graph --oneline --all'

# RESET git pc06 pc07
# -----------------------------------------------------------------------------
# Distributed revision control system.
# -----------------------------------------------------------------------------
# Web app: https://github.com
# -----------------------------------------------------------------------------
git config --global --unset alias.logg

# SETUP gnome-settings *
# -----------------------------------------------------------------------------
# Desktop environment.
# -----------------------------------------------------------------------------
if gsettings get org.gnome.desktop.calendar show-weekdate ; then gsettings set org.gnome.desktop.calendar show-weekdate true; fi
if gsettings get org.gnome.desktop.input-sources sources ; then gsettings set org.gnome.desktop.input-sources sources "$(gsettings get org.gnome.desktop.input-sources sources | sed "s/, ('ibus', 'mozc-jp')//")"; fi
if gsettings get org.gnome.desktop.input-sources sources ; then gsettings set org.gnome.desktop.input-sources sources "$(gsettings get org.gnome.desktop.input-sources sources | sed "s/('ibus', 'mozc-jp'), //")"; fi
if gsettings get org.gnome.desktop.interface clock-show-date ; then gsettings set org.gnome.desktop.interface clock-show-date true; fi
if gsettings get org.gnome.desktop.interface clock-show-weekday ; then gsettings set org.gnome.desktop.interface clock-show-weekday true; fi
if gsettings get org.gnome.desktop.interface font-antialiasing ; then gsettings set org.gnome.desktop.interface font-antialiasing 'rgba'; fi
if gsettings get org.gnome.desktop.interface show-battery-percentage ; then gsettings set org.gnome.desktop.interface show-battery-percentage true; fi
if gsettings get org.gnome.desktop.peripherals.touchpad tap-to-click ; then gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true; fi
if gsettings get org.gnome.desktop.screensaver lock-enabled ; then gsettings set org.gnome.desktop.screensaver lock-enabled false; fi
if gsettings get org.gnome.desktop.session idle-delay ; then gsettings set org.gnome.desktop.session idle-delay 900; fi
if gsettings get org.gnome.desktop.sound allow-volume-above-100-percent ; then gsettings set org.gnome.desktop.sound allow-volume-above-100-percent true; fi
if gsettings get org.gnome.desktop.wm.preferences button-layout ; then gsettings set org.gnome.desktop.wm.preferences button-layout ':minimize,maximize,close'; fi
if gsettings get org.gnome.mutter center-new-windows ; then gsettings set org.gnome.mutter center-new-windows true; fi
if gsettings get org.gnome.nautilus.icon-view default-zoom-level ; then gsettings set org.gnome.nautilus.icon-view default-zoom-level large; fi
if gsettings get org.gnome.nautilus.list-view use-tree-view ; then gsettings set org.gnome.nautilus.list-view use-tree-view true; fi
if gsettings get org.gnome.nautilus.preferences click-policy ; then gsettings set org.gnome.nautilus.preferences click-policy 'single'; fi
if gsettings get org.gnome.nautilus.preferences open-folder-on-dnd-hover ; then gsettings set org.gnome.nautilus.preferences open-folder-on-dnd-hover true; fi
if gsettings get org.gnome.nautilus.preferences show-create-link ; then gsettings set org.gnome.nautilus.preferences show-create-link true; fi
if gsettings get org.gnome.nautilus.preferences show-image-thumbnails ; then gsettings set org.gnome.nautilus.preferences show-image-thumbnails 'always'; fi
if gsettings get org.gnome.settings-daemon.plugins.power power-button-action ; then gsettings set org.gnome.settings-daemon.plugins.power power-button-action interactive; fi
if gsettings get org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type ; then gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type nothing; fi
if gsettings get org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type; then gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type nothing; fi
if gsettings get org.gnome.shell.extensions.ding show-home ; then gsettings set org.gnome.shell.extensions.ding show-home false; fi
if gsettings get org.gtk.gtk4.Settings.FileChooser sort-directories-first ; then gsettings set org.gtk.gtk4.Settings.FileChooser sort-directories-first true; fi
#
LOGOUT=true

# RESET gnome-settings *
# -----------------------------------------------------------------------------
# Desktop environment.
# -----------------------------------------------------------------------------
if gsettings get org.gnome.desktop.calendar show-weekdate ; then gsettings reset org.gnome.desktop.calendar show-weekdate; fi
if gsettings get org.gnome.desktop.interface clock-show-date ; then gsettings reset org.gnome.desktop.interface clock-show-date; fi
if gsettings get org.gnome.desktop.interface clock-show-weekday ; then gsettings reset org.gnome.desktop.interface clock-show-weekday; fi
if gsettings get org.gnome.desktop.interface font-antialiasing ; then gsettings reset org.gnome.desktop.interface font-antialiasing; fi
if gsettings get org.gnome.desktop.interface show-battery-percentage ; then gsettings reset org.gnome.desktop.interface show-battery-percentage; fi
if gsettings get org.gnome.desktop.peripherals.touchpad tap-to-click ; then gsettings reset org.gnome.desktop.peripherals.touchpad tap-to-click; fi
if gsettings get org.gnome.desktop.screensaver lock-enabled ; then gsettings reset org.gnome.desktop.screensaver lock-enabled; fi
if gsettings get org.gnome.desktop.session idle-delay ; then gsettings reset org.gnome.desktop.session idle-delay; fi
if gsettings get org.gnome.desktop.sound allow-volume-above-100-percent ; then gsettings reset org.gnome.desktop.sound allow-volume-above-100-percent; fi
if gsettings get org.gnome.desktop.wm.preferences button-layout ; then gsettings reset org.gnome.desktop.wm.preferences button-layout; fi
if gsettings get org.gnome.mutter center-new-windows ; then gsettings reset org.gnome.mutter center-new-windows; fi
if gsettings get org.gnome.nautilus.icon-view default-zoom-level ; then gsettings reset org.gnome.nautilus.icon-view default-zoom-level; fi
if gsettings get org.gnome.nautilus.list-view use-tree-view ; then gsettings reset org.gnome.nautilus.list-view use-tree-view; fi
if gsettings get org.gnome.nautilus.preferences click-policy ; then gsettings reset org.gnome.nautilus.preferences click-policy; fi
if gsettings get org.gnome.nautilus.preferences open-folder-on-dnd-hover ; then gsettings reset org.gnome.nautilus.preferences open-folder-on-dnd-hover; fi
if gsettings get org.gnome.nautilus.preferences show-create-link ; then gsettings reset org.gnome.nautilus.preferences show-create-link; fi
if gsettings get org.gnome.nautilus.preferences show-image-thumbnails ; then gsettings reset org.gnome.nautilus.preferences show-image-thumbnails; fi
if gsettings get org.gnome.settings-daemon.plugins.power power-button-action ; then gsettings reset org.gnome.settings-daemon.plugins.power power-button-action; fi
if gsettings get org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type ; then gsettings reset org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type; fi
if gsettings get org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type; then gsettings reset org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type; fi
if gsettings get org.gnome.shell.extensions.ding show-home ; then gsettings reset org.gnome.shell.extensions.ding show-home; fi
if gsettings get org.gtk.gtk4.Settings.FileChooser sort-directories-first ; then gsettings reset org.gtk.gtk4.Settings.FileChooser sort-directories-first; fi
if gsettings get org.gnome.desktop.input-sources sources ; then gsettings reset org.gnome.desktop.input-sources sources; fi
#
LOGOUT=true

# SETUP google-chrome pc01 pc06 pc07
# -----------------------------------------------------------------------------
# Web browser.
# -----------------------------------------------------------------------------
kz-desktop --addbef=google-chrome

# RESET google-chrome pc01 pc06 pc07
# -----------------------------------------------------------------------------
# Web browser.
# -----------------------------------------------------------------------------
kz-desktop --delete=google-chrome

# SETUP kvm pc06 pc07
# -----------------------------------------------------------------------------
# Kernel-based Virtual Machine.
# -----------------------------------------------------------------------------
kz-desktop --addaft=virt-manager

# RESET kvm pc06 pc07
# -----------------------------------------------------------------------------
# Kernel-based Virtual Machine.
# -----------------------------------------------------------------------------
kz-desktop --delete=virt-manager

# SETUP libreoffice *
# -----------------------------------------------------------------------------
# Office suite.
# -----------------------------------------------------------------------------
kz-desktop --addaft=libreoffice-writer
kz-desktop --addaft=org.libreoffice.LibreOffice.writer

# RESET libreoffice *
# -----------------------------------------------------------------------------
# Office suite.
# -----------------------------------------------------------------------------
kz-desktop --delete=libreoffice-writer
kz-desktop --delete=org.libreoffice.LibreOffice.writer

# SETUP lxde-settings *
# -----------------------------------------------------------------------------
# Desktop environment.
# -----------------------------------------------------------------------------
if type lxsession; then pcmanfm; fi
if type lxsession; then until [[ -f ~/.config/libfm/libfm.conf ]]; do sleep 2; done; fi
if type lxsession; then sed --in-place 's/single_click=0/single_click=1/g' ~/.config/libfm/libfm.conf; fi
#
LOGOUT=true

# RESET lxde-settings *
# -----------------------------------------------------------------------------
# Desktop environment.
# -----------------------------------------------------------------------------
if type lxsession && [[ -f ~/.config/libfm/libfm.conf ]]; then sed --in-place 's/single_click=1/single_click=0/g' ~/.config/libfm/libfm.conf; fi
#
LOGOUT=true

# SETUP lynis #none
# -----------------------------------------------------------------------------
# Security auditing.
# -----------------------------------------------------------------------------
if ! [[ -d ~/lynis ]]; then git clone https://github.com/CISOfy/lynis ~/lynis; fi
# -----------------------------------------------------------------------------
# Usage:
# $ cd ~/lynis
# $ [sudo] ./lynis audit system
# -----------------------------------------------------------------------------

# RESET lynis #none
# -----------------------------------------------------------------------------
# Security auditing.
# -----------------------------------------------------------------------------
rm --force --recursive ~/lynis

# SETUP microsoft-edge pc06 pc07
# -----------------------------------------------------------------------------
# Web browser.
# -----------------------------------------------------------------------------
kz-desktop --addaft=microsoft-edge

# RESET microsoft-edge pc06 pc07
# -----------------------------------------------------------------------------
# Web browser.
# -----------------------------------------------------------------------------
kz-desktop --delete=microsoft-edge

# SETUP no-annoyance *
# -----------------------------------------------------------------------------
# Disable the 'Window is ready' notification.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release && gnome-extensions info noannoyance-fork@vrba.dev; then gnome-extensions enable noannoyance-fork@vrba.dev; fi
#
# For Red Hat and RedHat-based systems go to https://extensions.gnome.org/extension/6109/noannoyance-fork/ and enable the extension.
#
LOGOUT=true

# RESET no-annoyance *
# -----------------------------------------------------------------------------
# Enable the 'Window is ready' notification.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release && gnome-extensions info noannoyance-fork@vrba.dev; then gnome-extensions disable noannoyance-fork@vrba.dev; fi
#
# For Red Hat and RedHat-based systems go to https://extensions.gnome.org/extension/6109/noannoyance-fork/ and disable the extension.
#
LOGOUT=true

# SETUP private-home *
# -----------------------------------------------------------------------------
# Private home.
# -----------------------------------------------------------------------------
chmod 750 ~

# RESET private-home *
# -----------------------------------------------------------------------------
# Private home.
# -----------------------------------------------------------------------------
chmod 755 ~

# SETUP restore-thumbnails #none
# -----------------------------------------------------------------------------
# Restore thumbnails.
# -----------------------------------------------------------------------------
rm --force --recursive ~/.cache/thumbnails/

# RESET restore-thumbnails #none
# -----------------------------------------------------------------------------
# Restore thumbnails.
# -----------------------------------------------------------------------------
# No reset actions defined.

# SETUP spotify *
# -----------------------------------------------------------------------------
# Music and podcasts.
# -----------------------------------------------------------------------------
# Web app: https://open.spotify.com
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then kz-desktop --addaft=spotify; fi
#
if grep --quiet rhel /etc/os-release; then kz-desktop --addaft=kz-spotify; fi

# RESET spotify *
# -----------------------------------------------------------------------------
# Music and podcasts.
# -----------------------------------------------------------------------------
# Web app: https://open.spotify.com
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then kz-desktop --delete=spotify; fi
#
if grep --quiet rhel /etc/os-release; then kz-desktop --delete=kz-spotify; fi

# SETUP terminal *
# -----------------------------------------------------------------------------
# Terminal emulator.
# -----------------------------------------------------------------------------
# Enable aliases.
# -----------------------------------------------------------------------------
sed --in-place 's/#alias/alias/g' ~/.bashrc
sed --in-place 's/# alias/alias/g' ~/.bashrc
sed --in-place 's/# export/export/g' ~/.bashrc
sed --in-place 's/# eval/eval/g' ~/.bashrc
# -----------------------------------------------------------------------------
# Enable search forward in history (with Ctrl-S).
# -----------------------------------------------------------------------------
sed --in-place '/^stty -ixon/d' ~/.bashrc
echo 'stty -ixon # Enable fwd search history (i-search)' >> ~/.bashrc
#
LOGOUT=true

# RESET terminal *
# -----------------------------------------------------------------------------
# Terminal emulator.
# -----------------------------------------------------------------------------
# Disable aliases.
# -----------------------------------------------------------------------------
sed --in-place 's/alias/#alias/g' ~/.bashrc
sed --in-place 's/export/#export/g' ~/.bashrc
sed --in-place 's/eval/#eval/g' ~/.bashrc
# -----------------------------------------------------------------------------
# Disable search forward in history (with Ctrl-S).
# -----------------------------------------------------------------------------
sed --in-place '/^stty -ixon/d' ~/.bashrc

# SETUP terminal pc06 pc07
# -----------------------------------------------------------------------------
# Terminal emulator.
# -----------------------------------------------------------------------------
kz-desktop --addbef=org.gnome.Terminal

# RESET terminal pc06 pc07
# -----------------------------------------------------------------------------
# Terminal emulator.
# -----------------------------------------------------------------------------
kz-desktop --delete=org.gnome.Terminal

# SETUP thunderbird *
# -----------------------------------------------------------------------------
# Web browser.
# -----------------------------------------------------------------------------
kz-desktop --addbef=thunderbird

# RESET thunderbird *
# -----------------------------------------------------------------------------
# Web browser.
# -----------------------------------------------------------------------------
kz-desktop --delete=thunderbird

# SETUP vscode pc06 pc07
# -----------------------------------------------------------------------------
# Editor.
# -----------------------------------------------------------------------------
# Web app: https://vscode.dev
# -----------------------------------------------------------------------------
kz-desktop --addbef=code
#
xdg-mime default code.desktop application/json
xdg-mime default code.desktop application/x-desktop
xdg-mime default code.desktop application/x-shellscript
xdg-mime default code.desktop application/xml
xdg-mime default code.desktop text/html
xdg-mime default code.desktop text/markdown
xdg-mime default code.desktop text/plain
xdg-mime default code.desktop text/troff
xdg-mime default code.desktop text/x-python

# RESET vscode pc06 pc07
# -----------------------------------------------------------------------------
# Editor.
# -----------------------------------------------------------------------------
# Web app: https://vscode.dev
# -----------------------------------------------------------------------------
kz-desktop --delete=code

# SETUP webmin pc07
# -----------------------------------------------------------------------------
# Web console.
# -----------------------------------------------------------------------------
# Web app: https://localhost:10000
# -----------------------------------------------------------------------------
kz-desktop --addaft=kz-webmin

# RESET webmin pc07
# -----------------------------------------------------------------------------
# Web console.
# -----------------------------------------------------------------------------
# Web app: https://localhost:10000
# -----------------------------------------------------------------------------
kz-desktop --delete=kz-webmin

# SETUP zoom pc01
# -----------------------------------------------------------------------------
# Videoconferencing.
# -----------------------------------------------------------------------------
kz-desktop --addaft=kz-zoom

# RESET zoom pc01
# -----------------------------------------------------------------------------
# Videoconferencing.
# -----------------------------------------------------------------------------
kz-desktop --delete=kz-zoom
