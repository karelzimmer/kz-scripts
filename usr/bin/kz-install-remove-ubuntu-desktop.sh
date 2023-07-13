# shellcheck shell=bash
###############################################################################
# Remove apps file for Ubuntu desktop.
#
# This script file is used by script kz-install.
# See the kz install man page for details of how to make use of this script
# file.
#
# Written by Karel Zimmer <info@karelzimmer.nl>, CC0 1.0 Universal
# <https://creativecommons.org/publicdomain/zero/1.0>, 2023.
###############################################################################

#  APP ansible
# HOST pc06
sudo apt-get remove --yes ansible

#  APP apport
# HOST *
sudo sed --in-place --expression='s/enabled=0/enabled=1/' /etc/default/apport
sudo systemctl enable --now apport.service

#  APP bleachbit
# HOST pc-van-hugo
sudo apt-get remove --yes bleachbit

#  APP bluetooth
# HOST pc01
# Enable internal bluetooth adapter, see: lsusb
sudo rm --force /etc/udev/rules.d/81-bluetooth-hci.rules

#  APP brightness
# HOST pc06
echo '' | sudo tee /etc/rc.local
sudo chmod -x /etc/rc.local

#  APP calibre
# HOST pc-van-hugo pc04
sudo apt-get remove --yes calibre

#  APP citrix
# HOST pc-van-ria-en-toos
sudo apt-get remove --yes icaclient libidn11

#  APP clamav
# HOST pc-van-hugo
sudo apt-get remove --yes clamtk-gnome

#  APP cockpit
# HOST pc06
# Web App: https://localhost:9090
sudo apt-get remove --yes cockpit

#  APP cups
# HOST pc-van-emily
# Remove support for Canon BJNP protocol
sudo apt-get remove --yes cups-backend-bjnp

#  APP dual-monitor
# HOST pc06
sudo rm --force ~gdm/.config/monitors.xml

#  APP exiftool
# HOST pc06
sudo apt-get remove --yes libimage-exiftool-perl

#  APP gast
# HOST pc01 pc06
sudo userdel --remove gast

#  APP gimp
# HOST pc-van-hugo pc06
sudo apt-get remove --yes gimp gimp-help-en gimp-help-nl

#  APP gnome-gmail
# HOST pc01 pc04 pc06
sudo apt-get remove --yes gnome-gmail

#  APP gnome-tweaks
# HOST pc06
sudo apt-get remove --yes gnome-tweaks

#  APP google-chrome
# HOST *
sudo apt-get remove --yes google-chrome-stable chrome-gnome-shell
sudo rm --force /etc/apt/sources.list.d/google-chrome.list* /usr/share/keyrings/google-chrome.gpg* /etc/apt/trusted.gpg.d/google-chrome.gpg
sudo apt-get update

#  APP google-earth
# HOST pc04
sudo apt-get remove --yes google-earth-pro-stable
sudo rm --force /etc/apt/sources.list.d/google-earth-pro.list* /usr/share/keyrings/google-earth.gpg*
sudo apt-get update

#  APP handbrake
# HOST pc-van-emily
sudo apt-get remove --yes handbrake

#  APP hosts
# HOST pc01 pc06
sudo sed --in-place --expression='/^192.168.1.83/d' /etc/hosts
sudo sed --in-place --expression='/^192.168.1.64/d' /etc/hosts

#  APP kvm
# HOST pc06
sudo apt-get remove --yes cpu-checker qemu-kvm bridge-utils virt-manager
sudo delgroup libvirtd-dnsmasq
sudo deluser "${SUDO_USER:-${SUDO_USER:-$USER}}" libvirtd
sudo delgroup libvirtd

#  APP libreoffice
# HOST *
sudo apt-get remove --yes aspell-nl libreoffice

#  APP lidswitch
# HOST pc-van-hugo pc04
sudo sed --in-place --expression='/^HandleLidSwitch=/d' /etc/systemd/logind.conf

#  APP locate
# HOST pc06
sudo apt-get remove --yes mlocate

#  APP nautilus-admin
# HOST pc06
sudo apt-get remove --yes nautilus-admin

#  APP restricted-addons
# HOST *
sudo apt-get remove --yes ubuntu-restricted-addons libavcodec-extra
sudo apt autoremove --yes

#  APP ros
# HOST pc04
:

#  APP signal
# HOST pc06
sudo apt-get remove --yes signal-desktop
sudo rm --force /etc/apt/sources.list.d/signal-xenial.list* /usr/share/keyrings/signal-desktop-keyring.gpg*
sudo apt-get update

#  APP sound-juicer
# HOST pc-van-emily
sudo apt-get remove --yes sound-juicer

#  APP ssh
# HOST pc01 pc06
sudo sed --in-place --expression='s/PermitRootLogin no/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config
sudo apt-get remove --yes ssh

#  APP sushi
# HOST pc06
# Select a file, press the space bar, and a preview will appear.
sudo apt-get remove --yes gnome-sushi

#  APP teamviewer
# HOST *
sudo apt-get remove --yes teamviewer
sudo rm --force /etc/apt/sources.list.d/teamviewer.list* /usr/share/keyrings/teamviewer.gpg*
sudo apt-key del 0C1289C0 DEB49217
sudo apt-get update

#  APP tree
# HOST pc06
sudo apt-get remove --yes tree

#  APP ufw
# HOST pc01 pc06
sudo ufw disable
sudo apt-get remove --yes gufw

#  APP virtualbox
# HOST pc-van-hugo
sudo apt-get remove --yes virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso

#  APP vlc
# HOST pc06
sudo snap remove vlc

#  APP vscode
# HOST pc01 pc07
sudo snap remove code

#  APP wine
# HOST pc04
sudo apt-get remove --yes wine winetricks playonlinux

#  APP x11
# Force to use wayland. With wayland issues with video playback and TeamViewer.
# To check execute: echo $XDG_SESSION_TYPE (should output 'wayland')
# HOST *
sudo sed --in-place --expression='s/WaylandEnable=false/#WaylandEnable=false/' /etc/gdm3/custom.conf

#  APP youtube-downloader
# HOST pc-van-hugo
sudo apt-get remove --yes youtubedl-gui
