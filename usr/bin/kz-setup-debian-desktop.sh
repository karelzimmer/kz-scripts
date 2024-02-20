# shellcheck shell=bash
###############################################################################
# Set up file for Debian desktop.
#
# Written by Karel Zimmer <info@karelzimmer.nl>, CC0 1.0 Universal
# <https://creativecommons.org/publicdomain/zero/1.0>, 2013-2024.
###############################################################################

# setup APP dashtodock USER *
gnome-extensions enable dash-to-dock@micxgx.gmail.com
gsettings set org.gnome.shell.extensions.dash-to-dock apply-custom-theme true
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize-or-previews'
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 32
gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed true
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'LEFT'
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height true
gsettings set org.gnome.shell.extensions.dash-to-dock icon-size-fixed true
gsettings set org.gnome.shell disable-user-extensions false

# reset APP dashtodock USER *
gnome-extensions disable dash-to-dock@micxgx.gmail.com
gsettings reset org.gnome.shell.extensions.dash-to-dock apply-custom-theme
gsettings reset org.gnome.shell.extensions.dash-to-dock click-action
gsettings reset org.gnome.shell.extensions.dash-to-dock dash-max-icon-size
gsettings reset org.gnome.shell.extensions.dash-to-dock dock-fixed
gsettings reset org.gnome.shell.extensions.dash-to-dock dock-position
gsettings reset org.gnome.shell.extensions.dash-to-dock extend-height
gsettings reset org.gnome.shell.extensions.dash-to-dock icon-size-fixed
gsettings reset org.gnome.shell disable-user-extensions


# setup APP firefox USER karel@pc07
kz-gset --delfav=firefox-esr

# reset APP firefox USER karel@pc07
kz-gset --addfavbef=firefox-esr


# setup APP gnome USER *
kz-gset --addappfolder=KZ
gsettings set org.gnome.desktop.calendar show-weekdate true
gsettings set org.gnome.desktop.interface clock-show-date true
gsettings set org.gnome.desktop.interface clock-show-weekday true
gsettings set org.gnome.desktop.interface show-battery-percentage true
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
gsettings set org.gnome.desktop.screensaver lock-enabled false
gsettings set org.gnome.desktop.session idle-delay 900
gsettings set org.gnome.desktop.sound allow-volume-above-100-percent true
gsettings set org.gnome.desktop.wm.preferences button-layout ':minimize,maximize,close'
gsettings set org.gnome.mutter center-new-windows true
gsettings set org.gnome.nautilus.icon-view default-zoom-level 'large'
gsettings set org.gnome.nautilus.preferences click-policy 'single'
gsettings set org.gnome.nautilus.preferences open-folder-on-dnd-hover true
gsettings set org.gnome.nautilus.preferences show-create-link true
gsettings set org.gnome.nautilus.preferences show-image-thumbnails 'always'
gsettings set org.gnome.settings-daemon.peripherals.touchscreen orientation-lock true
gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
gsettings set org.gnome.settings-daemon.plugins.power idle-dim false
gsettings set org.gnome.settings-daemon.plugins.power power-button-action 'interactive'
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'nothing'
gsettings set org.gnome.shell disable-user-extensions false
gsettings set org.gnome.Terminal.Legacy.Settings theme-variant 'light'

# reset APP gnome USER *
kz-gset --delappfolder=KZ
gsettings reset org.gnome.desktop.app-folders folder-children
gsettings reset org.gnome.desktop.calendar show-weekdate
gsettings reset org.gnome.desktop.interface clock-show-date
gsettings reset org.gnome.desktop.interface clock-show-weekday
gsettings reset org.gnome.desktop.interface show-battery-percentage
gsettings reset org.gnome.desktop.peripherals.touchpad tap-to-click
gsettings reset org.gnome.desktop.screensaver lock-enabled
gsettings reset org.gnome.desktop.session idle-delay
gsettings reset org.gnome.desktop.sound allow-volume-above-100-percent
gsettings reset org.gnome.desktop.wm.preferences button-layout
gsettings reset org.gnome.mutter center-new-windows
gsettings reset org.gnome.nautilus.icon-view default-zoom-level
gsettings reset org.gnome.nautilus.preferences click-policy
gsettings reset org.gnome.nautilus.preferences open-folder-on-dnd-hover
gsettings reset org.gnome.nautilus.preferences show-create-link
gsettings reset org.gnome.nautilus.preferences show-image-thumbnails
gsettings reset org.gnome.settings-daemon.peripherals.touchscreen orientation-lock
gsettings reset org.gnome.settings-daemon.plugins.color night-light-enabled
gsettings reset org.gnome.settings-daemon.plugins.power idle-dim
gsettings reset org.gnome.settings-daemon.plugins.power power-button-action
gsettings reset org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type
gsettings reset org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type
gsettings reset org.gnome.shell disable-user-extensions
gsettings reset org.gnome.Terminal.Legacy.Settings theme-variant


# setup APP google-chrome USER karel@pc07
kz-gset --addfavbef=google-chrome

# reset APP google-chrome USER karel@pc07
kz-gset --delfav=google-chrome


# setup APP kvm USER karel@pc07
kz-gset --addfavaft=virt-manager

# reset APP kvm USER karel@pc07
kz-gset --delfav=virt-manager


# setup APP lynis USER
# Use Lynis (CISOfy):
# cd ~/lynis
# [sudo] ./lynis audit system
git clone https://github.com/CISOfy/lynis /home/"$USER"/lynis

# reset APP lynis USER
rm --force --verbose --recursive --verbose /home/"$USER"/lynis


# setup APP nautilus-hide USER *
echo 'snap' > "$HOME"/.hidden

# reset APP nautilus-hide USER *
rm --force --verbose "$HOME"/.hidden


# setup APP recover-files-thumbnails USER
rm --force --verbose --recursive --verbose "$HOME"/.cache/thumbnails/


# setup APP spotify USER karel@pc07
kz-gset --addfavaft=kz-spotify

# reset APP spotify USER karel@pc07
kz-gset --delfav=kz-spotify


# setup APP start-installer USER *
kz-gset --delfav=install-debian

# reset APP start-installer USER *
kz-gset --addfavbef=install-debian


# setup APP terminal USER karel@pc07
kz-gset --addfavbef=org.gnome.Terminal
# Turn on aliases.
sed --in-place --expression='s/#alias/alias/g' "$HOME"/.bashrc
# Search forward in history (with Ctrl-S).
sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc
echo 'stty -ixon  # Enable fwd search history (i-search)' >> "$HOME"/.bashrc

# reset APP terminal USER karel@pc07
kz-gset --delfav=org.gnome.Terminal
sed --in-place --expression='s/alias/#alias/g' "$HOME"/.bashrc
sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc


# setup APP vlc USER *
xdg-mime default vlc_vlc.desktop video/mp4          # MPEG4-video
xdg-mime default vlc_vlc.desktop video/x-matroska   # Matroska-video
xdg-mime default vlc_vlc.desktop video/webm         # WebM video


# setup APP vscode USER karel@pc07
kz-gset --addfavbef=code_code
xdg-mime default code_code.desktop application/json             # JSON document
xdg-mime default code_code.desktop application/x-desktop        # Desktop configuration file
xdg-mime default code_code.desktop application/x-shellscript    # Bash script
xdg-mime default code_code.desktop application/xml              # PolicyKit action definition file
xdg-mime default code_code.desktop text/html                    # Web page
xdg-mime default code_code.desktop text/markdown                # Markdown document
xdg-mime default code_code.desktop text/troff                   # Man page
xdg-mime default code_code.desktop text/x-python                # Python-script

# reset APP vscode USER karel@pc07
kz-gset --delfav=code_code


# setup APP webmin USER karel@pc07
# Web app: https://localhost:10000
kz-gset --addfavaft=kz-webmin

# reset APP webmin USER karel@pc07
# Web app: https://localhost:10000
kz-gset --delfav=kz-webmin
rm --force --verbose "$HOME"/.local/share/applications/kz-webmin.desktop
