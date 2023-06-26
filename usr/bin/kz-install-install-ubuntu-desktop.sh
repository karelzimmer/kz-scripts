# shellcheck shell=bash
###############################################################################
# Install apps file for Ubuntu desktop.
#
# Written by Karel Zimmer <info@karelzimmer.nl>, CC0 1.0 Universal
# <https://creativecommons.org/publicdomain/zero/1.0>, 2009-2023.
###############################################################################

#  APP ansible
# HOST pc06
sudo apt-get install --yes ansible

#  APP apport
# HOST *
sudo systemctl stop apport.service
sudo systemctl disable apport.service
sudo rm --force /var/crash/*
sudo sed --in-place --expression='s/enabled=1/enabled=0/' /etc/default/apport

#  APP bleachbit
# HOST pc-van-hugo
sudo apt-get install --yes bleachbit

#  APP bluetooth
# HOST pc01
# Disable internal bluetooth adapter, see: lsusb
echo 'SUBSYSTEM=="usb", ATTRS{idVendor}=="413c", ATTRS{idProduct}=="8187", ATTR{authorized}="0"' | sudo tee /etc/udev/rules.d/81-bluetooth-hci.rules

#  APP brightness
# HOST pc06
echo '#!/bin/sh' | sudo tee /etc/rc.local
echo 'echo 1900 > /sys/class/backlight/intel_backlight/brightness' | sudo tee --append /etc/rc.local
sudo chmod +x /etc/rc.local

#  APP calibre
# HOST pc-van-hugo pc04
sudo apt-get install --yes calibre

#  APP citrix
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
# HOST pc-van-hugo
sudo apt-get install --yes clamtk-gnome

#  APP cockpit
# HOST pc06
# Web App: https://localhost:9090
sudo apt-get install --yes cockpit cockpit-pcp

#  APP cups
# HOST pc-van-emily
# Add support for Canon BJNP protocol
sudo apt-get install --yes cups-backend-bjnp

#  APP dual-monitor
# HOST pc06
if [[ -f /home/${SUDO_USER:-$USER}/.config/monitors.xml ]]; then sudo cp /home/"${SUDO_USER:-$USER}"/.config/monitors.xml ~gdm/.config/monitors.xml; fi
if [[ -f ~gdm/.config/monitors.xml ]]; then sudo chown gdm:gdm ~gdm/.config/monitors.xml; fi

#  APP exiftool
# HOST pc06
sudo apt-get install --yes libimage-exiftool-perl

#  APP gast
# HOST pc01 pc06
sudo useradd --create-home --shell /bin/bash --comment 'Gast' gast || true
sudo passwd --delete gast

#  APP gimp
# HOST pc-van-hugo pc06
sudo apt-get install --yes gimp gimp-help-en gimp-help-nl

#  APP gnome-gmail
# HOST pc01 pc04 pc06
sudo apt-get install --yes gnome-gmail

#  APP gnome-tweaks
# HOST pc06
sudo apt-get install --yes gnome-tweaks

#  APP google-chrome
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
# HOST pc04
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-earth.gpg] https://dl.google.com/linux/earth/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-earth-pro.list
wget --output-document=- 'https://dl.google.com/linux/linux_signing_key.pub' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/google-earth.gpg
sudo apt-get update
sudo apt-get install --yes google-earth-pro-stable
# The installation overwrites the newly added source-list.
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-earth.gpg] https://dl.google.com/linux/earth/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-earth-pro.list

#  APP handbrake
# HOST pc-van-emily
sudo apt-get install --yes handbrake

#  APP hosts
# HOST pc01 pc06
sudo sed --in-place --expression='/^192.168.1.83/d' /etc/hosts
sudo sed --in-place --expression='/^192.168.1.64/d' /etc/hosts
echo '192.168.1.83 pc06' | sudo tee --append /etc/hosts
echo '192.168.1.64 pc01' | sudo tee --append /etc/hosts

#  APP kvm
# HOST pc06
# Images are in /var/lib/libvirt/images/
# Dpkg::Options due to interaction due to restore /etc/libvirt configuration files.
sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes --option Dpkg::Options::="--force-confdef" --option Dpkg::Options::="--force-confold" cpu-checker qemu-kvm bridge-utils virt-manager

#  APP libreoffice
# HOST *
sudo apt-get install --yes aspell-nl libreoffice

#  APP lidswitch
# HOST pc-van-hugo pc04
sudo sed --in-place --expression='/^HandleLidSwitch=/d' /etc/systemd/logind.conf
echo 'HandleLidSwitch=ignore' | sudo tee --append /etc/systemd/logind.conf

#  APP locate
# HOST pc06
sudo apt-get install --yes mlocate

#  APP nautilus-admin
# HOST pc06
sudo apt-get install --yes nautilus-admin

#  APP restricted-addons
# HOST *
# No ubuntu-restricted-extras due to unreliable installation of ttf-mscorefonts-installer, do install libavcodec-extra from that metapackage
sudo apt-get install --yes ubuntu-restricted-addons libavcodec-extra

#  APP ros
# HOST pc04
:

#  APP signal
# HOST pc06
# Web App: n/a
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main'| sudo tee /etc/apt/sources.list.d/signal-xenial.list
wget --output-document=- 'https://updates.signal.org/desktop/apt/keys.asc' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/signal-desktop-keyring.gpg
sudo apt-get update
sudo apt-get install --yes signal-desktop

#  APP sound-juicer
# HOST pc-van-emily
sudo apt-get install --yes sound-juicer

#  APP ssh
# HOST pc01 pc06
sudo apt-get install --yes ssh
sudo sed --in-place --expression='s/PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
# Check for remote root access
grep --quiet --regexp='PermitRootLogin no' /etc/ssh/sshd_config
sudo systemctl restart ssh.service

#  APP sushi
# HOST pc06
# Select a file, press the space bar, and a preview will appear.
sudo apt-get install --yes gnome-sushi

#  APP teamviewer
# HOST *
# Web App: https://web.teamviewer.com
echo 'deb [signed-by=/usr/share/keyrings/teamviewer.gpg] https://linux.teamviewer.com/deb stable main' | sudo tee /etc/apt/sources.list.d/teamviewer.list
wget --output-document=- 'https://download.teamviewer.com/download/linux/signature/TeamViewer2017.asc' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/teamviewer.gpg
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes teamviewer
# The installation adds an apt-key that is no longer needed.
sudo apt-key del 0C1289C0 DEB49217

#  APP tree
# HOST pc06
sudo apt-get install --yes tree

#  APP ufw
# HOST pc01 pc06
sudo apt-get install --yes gufw
sudo ufw allow ssh
sudo ufw enable

#  APP virtualbox
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
# HOST pc06
sudo snap install vlc

#  APP vscode
# HOST pc01 pc06
sudo snap install --classic code

#  APP wine
# HOST pc04
sudo apt-get install --yes wine winetricks playonlinux

#  APP x11
# HOST *
# Fore to use x11. With wayland issues with video playback and TeamViewer.
# To check execute: echo $XDG_SESSION_TYPE (should output 'x11')
sudo sed --in-place --expression='s/#WaylandEnable=false/WaylandEnable=false/' /etc/gdm3/custom.conf

#  APP youtube-downloader
# HOST pc-van-hugo
sudo apt-get install --yes youtubedl-gui
