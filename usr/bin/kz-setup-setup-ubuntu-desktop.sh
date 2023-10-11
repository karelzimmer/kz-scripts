# shellcheck shell=bash
###############################################################################
# Standard set up file for Ubuntu desktop.
#
# Written by Karel Zimmer <info@karelzimmer.nl>, CC0 1.0 Universal
# <https://creativecommons.org/publicdomain/zero/1.0>, 2013-2023.
###############################################################################

# APP anydesk karel@pc06
# Web app: https://my.anydesk.com/v2
kz-gset --addfavaft=anydesk


# APP calibre hugo@pc-van-hugo nina@pc04 karel@pc06
kz-gset --addfavaft=calibre-gui


# APP cockpit karel@pc06
# Web app: https://localhost:9090
kz-gset --addfavaft=kz-cockpit


# APP citrix toos@pc-van-ria-en-toos
xdg-mime default wfica.desktop application/x-ica


# APP gnome *
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


# APP google-chrome *
kz-gset --addfavbef=google-chrome


# APP kvm karel@pc06
kz-gset --addfavaft=virt-manager


# APP libreoffice-calc nina@pc04
kz-gset --addfavaft=libreoffice-calc


# APP nautilus-hide *
echo 'snap' > "$HOME"/.hidden


# APP skype *
kz-gset --addfavaft=kz-skype


# APP spotify *
kz-gset --addfavaft=kz-spotify


# APP start-install *
kz-gset --delfav=ubuntu-desktop-installer_ubuntu-desktop-installer


# APP teams karel@pc06
kz-gset --addfavaft=kz-teams


# APP telegram hugo@pc-van-hugo
kz-gset --addfavaft=kz-telegram


# APP terminal karel@pc01 karel@pc06
kz-gset --addfavbef=org.gnome.Terminal
# Search forward in history (with Ctrl-S).
sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc
echo 'stty -ixon  # Enable fwd search history (i-search)' >> "$HOME"/.bashrc


# APP virtualbox hugo@pc-van-hugo
kz-gset --addfavaft=virtualbox
kz-gset --addfavaft=kz-vm-hugowin732


# APP vscode karel@pc01 karel@pc06
kz-gset --addfavbef=code_code
xdg-mime default code_code.desktop application/json             # JSON document
xdg-mime default code_code.desktop application/x-desktop        # Desktop configuration file
xdg-mime default code_code.desktop application/x-shellscript    # Bash script
xdg-mime default code_code.desktop application/xml              # PolicyKit action definition file
xdg-mime default code_code.desktop text/html                    # Web page
xdg-mime default code_code.desktop text/markdown                # Markdown document
xdg-mime default code_code.desktop text/troff                   # Man page
xdg-mime default code_code.desktop text/x-python                # Python-script


# APP whatsapp hugo@pc-van-hugo
kz-gset --addfavaft=kz-whatsapp


# APP zoom karel@pc01 monique@pc01
kz-gset --addfavaft=kz-zoom
