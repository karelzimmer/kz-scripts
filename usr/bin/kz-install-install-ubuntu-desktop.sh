# shellcheck shell=bash
###############################################################################
# Install apps file for Ubuntu desktop.
#
# Written by Karel Zimmer <info@karelzimmer.nl>, CC0 1.0 Universal
# <https://creativecommons.org/publicdomain/zero/1.0>, 2009-2023.
###############################################################################

#  APP ansible
# DESC Configuration management, deployment, and task execution
# HOST pc06
sudo apt-get install --yes ansible

#  APP apport
# DESC Stop generating crash reports
# HOST *
sudo systemctl stop apport.service
sudo systemctl disable apport.service
sudo rm --force /var/crash/*
sudo sed --in-place --expression='s/enabled=1/enabled=0/' /etc/default/apport

#  APP bleachbit
# DESC Remove unnecessary files
# HOST pc-van-hugo
sudo apt-get install --yes bleachbit

#  APP bluetooth
# DESC Disable internal bluetooth adapter
# HOST pc01
echo 'SUBSYSTEM=="usb", ATTRS{idVendor}=="413c", ATTRS{idProduct}=="8187", ATTR{authorized}="0"' | sudo tee /etc/udev/rules.d/81-bluetooth-hci.rules

#  APP brightness
# DESC Set brightness
# HOST pc06
echo '#!/bin/sh' | sudo tee /etc/rc.local
echo 'echo 1900 > /sys/class/backlight/intel_backlight/brightness' | sudo tee --append /etc/rc.local
sudo chmod +x /etc/rc.local

#  APP calibre
# DESC E-book manager
# HOST pc-van-hugo pc04
sudo apt-get install --yes calibre

#  APP citrix
# DESC Telecommuting (Aka Citrix Workspace app, Citrix Receiver, and ICA Client)
# HOST pc-van-ria-en-toos
# Aka Citrix Workspace app, Citrix Receiver, and ICA Client.
# Dependency since Ubuntu 22.04.
wget --output-document=/tmp/libidn11.deb 'https://karelzimmer.nl/assets/citrix/libidn11_1.33-3_amd64.deb'
sudo apt-get install --yes /tmp/libidn11.deb
# This old version because a newer one doesn't work for Toos' work.
wget --output-document=/tmp/icaclient.deb 'https://karelzimmer.nl/assets/citrix/icaclient_20.04.0.21_amd64.deb'
sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes /tmp/icaclient.deb
sudo ln --symbolic --force /usr/share/ca-certificates/mozilla/* /opt/Citrix/ICAClient/keystore/cacerts
sudo c_rehash /opt/Citrix/ICAClient/keystore/cacerts
rm /tmp/icaclient.deb /tmp/libidn11.deb

#  APP clamav
# DESC Anti-virus
# HOST pc-van-hugo
sudo apt-get install --yes clamtk-gnome

#  APP cockpit
# DESC Web-based administration
# HOST pc06
# Web App: https://localhost:9090
sudo apt-get install --yes cockpit cockpit-pcp

#  APP cups-backend-bjnp
# DESC Support for Canon BJNP protocol
# HOST pc-van-emily
sudo apt-get install --yes cups-backend-bjnp

#  APP dual-monitor
# DESC Dual monitor login screen
# HOST pc06
if [[ -f /home/${SUDO_USER:-$USER}/.config/monitors.xml ]]; then sudo cp /home/"${SUDO_USER:-$USER}"/.config/monitors.xml ~gdm/.config/monitors.xml; fi
if [[ -f ~gdm/.config/monitors.xml ]]; then sudo chown gdm:gdm ~gdm/.config/monitors.xml; fi

#  APP exiftool
# DESC Read and change Exif tags
# HOST pc06
sudo apt-get install --yes libimage-exiftool-perl

#  APP force-x11
# DESC Use X 11 instead of Wayland
# HOST *
# With wayland issues with video playback and TeamViewer
# To check execute: echo $XDG_SESSION_TYPE (should output 'x11')
sudo sed --in-place --expression='s/#WaylandEnable=false/WaylandEnable=false/' /etc/gdm3/custom.conf

#  APP gast
# DESC Add user gast
# HOST pc01 pc06
sudo useradd --create-home --shell /bin/bash --comment 'Gast' gast || true
sudo passwd --delete gast

#  APP gimp
# DESC GNU Image Manipulation Program
# HOST pc-van-hugo pc06
sudo apt-get install --yes gimp gimp-help-en gimp-help-nl

#  APP gnome-gmail
# DESC Gmail as the preferred email application in GNOME
# HOST pc01 pc04 pc06
sudo apt-get install --yes gnome-gmail

#  APP gnome-tweaks
# DESC Adjust settings for GNOME
# HOST pc06
sudo apt-get install --yes gnome-tweaks

#  APP google-chrome
# DESC Google's webbrowser
# HOST *
# Extensions and apps are automatically installed with /etc/opt/chrome/policies/managed/kz.json from "kz.deb".
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] https://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
wget --output-document=- 'https://dl.google.com/linux/linux_signing_key.pub' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/google-chrome.gpg
sudo apt-get update
# Also install chrome-gnome-shell to make extensions.gnome.org work.
sudo apt-get install --yes google-chrome-stable chrome-gnome-shell
# The installation overwrites the newly added source-list.
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] https://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
# The installation adds an apt-key that is no longer needed.
sudo rm --force /etc/apt/trusted.gpg.d/google-chrome.gpg

#  APP google-earth
# DESC Globe
# HOST pc04
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-earth.gpg] https://dl.google.com/linux/earth/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-earth-pro.list
wget --output-document=- 'https://dl.google.com/linux/linux_signing_key.pub' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/google-earth.gpg
sudo apt-get update
sudo apt-get install --yes google-earth-pro-stable
# The installation overwrites the newly added source-list.
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-earth.gpg] https://dl.google.com/linux/earth/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-earth-pro.list

#  APP handbrake
# DESC DVD ripper
# HOST pc-van-emily
sudo apt-get install --yes handbrake

#  APP hosts
# DESC Add hosts
# HOST pc01 pc06
sudo sed --in-place --expression='/^192.168.1.83/d' /etc/hosts
sudo sed --in-place --expression='/^192.168.1.64/d' /etc/hosts
echo '192.168.1.83 pc06' | sudo tee --append /etc/hosts
echo '192.168.1.64 pc01' | sudo tee --append /etc/hosts

#  APP kvm
# DESC Kernel-based Virtual Machine
# HOST pc06
# Images are in /var/lib/libvirt/images/
# Dpkg::Options due to interaction due to restore /etc/libvirt configuration files.
sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes --option Dpkg::Options::="--force-confdef" --option Dpkg::Options::="--force-confold" cpu-checker qemu-kvm bridge-utils virt-manager

#  APP libreoffice
# DESC Office suite
# HOST *
sudo apt-get install --yes aspell-nl libreoffice

#  APP lidswitch
# DESC Ignore closing laptop lid
# HOST pc-van-hugo pc04
sudo sed --in-place --expression='/^HandleLidSwitch=/d' /etc/systemd/logind.conf
echo 'HandleLidSwitch=ignore' | sudo tee --append /etc/systemd/logind.conf

#  APP locate
# DESC Find files quick
# HOST pc06
sudo apt-get install --yes mlocate

#  APP nautilus-admin
# DESC Add administrative actions to the right-click menu
# HOST pc06
sudo apt-get install --yes nautilus-admin

# -APP restricted-addons
# DESC Essential software not already included due to legal or copyright reasons
# HOST *
# No ubuntu-restricted-extras due to unreliable installation of ttf-mscorefonts-installer, do install libavcodec-extra from that metapackage
sudo apt-get install --yes ubuntu-restricted-addons libavcodec-extra

#  APP ros
# DESC Robot Operating System
# HOST pc04
:

#  APP signal
# DESC Messaging
# HOST pc06
# Web App: n/a
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main'| sudo tee /etc/apt/sources.list.d/signal-xenial.list
wget --output-document=- 'https://updates.signal.org/desktop/apt/keys.asc' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/signal-desktop-keyring.gpg
sudo apt-get update
sudo apt-get install --yes signal-desktop

#  APP sound-juicer
# DESC CD ripper
# HOST pc-van-emily
sudo apt-get install --yes sound-juicer

#  APP ssh
# DESC Secure SHell
# HOST pc01 pc06
sudo apt-get install --yes ssh
sudo sed --in-place --expression='s/PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
# Check for remote root access
grep --quiet --regexp='PermitRootLogin no' /etc/ssh/sshd_config
sudo systemctl restart ssh.service

#  APP sushi
# DESC Select a file, press the space bar, and a preview will appear
# HOST pc06
sudo apt-get install --yes gnome-sushi

#  APP teamviewer
# DESC Remote control
# HOST *
# Web App: https://web.teamviewer.com
echo 'deb [signed-by=/usr/share/keyrings/teamviewer.gpg] https://linux.teamviewer.com/deb stable main' | sudo tee /etc/apt/sources.list.d/teamviewer.list
wget --output-document=- 'https://download.teamviewer.com/download/linux/signature/TeamViewer2017.asc' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/teamviewer.gpg
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes teamviewer
# The installation adds an apt-key that is no longer needed.
sudo apt-key del 0C1289C0 DEB49217

#  APP tree
# DESC Display a directory structure
# HOST pc06
sudo apt-get install --yes tree

#  APP ufw
# DESC Uncomplicated FireWall
# HOST pc01 pc06
sudo apt-get install --yes gufw
sudo ufw allow ssh
sudo ufw enable

#  APP virtualbox
# DESC Virtualization
# HOST pc-van-hugo
# If installation hangs, the computer has UEFI Secure Boot, see the log:
# ----------------------------------------------------------------------------
# Configuring Secure Boot
# -----------------------
#
# Your system has UEFI Secure Boot enabled.
#
# UEFI Secure Boot requires additional configuration to work with third-party
# drivers.
#
# The system will assist you in configuring UEFI Secure Boot. To permit the
# use of third-party drivers, a new Machine-Owner Key MOK has been generated.
# This key now needs to be enrolled in your system's firmware.
#
# To ensure that this change is being made by you as an authorized user, and
# not by an attacker, you must choose a password now and then confirm the
# change after reboot using the same password, in both the "Enroll MOK" and
# "Change Secure Boot state" menus that will be presented to you when this
# system reboots.
#
# If you proceed but do not confirm the password upon reboot, Ubuntu will
# still be able to boot on your system but any hardware that requires
# third-party drivers to work correctly may not be usable.
# ----------------------------------------------------------------------------
# Steps to take:
# 1. Reboot.
# 2. Run kz update, who does a repair, among other things.
# 3. Provide a Secure Boot password and remember it.
# 4. Reboot.
# 5. Enroll MOK and provide the Secure Boot password from step 3.
#
# With an AMD processor, AMD-V will be enabled, but Intel often requires VT-x
# be enabled in the UEFI BIOS screen !
echo 'virtualbox-ext-pack virtualbox-ext-pack/license select true' | sudo debconf-set-selections
# VirtualBox Guest Additions ISO are in /usr/share/virtualbox/
sudo apt-get install --yes virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso

#  APP vlc
# DESC Media player
# HOST pc06
sudo snap install vlc

#  APP vscode
# DESC Editor
# HOST pc01 pc06
sudo snap install --classic code

#  APP wine
# DESC Run Windows programs (Wine Is Not an Emulator)
# HOST pc04
sudo apt-get install --yes wine winetricks playonlinux

#  APP youtube-downloader
# DESC Download videos
# HOST pc-van-hugo
sudo apt-get install --yes youtubedl-gui