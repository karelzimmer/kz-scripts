# shellcheck shell=bash
###############################################################################
# Remove apps file for Ubuntu desktop.
#
# Written by Karel Zimmer <info@karelzimmer.nl>, CC0 1.0 Universal
# <https://creativecommons.org/publicdomain/zero/1.0>, 2023.
###############################################################################

#  APP ansible
# DESC Configuration management, deployment, and task execution
# HOST pc06
sudo apt-get remove --yes ansible

#  APP apport
# DESC Stop generating crash reports
# HOST *
sudo sed --in-place --expression='s/enabled=0/enabled=1/' /etc/default/apport
sudo systemctl enable --now apport.service

#  APP bleachbit
# DESC Remove unnecessary files
# HOST pc-van-hugo
sudo apt-get remove --yes bleachbit

#  APP bluetooth
# DESC Disable internal bluetooth adapter
# HOST pc01
sudo rm --force /etc/udev/rules.d/81-bluetooth-hci.rules

#  APP brightness
# DESC Set brightness
# HOST pc06
echo '' | sudo tee /etc/rc.local
sudo chmod -x /etc/rc.local

#  APP calibre
# DESC E-book manager
# HOST pc-van-hugo pc04
sudo apt-get remove --yes calibre

#  APP citrix
# DESC Telecommuting (Aka Citrix Workspace app, Citrix Receiver, and ICA Client)
# HOST pc-van-ria-en-toos
sudo apt-get remove --yes icaclient libidn11

#  APP clamav
# DESC Anti-virus
# HOST pc-van-hugo
sudo apt-get remove --yes clamtk-gnome

#  APP cockpit
# DESC Web-based administration
# HOST pc06
# Web App: https://localhost:9090
sudo apt-get remove --yes cockpit

#  APP cups-backend-bjnp
# DESC Support for Canon BJNP protocol
# HOST pc-van-emily
sudo apt-get remove --yes cups-backend-bjnp

#  APP dual-monitor
# DESC Dual monitor login screen
# HOST pc06
sudo rm --force ~gdm/.config/monitors.xml

#  APP exiftool
# DESC Read and change Exif tags
# HOST pc06
sudo apt-get remove --yes libimage-exiftool-perl

#  APP force-x11
# DESC Use X 11 instead of Wayland
# HOST *
sudo sed --in-place --expression='s/WaylandEnable=false/#WaylandEnable=false/' /etc/gdm3/custom.conf

#  APP gast
# DESC Add user gast
# HOST pc01 pc06
sudo userdel --remove gast

#  APP gimp
# DESC GNU Image Manipulation Program
# HOST pc-van-hugo pc06
sudo apt-get remove --yes gimp gimp-help-en gimp-help-nl

#  APP gnome-gmail
# DESC Gmail as the preferred email application in GNOME
# HOST pc01 pc04 pc06
sudo apt-get remove --yes gnome-gmail

#  APP gnome-tweaks
# DESC Adjust settings for GNOME
# HOST pc06
sudo apt-get remove --yes gnome-tweaks

#  APP google-chrome
# DESC Google's webbrowser
# HOST *
sudo apt-get remove --yes google-chrome-stable chrome-gnome-shell
sudo rm --force /etc/apt/sources.list.d/google-chrome.list* /usr/share/keyrings/google-chrome.gpg* /etc/apt/trusted.gpg.d/google-chrome.gpg
sudo apt-get update

#  APP google-earth
# DESC Globe
# HOST pc04
sudo apt-get remove --yes google-earth-pro-stable
sudo rm --force /etc/apt/sources.list.d/google-earth-pro.list* /usr/share/keyrings/google-earth.gpg*
sudo apt-get update

#  APP handbrake
# DESC DVD ripper
# HOST pc-van-emily
sudo apt-get remove --yes handbrake

#  APP hosts
# DESC Add hosts
# HOST pc01 pc06
sudo sed --in-place --expression='/^192.168.1.83/d' /etc/hosts
sudo sed --in-place --expression='/^192.168.1.64/d' /etc/hosts

#  APP kvm
# DESC Kernel-based Virtual Machine
# HOST pc06
sudo apt-get remove --yes cpu-checker qemu-kvm bridge-utils virt-manager
sudo delgroup libvirtd-dnsmasq
sudo deluser "${SUDO_USER:-${SUDO_USER:-$USER}}" libvirtd
sudo delgroup libvirtd

#  APP libreoffice
# DESC Office suite
# HOST *
sudo apt-get remove --yes aspell-nl libreoffice

#  APP lidswitch
# DESC Ignore closing laptop lid
# HOST pc-van-hugo pc04
sudo sed --in-place --expression='/^HandleLidSwitch=/d' /etc/systemd/logind.conf

#  APP locate
# DESC Find files quick
# HOST pc06
sudo apt-get remove --yes mlocate

#  APP nautilus-admin
# DESC Add administrative actions to the right-click menu
# HOST pc06
sudo apt-get remove --yes nautilus-admin

#  APP restricted-addons
# DESC Essential software not already included due to legal or copyright reasons
# HOST *
sudo apt-get remove --yes ubuntu-restricted-addons libavcodec-extra
sudo apt autoremove --yes

#  APP ros
# DESC Robot Operating System
# HOST pc04
:

#  APP signal
# DESC Messaging
# HOST pc06
sudo apt-get remove --yes signal-desktop
sudo rm --force /etc/apt/sources.list.d/signal-xenial.list* /usr/share/keyrings/signal-desktop-keyring.gpg*
sudo apt-get update

#  APP sound-juicer
# DESC CD ripper
# HOST pc-van-emily
sudo apt-get remove --yes sound-juicer

#  APP ssh
# DESC Secure SHell
# HOST pc01 pc06
sudo sed --in-place --expression='s/PermitRootLogin no/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config
sudo apt-get remove --yes ssh

#  APP sushi
# DESC Select a file, press the space bar, and a preview will appear
# HOST pc06
sudo apt-get remove --yes gnome-sushi

#  APP teamviewer
# DESC Remote control
# HOST *
sudo apt-get remove --yes teamviewer
sudo rm --force /etc/apt/sources.list.d/teamviewer.list* /usr/share/keyrings/teamviewer.gpg*
sudo apt-key del 0C1289C0 DEB49217
sudo apt-get update

#  APP tree
# DESC Display a directory structure
# HOST pc06
sudo apt-get remove --yes tree

#  APP ufw
# DESC Uncomplicated FireWall
# HOST pc01 pc06
sudo ufw disable
sudo apt-get remove --yes gufw

#  APP virtualbox
# DESC Virtualization
# HOST pc-van-hugo
sudo apt-get remove --yes virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso

#  APP vlc
# DESC Media player
# HOST pc06
sudo snap remove vlc

#  APP vscode
# DESC Editor
# HOST pc01 pc07
sudo snap remove code

#  APP wine
# DESC Run Windows programs (Wine Is Not an Emulator)
# HOST pc04
sudo apt-get remove --yes wine winetricks playonlinux

#  APP youtube-downloader
# DESC Download videos
# HOST pc-van-hugo
sudo apt-get remove --yes youtubedl-gui
