# shellcheck shell=bash
###############################################################################
# SPDX-FileComment: Setup file for use with kz-setup script
#
# SPDX-FileCopyrightText: Karel Zimmer <info@karelzimmer.nl>
# SPDX-License-Identifier: CC0-1.0
###############################################################################
# Use "source kz_common.sh" before manually run a command line.
# Use "man kz setup.sh" to learn more about the format of this file.

# The apps are in alphabetical order of app name.

# Setup anydesk on pc06 pc07
# Remote desktop.
# Web app: https://my.anydesk.com/v2
if $GUI ; then kz-desktop --addaft=anydesk ; fi

# Reset anydesk on pc06 pc07
# Remote desktop.
# Web app: https://my.anydesk.com/v2
if $GUI ; then kz-desktop --delete=anydesk ; fi


# Setup calibre on pc06 pc-van-hugo
# E-book manager.
if $GUI ; then kz-desktop --addaft=calibre-gui ; fi

# Reset calibre on pc06 pc-van-hugo
# E-book manager.
if $GUI ; then kz-desktop --delete=calibre-gui ; fi


# Setup cockpit on pc06
# Web console.
# Web app: https://localhost:9090
if $GUI ; then kz-desktop --addaft=kz-cockpit ; fi

# Reset cockpit on pc06
# Web console.
# Web app: https://localhost:9090
if $GUI ; then kz-desktop --delete=kz-cockpit ; fi


# Setup dash-to-dock on pc07
# Desktop dock.
# Additional testing is needed because Ubuntu provides
# gnome-shell-extension-dashtodock as a virtual package
# which has been replaced by gnome-shell-extension-ubuntu-dock.
if $GUI && $APT && gsettings list-keys org.gnome.shell.extensions.dash-to-dock &> /dev/null && ! [[ $(uname --kernel-version) =~ 'Ubuntu' ]] ; then gnome-extensions enable dash-to-dock@micxgx.gmail.com ; fi
if $GUI && $APT && gsettings list-keys org.gnome.shell.extensions.dash-to-dock &> /dev/null ; then gsettings set org.gnome.shell.extensions.dash-to-dock disable-overview-on-startup true ; fi

if $GUI && $RPM ; then gnome-extensions enable dash-to-dock@gnome-shell-extensions.gcampax.github.com ; fi
if $GUI && $RPM ; then gnome-extensions enable no-overview@fthx ; fi

if $GUI && gsettings list-keys org.gnome.shell &> /dev/null ; then gsettings set org.gnome.shell disable-user-extensions false ; fi
if $GUI && gsettings list-keys org.gnome.shell.extensions.dash-to-dock &> /dev/null ; then gsettings set org.gnome.shell.extensions.dash-to-dock apply-custom-theme true ; fi
if $GUI && gsettings list-keys org.gnome.shell.extensions.dash-to-dock &> /dev/null ; then gsettings set org.gnome.shell.extensions.dash-to-dock click-action minimize-or-previews ; fi
if $GUI && gsettings list-keys org.gnome.shell.extensions.dash-to-dock &> /dev/null ; then gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 32 ; fi
if $GUI && gsettings list-keys org.gnome.shell.extensions.dash-to-dock &> /dev/null ; then gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed true ; fi
if $GUI && gsettings list-keys org.gnome.shell.extensions.dash-to-dock &> /dev/null ; then gsettings set org.gnome.shell.extensions.dash-to-dock dock-position LEFT ; fi
if $GUI && gsettings list-keys org.gnome.shell.extensions.dash-to-dock &> /dev/null ; then gsettings set org.gnome.shell.extensions.dash-to-dock extend-height true ; fi
if $GUI && gsettings list-keys org.gnome.shell.extensions.dash-to-dock &> /dev/null ; then gsettings set org.gnome.shell.extensions.dash-to-dock icon-size-fixed true ; fi

# Reset dash-to-dock on pc07
# Desktop dock.
# Additional testing is needed because Ubuntu provides
# gnome-shell-extension-dashtodock as a virtual package
# which has been replaced by gnome-shell-extension-ubuntu-dock.
if $GUI && $APT && gsettings list-keys org.gnome.shell.extensions.dash-to-dock &> /dev/null && ! [[ $(uname --kernel-version) =~ 'Ubuntu' ]] ; then gnome-extensions disable dash-to-dock@micxgx.gmail.com ; fi
if $GUI && $APT && gsettings list-keys org.gnome.shell.extensions.dash-to-dock &> /dev/null ; then gsettings reset org.gnome.shell.extensions.dash-to-dock disable-overview-on-startup  ; fi

if $GUI && $RPM ; then gnome-extensions disable dash-to-dock@gnome-shell-extensions.gcampax.github.com ; fi
if $GUI && $RPM ; then echo 'Goto https://extensions.gnome.org/extension/4099/no-overview/, install, and switch OFF' ; fi

if $GUI && gsettings list-keys org.gnome.shell &> /dev/null ; then gsettings reset org.gnome.shell disable-user-extensions ; fi
if $GUI && gsettings list-keys org.gnome.shell.extensions.dash-to-dock &> /dev/null ; then gsettings reset org.gnome.shell.extensions.dash-to-dock apply-custom-theme ; fi
if $GUI && gsettings list-keys org.gnome.shell.extensions.dash-to-dock &> /dev/null ; then gsettings reset org.gnome.shell.extensions.dash-to-dock click-action ; fi
if $GUI && gsettings list-keys org.gnome.shell.extensions.dash-to-dock &> /dev/null ; then gsettings reset org.gnome.shell.extensions.dash-to-dock dash-max-icon-size ; fi
if $GUI && gsettings list-keys org.gnome.shell.extensions.dash-to-dock &> /dev/null ; then gsettings reset org.gnome.shell.extensions.dash-to-dock dock-fixed ; fi
if $GUI && gsettings list-keys org.gnome.shell.extensions.dash-to-dock &> /dev/null ; then gsettings reset org.gnome.shell.extensions.dash-to-dock dock-position ; fi
if $GUI && gsettings list-keys org.gnome.shell.extensions.dash-to-dock &> /dev/null ; then gsettings reset org.gnome.shell.extensions.dash-to-dock extend-height ; fi
if $GUI && gsettings list-keys org.gnome.shell.extensions.dash-to-dock &> /dev/null ; then gsettings reset org.gnome.shell.extensions.dash-to-dock icon-size-fixed ; fi


# Setup evolution on pc07
# E-mail and organizer.
if $GUI ; then kz-desktop --delete=org.gnome.Evolution ; fi

# Reset evolution on pc07
# E-mail and organizer.
if $GUI ; then kz-desktop --addbef=org.gnome.Evolution ; fi


# Setup firefox on pc01 pc02 pc06 pc07 pc-van-emily
# Web browser.
if $GUI ; then kz-desktop --delete=firefox ; fi
if $GUI ; then kz-desktop --delete=firefox-esr ; fi
if $GUI ; then kz-desktop --delete=firefox_firefox ; fi

# Reset firefox on pc01 pc02 pc06 pc07 pc-van-emily
# Web browser.
if $GUI ; then kz-desktop --addbef=firefox ; fi
if $GUI ; then kz-desktop --addbef=firefox-esr ; fi
if $GUI ; then kz-desktop --addbef=firefox_firefox ; fi


# Setup gdebi on *
# View and install deb files.
if $GUI && $APT ; then xdg-mime default gdebi.desktop application/vnd.debian.binary-package ; fi
if $GUI && $RPM ; then echo 'App gdebi is not available.' ; fi

# Reset gdebi on *
# View and install deb files.
if $GUI ; then echo 'App gdebi cannot be reset.' ; fi


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
if $GUI && gsettings list-keys org.gnome.desktop.calendar &> /dev/null ; then gsettings set org.gnome.desktop.calendar show-weekdate true ; fi
if $GUI && gsettings list-keys org.gnome.desktop.interface &> /dev/null ; then gsettings set org.gnome.desktop.interface clock-show-date true ; fi
if $GUI && gsettings list-keys org.gnome.desktop.interface &> /dev/null ; then gsettings set org.gnome.desktop.interface clock-show-weekday true ; fi
if $GUI && gsettings list-keys org.gnome.desktop.interface &> /dev/null ; then gsettings set org.gnome.desktop.interface show-battery-percentage true ; fi
if $GUI && gsettings list-keys org.gnome.desktop.peripherals.touchpad &> /dev/null ; then gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true ; fi
if $GUI && gsettings list-keys org.gnome.desktop.screensaver &> /dev/null ; then gsettings set org.gnome.desktop.screensaver lock-enabled false ; fi
if $GUI && gsettings list-keys org.gnome.desktop.session &> /dev/null ; then gsettings set org.gnome.desktop.session idle-delay 900 ; fi
if $GUI && gsettings list-keys org.gnome.desktop.sound &> /dev/null ; then gsettings set org.gnome.desktop.sound allow-volume-above-100-percent true ; fi
if $GUI && gsettings list-keys org.gnome.desktop.wm.preferences &> /dev/null ; then gsettings set org.gnome.desktop.wm.preferences button-layout :minimize,maximize,close ; fi
if $GUI && gsettings list-keys org.gnome.mutter &> /dev/null ; then gsettings set org.gnome.mutter center-new-windows true ; fi
if $GUI && gsettings list-keys org.gnome.nautilus.icon-view &> /dev/null ; then gsettings set org.gnome.nautilus.icon-view default-zoom-level large ; fi
if $GUI && gsettings list-keys org.gnome.nautilus.preferences &> /dev/null ; then gsettings set org.gnome.nautilus.preferences click-policy single ; fi
if $GUI && gsettings list-keys org.gnome.nautilus.preferences &> /dev/null ; then gsettings set org.gnome.nautilus.preferences open-folder-on-dnd-hover true ; fi
if $GUI && gsettings list-keys org.gnome.nautilus.preferences &> /dev/null ; then gsettings set org.gnome.nautilus.preferences show-create-link true ; fi
if $GUI && gsettings list-keys org.gnome.nautilus.preferences &> /dev/null ; then gsettings set org.gnome.nautilus.preferences show-image-thumbnails always ; fi
if $GUI && gsettings list-keys org.gnome.settings-daemon.plugins.power &> /dev/null ; then gsettings set org.gnome.settings-daemon.plugins.power power-button-action interactive ; fi
if $GUI && gsettings list-keys org.gnome.settings-daemon.plugins.power &> /dev/null ; then gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type nothing ; fi
if $GUI && gsettings list-keys org.gnome.settings-daemon.plugins.power &> /dev/null ; then gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type nothing ; fi

# Reset gnome on *
# Desktop environment.
if $GUI && gsettings list-keys org.gnome.desktop.calendar &> /dev/null ; then gsettings reset org.gnome.desktop.calendar show-weekdate ; fi
if $GUI && gsettings list-keys org.gnome.desktop.interface &> /dev/null ; then gsettings reset org.gnome.desktop.interface clock-show-date ; fi
if $GUI && gsettings list-keys org.gnome.desktop.interface &> /dev/null ; then gsettings reset org.gnome.desktop.interface clock-show-weekday ; fi
if $GUI && gsettings list-keys org.gnome.desktop.interface &> /dev/null ; then gsettings reset org.gnome.desktop.interface show-battery-percentage ; fi
if $GUI && gsettings list-keys org.gnome.desktop.peripherals.touchpad &> /dev/null ; then gsettings reset org.gnome.desktop.peripherals.touchpad tap-to-click ; fi
if $GUI && gsettings list-keys org.gnome.desktop.screensaver &> /dev/null ; then gsettings reset org.gnome.desktop.screensaver lock-enabled ; fi
if $GUI && gsettings list-keys org.gnome.desktop.session &> /dev/null ; then gsettings reset org.gnome.desktop.session idle-delay ; fi
if $GUI && gsettings list-keys org.gnome.desktop.sound &> /dev/null ; then gsettings reset org.gnome.desktop.sound allow-volume-above-100-percent ; fi
if $GUI && gsettings list-keys org.gnome.desktop.wm.preferences &> /dev/null ; then gsettings reset org.gnome.desktop.wm.preferences button-layout ; fi
if $GUI && gsettings list-keys org.gnome.mutter &> /dev/null ; then gsettings reset org.gnome.mutter center-new-windows ; fi
if $GUI && gsettings list-keys org.gnome.nautilus.icon-view &> /dev/null ; then gsettings reset org.gnome.nautilus.icon-view default-zoom-level ; fi
if $GUI && gsettings list-keys org.gnome.nautilus.preferences &> /dev/null ; then gsettings reset org.gnome.nautilus.preferences click-policy ; fi
if $GUI && gsettings list-keys org.gnome.nautilus.preferences &> /dev/null ; then gsettings reset org.gnome.nautilus.preferences open-folder-on-dnd-hover ; fi
if $GUI && gsettings list-keys org.gnome.nautilus.preferences &> /dev/null ; then gsettings reset org.gnome.nautilus.preferences show-create-link ; fi
if $GUI && gsettings list-keys org.gnome.nautilus.preferences &> /dev/null ; then gsettings reset org.gnome.nautilus.preferences show-image-thumbnails ; fi
if $GUI && gsettings list-keys org.gnome.settings-daemon.plugins.power &> /dev/null ; then gsettings reset org.gnome.settings-daemon.plugins.power power-button-action ; fi
if $GUI && gsettings list-keys org.gnome.settings-daemon.plugins.power &> /dev/null ; then gsettings reset org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type ; fi
if $GUI && gsettings list-keys org.gnome.settings-daemon.plugins.power &> /dev/null ; then gsettings reset org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type ; fi


# Setup google-chrome on *
# Web browser.
if $GUI ; then kz-desktop --addbef=google-chrome ; fi
if $GUI ; then xdg-mime default google-chrome.desktop application/pdf ; fi

# Reset google-chrome on *
# Web browser.
if $GUI ; then kz-desktop --delete=google-chrome ; fi


# Setup handbrake on pc-van-emily
# Video-dvd ripper and transcoder.
if $GUI ; then kz-desktop --addaft=fr.handbrake.ghb ; fi

# Reset handbrake on pc-van-emily
# Video-dvd ripper and transcoder.
if $GUI ; then kz-desktop --delete=fr.handbrake.ghb ; fi


# Setup hide-files on *
# Hide files.
if $GUI ; then echo 'snap' > ~/.hidden ; fi

# Reset hide-files on *
# Hide files.
if $GUI ; then rm --force ~/.hidden ; fi


# Setup kvm on pc06 pc07
# Kernel-based Virtual Machine.
if $GUI ; then kz-desktop --addaft=virt-manager ; fi

# Reset kvm on pc06 pc07
# Kernel-based Virtual Machine.
if $GUI ; then kz-desktop --delete=virt-manager ; fi


# Setup lynis on -none
# Security auditing.
if [[ ! -d ~/lynis ]] ; then git clone https://github.com/CISOfy/lynis ~/lynis ; fi
# Usage:
# $ cd ~/lynis
# $ [sudo] ./lynis audit system

# Reset lynis on -none
# Security auditing.
rm --force --recursive ~/lynis


# Setup restore-thumbnails on -none
# Restore thumbnails.
rm --force --recursive ~/.cache/thumbnails/

# Reset restore-thumbnails on -none
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
if $GUI ; then kz-desktop --addaft=org.gnome.SoundJuicer ; fi

# Reset sound-juicer on pc-van-emily
# Audio-cd ripper and player.
if $GUI ; then kz-desktop --delete=org.gnome.SoundJuicer ; fi


# Setup spotify on pc01 pc02 pc06 pc07
# Music and podcasts.
# Web app: https://open.spotify.com
if $GUI && $APT ; then kz-desktop --addaft=spotify ; fi
if $GUI && $RPM ; then kz-desktop --addaft=kz-spotify ; fi

# Reset spotify on pc01 pc02 pc06 pc07
# Music and podcasts.
# Web app: https://open.spotify.com
if $GUI && $APT ; then kz-desktop --delete=spotify ; fi
if $GUI && $RPM ; then kz-desktop --delete=kz-spotify ; fi


# Setup teamviewer on *
# Remote desktop.
# Web app: https://web.teamviewer.com
if $GUI ; then kz-desktop --addaft=com.teamviewer.TeamViewer ; fi

# Reset teamviewer on *
# Remote desktop.
# Web app: https://web.teamviewer.com
if $GUI ; then kz-desktop --delete=com.teamviewer.TeamViewer ; fi


# Setup terminal on pc01 pc06 pc07
# Terminal emulator.
if $GUI ; then kz-desktop --addbef=org.gnome.Terminal ; fi
# Turn on aliases.
sed --in-place --expression='s/#alias/alias/g' ~/.bashrc
# Enable search forward in history (with Ctrl-S).
sed --in-place --expression='/^stty -ixon/d' ~/.bashrc
echo 'stty -ixon  # Enable fwd search history (i-search)' >> ~/.bashrc

# Reset terminal on pc01 pc06 pc07
# Terminal emulator.
if $GUI ; then kz-desktop --delete=org.gnome.Terminal ; fi
sed --in-place --expression='s/alias/#alias/g' ~/.bashrc
sed --in-place --expression='/^stty -ixon/d' ~/.bashrc


# Setup thunderbird on pc01 pc02 pc06
# E-mail and news.
if $GUI ; then kz-desktop --delete=thunderbird ; fi
if $GUI ; then kz-desktop --delete=thunderbird_thunderbird ; fi

# Reset thunderbird on pc01 pc02 pc06
# E-mail and news.
if $GUI ; then kz-desktop --addbef=thunderbird ; fi
if $GUI ; then kz-desktop --addbef=thunderbird_thunderbird ; fi


# Setup virtualbox on pc-van-hugo
# Virtualization.
if $GUI ; then kz-desktop --addaft=virtualbox ; fi
if $GUI ; then kz-desktop --addaft=kz-vm-hugowin732 ; fi

# Reset virtualbox on pc-van-hugo
# Virtualization.
if $GUI ; then kz-desktop --delete=virtualbox ; fi
if $GUI ; then kz-desktop --delete=kz-vm-hugowin732 ; fi


# Setup vscode on pc01 pc06 pc07
# Editor.
# Web app: https://vscode.dev
if $GUI ; then kz-desktop --addbef=code ; fi
if $GUI ; then xdg-mime default code.desktop application/json ; fi
if $GUI ; then xdg-mime default code.desktop application/x-desktop ; fi
if $GUI ; then xdg-mime default code.desktop application/x-shellscript ; fi
if $GUI ; then xdg-mime default code.desktop application/xml ; fi
if $GUI ; then xdg-mime default code.desktop text/html ; fi
if $GUI ; then xdg-mime default code.desktop text/markdown ; fi
if $GUI ; then xdg-mime default code.desktop text/plain ; fi
if $GUI ; then xdg-mime default code.desktop text/troff ; fi
if $GUI ; then xdg-mime default code.desktop text/x-python ; fi

# Reset vscode on pc01 pc06 pc07
# Editor.
# Web app: https://vscode.dev
if $GUI ; then kz-desktop --delete=code ; fi


# Setup webmin on pc07
# Web console.
# Web app: https://localhost:10000
if $GUI ; then kz-desktop --addaft=kz-webmin ; fi

# Reset webmin on pc07
# Web console.
# Web app: https://localhost:10000
if $GUI ; then kz-desktop --delete=kz-webmin ; fi


# Setup whatsapp on pc-van-hugo maria-desktop
# Instant messaging (IM) and voice-over-IP (VoIP).
if $GUI ; then kz-desktop --addaft=kz-whatsapp ; fi

# Reset whatsapp on pc-van-hugo maria-desktop
# Instant messaging (IM) and voice-over-IP (VoIP).
if $GUI ; then kz-desktop --delete=kz-whatsapp ; fi


# Setup youtube-dl on pc-van-emily
# Download videos.
if $GUI ; then kz-desktop --addaft=youtubedl-gui ; fi

# Reset youtube-dl on pc-van-emily
# Download videos.
if $GUI ; then kz-desktop --delete=youtubedl-gui ; fi


# Setup zoom on pc01
# Videoconferencing.
if $GUI ; then kz-desktop --addaft=kz-zoom ; fi

# Reset zoom on pc01
# Videoconferencing.
if $GUI ; then kz-desktop --delete=kz-zoom ; fi
