# shellcheck shell=bash disable=SC2034,SC2129
# #############################################################################
# SPDX-FileComment: Settings file for use with kz setup.
#
# SPDX-FileCopyrightText: Karel Zimmer <info@karelzimmer.nl>
# SPDX-License-Identifier: CC0-1.0
# #############################################################################
#
# =============================================================================
# Use "man kz setup.sh" and "man kz setup.sh.gpg" to learn more about the
# format of this file.
# =============================================================================

#|setup|bitwarden|*|Password manager
kz-desktop --addaft=com.bitwarden.desktop

#|reset|bitwarden|*|Password manager
kz-desktop --delete=com.bitwarden.desktop

#|setup|bottles|pc06 pc07|Run Windows software
kz-desktop --addaft=com.usebottles.bottles

#|reset|bottles|pc06 pc07|Run Windows software
kz-desktop --delete=com.usebottles.bottles

#|setup|cockpit|pc06|Server management
# -----------------------------------------------------------------------------
# Web app: https://localhost:9090
# -----------------------------------------------------------------------------
kz-desktop --addaft=kz-cockpit

#|reset|cockpit|pc06|Server management
kz-desktop --delete=kz-cockpit

#|setup|desktop-settings|*|Desktop settings
# -----------------------------------------------------------------------------
# Set Cinnamon desktop environment settings.
# -----------------------------------------------------------------------------
if gsettings get org.nemo.preferences click-policy; then gsettings set org.nemo.preferences click-policy 'single'; fi
# -----------------------------------------------------------------------------
# Set GNOME desktop environment settings.
# -----------------------------------------------------------------------------
if gsettings get org.gnome.desktop.calendar show-weekdate; then gsettings set org.gnome.desktop.calendar show-weekdate true; fi
if gsettings get org.gnome.desktop.input-sources sources; then gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us+intl')]"; fi
if gsettings get org.gnome.desktop.interface clock-show-date; then gsettings set org.gnome.desktop.interface clock-show-date true; fi
if gsettings get org.gnome.desktop.interface clock-show-weekday; then gsettings set org.gnome.desktop.interface clock-show-weekday true; fi
if gsettings get org.gnome.desktop.interface font-antialiasing; then gsettings set org.gnome.desktop.interface font-antialiasing 'rgba'; fi
if gsettings get org.gnome.desktop.interface show-battery-percentage; then gsettings set org.gnome.desktop.interface show-battery-percentage true; fi
if gsettings get org.gnome.desktop.peripherals.touchpad tap-to-click; then gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true; fi
if gsettings get org.gnome.desktop.screensaver lock-enabled; then gsettings set org.gnome.desktop.screensaver lock-enabled false; fi
if gsettings get org.gnome.desktop.session idle-delay; then gsettings set org.gnome.desktop.session idle-delay 900; fi
if gsettings get org.gnome.desktop.sound allow-volume-above-100-percent; then gsettings set org.gnome.desktop.sound allow-volume-above-100-percent true; fi
if gsettings get org.gnome.desktop.wm.preferences button-layout; then gsettings set org.gnome.desktop.wm.preferences button-layout ':minimize,maximize,close'; fi
if gsettings get org.gnome.mutter center-new-windows; then gsettings set org.gnome.mutter center-new-windows true; fi
if gsettings get org.gnome.nautilus.icon-view default-zoom-level; then gsettings set org.gnome.nautilus.icon-view default-zoom-level large; fi
if gsettings get org.gnome.nautilus.list-view use-tree-view; then gsettings set org.gnome.nautilus.list-view use-tree-view true; fi
if gsettings get org.gnome.nautilus.preferences click-policy; then gsettings set org.gnome.nautilus.preferences click-policy 'single'; fi
if gsettings get org.gnome.nautilus.preferences open-folder-on-dnd-hover; then gsettings set org.gnome.nautilus.preferences open-folder-on-dnd-hover true; fi
if gsettings get org.gnome.nautilus.preferences show-create-link; then gsettings set org.gnome.nautilus.preferences show-create-link true; fi
if gsettings get org.gnome.nautilus.preferences show-image-thumbnails; then gsettings set org.gnome.nautilus.preferences show-image-thumbnails 'always'; fi
if gsettings get org.gnome.settings-daemon.plugins.power power-button-action; then gsettings set org.gnome.settings-daemon.plugins.power power-button-action interactive; fi
if gsettings get org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type; then gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type nothing; fi
if gsettings get org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type; then gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type nothing; fi
if gsettings get org.gnome.shell.extensions.ding show-home; then gsettings set org.gnome.shell.extensions.ding show-home false; fi
if gsettings get org.gtk.gtk4.Settings.FileChooser sort-directories-first; then gsettings set org.gtk.gtk4.Settings.FileChooser sort-directories-first true; fi
# -----------------------------------------------------------------------------
# Set LXQt desktop environment settings.
# -----------------------------------------------------------------------------
if type lxqt-session; then sed -i 's/Alt%2BF1\./Super_L./g' ~/.config/lxqt/globalkeyshortcuts.conf && sed -i '/single_click_activate=/d; /\[General\]/a single_click_activate=true' ~/.config/lxqt/lxqt.conf && sed -i '/categoriesAtRight=/d; /\[mainmenu\]\|\[fancymenu\]/a categoriesAtRight=false' ~/.config/lxqt/panel.conf; fi
LOGOUT=true

#|reset|desktop-settings|*|Desktop settings
# -----------------------------------------------------------------------------
# Reset Cinnamon desktop environment settings.
# -----------------------------------------------------------------------------
if gsettings get org.nemo.preferences click-policy; then gsettings reset org.nemo.preferences click-policy; fi
# -----------------------------------------------------------------------------
# Reset GNOME desktop environment settings.
# -----------------------------------------------------------------------------
if gsettings get org.gnome.desktop.calendar show-weekdate; then gsettings reset org.gnome.desktop.calendar show-weekdate; fi
if gsettings get org.gnome.desktop.input-sources sources; then gsettings reset org.gnome.desktop.input-sources sources; fi
if gsettings get org.gnome.desktop.interface clock-show-date; then gsettings reset org.gnome.desktop.interface clock-show-date; fi
if gsettings get org.gnome.desktop.interface clock-show-weekday; then gsettings reset org.gnome.desktop.interface clock-show-weekday; fi
if gsettings get org.gnome.desktop.interface font-antialiasing; then gsettings reset org.gnome.desktop.interface font-antialiasing; fi
if gsettings get org.gnome.desktop.interface show-battery-percentage; then gsettings reset org.gnome.desktop.interface show-battery-percentage; fi
if gsettings get org.gnome.desktop.peripherals.touchpad tap-to-click; then gsettings reset org.gnome.desktop.peripherals.touchpad tap-to-click; fi
if gsettings get org.gnome.desktop.screensaver lock-enabled; then gsettings reset org.gnome.desktop.screensaver lock-enabled; fi
if gsettings get org.gnome.desktop.session idle-delay; then gsettings reset org.gnome.desktop.session idle-delay; fi
if gsettings get org.gnome.desktop.sound allow-volume-above-100-percent; then gsettings reset org.gnome.desktop.sound allow-volume-above-100-percent; fi
if gsettings get org.gnome.desktop.wm.preferences button-layout; then gsettings reset org.gnome.desktop.wm.preferences button-layout; fi
if gsettings get org.gnome.mutter center-new-windows; then gsettings reset org.gnome.mutter center-new-windows; fi
if gsettings get org.gnome.nautilus.icon-view default-zoom-level; then gsettings reset org.gnome.nautilus.icon-view default-zoom-level; fi
if gsettings get org.gnome.nautilus.list-view use-tree-view; then gsettings reset org.gnome.nautilus.list-view use-tree-view; fi
if gsettings get org.gnome.nautilus.preferences click-policy; then gsettings reset org.gnome.nautilus.preferences click-policy; fi
if gsettings get org.gnome.nautilus.preferences open-folder-on-dnd-hover; then gsettings reset org.gnome.nautilus.preferences open-folder-on-dnd-hover; fi
if gsettings get org.gnome.nautilus.preferences show-create-link; then gsettings reset org.gnome.nautilus.preferences show-create-link; fi
if gsettings get org.gnome.nautilus.preferences show-image-thumbnails; then gsettings reset org.gnome.nautilus.preferences show-image-thumbnails; fi
if gsettings get org.gnome.settings-daemon.plugins.power power-button-action; then gsettings reset org.gnome.settings-daemon.plugins.power power-button-action; fi
if gsettings get org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type; then gsettings reset org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type; fi
if gsettings get org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type; then gsettings reset org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type; fi
if gsettings get org.gnome.shell.extensions.ding show-home; then gsettings reset org.gnome.shell.extensions.ding show-home; fi
if gsettings get org.gtk.gtk4.Settings.FileChooser sort-directories-first; then gsettings reset org.gtk.gtk4.Settings.FileChooser sort-directories-first; fi
# -----------------------------------------------------------------------------
# Reset LXQt desktop environment settings.
# -----------------------------------------------------------------------------
if type lxqt-session; then sed -i 's/Super_L./Alt%2BF1\./g' ~/.config/lxqt/globalkeyshortcuts.conf && sed -i '/single_click_activate=/d; /\[General\]/a single_click_activate=false' ~/.config/lxqt/lxqt.conf && sed -i '/categoriesAtRight=/d; /\[mainmenu\]\|\[fancymenu\]/a categoriesAtRight=true' ~/.config/lxqt/panel.conf; fi
LOGOUT=true

#|setup|evolution|*|Email & agenda
kz-desktop --delete=org.gnome.Evolution

#|reset|evolution|*|Email & agenda
kz-desktop --addbef=org.gnome.Evolution

#|setup|evolution|pc06 pc07|Email & agenda
kz-desktop --addaft=org.gnome.Evolution

#|reset|evolution|pc06 pc07|Email & agenda
kz-desktop --delete=org.gnome.Evolution

#|setup|git|pc06 pc07|Version control system
# -----------------------------------------------------------------------------
# Web app: https://github.com
# -----------------------------------------------------------------------------
git config --global alias.logg 'log --decorate --graph --oneline --all'

#|reset|git|pc06 pc07|Version control system
git config --global --unset alias.logg

#|setup|gnome-shell-extension-caffeine|*|GNOME disable screensaver & suspend
if gsettings get org.gnome.shell disable-user-extensions; then gsettings set org.gnome.shell disable-user-extensions false; fi
if grep -q debian /etc/os-release && gnome-extensions info caffeine@patapon.info; then gnome-extensions enable caffeine@patapon.info; fi
if grep -qE 'fedora|rhel' /etc/os-release && gnome-extensions info caffeine@patapon.info; then gnome-extensions enable caffeine@patapon.info; fi
LOGOUT=true

#|reset|gnome-shell-extension-caffeine|*|GNOME isable screensaver & suspend
if grep -q debian /etc/os-release && gnome-extensions info caffeine@patapon.info; then gnome-extensions disable caffeine@patapon.info; fi
if grep -qE 'fedora|rhel' /etc/os-release && gnome-extensions info caffeine@patapon.info; then gnome-extensions disable caffeine@patapon.info; fi
LOGOUT=true

#|setup|gnome-shell-extension-dashtodock|*|GNOME dock
if gsettings get org.gnome.shell disable-user-extensions; then gsettings set org.gnome.shell disable-user-extensions false; fi
if grep -q debian /etc/os-release && gnome-extensions info dash-to-dock@micxgx.gmail.com; then gnome-extensions enable dash-to-dock@micxgx.gmail.com; fi
if grep -qE 'fedora|rhel' /etc/os-release && gnome-extensions info dash-to-dock@gnome-shell-extensions.gcampax.github.com; then gnome-extensions enable dash-to-dock@gnome-shell-extensions.gcampax.github.com; fi
if grep -qE 'fedora|rhel' /etc/os-release && gnome-extensions info dash-to-dock@micxgx.gmail.com; then gnome-extensions enable dash-to-dock@micxgx.gmail.com; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock apply-custom-theme; then gsettings set org.gnome.shell.extensions.dash-to-dock apply-custom-theme true; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock click-action; then gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize-or-previews'; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock custom-theme-shrink; then gsettings set org.gnome.shell.extensions.dash-to-dock custom-theme-shrink true; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock dash-max-icon-size; then gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 32; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock disable-overview-on-startup; then gsettings set org.gnome.shell.extensions.dash-to-dock disable-overview-on-startup true; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock dock-fixed; then gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed true; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock dock-position; then gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM'; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock extend-height; then gsettings set org.gnome.shell.extensions.dash-to-dock extend-height true; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock icon-size-fixed; then gsettings set org.gnome.shell.extensions.dash-to-dock icon-size-fixed true; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock show-mounts; then gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts true; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock show-mounts-network; then gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts-network false; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock show-mounts-only-mounted; then gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts-only-mounted true; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock show-trash; then gsettings set org.gnome.shell.extensions.dash-to-dock show-trash false; fi
LOGOUT=true

#|reset|gnome-shell-extension-dashtodock|*|GNOME dock
if gsettings get org.gnome.shell.extensions.dash-to-dock apply-custom-theme; then gsettings reset org.gnome.shell.extensions.dash-to-dock apply-custom-theme; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock click-action; then gsettings reset org.gnome.shell.extensions.dash-to-dock click-action; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock custom-theme-shrink; then gsettings reset org.gnome.shell.extensions.dash-to-dock custom-theme-shrink; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock dash-max-icon-size; then gsettings reset org.gnome.shell.extensions.dash-to-dock dash-max-icon-size; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock disable-overview-on-startup; then gsettings reset org.gnome.shell.extensions.dash-to-dock disable-overview-on-startup; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock dock-fixed; then gsettings reset org.gnome.shell.extensions.dash-to-dock dock-fixed; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock dock-position; then gsettings reset org.gnome.shell.extensions.dash-to-dock dock-position; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock extend-height; then gsettings reset org.gnome.shell.extensions.dash-to-dock extend-height; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock icon-size-fixed; then gsettings reset org.gnome.shell.extensions.dash-to-dock icon-size-fixed; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock show-mounts; then gsettings reset org.gnome.shell.extensions.dash-to-dock show-mounts; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock show-mounts-network; then gsettings reset org.gnome.shell.extensions.dash-to-dock show-mounts-network; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock show-mounts-only-mounted; then gsettings reset org.gnome.shell.extensions.dash-to-dock show-mounts-only-mounted; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock show-trash; then gsettings reset org.gnome.shell.extensions.dash-to-dock show-trash; fi
if grep -q debian /etc/os-release && gnome-extensions info dash-to-dock@micxgx.gmail.com; then gnome-extensions disable dash-to-dock@micxgx.gmail.com; fi
if grep -qE 'fedora|rhel' /etc/os-release && gnome-extensions info dash-to-dock@gnome-shell-extensions.gcampax.github.com; then gnome-extensions disable dash-to-dock@gnome-shell-extensions.gcampax.github.com; fi
if grep -qE 'fedora|rhel' /etc/os-release && gnome-extensions info dash-to-dock@micxgx.gmail.com; then gnome-extensions disable dash-to-dock@micxgx.gmail.com; fi
LOGOUT=true

#|setup|gnome-shell-extension-gsconnect|pc06 pc07|GNOME connect mobile devices & desktops
if gsettings get org.gnome.shell disable-user-extensions; then gsettings set org.gnome.shell disable-user-extensions false; fi
if grep -q debian /etc/os-release && gnome-extensions info gsconnect@andyholmes.github.io; then gnome-extensions enable gsconnect@andyholmes.github.io; fi
# For Red Hat and Red Hat-based systems go to https://extensions.gnome.org/extension/1319/gsconnect/ and enable the extension.
LOGOUT=true

#|reset|gnome-shell-extension-gsconnect|pc06 pc07|GNOME connect mobile devices & desktops
if grep -q debian /etc/os-release && gnome-extensions info gsconnect@andyholmes.github.io; then gnome-extensions disable gsconnect@andyholmes.github.io; fi
# For Red Hat and Red Hat-based systems go to https://extensions.gnome.org/extension/1319/gsconnect/ and disable the extension.

#|setup|gnome-shell-extension-no-annoyance|*|GNOME disable 'Window is ready'
if gsettings get org.gnome.shell disable-user-extensions; then gsettings set org.gnome.shell disable-user-extensions false; fi
if grep -q debian /etc/os-release && gnome-extensions info noannoyance-fork@vrba.dev; then gnome-extensions enable noannoyance-fork@vrba.dev; fi
# For Red Hat and Red Hat-based systems go to https://extensions.gnome.org/extension/6109/noannoyance-fork/ and enable the extension.
LOGOUT=true

#|reset|gnome-shell-extension-no-annoyance|*|GNOME disable 'Window is ready'
if grep -q debian /etc/os-release && gnome-extensions info noannoyance-fork@vrba.dev; then gnome-extensions disable noannoyance-fork@vrba.dev; fi
# For Red Hat and Red Hat-based systems go to https://extensions.gnome.org/extension/6109/noannoyance-fork/ and disable the extension.
LOGOUT=true

#|setup|gnome-shell-extension-no-overview|*|GNOME no overview at start-up
if gsettings get org.gnome.shell disable-user-extensions; then gsettings set org.gnome.shell disable-user-extensions false; fi
if grep -q debian /etc/os-release && gnome-extensions info no-overview@fthx; then gnome-extensions enable no-overview@fthx; fi
# For Red Hat and Red Hat-based systems go to https://extensions.gnome.org/extension/4099/no-overview/ and enable the extension.
LOGOUT=true

#|reset|gnome-shell-extension-no-overview|*|GNOME no overview at start-up
# This app is included in dash-to-dock-extension on Debian and Debian-based systems.
if grep -q debian /etc/os-release && gnome-extensions info no-overview@fthx; then gnome-extensions disable no-overview@fthx; fi
# For Red Hat and Red Hat-based systems go to https://extensions.gnome.org/extension/4099/no-overview/ and disable the extension.
LOGOUT=true

#|setup|gnome-shell-extensions-visual-effects|pc06 pc07|GNOME visual effects
# -----------------------------------------------------------------------------
# This setup includes:
# Compiz alike magic lamp effect    https://extensions.gnome.org/extension/3740/compiz-alike-magic-lamp-effect/
# Compiz windows effect             https://extensions.gnome.org/extension/3210/compiz-windows-effect/
# Coverflow Alt-Tab                 https://extensions.gnome.org/extension/97/coverflow-alt-tab/
# Customize Clock on Lock Screen    https://extensions.gnome.org/extension/4663/customize-clock-on-lock-screen/
# Desktop Cube                      https://extensions.gnome.org/extension/4648/desktop-cube/
# -----------------------------------------------------------------------------
if type gnome-session; then pipx install gnome-extensions-cli --system-site-packages && pipx ensurepath && ~/.local/bin/gext install 'compiz-alike-magic-lamp-effect@hermes83.github.com' 'compiz-windows-effect@hermes83.github.com' 'CoverflowAltTab@palatis.blogspot.com' 'CustomizeClockOnLockScreen@pratap.fastmail.fm' 'desktop-cube@schneegans.github.com' && ~/.local/bin/gext enable 'compiz-alike-magic-lamp-effect@hermes83.github.com' 'compiz-windows-effect@hermes83.github.com' 'CoverflowAltTab@palatis.blogspot.com' 'CustomizeClockOnLockScreen@pratap.fastmail.fm' 'desktop-cube@schneegans.github.com'; fi

#|reset|gnome-shell-extensions-visual-effects|pc06 pc07|GNOME visual effects
if type gnome-session; then ~/.local/bin/gext disable 'compiz-alike-magic-lamp-effect@hermes83.github.com' 'compiz-windows-effect@hermes83.github.com' 'CoverflowAltTab@palatis.blogspot.com' 'CustomizeClockOnLockScreen@pratap.fastmail.fm' 'desktop-cube@schneegans.github.com' && ~/.local/bin/gext uninstall 'compiz-alike-magic-lamp-effect@hermes83.github.com' 'compiz-windows-effect@hermes83.github.com' 'CoverflowAltTab@palatis.blogspot.com' 'CustomizeClockOnLockScreen@pratap.fastmail.fm' 'desktop-cube@schneegans.github.com'; fi

#|setup|google-chrome|pc01 pc06 pc07|Browser
kz-desktop --addbef=google-chrome

#|reset|google-chrome|pc01 pc06 pc07|Browser
kz-desktop --delete=google-chrome

#|setup|kvm|pc06 pc07|Virtualization
kz-desktop --addaft=virt-manager

#|reset|kvm|pc06 pc07|Virtualization
kz-desktop --delete=virt-manager

#|setup|libreoffice|#none|Office suite
kz-desktop --addaft=libreoffice-writer && kz-desktop --addaft=org.libreoffice.LibreOffice.writer

#|reset|libreoffice|#none|Office suite
kz-desktop --delete=libreoffice-writer && kz-desktop --delete=org.libreoffice.LibreOffice.writer

#|setup|lynis|#none|Security auditing & hardening
git clone https://github.com/CISOfy/lynis.git "$HOME/lynis"
# -----------------------------------------------------------------------------
# Usage:
# $ cd ~/lynis
# $ [sudo] ./lynis audit system
# -----------------------------------------------------------------------------

#|reset|lynis|#none|Security auditing & hardening
rm --force --recursive "$HOME/lynis"

#|setup|microsoft-edge|pc06 pc07|Browser
kz-desktop --addaft=microsoft-edge

#|reset|microsoft-edge|pc06 pc07|Browser
kz-desktop --delete=microsoft-edge

#|setup|private-home|*|Private home
chmod 750 ~

#|reset|private-home|*|Private home
chmod 755 ~

#|setup|spotify|pc01 pc06 pc07|Streaming music
# -----------------------------------------------------------------------------
# Web app: https://open.spotify.com
# -----------------------------------------------------------------------------
if grep -q debian /etc/os-release; then kz-desktop --addaft=spotify; fi
if grep -qE 'fedora|rhel' /etc/os-release; then kz-desktop --addaft=kz-spotify; fi

#|reset|spotify|pc01 pc06 pc07|Streaming music
if grep -q debian /etc/os-release; then kz-desktop --delete=spotify; fi
if grep -qE 'fedora|rhel' /etc/os-release; then kz-desktop --delete=kz-spotify; fi

#|setup|terminal|pc01 pc06 pc07|Terminal
# -----------------------------------------------------------------------------
# Enable aliases & enable search forward in history (with Ctrl-S).
# -----------------------------------------------------------------------------
sed -i 's/#alias/alias/g; s/# alias/alias/g; s/# export/export/g; s/# eval/eval/g' ~/.bashrc && sed --in-place '/^stty -ixon/d' ~/.bashrc && echo 'stty -ixon # Enable fwd search history (i-search)' >> ~/.bashrc
LOGOUT=true

#|reset|terminal|pc01 pc06 pc07|Terminal
# -----------------------------------------------------------------------------
# Disable aliases.
# -----------------------------------------------------------------------------
sed -i 's/^alias/#alias/g; s/^export/#export/g; s/^eval/#eval/g' ~/.bashrc
# -----------------------------------------------------------------------------
# Disable search forward in history (with Ctrl-S).
# -----------------------------------------------------------------------------
sed -i '/^stty -ixon/d' ~/.bashrc
LOGOUT=true

#|setup|terminal|pc06 pc07|Terminal
sed -i '/^alias bin/d; /^alias docs/d' ~/.bashrc && echo -e "alias bin='cd $(xdg-user-dir PROJECTS)/kz-scripts/usr/bin'\nalias docs='cd $(xdg-user-dir PROJECTS)/kz-docs'" >> ~/.bashrc && kz-desktop --addbef=org.gnome.Terminal

#|reset|terminal|pc06 pc07|Terminal
sed -i '/^alias bin/d; /^alias docs/d' ~/.bashrc && kz-desktop --delete=org.gnome.Terminal

#|setup|thumbnails-cache|#none|Restore thumbnails
rm --force --recursive ~/.cache/thumbnails/

#|reset|thumbnails-cache|#none|Restore thumbnails
rm --force --recursive ~/.cache/thumbnails/

#|setup|thunderbird|#none|Email & agenda
kz-desktop --addbef=thunderbird

#|reset|thunderbird|#none|Email & agenda
kz-desktop --delete=thunderbird

#|setup|vscode|pc06 pc07|Code editor
# -----------------------------------------------------------------------------
# Web app: https://vscode.dev
# -----------------------------------------------------------------------------
if type xdg-mime; then xdg-mime default code.desktop application/json && xdg-mime default code.desktop application/x-desktop && xdg-mime default code.desktop application/x-shellscript && xdg-mime default code.desktop application/xml && xdg-mime default code.desktop text/html && xdg-mime default code.desktop text/markdown && xdg-mime default code.desktop text/plain && xdg-mime default code.desktop text/troff && xdg-mime default code.desktop text/x-python; fi && kz-desktop --addbef=code

#|reset|vscode|pc06 pc07|Code editor
kz-desktop --delete=code

#|setup|webmin|pc07|Manage servers
# -----------------------------------------------------------------------------
# Web app: https://localhost:10000
# -----------------------------------------------------------------------------
kz-desktop --addaft=kz-webmin

#|reset|webmin|pc07|Manage servers
kz-desktop --delete=kz-webmin

#|setup|xdg-projects-dir|pc06 pc07|Add XDG_PROJECTS_DIR
# -----------------------------------------------------------------------------
# This app is not required when "apt-cache show xdg-user-dirs" shows version 0.20 or higher.
# -----------------------------------------------------------------------------
if [[ ${LANG:0:2} = 'nl' ]]; then mkdir --parents --verbose ~/Projecten && xdg-user-dirs-update --set PROJECTS ~/Projecten && xdg-user-dirs-update; fi
if [[ ${LANG:0:2} = 'en' ]]; then mkdir --parents --verbose ~/Projects && xdg-user-dirs-update --set PROJECTS ~/Projects && xdg-user-dirs-update; fi

#|reset|xdg-projects-dir|pc06 pc07|Add XDG_PROJECTS_DIR
xdg-user-dirs-update --set PROJECTS ~ && xdg-user-dirs-update

#|setup|zoom|pc01|Video call
kz-desktop --addaft=kz-zoom

#|reset|zoom|pc01|Video call
kz-desktop --delete=kz-zoom
