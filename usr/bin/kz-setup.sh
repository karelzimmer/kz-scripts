# shellcheck shell=bash
###############################################################################
# SPDX-FileComment: Setup file for use with kz-setup script
#
# SPDX-FileCopyrightText: Karel Zimmer <info@karelzimmer.nl>
# SPDX-License-Identifier: CC0-1.0
###############################################################################
# For the format of the records in this file, see the kz setup man page.
# To manually running a command, first run the following: source kz_common.sh

# Setup anydesk for karel@pc06 karel@pc07
# Remote Wayland display server is not supported.
if $DESKTOP_ENVIRONMENT; then kz-desktop --addaft=anydesk; fi

# Reset anydesk for karel@pc06 karel@pc07
if $DESKTOP_ENVIRONMENT; then kz-desktop --delete=anydesk; fi

# Setup calibre for hugo@pc-van-hugo
if $DESKTOP_ENVIRONMENT; then kz-desktop --addaft=calibre-gui; fi

# Reset calibre for hugo@pc-van-hugo
if $DESKTOP_ENVIRONMENT; then kz-desktop --delete=calibre-gui; fi

# Setup cockpit for karel@pc06
if $DESKTOP_ENVIRONMENT; then kz-desktop --addaft=kz-cockpit; fi

# Reset cockpit for karel@pc06
if $DESKTOP_ENVIRONMENT; then kz-desktop --delete=kz-cockpit; fi
if $DESKTOP_ENVIRONMENT; then rm --force --verbose "$HOME/.local/share/applications/kz-cockpit.desktop"; fi

# Setup dashtodock for *
if $DEBIAN; then gnome-extensions enable dash-to-dock@micxgx.gmail.com; fi
if $ROCKY; then gnome-extensions enable dash-to-dock@gnome-shell-extensions.gcampax.github.com; fi
if $DEBIAN; then gsettings set org.gnome.shell.extensions.dash-to-dock disable-overview-on-startup true; fi
if $DEBIAN || $ROCKY; then gsettings set org.gnome.shell disable-user-extensions false; fi
if $DEBIAN || $ROCKY; then gsettings set org.gnome.shell.extensions.dash-to-dock apply-custom-theme true; fi
if $DEBIAN || $ROCKY; then gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize-or-previews'; fi
if $DEBIAN || $ROCKY; then gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 32; fi
if $DEBIAN || $ROCKY; then gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed true; fi
if $DEBIAN || $ROCKY; then gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'LEFT'; fi
if $DEBIAN || $ROCKY; then gsettings set org.gnome.shell.extensions.dash-to-dock extend-height true; fi
if $DEBIAN || $ROCKY; then gsettings set org.gnome.shell.extensions.dash-to-dock icon-size-fixed true; fi

# Reset dashtodock for *
if $DEBIAN; then gnome-extensions disable dash-to-dock@micxgx.gmail.com; fi
if $ROCKY; then gnome-extensions disable dash-to-dock@gnome-shell-extensions.gcampax.github.com; fi
if $DEBIAN; then gsettings reset org.gnome.shell.extensions.dash-to-dock disable-overview-on-startup; fi
if $DEBIAN || $ROCKY; then gsettings reset org.gnome.shell disable-user-extensions; fi
if $DEBIAN || $ROCKY; then gsettings reset org.gnome.shell.extensions.dash-to-dock apply-custom-theme; fi
if $DEBIAN || $ROCKY; then gsettings reset org.gnome.shell.extensions.dash-to-dock click-action; fi
if $DEBIAN || $ROCKY; then gsettings reset org.gnome.shell.extensions.dash-to-dock dash-max-icon-size; fi
if $DEBIAN || $ROCKY; then gsettings reset org.gnome.shell.extensions.dash-to-dock dock-fixed; fi
if $DEBIAN || $ROCKY; then gsettings reset org.gnome.shell.extensions.dash-to-dock dock-position; fi
if $DEBIAN || $ROCKY; then gsettings reset org.gnome.shell.extensions.dash-to-dock extend-height; fi
if $DEBIAN || $ROCKY; then gsettings reset org.gnome.shell.extensions.dash-to-dock icon-size-fixed; fi

# Setup evolution for karel@pc07
if $DESKTOP_ENVIRONMENT; then kz-desktop --delete=org.gnome.Evolution; fi

# Reset evolution for karel@pc07
if $DESKTOP_ENVIRONMENT; then kz-desktop --addbef=org.gnome.Evolution; fi

# Setup firefox for karel@pc07
if $DESKTOP_ENVIRONMENT; then kz-desktop --delete=firefox-esr; fi

# Setup firefox for emily@pc-van-emily karel@pc01 karel@pc06 marin@pc02 monique@pc01
if $DESKTOP_ENVIRONMENT; then kz-desktop --delete=firefox; fi
if $DESKTOP_ENVIRONMENT; then kz-desktop --delete=firefox_firefox; fi

# Reset firefox for karel@pc07
if $DESKTOP_ENVIRONMENT; then kz-desktop --addbef=firefox-esr; fi

# Reset firefox for emily@pc-van-emily karel@pc01 karel@pc06 marin@pc02 monique@pc01
if $DESKTOP_ENVIRONMENT; then kz-desktop --addbef=firefox; fi
if $DESKTOP_ENVIRONMENT; then kz-desktop --addbef=firefox_firefox; fi

# Setup gdebi for *
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then xdg-mime default gdebi.desktop application/vnd.debian.binary-package; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then echo 'App gdebi is not available on an RPM system.'; fi

# Reset gdebi for *
echo 'App gdebi cannot be reset.'

# Setup git for karel@pc06 karel@pc07
git config --global alias.logg 'log --decorate --graph --oneline --all'

# Reset git for karel@pc06 karel@pc07
git config --global --unset alias.logg

# Setup gnome for *
if $DESKTOP_ENVIRONMENT; then gsettings set org.gnome.desktop.calendar show-weekdate true; fi
if $DESKTOP_ENVIRONMENT; then gsettings set org.gnome.desktop.interface clock-show-date true; fi
if $DESKTOP_ENVIRONMENT; then gsettings set org.gnome.desktop.interface clock-show-weekday true; fi
if $DESKTOP_ENVIRONMENT; then gsettings set org.gnome.desktop.interface show-battery-percentage true; fi
if $DESKTOP_ENVIRONMENT; then gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true; fi
if $DESKTOP_ENVIRONMENT; then gsettings set org.gnome.desktop.screensaver lock-enabled false; fi
if $DESKTOP_ENVIRONMENT; then gsettings set org.gnome.desktop.session idle-delay 900; fi
if $DESKTOP_ENVIRONMENT; then gsettings set org.gnome.desktop.sound allow-volume-above-100-percent true; fi
if $DESKTOP_ENVIRONMENT; then gsettings set org.gnome.desktop.wm.preferences button-layout ':minimize,maximize,close'; fi
if $DESKTOP_ENVIRONMENT; then gsettings set org.gnome.mutter center-new-windows true; fi
if $DESKTOP_ENVIRONMENT; then gsettings set org.gnome.nautilus.icon-view default-zoom-level 'large'; fi
if $DESKTOP_ENVIRONMENT; then gsettings set org.gnome.nautilus.preferences click-policy 'single'; fi
if $DESKTOP_ENVIRONMENT; then gsettings set org.gnome.nautilus.preferences open-folder-on-dnd-hover true; fi
if $DESKTOP_ENVIRONMENT; then gsettings set org.gnome.nautilus.preferences show-create-link true; fi
if $DESKTOP_ENVIRONMENT; then gsettings set org.gnome.nautilus.preferences show-image-thumbnails 'always'; fi
if $DESKTOP_ENVIRONMENT; then gsettings set org.gnome.settings-daemon.plugins.power power-button-action 'interactive'; fi
if $DESKTOP_ENVIRONMENT; then gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'; fi
if $DESKTOP_ENVIRONMENT; then gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'nothing'; fi

# Reset gnome for *
if $DESKTOP_ENVIRONMENT; then gsettings reset org.gnome.desktop.calendar show-weekdate; fi
if $DESKTOP_ENVIRONMENT; then gsettings reset org.gnome.desktop.interface clock-show-date; fi
if $DESKTOP_ENVIRONMENT; then gsettings reset org.gnome.desktop.interface clock-show-weekday; fi
if $DESKTOP_ENVIRONMENT; then gsettings reset org.gnome.desktop.interface show-battery-percentage; fi
if $DESKTOP_ENVIRONMENT; then gsettings reset org.gnome.desktop.peripherals.touchpad tap-to-click; fi
if $DESKTOP_ENVIRONMENT; then gsettings reset org.gnome.desktop.screensaver lock-enabled; fi
if $DESKTOP_ENVIRONMENT; then gsettings reset org.gnome.desktop.session idle-delay; fi
if $DESKTOP_ENVIRONMENT; then gsettings reset org.gnome.desktop.sound allow-volume-above-100-percent; fi
if $DESKTOP_ENVIRONMENT; then gsettings reset org.gnome.desktop.wm.preferences button-layout; fi
if $DESKTOP_ENVIRONMENT; then gsettings reset org.gnome.mutter center-new-windows; fi
if $DESKTOP_ENVIRONMENT; then gsettings reset org.gnome.nautilus.icon-view default-zoom-level; fi
if $DESKTOP_ENVIRONMENT; then gsettings reset org.gnome.nautilus.preferences click-policy; fi
if $DESKTOP_ENVIRONMENT; then gsettings reset org.gnome.nautilus.preferences open-folder-on-dnd-hover; fi
if $DESKTOP_ENVIRONMENT; then gsettings reset org.gnome.nautilus.preferences show-create-link; fi
if $DESKTOP_ENVIRONMENT; then gsettings reset org.gnome.nautilus.preferences show-image-thumbnails; fi
if $DESKTOP_ENVIRONMENT; then gsettings reset org.gnome.settings-daemon.plugins.power power-button-action; fi
if $DESKTOP_ENVIRONMENT; then gsettings reset org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type; fi
if $DESKTOP_ENVIRONMENT; then gsettings reset org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type; fi

# Setup google-chrome for *
if $DESKTOP_ENVIRONMENT; then kz-desktop --addbef=google-chrome; fi
if $DESKTOP_ENVIRONMENT; then xdg-mime default google-chrome.desktop application/pdf; fi

# Reset google-chrome for *
if $DESKTOP_ENVIRONMENT; then kz-desktop --delete=google-chrome; fi

# Setup handbrake for emily@pc-van-emily
if $DESKTOP_ENVIRONMENT; then kz-desktop --addaft=fr.handbrake.ghb; fi

# Reset handbrake for emily@pc-van-emily
if $DESKTOP_ENVIRONMENT; then kz-desktop --delete=fr.handbrake.ghb; fi

# Setup hide-files for *
if $DESKTOP_ENVIRONMENT; then echo 'snap' > "$HOME/.hidden"; fi
if $DESKTOP_ENVIRONMENT; then echo 'kz-backup' >> "$HOME/.hidden"; fi

# Reset hide-files for *
if $DESKTOP_ENVIRONMENT; then rm --force --verbose "$HOME/.hidden"; fi

# Setup kvm for karel@pc06 karel@pc07
if $DESKTOP_ENVIRONMENT; then kz-desktop --addaft=virt-manager; fi

# Reset kvm for karel@pc06 karel@pc07
if $DESKTOP_ENVIRONMENT; then kz-desktop --delete=virt-manager; fi

# Setup lynis for -none
git clone https://github.com/CISOfy/lynis "$HOME/lynis" || true
# Usage:
# $ cd ~/lynis
# $ [sudo] ./lynis audit system

# Reset lynis for -none
rm --force --recursive --verbose "$HOME/lynis"

# Setup restore-thumbnails for -none
rm --force --recursive --verbose "$HOME/.cache/thumbnails/"

# Reset restore-thumbnails for -none
echo 'App restore-thumbnails cannot be reset.'

# Setup private-home for *
chmod 750 "$HOME"

# Reset private-home for *
chmod 755 "$HOME"

# Setup sound-juicer for emily@pc-van-emily
if $DESKTOP_ENVIRONMENT; then kz-desktop --addaft=org.gnome.SoundJuicer; fi

# Reset sound-juicer for emily@pc-van-emily
if $DESKTOP_ENVIRONMENT; then kz-desktop --delete=org.gnome.SoundJuicer; fi

# Setup spotify for karel@pc01 karel@pc06 karel@pc07 marin@pc02 monique@pc01
if $DESKTOP_ENVIRONMENT; then kz-desktop --addaft=kz-spotify; fi

# Reset spotify for karel@pc01 karel@pc06 karel@pc07 marin@pc02 monique@pc01
if $DESKTOP_ENVIRONMENT; then kz-desktop --delete=kz-spotify; fi

# Setup teamviewer for karel@pc06
if $DESKTOP_ENVIRONMENT; then kz-desktop --addaft=com.teamviewer.TeamViewer; fi

# Reset teamviewer for karel@pc06
if $DESKTOP_ENVIRONMENT; then kz-desktop --delete=com.teamviewer.TeamViewer; fi

# Setup terminal for karel@pc01 karel@pc06 karel@pc07
if $DESKTOP_ENVIRONMENT; then kz-desktop --addbef=org.gnome.Terminal; fi
# Turn on aliases.
sed --in-place --expression='s/#alias/alias/g' "$HOME/.bashrc"
# Enable search forward in history (with Ctrl-S).
sed --in-place --expression='/^stty -ixon/d' "$HOME/.bashrc"
echo 'stty -ixon  # Enable fwd search history (i-search)' >> "$HOME/.bashrc"

# Reset terminal for karel@pc01 karel@pc06 karel@pc07
if $DESKTOP_ENVIRONMENT; then kz-desktop --delete=org.gnome.Terminal; fi
sed --in-place --expression='s/alias/#alias/g' "$HOME/.bashrc"
sed --in-place --expression='/^stty -ixon/d' "$HOME/.bashrc"

# Setup thunderbird for karel@pc01 karel@pc06 marin@pc02 monique@pc01
if $DESKTOP_ENVIRONMENT; then kz-desktop --delete=thunderbird; fi
if $DESKTOP_ENVIRONMENT; then kz-desktop --delete=thunderbird_thunderbird; fi

# Reset thunderbird for karel@pc01 karel@pc06 marin@pc02 monique@pc01
if $DESKTOP_ENVIRONMENT; then kz-desktop --addbef=thunderbird; fi
if $DESKTOP_ENVIRONMENT; then kz-desktop --addbef=thunderbird_thunderbird; fi

# Setup virtualbox for hugo@pc-van-hugo
if $DESKTOP_ENVIRONMENT; then kz-desktop --addaft=virtualbox; fi
if $DESKTOP_ENVIRONMENT; then kz-desktop --addaft=kz-vm-hugowin732; fi

# Reset virtualbox for hugo@pc-van-hugo
if $DESKTOP_ENVIRONMENT; then kz-desktop --delete=virtualbox; fi
if $DESKTOP_ENVIRONMENT; then kz-desktop --delete=kz-vm-hugowin732; fi

# Setup vscode for karel@pc01 karel@pc06 karel@pc07
if $DESKTOP_ENVIRONMENT; then kz-desktop --addbef=code; fi
if $DESKTOP_ENVIRONMENT; then xdg-mime default code.desktop application/json; fi
if $DESKTOP_ENVIRONMENT; then xdg-mime default code.desktop application/x-desktop; fi
if $DESKTOP_ENVIRONMENT; then xdg-mime default code.desktop application/x-shellscript; fi
if $DESKTOP_ENVIRONMENT; then xdg-mime default code.desktop application/xml; fi
if $DESKTOP_ENVIRONMENT; then xdg-mime default code.desktop text/html; fi
if $DESKTOP_ENVIRONMENT; then xdg-mime default code.desktop text/markdown; fi
if $DESKTOP_ENVIRONMENT; then xdg-mime default code.desktop text/plain; fi
if $DESKTOP_ENVIRONMENT; then xdg-mime default code.desktop text/troff; fi
if $DESKTOP_ENVIRONMENT; then xdg-mime default code.desktop text/x-python; fi

# Reset vscode for karel@pc01 karel@pc06 karel@pc07
if $DESKTOP_ENVIRONMENT; then kz-desktop --delete=code; fi

# Setup webmin for karel@pc07
if $DESKTOP_ENVIRONMENT; then kz-desktop --addaft=kz-webmin; fi

# Reset webmin for karel@pc07
if $DESKTOP_ENVIRONMENT; then kz-desktop --delete=kz-webmin; fi
if $DESKTOP_ENVIRONMENT; then rm --force --verbose "$HOME/.local/share/applications/kz-webmin.desktop"; fi

# Setup whatsapp for hugo@pc-van-hugo maria@maria-desktop
if $DESKTOP_ENVIRONMENT; then kz-desktop --addaft=kz-whatsapp; fi

# Reset whatsapp for hugo@pc-van-hugo maria@maria-desktop
if $DESKTOP_ENVIRONMENT; then kz-desktop --delete=kz-whatsapp; fi

# Setup youtube-dl for emily@pc-van-emily
if $DESKTOP_ENVIRONMENT; then kz-desktop --addaft=youtubedl-gui; fi

# Reset youtube-dl for emily@pc-van-emily
if $DESKTOP_ENVIRONMENT; then kz-desktop --delete=youtubedl-gui; fi

# Setup zoom for monique@pc01 karel@pc01
if $DESKTOP_ENVIRONMENT; then kz-desktop --addaft=kz-zoom; fi

# Reset zoom for monique@pc01 karel@pc01
if $DESKTOP_ENVIRONMENT; then kz-desktop --delete=kz-zoom; fi

