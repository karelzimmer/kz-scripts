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

# SETUP calibre pc06
# -----------------------------------------------------------------------------
# E-book manager.
# -----------------------------------------------------------------------------
kz-desktop --addaft=calibre-gui

# RESET calibre pc06
# -----------------------------------------------------------------------------
# E-book manager.
# -----------------------------------------------------------------------------
kz-desktop --delete=calibre-gui

# SETUP cinnamon-settings #none
# -----------------------------------------------------------------------------
#  Desktop environment.
# -----------------------------------------------------------------------------
if gsettings get org.nemo.preferences click-policy &> /dev/null; then gsettings set org.nemo.preferences click-policy 'single'; fi

# RESET cinnamon-settings #none
# -----------------------------------------------------------------------------
#  Desktop environment.
# -----------------------------------------------------------------------------
if gsettings get org.nemo.preferences click-policy &> /dev/null; then gsettings reset org.nemo.preferences click-policy; fi

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
# Desktop dock like Ubuntu's dash.
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && gnome-extensions info dash-to-dock@micxgx.gmail.com)                          &> /dev/null; then gnome-extensions enable dash-to-dock@micxgx.gmail.com; fi
if (grep rhel   /etc/os-release && gnome-extensions info dash-to-dock@gnome-shell-extensions.gcampax.github.com) &> /dev/null; then gnome-extensions enable dash-to-dock@gnome-shell-extensions.gcampax.github.com; fi
if (grep rhel   /etc/os-release && gnome-extensions info dash-to-dock@micxgx.gmail.com)                          &> /dev/null; then gnome-extensions enable dash-to-dock@micxgx.gmail.com; fi
if (grep rhel   /etc/os-release && gnome-extensions info no-overview@fthx)                                       &> /dev/null; then gnome-extensions enable no-overview@fthx; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock apply-custom-theme                                      &> /dev/null; then gsettings set org.gnome.shell.extensions.dash-to-dock apply-custom-theme true; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock click-action                                            &> /dev/null; then gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize-or-previews'; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock dash-max-icon-size                                      &> /dev/null; then gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 32; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock disable-overview-on-startup                             &> /dev/null; then gsettings set org.gnome.shell.extensions.dash-to-dock disable-overview-on-startup true; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock dock-fixed                                              &> /dev/null; then gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed true; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock dock-position                                           &> /dev/null; then gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'LEFT'; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock extend-height                                           &> /dev/null; then gsettings set org.gnome.shell.extensions.dash-to-dock extend-height true; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock icon-size-fixed                                         &> /dev/null; then gsettings set org.gnome.shell.extensions.dash-to-dock icon-size-fixed true; fi
if gsettings get org.gnome.shell disable-user-extensions &> /dev/null; then gsettings set org.gnome.shell disable-user-extensions false; fi

# RESET dash-to-dock *
# -----------------------------------------------------------------------------
# Desktop dock like Ubuntu's dash.
# -----------------------------------------------------------------------------
if gsettings get org.gnome.shell disable-user-extensions                                                         &> /dev/null; then gsettings reset org.gnome.shell disable-user-extensions; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock apply-custom-theme                                      &> /dev/null; then gsettings reset org.gnome.shell.extensions.dash-to-dock apply-custom-theme; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock click-action                                            &> /dev/null; then gsettings reset org.gnome.shell.extensions.dash-to-dock click-action; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock dash-max-icon-size                                      &> /dev/null; then gsettings reset org.gnome.shell.extensions.dash-to-dock dash-max-icon-size; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock disable-overview-on-startup                             &> /dev/null; then gsettings reset org.gnome.shell.extensions.dash-to-dock disable-overview-on-startup; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock dock-fixed                                              &> /dev/null; then gsettings reset org.gnome.shell.extensions.dash-to-dock dock-fixed; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock dock-position                                           &> /dev/null; then gsettings reset org.gnome.shell.extensions.dash-to-dock dock-position; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock extend-height                                           &> /dev/null; then gsettings reset org.gnome.shell.extensions.dash-to-dock extend-height; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock icon-size-fixed                                         &> /dev/null; then gsettings reset org.gnome.shell.extensions.dash-to-dock icon-size-fixed; fi
if (grep debian /etc/os-release && gnome-extensions info dash-to-dock@micxgx.gmail.com)                          &> /dev/null; then gnome-extensions disable dash-to-dock@micxgx.gmail.com; fi
if (grep rhel   /etc/os-release && gnome-extensions info no-overview@fthx)                                       &> /dev/null; then gnome-extensions disable no-overview@fthx; fi
if (grep rhel   /etc/os-release && gnome-extensions info dash-to-dock@gnome-shell-extensions.gcampax.github.com) &> /dev/null; then gnome-extensions disable dash-to-dock@gnome-shell-extensions.gcampax.github.com; fi
if (grep rhel   /etc/os-release && gnome-extensions info dash-to-dock@micxgx.gmail.com)                          &> /dev/null; then gnome-extensions disable dash-to-dock@micxgx.gmail.com; fi

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
if gsettings get org.gnome.desktop.calendar show-weekdate                            &> /dev/null; then gsettings set org.gnome.desktop.calendar show-weekdate true; fi
if gsettings get org.gnome.desktop.interface clock-show-date                         &> /dev/null; then gsettings set org.gnome.desktop.interface clock-show-date true; fi
if gsettings get org.gnome.desktop.interface clock-show-weekday                      &> /dev/null; then gsettings set org.gnome.desktop.interface clock-show-weekday true; fi
if gsettings get org.gnome.desktop.interface show-battery-percentage                 &> /dev/null; then gsettings set org.gnome.desktop.interface show-battery-percentage true; fi
if gsettings get org.gnome.desktop.peripherals.touchpad tap-to-click                 &> /dev/null; then gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true; fi
if gsettings get org.gnome.desktop.screensaver lock-enabled                          &> /dev/null; then gsettings set org.gnome.desktop.screensaver lock-enabled false; fi
if gsettings get org.gnome.desktop.session idle-delay                                &> /dev/null; then gsettings set org.gnome.desktop.session idle-delay 900; fi
if gsettings get org.gnome.desktop.sound allow-volume-above-100-percent              &> /dev/null; then gsettings set org.gnome.desktop.sound allow-volume-above-100-percent true; fi
if gsettings get org.gnome.desktop.wm.preferences button-layout                      &> /dev/null; then gsettings set org.gnome.desktop.wm.preferences button-layout ':minimize,maximize,close'; fi
if gsettings get org.gnome.mutter center-new-windows                                 &> /dev/null; then gsettings set org.gnome.mutter center-new-windows true; fi
if gsettings get org.gnome.nautilus.icon-view default-zoom-level                     &> /dev/null; then gsettings set org.gnome.nautilus.icon-view default-zoom-level large; fi
if gsettings get org.gnome.nautilus.preferences click-policy                         &> /dev/null; then gsettings set org.gnome.nautilus.preferences click-policy 'single'; fi
if gsettings get org.gnome.nautilus.preferences open-folder-on-dnd-hover             &> /dev/null; then gsettings set org.gnome.nautilus.preferences open-folder-on-dnd-hover true; fi
if gsettings get org.gnome.nautilus.preferences show-create-link                     &> /dev/null; then gsettings set org.gnome.nautilus.preferences show-create-link true; fi
if gsettings get org.gnome.nautilus.preferences show-image-thumbnails                &> /dev/null; then gsettings set org.gnome.nautilus.preferences show-image-thumbnails 'always'; fi
if gsettings get org.gnome.settings-daemon.plugins.power power-button-action         &> /dev/null; then gsettings set org.gnome.settings-daemon.plugins.power power-button-action interactive; fi
if gsettings get org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type      &> /dev/null; then gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type nothing; fi
if gsettings get org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type &> /dev/null; then gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type nothing; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock show-mounts                 &> /dev/null; then gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts true; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock show-mounts-network         &> /dev/null; then gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts-network false; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock show-mounts-only-mounted    &> /dev/null; then gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts-only-mounted true; fi
if gsettings get org.gnome.shell.extensions.dash-to-dock show-trash                  &> /dev/null; then gsettings set org.gnome.shell.extensions.dash-to-dock show-trash false; fi
if gsettings get org.gnome.shell.extensions.ding show-home                           &> /dev/null; then gsettings set org.gnome.shell.extensions.ding show-home false; fi
if gsettings get org.gnome.desktop.input-sources sources                             &> /dev/null; then gsettings set org.gnome.desktop.input-sources sources "$(gsettings get org.gnome.desktop.input-sources sources | sed "s/, ('ibus', 'mozc-jp')//")"; fi
if gsettings get org.gnome.desktop.input-sources sources                             &> /dev/null; then gsettings set org.gnome.desktop.input-sources sources "$(gsettings get org.gnome.desktop.input-sources sources | sed "s/('ibus', 'mozc-jp'), //")"; fi
# -----------------------------------------------------------------------------
# Terminal emulator.
# -----------------------------------------------------------------------------
# Enable aliases.
# -----------------------------------------------------------------------------
sed --in-place 's/#alias/alias/g'    ~/.bashrc
sed --in-place 's/# alias/alias/g'   ~/.bashrc
sed --in-place 's/# export/export/g' ~/.bashrc
sed --in-place 's/# eval/eval/g'     ~/.bashrc
# -----------------------------------------------------------------------------
# Enable search forward in history (with Ctrl-S).
# -----------------------------------------------------------------------------
sed --in-place '/^stty -ixon/d' ~/.bashrc
echo 'stty -ixon # Enable fwd search history (i-search)' >> ~/.bashrc

# RESET gnome-settings *
# -----------------------------------------------------------------------------
#  Desktop environment.
# -----------------------------------------------------------------------------
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
if gsettings set org.gnome.desktop.input-sources sources                             &> /dev/null; then gsettings reset org.gnome.desktop.input-sources sources; fi
# -----------------------------------------------------------------------------
# Terminal emulator.
# -----------------------------------------------------------------------------
sed --in-place 's/alias/#alias/g'   ~/.bashrc
sed --in-place 's/export/#export/g' ~/.bashrc
sed --in-place 's/eval/#eval/g'     ~/.bashrc
sed --in-place '/^stty -ixon/d'     ~/.bashrc

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

# SETUP handbrake #gpg
# -----------------------------------------------------------------------------
# Video-dvd ripper and transcoder.
# -----------------------------------------------------------------------------
kz-desktop --addaft=fr.handbrake.ghb

# RESET handbrake #gpg
# -----------------------------------------------------------------------------
# Video-dvd ripper and transcoder.
# -----------------------------------------------------------------------------
kz-desktop --delete=fr.handbrake.ghb

# SETUP kde-settings #none
# -----------------------------------------------------------------------------
# Desktop environment.
# -----------------------------------------------------------------------------
if type ksmserver &> /dev/null && ! grep --quiet '\[KDE\]' ~/.config/kdeglobals; then echo -e '\n[KDE]' >> ~/.config/kdeglobals; fi
if type ksmserver &> /dev/null && ! grep --quiet 'SingleClick=true' ~/.config/kdeglobals; then sed --in-place '/[KDE]/aSingleClick=true' ~/.config/kdeglobals; fi

# RESET kde-settings #none
# -----------------------------------------------------------------------------
# Desktop environment.
# -----------------------------------------------------------------------------
if type ksmserver &> /dev/null; then sed --in-place '/SingleClick=true/d' ~/.config/kdeglobals; fi

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

# SETUP lxqt-settings #none
# -----------------------------------------------------------------------------
#  Desktop environment.
# -----------------------------------------------------------------------------
if type lxqt-session &> /dev/null; then sed --in-place 's/Alt%2BF1/Super_L/g'                                     ~/.config/lxqt/globalkeyshortcuts.conf; fi
if type lxqt-session &> /dev/null; then sed --in-place '/single_click_activate=.*$/d'                             ~/.config/lxqt/lxqt.conf; fi
if type lxqt-session &> /dev/null; then sed --in-place '/__userfile__=true/asingle_click_activate=true'           ~/.config/lxqt/lxqt.conf; fi
if type lxqt-session &> /dev/null; then sed --in-place 's/single_click_activate=.*$/single_click_activate=true/g' ~/.config/lxqt/lxqt.conf; fi
if type lxqt-session &> /dev/null; then sed --in-place 's/categoriesAtRight=.*$/categoriesAtRight=false/g'        ~/.config/lxqt/panel.conf; fi

# RESET lxqt-settings #none
# -----------------------------------------------------------------------------
# Desktop environment.
# -----------------------------------------------------------------------------
if type lxqt-session &> /dev/null; then sed --in-place 's/Super_L/Alt%2BF1/g'                             ~/.config/lxqt/globalkeyshortcuts.conf; fi
if type lxqt-session &> /dev/null; then sed --in-place '/single_click_activate=.*$/d'                     ~/.config/lxqt/lxqt.conf; fi
if type lxqt-session &> /dev/null; then sed --in-place 's/categoriesAtRight=.*$/categoriesAtRight=true/g' ~/.config/lxqt/panel.conf; fi

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

# SETUP sound-juicer #gpg
# -----------------------------------------------------------------------------
# Audio-cd ripper and player.
# -----------------------------------------------------------------------------
kz-desktop --addaft=org.gnome.SoundJuicer

# RESET sound-juicer #gpg
# -----------------------------------------------------------------------------
# Audio-cd ripper and player.
# -----------------------------------------------------------------------------
kz-desktop --delete=org.gnome.SoundJuicer

# SETUP spotify pc01 pc02 pc06 pc07
# -----------------------------------------------------------------------------
# Music and podcasts.
# -----------------------------------------------------------------------------
# Web app: https://open.spotify.com
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then kz-desktop --addaft=spotify; fi
if grep --quiet rhel   /etc/os-release; then kz-desktop --addaft=kz-spotify; fi

# RESET spotify pc01 pc02 pc06 pc07
# -----------------------------------------------------------------------------
# Music and podcasts.
# -----------------------------------------------------------------------------
# Web app: https://open.spotify.com
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then kz-desktop --delete=spotify; fi
if grep --quiet rhel   /etc/os-release; then kz-desktop --delete=kz-spotify; fi

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

# SETUP virtualbox #gpg
# -----------------------------------------------------------------------------
# Virtualization.
# -----------------------------------------------------------------------------
kz-desktop --addaft=virtualbox
kz-desktop --addaft=kz-vm-hugowin732

# RESET virtualbox #gpg
# -----------------------------------------------------------------------------
# Virtualization.
# -----------------------------------------------------------------------------
kz-desktop --delete=virtualbox
kz-desktop --delete=kz-vm-hugowin732

# SETUP vscode pc06 pc07
# -----------------------------------------------------------------------------
# Editor.
# -----------------------------------------------------------------------------
# Web app: https://vscode.dev
# -----------------------------------------------------------------------------
kz-desktop --addbef=code
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

# SETUP whatsapp #gpg
# -----------------------------------------------------------------------------
# Instant messaging (IM) and voice-over-IP (VoIP).
# -----------------------------------------------------------------------------
kz-desktop --addaft=kz-whatsapp

# RESET whatsapp #gpg
# -----------------------------------------------------------------------------
# Instant messaging (IM) and voice-over-IP (VoIP).
# -----------------------------------------------------------------------------
kz-desktop --delete=kz-whatsapp

# SETUP youtube-dl #gpg
# -----------------------------------------------------------------------------
# Download videos.
# -----------------------------------------------------------------------------
kz-desktop --addaft=youtubedl-gui

# RESET youtube-dl #gpg
# -----------------------------------------------------------------------------
# Download videos.
# -----------------------------------------------------------------------------
kz-desktop --delete=youtubedl-gui

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
