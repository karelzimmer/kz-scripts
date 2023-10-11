# shellcheck shell=bash
###############################################################################
# Standard uninstaller file for Ubuntu desktop.
#
# Written by Karel Zimmer <info@karelzimmer.nl>, CC0 1.0 Universal
# <https://creativecommons.org/publicdomain/zero/1.0>, 2023.
###############################################################################

# APP apport *
# EXEC THIS FIRST.
sudo sed --in-place --expression='s/enabled=0/enabled=1/' /etc/default/apport
sudo systemctl enable --now apport.service


# APP ansible pc06
sudo apt-get remove --yes ansible


# APP anydesk *
sudo apt-get remove --yes anydesk
sudo rm --force /etc/apt/sources.list.d/anydesk.list* /usr/share/keyrings/anydesk.gpg*
sudo apt-get update


# APP bleachbit pc-van-hugo
sudo apt-get remove --yes bleachbit


# APP bluetooth pc01
# Enable internal bluetooth adapter, see: lsusb
sudo rm --force /etc/udev/rules.d/81-bluetooth-hci.rules


# APP brightness pc06
echo '' | sudo tee /etc/rc.local
sudo chmod -x /etc/rc.local


# APP calibre pc-van-hugo pc04 pc06
sudo apt-get remove --yes calibre


# APP citrix pc-van-ria-en-toos
sudo apt-get remove --yes icaclient libidn11


# APP clamav pc-van-hugo
sudo apt-get remove --yes clamtk-gnome


# APP cockpit pc06
# Web app: https://localhost:9090
sudo apt-get remove --yes cockpit


# APP cups pc-van-emily
# Remove support for Canon BJNP protocol
sudo apt-get remove --yes cups-backend-bjnp


# APP dual-monitor pc06
sudo rm --force ~gdm/.config/monitors.xml


# APP exiftool pc06
sudo apt-get remove --yes libimage-exiftool-perl


# APP gast pc01 pc06
sudo userdel --remove gast


# APP gimp pc-van-hugo pc06
sudo apt-get remove --yes gimp gimp-help-en gimp-help-nl


# APP gnome-gmail pc01 pc04 pc06
sudo apt-get remove --yes gnome-gmail


# APP gnome-tweaks pc06
sudo apt-get remove --yes gnome-tweaks


# APP google-chrome *
sudo apt-get remove --yes google-chrome-stable chrome-gnome-shell
sudo rm --force /etc/apt/sources.list.d/google-chrome.list* /usr/share/keyrings/google-chrome.gpg* /etc/apt/trusted.gpg.d/google-chrome.gpg
sudo apt-get update


# APP google-earth pc04
sudo apt-get remove --yes google-earth-pro-stable
sudo rm --force /etc/apt/sources.list.d/google-earth-pro.list* /usr/share/keyrings/google-earth.gpg*
sudo apt-get update


# APP handbrake pc-van-emily
sudo apt-get remove --yes handbrake


# APP hosts pc01 pc06
sudo sed --in-place --expression='/^192.168.1.83/d' /etc/hosts
sudo sed --in-place --expression='/^192.168.1.64/d' /etc/hosts


# APP kvm pc06
sudo apt-get remove --yes cpu-checker qemu-kvm bridge-utils virt-manager
sudo delgroup libvirtd-dnsmasq
sudo deluser "${SUDO_USER:-${SUDO_USER:-$USER}}" libvirtd
sudo delgroup libvirtd


# APP libreoffice *
sudo apt-get remove --yes aspell-nl libreoffice


# APP lidswitch pc-van-hugo pc04
sudo sed --in-place --expression='/^HandleLidSwitch=/d' /etc/systemd/logind.conf


# APP locate pc06
sudo apt-get remove --yes mlocate


# APP nautilus-admin pc06
sudo apt-get remove --yes nautilus-admin


# APP restricted-addons *
sudo apt-get remove --yes ubuntu-restricted-addons libavcodec-extra
sudo apt autoremove --yes


# APP ros pc04
:


# APP signal pc06
sudo apt-get remove --yes signal-desktop
sudo rm --force /etc/apt/sources.list.d/signal-xenial.list* /usr/share/keyrings/signal-desktop-keyring.gpg*
sudo apt-get update


# APP sound-juicer pc-van-emily
sudo apt-get remove --yes sound-juicer


# APP ssh pc01 pc06
sudo sed --in-place --expression='s/PermitRootLogin no/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config
sudo apt-get remove --yes ssh


# APP sushi pc06
# Select a file, press the space bar, and a preview will appear.
sudo apt-get remove --yes gnome-sushi


# APP tree pc06
sudo apt-get remove --yes tree


# APP ufw pc01 pc06
sudo ufw disable
sudo apt-get remove --yes gufw


# APP virtualbox pc-van-hugo
sudo apt-get remove --yes virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso


# APP vlc pc06
sudo snap remove vlc


# APP vscode pc01 pc07
sudo snap remove code


# APP web pc06
sudo apt-get remove --yes epiphany-browser


# APP wine pc04
sudo apt-get remove --yes wine winetricks playonlinux


# APP x11
# Force to use wayland. With wayland issues with video playback and TeamViewer.
# To check execute: echo $XDG_SESSION_TYPE (should output 'wayland') *
sudo sed --in-place --expression='s/WaylandEnable=false/#WaylandEnable=false/' /etc/gdm3/custom.conf


# APP youtube-downloader pc-van-emily pc-van-hugo
sudo apt-get remove --yes youtubedl-gui
