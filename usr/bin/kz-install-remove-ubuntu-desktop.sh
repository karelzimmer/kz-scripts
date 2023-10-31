# shellcheck shell=bash
###############################################################################
# Standard uninstaller file for Ubuntu desktop.
#
# Written by Karel Zimmer <info@karelzimmer.nl>, CC0 1.0 Universal
# <https://creativecommons.org/publicdomain/zero/1.0>, 2023.
###############################################################################

# APP apport HOST *
# EXEC THIS FIRST.
sudo sed --in-place --expression='s/enabled=0/enabled=1/' /etc/default/apport
sudo systemctl enable --now apport.service


# APP add-host HOST pc01 pc06
sudo sed --in-place --expression='/^192.168.1.83/d' /etc/hosts
sudo sed --in-place --expression='/^192.168.1.100/d' /etc/hosts


# APP ansible HOST pc06
sudo apt-get remove --purge --yes ansible
sudo apt-get autoremove --yes


# APP anydesk HOST *
sudo apt-get remove --purge --yes anydesk
sudo apt-get autoremove --yes
sudo rm --force /etc/apt/sources.list.d/anydesk.list* /usr/share/keyrings/anydesk.gpg*
sudo apt-get update


# APP bleachbit HOST pc-van-hugo
sudo apt-get remove --purge --yes bleachbit
sudo apt-get autoremove --yes


# APP calibre HOST pc04 pc06 pc-van-hugo
sudo apt-get remove --purge --yes calibre
sudo apt-get autoremove --yes


# APP clamav HOST pc-van-hugo
sudo apt-get remove --purge --yes clamtk-gnome
sudo apt-get autoremove --yes


# APP cockpit HOST pc06
sudo apt-get remove --purge --yes cockpit
sudo apt-get autoremove --yes


# APP config-dual-monitor HOST pc06
sudo rm --force ~gdm/.config/monitors.xml


# APP cups-backend-bjnp HOST pc-van-emily
sudo apt-get remove --purge --yes cups-backend-bjnp
sudo apt-get autoremove --yes


# APP exiftool HOST pc06
sudo apt-get remove --purge --yes libimage-exiftool-perl
sudo apt-get autoremove --yes


# APP gimp HOST pc06 pc-van-hugo
sudo apt-get remove --purge --yes gimp gimp-help-en gimp-help-nl
sudo apt-get autoremove --yes


# APP gnome-gmail HOST pc01 pc04 pc06
sudo apt-get remove --purge --yes gnome-gmail
sudo apt-get autoremove --yes


# APP gnome-tweaks HOST pc06
sudo apt-get remove --purge --yes gnome-tweaks
sudo apt-get autoremove --yes


# APP gnome-web HOST pc06
sudo apt-get remove --purge --yes epiphany-browser
sudo apt-get autoremove --yes


# APP google-chrome HOST *
sudo apt-get remove --purge --yes google-chrome-stable chrome-gnome-shell
sudo apt-get autoremove --yes
sudo rm --force /etc/apt/sources.list.d/google-chrome.list* /usr/share/keyrings/google-chrome.gpg* /etc/apt/trusted.gpg.d/google-chrome.gpg
sudo apt-get update


# APP google-earth HOST pc04
sudo apt-get remove --purge --yes google-earth-pro-stable
sudo apt-get autoremove --yes
sudo rm --force /etc/apt/sources.list.d/google-earth-pro.list* /usr/share/keyrings/google-earth.gpg*
sudo apt-get update


# APP handbrake HOST pc-van-emily
sudo apt-get remove --purge --yes handbrake
sudo apt-get autoremove --yes


# APP ignore-close-laptop-lid HOST pc04 pc-van-hugo
sudo sed --in-place --expression='/^HandleLidSwitch=/d' /etc/systemd/logind.conf


# APP kvm HOST pc06
sudo apt-get remove --purge --yes cpu-checker qemu-kvm bridge-utils virt-manager
sudo apt-get autoremove --yes
sudo delgroup libvirtd-dnsmasq
sudo deluser "${SUDO_USER:-${SUDO_USER:-$USER}}" libvirtd
sudo delgroup libvirtd


# APP libreoffice HOST *
sudo apt-get remove --purge --yes aspell-en aspell-nl libreoffice
sudo apt-get autoremove --yes


# APP locate HOST pc06
sudo apt-get remove --purge --yes mlocate
sudo apt-get autoremove --yes


# APP nautilus-admin HOST pc06
sudo apt-get remove --purge --yes nautilus-admin
sudo apt-get autoremove --yes


# APP ros HOST pc04
:


# APP signal HOST pc06
sudo apt-get remove --purge --yes signal-desktop
sudo apt-get autoremove --yes
sudo rm --force /etc/apt/sources.list.d/signal-xenial.list* /usr/share/keyrings/signal-desktop-keyring.gpg*
sudo apt-get update


# APP sound-juicer HOST pc-van-emily
sudo apt-get remove --purge --yes sound-juicer
sudo apt-get autoremove --yes


# APP ssh HOST pc01 pc06
sudo sed --in-place --expression='s/PermitRootLogin no/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config
sudo apt-get remove --purge --yes ssh
sudo apt-get autoremove --yes


# APP sushi HOST pc06
sudo apt-get remove --purge --yes gnome-sushi
sudo apt-get autoremove --yes


# APP teamviewer HOST pc06
sudo apt-get remove --yes teamviewer
sudo rm --force /etc/apt/sources.list.d/teamviewer.list* /usr/share/keyrings/teamviewer*.gpg*
sudo apt-key del 0C1289C0 DEB49217
sudo apt-get update


# APP tree HOST pc06
sudo apt-get remove --purge --yes tree
sudo apt-get autoremove --yes


# APP totem HOST *
sudo apt-get remove --purge --yes ubuntu-restricted-addons libavcodec-extra libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libgstreamer-plugins-bad1.0-dev gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-libav gstreamer1.0-tools gstreamer1.0-x gstreamer1.0-alsa gstreamer1.0-gl gstreamer1.0-gtk3 gstreamer1.0-qt5 gstreamer1.0-pulseaudio
sudo apt-get autoremove --yes


# APP ufw HOST pc01 pc06
sudo ufw disable
sudo apt-get remove --purge --yes gufw
sudo apt-get autoremove --yes


# APP virtualbox HOST pc-van-hugo
sudo apt-get remove --purge --yes virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso
sudo apt-get autoremove --yes


# APP vlc HOST pc06
sudo snap remove --purge vlc


# APP vscode HOST pc01 pc06
sudo snap remove --purge code


# APP wine HOST pc04
sudo apt-get remove --purge --yes wine winetricks playonlinux
sudo apt-get autoremove --yes


# APP youtube-dl HOST pc-van-emily pc-van-hugo
sudo apt-get remove --purge --yes youtubedl-gui
sudo apt-get autoremove --yes
