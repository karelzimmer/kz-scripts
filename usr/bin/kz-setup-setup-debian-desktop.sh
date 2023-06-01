# shellcheck shell=bash
###############################################################################
# Setup apps file for Debian desktop.
#
# Written by Karel Zimmer <info@karelzimmer.nl>, CC0 1.0 Universal
# <https://creativecommons.org/publicdomain/zero/1.0>, 2013-2023.
###############################################################################
# Record types:
# # APP <app>       Set up <app>, or
# #-APP <app>       Ditto, not used with option --apps and argument APP
# # USER <user>@<host>...
#                   For who to execute <Command>s (e.g. jan@pc02 or *.*)
# # <Description>   Description of the <app>
# <Command>         Command line [1-n]
###############################################################################

#-APP dashtodock
# Transform dash to dock
# USER *@*
gnome-extensions enable dash-to-dock@micxgx.gmail.com

# APP gnome
# Desktop environment
# USER *@*
kz-gset --addappfolder=KZ
gsettings set org.gnome.desktop.calendar show-weekdate true
gsettings set org.gnome.desktop.interface clock-show-date true
gsettings set org.gnome.desktop.interface clock-show-weekday true
gsettings set org.gnome.desktop.interface show-battery-percentage true
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
gsettings set org.gnome.desktop.screensaver lock-enabled false
gsettings set org.gnome.desktop.session idle-delay 900
gsettings set org.gnome.mutter center-new-windows true
gsettings set org.gnome.nautilus.icon-view default-zoom-level 'large'
gsettings set org.gnome.nautilus.preferences click-policy 'single'
gsettings set org.gnome.nautilus.preferences open-folder-on-dnd-hover true
gsettings set org.gnome.settings-daemon.peripherals.touchscreen orientation-lock true
gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
gsettings set org.gnome.settings-daemon.plugins.power idle-dim false
gsettings set org.gnome.settings-daemon.plugins.power power-button-action 'interactive'
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'nothing'
gsettings set org.gnome.shell.extensions.dash-to-dock apply-custom-theme true
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize-or-previews'
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 32
gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed true
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height true
gsettings set org.gnome.shell.extensions.dash-to-dock icon-size-fixed true
gsettings set org.gnome.Terminal.Legacy.Settings theme-variant light

#-APP gnome
# Desktop environment
# USER karel@pc07
gsettings set org.gnome.desktop.sound allow-volume-above-100-percent true
gsettings set org.gnome.nautilus.preferences show-create-link true
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type nothing

# APP google-chrome
# Google's webbrowser
# USER *@*
kz-gset --addfavbef=google-chrome

# APP hide-folders
# Hide folders in Home folder
# USER *@*
echo 'snap' > "$HOME"/.hidden

# APP kvm
# Virtualization
# USER karel@pc07
kz-gset --addfavaft=virt-manager

# APP skype
# Video calls
# USER *@*
kz-gset --addfavaft=kz-skype

# APP spotify
# Music player
# USER *@*
kz-gset --addfavaft=kz-spotify

#-APP start-install
# Remove starter Start installation
# USER *@*
kz-gset --delfav=install-debian

# APP terminal
# Terminal
# USER karel@pc07
kz-gset --addfavbef=org.gnome.Terminal
# Turn on aliases.
sed --in-place --expression='s/#alias/alias/g' "$HOME"/.bashrc
# Search forward in history (with Ctrl-S).
sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc
echo 'stty -ixon  # Enable fwd search history (i-search)' >> "$HOME"/.bashrc

# APP vscode
# Editor
# USER karel@pc07
kz-gset --addfavbef=code_code
xdg-mime default code_code.desktop application/json             # JSON document
xdg-mime default code_code.desktop application/x-desktop        # Desktop configuration file
xdg-mime default code_code.desktop application/x-shellscript    # Bash script
xdg-mime default code_code.desktop application/xml              # PolicyKit action definition file
xdg-mime default code_code.desktop text/html                    # Web page
xdg-mime default code_code.desktop text/markdown                # Markdown document
xdg-mime default code_code.desktop text/troff                   # Man page

# APP webmin
# Web-based administration
# USER karel@pc07
# Web App: https://localhost:10000
kz-gset --addfavaft=kz-webmin
