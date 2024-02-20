# shellcheck shell=bash
###############################################################################
# Set up file for Ubuntu desktop.
#
# Written by Karel Zimmer <info@karelzimmer.nl>, CC0 1.0 Universal
# <https://creativecommons.org/publicdomain/zero/1.0>, 2013-2024.
###############################################################################

# setup APP anydesk USER
kz-gset --addfavaft=anydesk

# reset APP anydesk USER
kz-gset --delfav=anydesk


# setup APP calibre USER hugo@pc-van-hugo
kz-gset --addfavaft=calibre-gui

# reset APP calibre USER hugo@pc-van-hugo
kz-gset --delfav=calibre-gui


# setup APP cockpit USER karel@pc06
# Web app: https://localhost:9090
kz-gset --addfavaft=kz-cockpit

# reset APP cockpit USER karel@pc06
kz-gset --delfav=kz-cockpit
rm --force --verbose "$HOME"/.local/share/applications/kz-cockpit.desktop


# setup APP firefox USER monique@pc01 karel@pc01 marin@pc02 karel@pc06
kz-gset --delfav=firefox_firefox

# reset APP firefox USER monique@pc01 karel@pc01 marin@pc02 karel@pc06
kz-gset --addfavbef=firefox_firefox


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
gsettings set org.gnome.shell.extensions.dash-to-dock apply-custom-theme true
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize-or-previews'
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 32
gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts-network false
gsettings set org.gnome.shell.extensions.ding show-home false
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
gsettings reset org.gnome.shell.extensions.dash-to-dock apply-custom-theme
gsettings reset org.gnome.shell.extensions.dash-to-dock click-action
gsettings reset org.gnome.shell.extensions.dash-to-dock dash-max-icon-size
gsettings reset org.gnome.shell.extensions.dash-to-dock show-mounts-network
gsettings reset org.gnome.shell.extensions.ding show-home
gsettings reset org.gnome.Terminal.Legacy.Settings theme-variant


# setup APP google-chrome USER monique@pc01 karel@pc01 marin@pc02 karel@pc06
kz-gset --addfavbef=google-chrome

# reset APP google-chrome USER monique@pc01 karel@pc01 marin@pc02 karel@pc06
kz-gset --delfav=google-chrome


# setup APP handbrake USER emily@pc-van-emily
kz-gset --addfavaft=fr.handbrake.ghb

# reset APP handbrake USER emily@pc-van-emily
kz-gset --delfav=fr.handbrake.ghb


# setup APP kvm USER karel@pc06
kz-gset --addfavaft=virt-manager

# reset APP kvm USER karel@pc06
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


# setup APP spotify USER monique@pc01 karel@pc01 marin@pc02 karel@pc06
kz-gset --addfavaft=kz-spotify

# reset APP spotify USER monique@pc01 karel@pc01 marin@pc02 karel@pc06
kz-gset --delfav=kz-spotify


# setup APP start-installer USER *
kz-gset --delfav=ubuntu-desktop-installer_ubuntu-desktop-installer

# reset APP start-installer USER *
kz-gset --addfavbef=ubuntu-desktop-installer_ubuntu-desktop-installer


# setup APP sound-juicer USER emily@pc-van-emily
kz-gset --addfavaft=org.gnome.SoundJuicer

# reset APP sound-juicer USER emily@pc-van-emily
kz-gset --delfav=org.gnome.SoundJuicer


# setup APP thunderbird USER monique@pc01 karel@pc01 marin@pc02 karel@pc06
kz-gset --delfav=thunderbird

# reset APP thunderbird USER monique@pc01 karel@pc01 marin@pc02 karel@pc06
kz-gset --addfavbef=thunderbird


# setup APP teamviewer USER karel@pc06
kz-gset --addfavaft=com.teamviewer.TeamViewer

# reset APP teamviewer USER karel@pc06
kz-gset --delfav=com.teamviewer.TeamViewer


# setup APP telegram USER hugo@pc-van-hugo maria@maria-desktop
kz-gset --addfavaft=kz-telegram

# reset APP telegram USER hugo@pc-van-hugo  maria@maria-desktop
kz-gset --delfav=kz-telegram


# setup APP terminal USER karel@pc01 karel@pc06
kz-gset --addfavbef=org.gnome.Terminal
# Search forward in history (with Ctrl-S).
sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc
echo 'stty -ixon  # Enable fwd search history (i-search)' >> "$HOME"/.bashrc

# reset APP terminal USER karel@pc01 karel@pc06
kz-gset --delfav=org.gnome.Terminal
sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc


# setup APP virtualbox USER hugo@pc-van-hugo
kz-gset --addfavaft=virtualbox
kz-gset --addfavaft=kz-vm-hugowin732

# reset APP virtualbox USER hugo@pc-van-hugo
kz-gset --delfav=virtualbox
kz-gset --delfav=kz-vm-hugowin732


# setup APP vlc USER *
xdg-mime default vlc_vlc.desktop video/mp4          # MPEG4-video
xdg-mime default vlc_vlc.desktop video/x-matroska   # Matroska-video
xdg-mime default vlc_vlc.desktop video/webm         # WebM video


# setup APP vscode USER karel@pc01 karel@pc06
kz-gset --addfavbef=code_code
xdg-mime default code_code.desktop application/json             # JSON document
xdg-mime default code_code.desktop application/x-desktop        # Desktop configuration file
xdg-mime default code_code.desktop application/x-shellscript    # Bash script
xdg-mime default code_code.desktop application/xml              # PolicyKit action definition file
xdg-mime default code_code.desktop text/html                    # Web page
xdg-mime default code_code.desktop text/markdown                # Markdown document
xdg-mime default code_code.desktop text/troff                   # Man page
xdg-mime default code_code.desktop text/x-python                # Python-script

# reset APP vscode USER karel@pc01 karel@pc06
kz-gset --delfav=code_code


# setup APP whatsapp USER hugo@pc-van-hugo maria@maria-desktop
kz-gset --addfavaft=kz-whatsapp

# reset APP whatsapp USER hugo@pc-van-hugo maria@maria-desktop
kz-gset --delfav=kz-whatsapp


# setup APP zoom USER monique@pc01 karel@pc01
kz-gset --addfavaft=kz-zoom

# reset APP zoom USER monique@pc01 karel@pc01
kz-gset --delfav=kz-zoom
