# shellcheck shell=bash
###############################################################################
# Remove apps file for Ubuntu desktop.
#
# Written by Karel Zimmer <info@karelzimmer.nl>, CC0 1.0 Universal
# <https://creativecommons.org/publicdomain/zero/1.0>, 2023.
###############################################################################
# Record types:
# # APP <app>       Remove <app>, or
# #-APP <app>       Ditto, not used with option --apps and argument APP
# # HOST <host>...  Where to execute <Command> (e.g. pc02 or *)
# # <Description>   <app> description
# # <Command>       Command line 1
# # <Command>...    Command line...
###############################################################################

# APP ansible
# HOST pc06
# Configuration management, deployment, and task execution
sudo apt-get remove --yes ansible

#-APP apport
# HOST *
# Stop generating crash reports
sudo sed --in-place --expression='s/enabled=0/enabled=1/' /etc/default/apport
sudo systemctl enable --now apport.service

# APP bleachbit
# HOST pc-van-hugo
# Remove unnecessary files
sudo apt-get remove --yes bleachbit

#-APP bluetooth
# HOST pc01
# Disable internal bluetooth adapter
sudo rm --force /etc/udev/rules.d/81-bluetooth-hci.rules

#-APP brightness
# HOST pc06
# Set brightness
echo '' | sudo tee /etc/rc.local
sudo chmod -x /etc/rc.local

# APP calibre
# HOST pc-van-hugo pc04
# E-book manager
sudo apt-get remove --yes calibre

# APP citrix
# HOST pc-van-ria-en-toos
# Telecommuting (Aka Citrix Workspace app, Citrix Receiver, and ICA Client)
sudo apt-get remove --yes icaclient libidn11

# APP clamav
# HOST pc-van-hugo
# Anti-virus
sudo apt-get remove --yes clamtk-gnome

# APP cockpit
# HOST pc06
# Web-based administration
# Web App: https://localhost:9090
sudo apt-get remove --yes cockpit

#-APP cups-backend-bjnp
# HOST pc-van-emily
# Support for Canon BJNP protocol
sudo apt-get remove --yes cups-backend-bjnp

# APP dual-monitor
# HOST pc06
# Dual monitor login screen
sudo rm --force ~gdm/.config/monitors.xml

# APP exiftool
# HOST pc06
# Read and change Exif tags
sudo apt-get remove --yes libimage-exiftool-perl

#-APP force-x11
# HOST *
# Use X 11 instead of Wayland
sudo sed --in-place --expression='s/WaylandEnable=false/#WaylandEnable=false/' /etc/gdm3/custom.conf

#-APP gast
# HOST pc01 pc06
# Add user gast
sudo userdel --remove gast

# APP gimp
# HOST pc-van-hugo pc06
# GNU Image Manipulation Program
sudo apt-get remove --yes gimp gimp-help-en gimp-help-nl

# APP gnome-gmail
# HOST pc01 pc04 pc06
# Gmail as the preferred email application in GNOME
sudo apt-get remove --yes gnome-gmail

# APP gnome-tweaks
# HOST pc06
# Adjust settings for GNOME
sudo apt-get remove --yes gnome-tweaks

# APP google-chrome
# HOST *
# Google's webbrowser
sudo apt-get remove --yes google-chrome-stable chrome-gnome-shell
sudo rm --force /etc/apt/sources.list.d/google-chrome.list* /usr/share/keyrings/google-chrome.gpg* /etc/apt/trusted.gpg.d/google-chrome.gpg
sudo apt-get update

# APP google-earth
# HOST pc04
# Globe
sudo apt-get remove --yes google-earth-pro-stable
sudo rm --force /etc/apt/sources.list.d/google-earth-pro.list* /usr/share/keyrings/google-earth.gpg*
sudo apt-get update

# APP handbrake
# HOST pc-van-emily
# DVD ripper
sudo apt-get remove --yes handbrake

#-APP hosts
# HOST pc01 pc06
# Add hosts
sudo sed --in-place --expression='/^192.168.1.83/d' /etc/hosts
sudo sed --in-place --expression='/^192.168.1.64/d' /etc/hosts

# APP kvm
# HOST pc06
# Kernel-based Virtual Machine
sudo apt-get remove --yes cpu-checker qemu-kvm bridge-utils virt-manager
sudo delgroup libvirtd-dnsmasq
sudo deluser "${SUDO_USER:-${SUDO_USER:-$USER}}" libvirtd
sudo delgroup libvirtd

# APP libreoffice
# HOST *
# Office suite
sudo apt-get remove --yes aspell-nl libreoffice

# APP lidswitch
# HOST pc-van-hugo pc04
# Ignore closing laptop lid
sudo sed --in-place --expression='/^HandleLidSwitch=/d' /etc/systemd/logind.conf

# APP locate
# HOST pc06
# Find files quick
sudo apt-get remove --yes mlocate

# APP nautilus-admin
# HOST pc06
# Add administrative actions to the right-click menu
sudo apt-get remove --yes nautilus-admin

#-APP restricted-addons
# HOST *
# Essential software not already included due to legal or copyright reasons
sudo apt-get remove --yes ubuntu-restricted-addons libavcodec-extra
sudo apt autoremove --yes

#-APP ros
# HOST pc04
# Robot Operating System
:

# APP signal
# HOST pc06
# Messaging
sudo apt-get remove --yes signal-desktop
sudo rm --force /etc/apt/sources.list.d/signal-xenial.list* /usr/share/keyrings/signal-desktop-keyring.gpg*
sudo apt-get update

# APP sound-juicer
# HOST pc-van-emily
# CD ripper
sudo apt-get remove --yes sound-juicer

# APP ssh
# HOST pc01 pc06
# Secure SHell
sudo sed --in-place --expression='s/PermitRootLogin no/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config
sudo apt-get remove --yes ssh

# APP sushi
# HOST pc06
# Select a file, press the space bar, and a preview will appear
sudo apt-get remove --yes gnome-sushi

# APP teamviewer
# HOST *
# Remote control
sudo apt-get remove --yes teamviewer
sudo rm --force /etc/apt/sources.list.d/teamviewer.list* /usr/share/keyrings/teamviewer.gpg*
sudo apt-key del 0C1289C0 DEB49217
sudo apt-get update

# APP tree
# HOST pc06
# Display a directory structure
sudo apt-get remove --yes tree

# APP ufw
# HOST pc01 pc06
# Uncomplicated FireWall
sudo ufw disable
sudo apt-get remove --yes gufw

# APP virtualbox
# HOST pc-van-hugo
# Virtualization
sudo apt-get remove --yes virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso

# APP vlc
# HOST pc06
# Media player
sudo snap remove vlc

# APP wine
# HOST pc04
# Run Windows programs (Wine Is Not an Emulator)
sudo apt-get remove --yes wine winetricks playonlinux

# APP youtube-downloader
# HOST pc-van-hugo
# Download videos
sudo apt-get remove --yes youtubedl-gui
