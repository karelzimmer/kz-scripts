# shellcheck shell=bash disable=SC2034,SC2129
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


# SETUP bitwarden
# DESC  A secure and free password manager for all of your devices.
# HOST  *
kz-desktop --addaft=com.bitwarden.desktop

# RESET bitwarden
kz-desktop --delete=com.bitwarden.desktop


# SETUP bottles
# DESC  Run Windows software.
# HOST  pc06 pc07
kz-desktop --addaft=com.usebottles.bottles

# RESET bottles
kz-desktop --delete=com.usebottles.bottles


# SETUP cinnamon-settings
# DESC  Cinnamon desktop environment settings.
# HOST  #none
if gsettings get org.nemo.preferences click-policy &> /dev/null; then gsettings set org.nemo.preferences click-policy 'single'; fi

# RESET cinnamon-settings
if gsettings get org.nemo.preferences click-policy &> /dev/null; then gsettings reset org.nemo.preferences click-policy; fi


# SETUP cockpit
# DESC  Web Console for Linux servers.
# HOST  pc06
# -----------------------------------------------------------------------------
# Web app: https://localhost:9090
# -----------------------------------------------------------------------------
kz-desktop --addaft=kz-cockpit

# RESET cockpit
kz-desktop --delete=kz-cockpit


# SETUP dash-to-dock-extension
# DESC  A dock for the Gnome Shell.
# HOST  *
if gsettings get org.gnome.shell disable-user-extensions &> /dev/null; then gsettings set org.gnome.shell disable-user-extensions false; fi
#
if grep --quiet --regexp='debian' /etc/os-release && gnome-extensions info dash-to-dock@micxgx.gmail.com &> /dev/null; then gnome-extensions enable dash-to-dock@micxgx.gmail.com; fi
#
if grep --quiet --regexp='rhel\|fedora' /etc/os-release && gnome-extensions info dash-to-dock@gnome-shell-extensions.gcampax.github.com &> /dev/null; then gnome-extensions enable dash-to-dock@gnome-shell-extensions.gcampax.github.com; fi
if grep --quiet --regexp='rhel\|fedora' /etc/os-release && gnome-extensions info dash-to-dock@micxgx.gmail.com &> /dev/null; then gnome-extensions enable dash-to-dock@micxgx.gmail.com; fi
if grep --quiet --regexp='rhel\|fedora' /etc/os-release && gnome-extensions info no-overview@fthx &> /dev/null; then gnome-extensions enable no-overview@fthx; fi
#
if gsettings get org.gnome.shell.extensions.dash-to-dock apply-custom-theme &> /dev/null; then gsettings set org.gnome.shell.extensions.dash-to-dock apply-custom-theme true; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock click-action &> /dev/null; then gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize-or-previews'; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock custom-theme-shrink &> /dev/null; then gsettings set org.gnome.shell.extensions.dash-to-dock custom-theme-shrink true; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock dash-max-icon-size &> /dev/null; then gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 32; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock disable-overview-on-startup &> /dev/null; then gsettings set org.gnome.shell.extensions.dash-to-dock disable-overview-on-startup true; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock dock-fixed &> /dev/null; then gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed true; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock dock-position &> /dev/null; then gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM'; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock extend-height &> /dev/null; then gsettings set org.gnome.shell.extensions.dash-to-dock extend-height true; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock icon-size-fixed &> /dev/null; then gsettings set org.gnome.shell.extensions.dash-to-dock icon-size-fixed true; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock show-mounts &> /dev/null; then gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts true; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock show-mounts-network &> /dev/null; then gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts-network false; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock show-mounts-only-mounted &> /dev/null; then gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts-only-mounted true; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock show-trash &> /dev/null; then gsettings set org.gnome.shell.extensions.dash-to-dock show-trash false; fi
#
LOGOUT=true

# RESET dash-to-dock-extension
if gsettings get org.gnome.shell.extensions.dash-to-dock apply-custom-theme &> /dev/null; then gsettings reset org.gnome.shell.extensions.dash-to-dock apply-custom-theme; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock click-action &> /dev/null; then gsettings reset org.gnome.shell.extensions.dash-to-dock click-action; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock custom-theme-shrink &> /dev/null; then gsettings reset org.gnome.shell.extensions.dash-to-dock custom-theme-shrink; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock dash-max-icon-size &> /dev/null; then gsettings reset org.gnome.shell.extensions.dash-to-dock dash-max-icon-size; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock disable-overview-on-startup &> /dev/null; then gsettings reset org.gnome.shell.extensions.dash-to-dock disable-overview-on-startup; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock dock-fixed &> /dev/null; then gsettings reset org.gnome.shell.extensions.dash-to-dock dock-fixed; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock dock-position &> /dev/null; then gsettings reset org.gnome.shell.extensions.dash-to-dock dock-position; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock extend-height &> /dev/null; then gsettings reset org.gnome.shell.extensions.dash-to-dock extend-height; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock icon-size-fixed &> /dev/null; then gsettings reset org.gnome.shell.extensions.dash-to-dock icon-size-fixed; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock show-mounts &> /dev/null; then gsettings reset org.gnome.shell.extensions.dash-to-dock show-mounts; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock show-mounts-network &> /dev/null; then gsettings reset org.gnome.shell.extensions.dash-to-dock show-mounts-network; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock show-mounts-only-mounted &> /dev/null; then gsettings reset org.gnome.shell.extensions.dash-to-dock show-mounts-only-mounted; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock show-trash &> /dev/null; then gsettings reset org.gnome.shell.extensions.dash-to-dock show-trash; fi
#
if grep --quiet --regexp='debian' /etc/os-release && gnome-extensions info dash-to-dock@micxgx.gmail.com &> /dev/null; then gnome-extensions disable dash-to-dock@micxgx.gmail.com; fi
#
if grep --quiet --regexp='rhel\|fedora' /etc/os-release && gnome-extensions info no-overview@fthx &> /dev/null; then gnome-extensions disable no-overview@fthx; fi
if grep --quiet --regexp='rhel\|fedora' /etc/os-release && gnome-extensions info dash-to-dock@gnome-shell-extensions.gcampax.github.com &> /dev/null; then gnome-extensions disable dash-to-dock@gnome-shell-extensions.gcampax.github.com; fi
if grep --quiet --regexp='rhel\|fedora' /etc/os-release && gnome-extensions info dash-to-dock@micxgx.gmail.com &> /dev/null; then gnome-extensions disable dash-to-dock@micxgx.gmail.com; fi
#
LOGOUT=true


# SETUP evolution
# DESC  Groupware suite with mail client and organizer.
# HOST  *
kz-desktop --delete=org.gnome.Evolution

# RESET evolution
kz-desktop --addbef=org.gnome.Evolution


# SETUP evolution
# DESC  Groupware suite with mail client and organizer.
# HOST  pc06 pc07
kz-desktop --addaft=org.gnome.Evolution

# RESET evolution
kz-desktop --delete=org.gnome.Evolution


# SETUP git
# DESC  Fast, scalable, distributed revision control system.
# HOST  pc06 pc07
# -----------------------------------------------------------------------------
# Web app: https://github.com
# -----------------------------------------------------------------------------
git config --global alias.logg 'log --decorate --graph --oneline --all'

# RESET git
git config --global --unset alias.logg


# SETUP gnome-extensions
# DESC  GNOME desktop extensions.
# HOST  pc06 pc07
if type gnome-session &> /dev/null; then pipx install gnome-extensions-cli --system-site-packages; fi
if type gnome-session &> /dev/null; then pipx ensurepath; fi
# -----------------------------------------------------------------------------
# Coverflow Alt-Tab
# https://extensions.gnome.org/extension/97/coverflow-alt-tab/
# -----------------------------------------------------------------------------
if type gnome-session &> /dev/null; then ~/.local/bin/gext install 'CoverflowAltTab@palatis.blogspot.com'; fi
if type gnome-session &> /dev/null; then ~/.local/bin/gext enable 'CoverflowAltTab@palatis.blogspot.com'; fi
# -----------------------------------------------------------------------------
# Compiz windows effect
# https://extensions.gnome.org/extension/3210/compiz-windows-effect/
# -----------------------------------------------------------------------------
if type gnome-session &> /dev/null; then ~/.local/bin/gext install 'compiz-windows-effect@hermes83.github.com'; fi
if type gnome-session &> /dev/null; then ~/.local/bin/gext enable 'compiz-windows-effect@hermes83.github.com'; fi
# -----------------------------------------------------------------------------
# Compiz alike magic lamp effect
# https://extensions.gnome.org/extension/3740/compiz-alike-magic-lamp-effect/
# -----------------------------------------------------------------------------
if type gnome-session &> /dev/null; then ~/.local/bin/gext install 'compiz-alike-magic-lamp-effect@hermes83.github.com'; fi
if type gnome-session &> /dev/null; then ~/.local/bin/gext enable 'compiz-alike-magic-lamp-effect@hermes83.github.com'; fi
# -----------------------------------------------------------------------------
# Desktop Cube
# https://extensions.gnome.org/extension/4648/desktop-cube/
# -----------------------------------------------------------------------------
if type gnome-session &> /dev/null; then ~/.local/bin/gext install 'desktop-cube@schneegans.github.com'; fi
if type gnome-session &> /dev/null; then ~/.local/bin/gext enable 'desktop-cube@schneegans.github.com'; fi

# RESET gnome-extensions
# -----------------------------------------------------------------------------
# Coverflow Alt-Tab
# https://extensions.gnome.org/extension/97/coverflow-alt-tab/
# -----------------------------------------------------------------------------
if type gnome-session &> /dev/null; then ~/.local/bin/gext disable 'CoverflowAltTab@palatis.blogspot.com'; fi
if type gnome-session &> /dev/null; then ~/.local/bin/gext uninstall 'CoverflowAltTab@palatis.blogspot.com'; fi
# -----------------------------------------------------------------------------
# Compiz windows effect
# https://extensions.gnome.org/extension/3210/compiz-windows-effect/
# -----------------------------------------------------------------------------
if type gnome-session &> /dev/null; then ~/.local/bin/gext disable 'compiz-windows-effect@hermes83.github.com'; fi
if type gnome-session &> /dev/null; then ~/.local/bin/gext uninstall 'compiz-windows-effect@hermes83.github.com'; fi
# -----------------------------------------------------------------------------
# Compiz alike magic lamp effect
# https://extensions.gnome.org/extension/3740/compiz-alike-magic-lamp-effect/
# -----------------------------------------------------------------------------
if type gnome-session &> /dev/null; then ~/.local/bin/gext disable 'compiz-alike-magic-lamp-effect@hermes83.github.com'; fi
if type gnome-session &> /dev/null; then ~/.local/bin/gext uninstall 'compiz-alike-magic-lamp-effect@hermes83.github.com'; fi
# -----------------------------------------------------------------------------
# Desktop Cube
# https://extensions.gnome.org/extension/4648/desktop-cube/
# -----------------------------------------------------------------------------
if type gnome-session &> /dev/null; then ~/.local/bin/gext disable 'desktop-cube@schneegans.github.com'; fi
if type gnome-session &> /dev/null; then ~/.local/bin/gext uninstall 'desktop-cube@schneegans.github.com'; fi


# SETUP gnome-settings
# DESC  GNOME desktop environment settings.
# HOST  *
if gsettings get org.gnome.desktop.calendar show-weekdate &> /dev/null; then gsettings set org.gnome.desktop.calendar show-weekdate true; fi
if gsettings get org.gnome.desktop.input-sources sources &> /dev/null; then gsettings set org.gnome.desktop.input-sources sources "$(gsettings get org.gnome.desktop.input-sources sources | sed --expression="s/, ('ibus', 'mozc-jp')//")"; fi
if gsettings get org.gnome.desktop.input-sources sources &> /dev/null; then gsettings set org.gnome.desktop.input-sources sources "$(gsettings get org.gnome.desktop.input-sources sources | sed --expression="s/('ibus', 'mozc-jp'), //")"; fi
if gsettings get org.gnome.desktop.interface clock-show-date &> /dev/null; then gsettings set org.gnome.desktop.interface clock-show-date true; fi
if gsettings get org.gnome.desktop.interface clock-show-weekday &> /dev/null; then gsettings set org.gnome.desktop.interface clock-show-weekday true; fi
if gsettings get org.gnome.desktop.interface font-antialiasing &> /dev/null; then gsettings set org.gnome.desktop.interface font-antialiasing 'rgba'; fi
if gsettings get org.gnome.desktop.interface show-battery-percentage &> /dev/null; then gsettings set org.gnome.desktop.interface show-battery-percentage true; fi
if gsettings get org.gnome.desktop.peripherals.touchpad tap-to-click &> /dev/null; then gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true; fi
if gsettings get org.gnome.desktop.screensaver lock-enabled &> /dev/null; then gsettings set org.gnome.desktop.screensaver lock-enabled false; fi
if gsettings get org.gnome.desktop.session idle-delay &> /dev/null; then gsettings set org.gnome.desktop.session idle-delay 900; fi
if gsettings get org.gnome.desktop.sound allow-volume-above-100-percent &> /dev/null; then gsettings set org.gnome.desktop.sound allow-volume-above-100-percent true; fi
if gsettings get org.gnome.desktop.wm.preferences button-layout &> /dev/null; then gsettings set org.gnome.desktop.wm.preferences button-layout ':minimize,maximize,close'; fi
if gsettings get org.gnome.mutter center-new-windows &> /dev/null; then gsettings set org.gnome.mutter center-new-windows true; fi
if gsettings get org.gnome.nautilus.icon-view default-zoom-level &> /dev/null; then gsettings set org.gnome.nautilus.icon-view default-zoom-level large; fi
if gsettings get org.gnome.nautilus.list-view use-tree-view &> /dev/null; then gsettings set org.gnome.nautilus.list-view use-tree-view true; fi
if gsettings get org.gnome.nautilus.preferences click-policy &> /dev/null; then gsettings set org.gnome.nautilus.preferences click-policy 'single'; fi
if gsettings get org.gnome.nautilus.preferences open-folder-on-dnd-hover &> /dev/null; then gsettings set org.gnome.nautilus.preferences open-folder-on-dnd-hover true; fi
if gsettings get org.gnome.nautilus.preferences show-create-link &> /dev/null; then gsettings set org.gnome.nautilus.preferences show-create-link true; fi
if gsettings get org.gnome.nautilus.preferences show-image-thumbnails &> /dev/null; then gsettings set org.gnome.nautilus.preferences show-image-thumbnails 'always'; fi
if gsettings get org.gnome.settings-daemon.plugins.power power-button-action &> /dev/null; then gsettings set org.gnome.settings-daemon.plugins.power power-button-action interactive; fi
if gsettings get org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type &> /dev/null; then gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type nothing; fi
if gsettings get org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type &> /dev/null; then gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type nothing; fi
if gsettings get org.gnome.shell.extensions.ding show-home &> /dev/null; then gsettings set org.gnome.shell.extensions.ding show-home false; fi
if gsettings get org.gtk.gtk4.Settings.FileChooser sort-directories-first &> /dev/null; then gsettings set org.gtk.gtk4.Settings.FileChooser sort-directories-first true; fi
#
LOGOUT=true

# RESET gnome-settings
if gsettings get org.gnome.desktop.calendar show-weekdate &> /dev/null; then gsettings reset org.gnome.desktop.calendar show-weekdate; fi
if gsettings get org.gnome.desktop.interface clock-show-date &> /dev/null; then gsettings reset org.gnome.desktop.interface clock-show-date; fi
if gsettings get org.gnome.desktop.interface clock-show-weekday &> /dev/null; then gsettings reset org.gnome.desktop.interface clock-show-weekday; fi
if gsettings get org.gnome.desktop.interface font-antialiasing &> /dev/null; then gsettings reset org.gnome.desktop.interface font-antialiasing; fi
if gsettings get org.gnome.desktop.interface show-battery-percentage &> /dev/null; then gsettings reset org.gnome.desktop.interface show-battery-percentage; fi
if gsettings get org.gnome.desktop.peripherals.touchpad tap-to-click &> /dev/null; then gsettings reset org.gnome.desktop.peripherals.touchpad tap-to-click; fi
if gsettings get org.gnome.desktop.screensaver lock-enabled &> /dev/null; then gsettings reset org.gnome.desktop.screensaver lock-enabled; fi
if gsettings get org.gnome.desktop.session idle-delay &> /dev/null; then gsettings reset org.gnome.desktop.session idle-delay; fi
if gsettings get org.gnome.desktop.sound allow-volume-above-100-percent &> /dev/null; then gsettings reset org.gnome.desktop.sound allow-volume-above-100-percent; fi
if gsettings get org.gnome.desktop.wm.preferences button-layout &> /dev/null; then gsettings reset org.gnome.desktop.wm.preferences button-layout; fi
if gsettings get org.gnome.mutter center-new-windows &> /dev/null; then gsettings reset org.gnome.mutter center-new-windows; fi
if gsettings get org.gnome.nautilus.icon-view default-zoom-level &> /dev/null; then gsettings reset org.gnome.nautilus.icon-view default-zoom-level; fi
if gsettings get org.gnome.nautilus.list-view use-tree-view &> /dev/null; then gsettings reset org.gnome.nautilus.list-view use-tree-view; fi
if gsettings get org.gnome.nautilus.preferences click-policy &> /dev/null; then gsettings reset org.gnome.nautilus.preferences click-policy; fi
if gsettings get org.gnome.nautilus.preferences open-folder-on-dnd-hover &> /dev/null; then gsettings reset org.gnome.nautilus.preferences open-folder-on-dnd-hover; fi
if gsettings get org.gnome.nautilus.preferences show-create-link &> /dev/null; then gsettings reset org.gnome.nautilus.preferences show-create-link; fi
if gsettings get org.gnome.nautilus.preferences show-image-thumbnails &> /dev/null; then gsettings reset org.gnome.nautilus.preferences show-image-thumbnails; fi
if gsettings get org.gnome.settings-daemon.plugins.power power-button-action &> /dev/null; then gsettings reset org.gnome.settings-daemon.plugins.power power-button-action; fi
if gsettings get org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type &> /dev/null; then gsettings reset org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type; fi
if gsettings get org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type &> /dev/null; then gsettings reset org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type; fi
if gsettings get org.gnome.shell.extensions.ding show-home &> /dev/null; then gsettings reset org.gnome.shell.extensions.ding show-home; fi
if gsettings get org.gtk.gtk4.Settings.FileChooser sort-directories-first &> /dev/null; then gsettings reset org.gtk.gtk4.Settings.FileChooser sort-directories-first; fi
if gsettings get org.gnome.desktop.input-sources sources &> /dev/null; then gsettings reset org.gnome.desktop.input-sources sources; fi
#
LOGOUT=true


# SETUP google-chrome
# DESC  The web browser from Google.
# HOST  pc01 pc06 pc07
kz-desktop --addbef=google-chrome

# RESET google-chrome
kz-desktop --delete=google-chrome


# SETUP gsconnect-extension
# DESC  Securely connect to mobile devices and other desktops.
# HOST  pc06 pc07
if gsettings get org.gnome.shell disable-user-extensions &> /dev/null; then gsettings set org.gnome.shell disable-user-extensions false; fi
#
if grep --quiet --regexp='debian' /etc/os-release && gnome-extensions info gsconnect@andyholmes.github.io &> /dev/null; then gnome-extensions enable gsconnect@andyholmes.github.io; fi
#
# For Red Hat and Red Hat-based systems go to https://extensions.gnome.org/extension/1319/gsconnect/ and enable the extension.
#
LOGOUT=true

# RESET gsconnect-extension
if grep --quiet --regexp='debian' /etc/os-release && gnome-extensions info gsconnect@andyholmes.github.io &> /dev/null; then gnome-extensions disable gsconnect@andyholmes.github.io; fi
#
# For Red Hat and Red Hat-based systems go to https://extensions.gnome.org/extension/1319/gsconnect/ and disable the extension.


# SETUP kvm
# DESC  KVM (for Kernel-based Virtual Machine) is a full virtualization solution.
# HOST  pc06 pc07
kz-desktop --addaft=virt-manager

# RESET kvm
kz-desktop --delete=virt-manager


# SETUP libreoffice
# DESC  Office productivity suite.
# HOST  #none
kz-desktop --addaft=libreoffice-writer
kz-desktop --addaft=org.libreoffice.LibreOffice.writer

# RESET libreoffice
kz-desktop --delete=libreoffice-writer
kz-desktop --delete=org.libreoffice.LibreOffice.writer


# SETUP lxde-settings
# DESC  LXDE desktop environment settings.
# HOST  #none
if type lxsession &> /dev/null; then pcmanfm; fi
if type lxsession &> /dev/null; then until [[ -f ~/.config/libfm/libfm.conf ]]; do sleep 2; done; fi
if type lxsession &> /dev/null; then sed --in-place --expression='s/single_click=.*$/single_click=1/g' ~/.config/libfm/libfm.conf; fi
#
LOGOUT=true

# RESET lxde-settings
if type lxsession > /dev/null && [[ -f ~/.config/libfm/libfm.conf ]]; then sed --in-place --expression='s/single_click=.*$/single_click=0/g' ~/.config/libfm/libfm.conf; fi
#
LOGOUT=true


# SETUP lynis
# DESC  Security auditing and hardening tool for Linux/Unix.
# HOST  #none
git clone https://github.com/CISOfy/lynis.git "$HOME/lynis"
# -----------------------------------------------------------------------------
# Usage:
# $ cd ~/lynis
# $ [sudo] ./lynis audit system
# -----------------------------------------------------------------------------

# RESET lynis
rm --force --recursive "$HOME/lynis"


# SETUP microsoft-edge
# DESC  The web browser from Microsoft.
# HOST  pc06 pc07
kz-desktop --addaft=microsoft-edge

# RESET microsoft-edge
kz-desktop --delete=microsoft-edge


# SETUP no-annoyance-extension
# DESC  Disable the 'Window is ready' notification.
# HOST  *
if gsettings get org.gnome.shell disable-user-extensions &> /dev/null; then gsettings set org.gnome.shell disable-user-extensions false; fi
#
if grep --quiet --regexp='debian' /etc/os-release && gnome-extensions info noannoyance-fork@vrba.dev &> /dev/null; then gnome-extensions enable noannoyance-fork@vrba.dev; fi
#
# For Red Hat and Red Hat-based systems go to https://extensions.gnome.org/extension/6109/noannoyance-fork/ and enable the extension.
#
LOGOUT=true

# RESET no-annoyance-extension
if grep --quiet --regexp='debian' /etc/os-release && gnome-extensions info noannoyance-fork@vrba.dev &> /dev/null; then gnome-extensions disable noannoyance-fork@vrba.dev; fi
#
# For Red Hat and Red Hat-based systems go to https://extensions.gnome.org/extension/6109/noannoyance-fork/ and disable the extension.
#
LOGOUT=true


# SETUP private-home
# DESC  Private home directory permissions.
# HOST  *
chmod 750 ~

# RESET private-home
chmod 755 ~


# SETUP spotify
# DESC  Spotify streaming music client.
# HOST  pc01 pc06 pc07
# -----------------------------------------------------------------------------
# Web app: https://open.spotify.com
# -----------------------------------------------------------------------------
if grep --quiet --regexp='debian' /etc/os-release; then kz-desktop --addaft=spotify; fi
#
if grep --quiet --regexp='rhel\|fedora' /etc/os-release; then kz-desktop --addaft=kz-spotify; fi

# RESET spotify
if grep --quiet --regexp='debian' /etc/os-release; then kz-desktop --delete=spotify; fi
#
if grep --quiet --regexp='rhel\|fedora' /etc/os-release; then kz-desktop --delete=kz-spotify; fi


# SETUP terminal
# DESC  Terminal emulator application.
# HOST  pc01 pc06 pc07
# -----------------------------------------------------------------------------
# Enable aliases.
# -----------------------------------------------------------------------------
sed --in-place --expression='s/#alias/alias/g' --expression='s/# alias/alias/g' --expression='s/# export/export/g' --expression='s/# eval/eval/g' ~/.bashrc
# -----------------------------------------------------------------------------
# Enable search forward in history (with Ctrl-S).
# -----------------------------------------------------------------------------
sed --in-place '/^stty -ixon/d' ~/.bashrc
echo 'stty -ixon # Enable fwd search history (i-search)' >> ~/.bashrc
#
LOGOUT=true

# RESET terminal
# -----------------------------------------------------------------------------
# Disable aliases.
# -----------------------------------------------------------------------------
sed --in-place --expression='s/^alias/#alias/g' --expression='s/^export/#export/g' --expression='s/^eval/#eval/g' ~/.bashrc
# -----------------------------------------------------------------------------
# Disable search forward in history (with Ctrl-S).
# -----------------------------------------------------------------------------
sed --in-place --expression='/^stty -ixon/d' ~/.bashrc
#
LOGOUT=true


# SETUP terminal
# DESC  Terminal emulator application.
# HOST  pc06 pc07
sed --in-place --expression='/^alias bin/d' --expression='/^alias doc/d' ~/.bashrc
echo "alias bin='cd $(xdg-user-dir PROJECTS)/kz-scripts/usr/bin'" >> ~/.bashrc
echo "alias doc='cd $(xdg-user-dir PROJECTS)/kz-docs'" >> ~/.bashrc
kz-desktop --addbef=org.gnome.Terminal

# RESET terminal
kz-desktop --delete=org.gnome.Terminal
sed --in-place --expression='/^alias bin/d' --expression='/^alias doc/d' ~/.bashrc


# SETUP thumbnails-cache
# DESC  Restore thumbnails in nautilus.
# HOST  #none
rm --force --recursive ~/.cache/thumbnails/

# RESET thumbnails-cache
rm --force --recursive ~/.cache/thumbnails/


# SETUP thunderbird
# DESC  Mail/news client with RSS, chat and integrated spam filter support.
# HOST  #none
kz-desktop --addbef=thunderbird

# RESET thunderbird
kz-desktop --delete=thunderbird


# SETUP vscode
# DESC  Code editing. Redefined.
# HOST  pc06 pc07
# -----------------------------------------------------------------------------
# Web app: https://vscode.dev
# -----------------------------------------------------------------------------
kz-desktop --addbef=code
#
if [[ -n ${XDG_CURRENT_DESKTOP-} ]]; then xdg-mime default code.desktop application/json; fi
if [[ -n ${XDG_CURRENT_DESKTOP-} ]]; then xdg-mime default code.desktop application/x-desktop; fi
if [[ -n ${XDG_CURRENT_DESKTOP-} ]]; then xdg-mime default code.desktop application/x-shellscript; fi
if [[ -n ${XDG_CURRENT_DESKTOP-} ]]; then xdg-mime default code.desktop application/xml; fi
if [[ -n ${XDG_CURRENT_DESKTOP-} ]]; then xdg-mime default code.desktop text/html; fi
if [[ -n ${XDG_CURRENT_DESKTOP-} ]]; then xdg-mime default code.desktop text/markdown; fi
if [[ -n ${XDG_CURRENT_DESKTOP-} ]]; then xdg-mime default code.desktop text/plain; fi
if [[ -n ${XDG_CURRENT_DESKTOP-} ]]; then xdg-mime default code.desktop text/troff; fi
if [[ -n ${XDG_CURRENT_DESKTOP-} ]]; then xdg-mime default code.desktop text/x-python; fi

# RESET vscode
kz-desktop --delete=code


# SETUP webmin
# DESC  Web Console for Linux servers.
# HOST  pc07
# -----------------------------------------------------------------------------
# Web app: https://localhost:10000
# -----------------------------------------------------------------------------
kz-desktop --addaft=kz-webmin

# RESET webmin
kz-desktop --delete=kz-webmin


# SETUP xdg-projects-dir
# DESC  Add XDG_PROJECTS_DIR to ~/.config/user-dirs.dirs.
# HOST  pc06 pc07
# -----------------------------------------------------------------------------
# App xdg-projects-dir is not required with xdg-user-dirs version 0.20 or higher.
# -----------------------------------------------------------------------------
if [[ ${LANG:0:2} = 'nl' ]]; then mkdir --parents --verbose ~/Projecten; else mkdir --parents --verbose ~/Projects; fi
if [[ ${LANG:0:2} = 'nl' ]]; then xdg-user-dirs-update --set PROJECTS ~/Projecten; else xdg-user-dirs-update --set PROJECTS ~/Projects; fi
xdg-user-dirs-update

# RESET xdg-projects-dir
xdg-user-dirs-update --set PROJECTS ~


# SETUP zoom
# DESC  Cloud-based communication and collaboration platform.
# HOST  pc01
kz-desktop --addaft=kz-zoom

# RESET zoom
kz-desktop --delete=kz-zoom
