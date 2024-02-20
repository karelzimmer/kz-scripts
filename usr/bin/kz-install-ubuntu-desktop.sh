# shellcheck shell=bash
###############################################################################
# Install file for Ubuntu desktop.
#
# Written by Karel Zimmer <info@karelzimmer.nl>, CC0 1.0 Universal
# <https://creativecommons.org/publicdomain/zero/1.0>, 2009-2024.
###############################################################################

# install APP ansible HOST pc06
sudo apt-get install --yes ansible

# remove APP ansible HOST pc06
sudo apt-get remove --yes ansible


# install APP anydesk HOST
# Web app: https://my.anydesk.com/v2
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/anydesk.gpg] http://deb.anydesk.com/ all main' | sudo tee /etc/apt/sources.list.d/anydesk.list > /dev/null
wget --output-document=- 'https://keys.anydesk.com/repos/DEB-GPG-KEY' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/anydesk.gpg
sudo apt-get update
sudo apt-get install --yes anydesk

# remove APP anydesk HOST
sudo apt-get remove --yes anydesk
sudo rm --force --verbose /etc/apt/sources.list.d/anydesk.list* /usr/share/keyrings/anydesk.gpg*
sudo apt-get update


# install APP apport HOST *
sudo systemctl stop apport.service
sudo systemctl disable apport.service
sudo rm --force --verbose /var/crash/*
sudo sed --in-place --expression='s/enabled=1/enabled=0/' /etc/default/apport

# remove APP apport HOST *
sudo sed --in-place --expression='s/enabled=0/enabled=1/' /etc/default/apport
sudo systemctl enable --now apport.service


# install APP bleachbit HOST pc-van-hugo
sudo apt-get install --yes bleachbit

# remove APP bleachbit HOST pc-van-hugo
sudo apt-get remove --yes bleachbit


# install APP calibre HOST pc06 pc-van-hugo
sudo apt-get install --yes calibre

# remove APP calibre HOST pc06 pc-van-hugo
sudo apt-get remove --yes calibre


# install APP clamav HOST pc-van-hugo
sudo apt-get install --yes clamtk-gnome

# remove APP clamav HOST pc-van-hugo
sudo apt-get remove --yes clamtk-gnome


# install APP cockpit HOST pc06
# Web app: https://localhost:9090
sudo apt-get install --yes cockpit cockpit-pcp

# remove APP cockpit HOST pc06
sudo apt-get remove --yes cockpit


# install APP cups-backend-bjnp HOST pc-van-emily
# Add support for Canon USB over IP BJNP protocol
sudo apt-get install --yes cups-backend-bjnp

# remove APP cups-backend-bjnp HOST pc-van-emily
sudo apt-get remove --yes cups-backend-bjnp


# install APP disable-aer HOST pc06
# Disable kernel config parameter PCIEAER (Peripheral Component Interconnect
# Express Advanced Error Reporting) to prevent the log gets flooded with
# 'AER: Corrected errors received'.  Usually needed for HP hardware.
sudo sed --in-place --expression='s/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash pci=noaer"/' /etc/default/grub
sudo update-grub
# Check for kernel config parameter pci=noaer.
grep --quiet --regexp='pci=noaer' /etc/default/grub

# remove APP disable-aer HOST pc06
sudo sed --in-place --expression='s/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash pci=noaer"/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash pci=noaer"/' /etc/default/grub
sudo update-grub
# Check for kernel config parameter pci=noaer.
! grep --quiet --regexp='pci=noaer' /etc/default/grub


# install APP exiftool HOST pc06
sudo apt-get install --yes libimage-exiftool-perl

# remove APP exiftool HOST pc06
sudo apt-get remove --yes libimage-exiftool-perl


# install APP fdupes HOST
# Usage:
# fdupes -r /home               # Report recursively from /home
# fdupes -d /path/to/folder     # Remove, interactively, from /path/to/folder
# fdupes -d -N /path/to/folder  # Delete, from /path/to/folder
sudo apt-get install --yes fdupes

# remove APP fdupes HOST
sudo apt-get remove --yes fdupes


# install APP force-x11 HOST
# Force the use of X11 because Wayland is not (yet) supported by remote desktop app AnyDesk.
# Force means no choice @ user login for X11 or Wayland!
# To check, after reboot (!), execute: echo $XDG_SESSION_TYPE (should output 'x11')
sudo sed --in-place --expression='s/^#WaylandEnable=false/WaylandEnable=false/' /etc/gdm3/custom.conf

# remove APP force-x11 HOST
# Force the use of X11 because Wayland is not (yet) supported by remote desktop apps such as AnyDesk and TeamViewer.
# Force means no choice @ user login for X11 or Wayland!
# To check, after reboot (!), execute: echo $XDG_SESSION_TYPE (should output 'wayland')
sudo sed --in-place --expression='s/^WaylandEnable=false/#WaylandEnable=false/' /etc/gdm3/custom.conf


# install APP fwupd HOST
# Disable the Firmware update daemon
sudo systemctl stop fwupd.service       # Stop the service
sudo systemctl disable fwupd.service    # Disable automatic start upon boot
sudo systemctl mask fwupd.service       # Disable manual invoking

# remove APP fwupd HOST
# Enable the Firmware update daemon
systemctl unmask fwupd.service
sudo systemctl enable fwupd.service
sudo systemctl start fwupd.service


# install APP gimp HOST pc06 pc-van-hugo
sudo apt-get install --yes gimp gimp-help-en gimp-help-nl

# remove APP gimp HOST pc06 pc-van-hugo
sudo apt-get remove --yes gimp gimp-help-en gimp-help-nl


# install APP gnome-gmail HOST pc01 pc06
sudo apt-get install --yes gnome-gmail

# remove APP gnome-gmail HOST pc01 pc06
sudo apt-get remove --yes gnome-gmail


# install APP gnome-tweaks HOST *
sudo apt-get install --yes gnome-tweaks

# remove APP gnome-tweaks HOST *
sudo apt-get remove --yes gnome-tweaks


# install APP gnome-web HOST pc06
sudo apt-get install --yes epiphany-browser

# remove APP gnome-web HOST pc06
sudo apt-get remove --yes epiphany-browser


# install APP google-chrome HOST pc01 pc02 pc06
# Extensions and policies are applied by "kz.deb" policy file policies.json, for Chrome in /etc/opt/chrome/policies/managed/, for Firefox in /etc/firefox/policies/.
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] https://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list > /dev/null
wget --output-document=- 'https://dl.google.com/linux/linux_signing_key.pub' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/google-chrome.gpg
sudo apt-get update
# Also install chrome-gnome-shell to make extensions.gnome.org work.
sudo apt-get install --yes google-chrome-stable chrome-gnome-shell
# The installation overwrites the newly added source-list.
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] https://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list > /dev/null
# The installation adds an apt-key that is no longer needed.
sudo rm --force --verbose /etc/apt/trusted.gpg.d/google-chrome.gpg

# remove APP google-chrome HOST pc01 pc02 pc06
sudo apt-get remove --yes google-chrome-stable chrome-gnome-shell
sudo rm --force --verbose /etc/apt/sources.list.d/google-chrome.list* /usr/share/keyrings/google-chrome.gpg* /etc/apt/trusted.gpg.d/google-chrome.gpg
sudo apt-get update


# install APP google-earth HOST
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-earth.gpg] https://dl.google.com/linux/earth/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-earth-pro.list > /dev/null
wget --output-document=- 'https://dl.google.com/linux/linux_signing_key.pub' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/google-earth.gpg
sudo apt-get update
sudo apt-get install --yes google-earth-pro-stable
# The installation overwrites the newly added source-list.
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-earth.gpg] https://dl.google.com/linux/earth/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-earth-pro.list > /dev/null

# remove APP google-earth HOST
sudo apt-get remove --yes google-earth-pro-stable
sudo rm --force --verbose /etc/apt/sources.list.d/google-earth-pro.list* /usr/share/keyrings/google-earth.gpg*
sudo apt-get update


# install APP grub-timeout HOST *
sudo sed --in-place --expression='s/GRUB_TIMEOUT=10/GRUB_TIMEOUT=3/' /etc/default/grub
sudo update-grub

# remove APP grub-timeout HOST *
sudo sed --in-place --expression='s/GRUB_TIMEOUT=3/GRUB_TIMEOUT=10/' /etc/default/grub
sudo update-grub


# install APP guest HOST
sudo useradd --create-home --shell /usr/bin/bash --comment "$(gettext --domain=kz 'Guest')" "$(gettext --domain=kz 'guest')" || true
sudo passwd --delete "$(gettext --domain=kz 'guest')"

# remove APP guest HOST
sudo userdel --remove "$(gettext --domain=kz 'guest')"


# install APP handbrake HOST pc-van-emily
sudo apt-get install --yes handbrake

# remove APP handbrake HOST pc-van-emily
sudo apt-get remove --yes handbrake


# install APP handlelidswitch HOST pc-van-hugo
sudo sed --in-place --expression='/^HandleLidSwitch=/d' /etc/systemd/logind.conf
echo 'HandleLidSwitch=ignore' | sudo tee --append /etc/systemd/logind.conf > /dev/null

# remove APP handlelidswitch HOST pc-van-hugo
sudo sed --in-place --expression='/^HandleLidSwitch=/d' /etc/systemd/logind.conf


# install APP hostnames HOST pc01 pc06
sudo sed --in-place --expression='/^192.168.1.83/d' /etc/hosts
sudo sed --in-place --expression='/^192.168.1.100/d' /etc/hosts
sudo sed --in-place --expression='2a192.168.1.100 pc01' /etc/hosts
sudo sed --in-place --expression='3a192.168.1.83 pc06' /etc/hosts

# remove APP hostnames HOST pc01 pc06
sudo sed --in-place --expression='/^192.168.1.83/d' /etc/hosts
sudo sed --in-place --expression='/^192.168.1.100/d' /etc/hosts


# install APP htop HOST pc06
sudo apt-get install --yes htop

# remove APP htop HOST pc06
sudo apt-get remove --yes htop


# install APP kvm HOST pc06
# Images are in /var/lib/libvirt/images/
# Dpkg::Options due to interaction due to restore /etc/libvirt configuration files.
sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes --option Dpkg::Options::="--force-confdef" --option Dpkg::Options::="--force-confold" cpu-checker qemu-kvm bridge-utils virt-manager

# remove APP kvm HOST pc06
sudo apt-get remove --yes cpu-checker qemu-kvm bridge-utils virt-manager
sudo delgroup libvirtd-dnsmasq
sudo deluser "${SUDO_USER:-${SUDO_USER:-$USER}}" libvirtd
sudo delgroup libvirtd


# install APP libreoffice HOST *
sudo apt-get install --yes aspell-en aspell-nl libreoffice

# remove APP libreoffice HOST *
sudo apt-get remove --yes aspell-en aspell-nl libreoffice


# install APP locate HOST pc06
sudo apt-get install --yes mlocate

# remove APP locate HOST pc06
sudo apt-get remove --yes mlocate


# install APP monitors HOST pc06
if [[ -f /home/${SUDO_USER:-$USER}/.config/monitors.xml ]]; then sudo cp /home/"${SUDO_USER:-$USER}"/.config/monitors.xml ~gdm/.config/monitors.xml; fi
if [[ -f ~gdm/.config/monitors.xml ]]; then sudo chown gdm:gdm ~gdm/.config/monitors.xml; fi

# remove APP monitors HOST pc06
sudo rm --force --verbose ~gdm/.config/monitors.xml


# install APP nautilus-admin HOST pc06
sudo apt-get install --yes nautilus-admin

# remove APP nautilus-admin HOST pc06
sudo apt-get remove --yes nautilus-admin


# install APP repair-ntfs HOST
# Usage:
# findmnt
# TARGET          SOURCE    FSTYPE OPTIONS
# /media/...      /dev/sdb2 ntfs3  rw,nosuid,nodev,relatime,uid=...
# sudo ntfsfix /dev/sdb2
sudo apt-get install --yes ntfs-3g

# remove APP repair-ntfs HOST
sudo apt-get remove --yes ntfs-3g


# install APP signal HOST pc06
# Web app: n/a
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main'| sudo tee /etc/apt/sources.list.d/signal-xenial.list > /dev/null
wget --output-document=- 'https://updates.signal.org/desktop/apt/keys.asc' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/signal-desktop-keyring.gpg
sudo apt-get update
sudo apt-get install --yes signal-desktop

# remove APP signal HOST pc06
sudo apt-get remove --yes signal-desktop
sudo rm --force --verbose /etc/apt/sources.list.d/signal-xenial.list* /usr/share/keyrings/signal-desktop-keyring.gpg*
sudo apt-get update


# install APP sound-juicer HOST pc-van-emily
sudo apt-get install --yes sound-juicer

# remove APP sound-juicer HOST pc-van-emily
sudo apt-get remove --yes sound-juicer


# install APP ssh HOST pc01 pc06
sudo apt-get install --yes ssh
sudo sed --in-place --expression='s/PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
# Check for remote root access
grep --quiet --regexp='PermitRootLogin no' /etc/ssh/sshd_config
sudo systemctl restart ssh.service

# remove APP ssh HOST pc01 pc06
sudo sed --in-place --expression='s/PermitRootLogin no/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config
sudo apt-get remove --yes ssh


# install APP sushi HOST pc06
# Select a file, press the space bar, and a preview will appear.
sudo apt-get install --yes gnome-sushi

# remove APP sushi HOST pc06
sudo apt-get remove --yes gnome-sushi


# install APP teamviewer HOST *
# Web app: https://web.teamviewer.com
echo 'deb [signed-by=/usr/share/keyrings/teamviewer.gpg] https://linux.teamviewer.com/deb stable main' | sudo tee /etc/apt/sources.list.d/teamviewer.list > /dev/null
wget --output-document=- 'https://download.teamviewer.com/download/linux/signature/TeamViewer2017.asc' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/teamviewer.gpg
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes teamviewer
# The installation adds an apt-key that is no longer needed.
sudo apt-key del 0C1289C0 DEB49217

# remove APP teamviewer HOST *
sudo apt-get remove --yes teamviewer
sudo rm --force --verbose /etc/apt/sources.list.d/teamviewer.list* /usr/share/keyrings/teamviewer*.gpg*
sudo apt-key del 0C1289C0 DEB49217
sudo apt-get update


# install APP tree HOST pc06
sudo apt-get install --yes tree

# remove APP tree HOST pc06
sudo apt-get remove --yes tree


# install APP ufw HOST pc01 pc06
sudo apt-get install --yes gufw
sudo ufw allow ssh
sudo ufw enable

# remove APP ufw HOST pc01 pc06
sudo ufw disable
sudo apt-get remove --yes gufw


# install APP virtualbox HOST pc-van-hugo
# If installation hangs or VBox does not work, check Linux-info.txt.
echo 'virtualbox-ext-pack virtualbox-ext-pack/license select true' | sudo debconf-set-selections
# VirtualBox Guest Additions ISO are in /usr/share/virtualbox/
sudo apt-get install --yes virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso

# remove APP virtualbox HOST pc-van-hugo
sudo apt-get remove --yes virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso


# install APP vlc HOST *
sudo snap install vlc

# remove APP vlc HOST *
sudo snap remove vlc


# install APP vscode HOST pc01 pc06
sudo snap install --classic code

# remove APP vscode HOST pc01 pc06
sudo snap remove code


# install APP wine HOST
sudo apt-get install --yes wine winetricks playonlinux

# remove APP wine HOST
sudo apt-get remove --yes wine winetricks playonlinux


# install APP youtube-dl HOST pc-van-emily pc-van-hugo
sudo apt-get install --yes youtubedl-gui

# remove APP youtube-dl HOST pc-van-emily pc-van-hugo
sudo apt-get remove --yes youtubedl-gui
