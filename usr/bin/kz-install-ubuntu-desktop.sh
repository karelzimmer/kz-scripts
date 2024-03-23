# shellcheck shell=bash
###############################################################################
# Install file for Ubuntu desktop.
#
# Written by Karel Zimmer <info@karelzimmer.nl>, CC0 1.0 Universal
# <https://creativecommons.org/publicdomain/zero/1.0>, 2009.
###############################################################################

# Install APP ansible HOST pc06
sudo apt-get install --yes ansible

# Remove APP ansible HOST pc06
sudo apt-get remove --yes ansible


# Install APP anydesk HOST
# Web app: https://my.anydesk.com/v2
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/anydesk.gpg] http://deb.anydesk.com/ all main' | sudo tee /etc/apt/sources.list.d/anydesk.list > /dev/null
wget --output-document=- 'https://keys.anydesk.com/repos/DEB-GPG-KEY' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/anydesk.gpg
sudo apt-get update
sudo apt-get install --yes anydesk

# Remove APP anydesk HOST
sudo apt-get remove --yes anydesk
sudo rm --force --verbose /etc/apt/sources.list.d/anydesk.list* /usr/share/keyrings/anydesk.gpg*
sudo apt-get update


# Install APP apport HOST *
sudo systemctl stop apport.service
sudo systemctl disable apport.service
sudo rm --force --verbose /var/crash/*
sudo sed --in-place --expression='s/enabled=1/enabled=0/' /etc/default/apport

# Remove APP apport HOST *
sudo sed --in-place --expression='s/enabled=0/enabled=1/' /etc/default/apport
sudo systemctl enable --now apport.service


# Install APP bleachbit HOST pc-van-hugo
sudo apt-get install --yes bleachbit

# Remove APP bleachbit HOST pc-van-hugo
sudo apt-get remove --yes bleachbit


# Install APP calibre HOST pc06 pc-van-hugo
sudo apt-get install --yes calibre

# Remove APP calibre HOST pc06 pc-van-hugo
sudo apt-get remove --yes calibre


# Install APP clamav HOST pc-van-hugo
sudo apt-get install --yes clamtk-gnome

# Remove APP clamav HOST pc-van-hugo
sudo apt-get remove --yes clamtk-gnome


# Install APP cockpit HOST pc06
# Web app: https://localhost:9090
sudo apt-get install --yes cockpit cockpit-pcp

# Remove APP cockpit HOST pc06
sudo apt-get remove --yes cockpit


# Install APP cups-backend-bjnp HOST pc-van-emily
# Add support for Canon USB over IP BJNP protocol
sudo apt-get install --yes cups-backend-bjnp

# Remove APP cups-backend-bjnp HOST pc-van-emily
sudo apt-get remove --yes cups-backend-bjnp


# Install APP disable-aer HOST pc06
# Disable kernel config parameter PCIEAER (Peripheral Component Interconnect
# Express Advanced Error Reporting) to prevent the log gets flooded with
# 'AER: Corrected errors received'.  Usually needed for HP hardware.
sudo sed --in-place --expression='s/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash pci=noaer"/' /etc/default/grub
sudo update-grub
# Check for kernel config parameter pci=noaer.
grep --quiet --regexp='pci=noaer' /etc/default/grub

# Remove APP disable-aer HOST pc06
sudo sed --in-place --expression='s/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash pci=noaer"/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash pci=noaer"/' /etc/default/grub
sudo update-grub
# Check for kernel config parameter pci=noaer.
! grep --quiet --regexp='pci=noaer' /etc/default/grub


# Install APP exiftool HOST pc06
sudo apt-get install --yes libimage-exiftool-perl

# Remove APP exiftool HOST pc06
sudo apt-get remove --yes libimage-exiftool-perl


# Install APP fdupes HOST
# Usage:
# fdupes -r /home               # Report recursively from /home
# fdupes -d /path/to/folder     # Remove, interactively, from /path/to/folder
# fdupes -d -N /path/to/folder  # Delete, from /path/to/folder
sudo apt-get install --yes fdupes

# Remove APP fdupes HOST
sudo apt-get remove --yes fdupes


# Install APP force-x11 HOST
# Force the use of X11 because Wayland is not (yet) supported by remote desktop app AnyDesk.
# Force means no choice @ user login for X11 or Wayland!
# To check, after reboot (!), execute: echo $XDG_SESSION_TYPE (should output 'x11')
sudo sed --in-place --expression='s/^#WaylandEnable=false/WaylandEnable=false/' /etc/gdm3/custom.conf

# Remove APP force-x11 HOST
# Force the use of X11 because Wayland is not (yet) supported by remote desktop apps such as AnyDesk and TeamViewer.
# Force means no choice @ user login for X11 or Wayland!
# To check, after reboot (!), execute: echo $XDG_SESSION_TYPE (should output 'wayland')
sudo sed --in-place --expression='s/^WaylandEnable=false/#WaylandEnable=false/' /etc/gdm3/custom.conf


# Install APP fwupd HOST
# Disable the Firmware update daemon
sudo systemctl stop fwupd.service       # Stop the service
sudo systemctl disable fwupd.service    # Disable automatic start upon boot
sudo systemctl mask fwupd.service       # Disable manual invoking

# Remove APP fwupd HOST
# Enable the Firmware update daemon
systemctl unmask fwupd.service
sudo systemctl enable fwupd.service
sudo systemctl start fwupd.service


# Install APP gimp HOST pc06 pc-van-hugo
sudo apt-get install --yes gimp gimp-help-en gimp-help-nl

# Remove APP gimp HOST pc06 pc-van-hugo
sudo apt-get remove --yes gimp gimp-help-en gimp-help-nl


# Install APP gnome-gmail HOST pc01 pc06
sudo apt-get install --yes gnome-gmail

# Remove APP gnome-gmail HOST pc01 pc06
sudo apt-get remove --yes gnome-gmail


# Install APP gnome-tweaks HOST *
sudo apt-get install --yes gnome-tweaks

# Remove APP gnome-tweaks HOST *
sudo apt-get remove --yes gnome-tweaks


# Install APP gnome-web HOST pc06
sudo apt-get install --yes epiphany-browser

# Remove APP gnome-web HOST pc06
sudo apt-get remove --yes epiphany-browser


# Install APP google-chrome HOST pc01 pc02 pc06
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

# Remove APP google-chrome HOST pc01 pc02 pc06
sudo apt-get remove --yes google-chrome-stable chrome-gnome-shell
sudo rm --force --verbose /etc/apt/sources.list.d/google-chrome.list* /usr/share/keyrings/google-chrome.gpg* /etc/apt/trusted.gpg.d/google-chrome.gpg
sudo apt-get update


# Install APP google-earth HOST
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-earth.gpg] https://dl.google.com/linux/earth/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-earth-pro.list > /dev/null
wget --output-document=- 'https://dl.google.com/linux/linux_signing_key.pub' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/google-earth.gpg
sudo apt-get update
sudo apt-get install --yes google-earth-pro-stable
# The installation overwrites the newly added source-list.
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-earth.gpg] https://dl.google.com/linux/earth/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-earth-pro.list > /dev/null

# Remove APP google-earth HOST
sudo apt-get remove --yes google-earth-pro-stable
sudo rm --force --verbose /etc/apt/sources.list.d/google-earth-pro.list* /usr/share/keyrings/google-earth.gpg*
sudo apt-get update


# Install APP grub-timeout HOST *
sudo sed --in-place --expression='s/GRUB_TIMEOUT=10/GRUB_TIMEOUT=3/' /etc/default/grub
sudo update-grub

# Remove APP grub-timeout HOST *
sudo sed --in-place --expression='s/GRUB_TIMEOUT=3/GRUB_TIMEOUT=10/' /etc/default/grub
sudo update-grub


# Install APP guest HOST
sudo useradd --create-home --shell /usr/bin/bash --comment "$(gettext --domain=kz 'Guest')" "$(gettext --domain=kz 'guest')" || true
sudo passwd --delete "$(gettext --domain=kz 'guest')"

# Remove APP guest HOST
sudo userdel --remove "$(gettext --domain=kz 'guest')"


# Install APP handbrake HOST pc-van-emily
sudo apt-get install --yes handbrake

# Remove APP handbrake HOST pc-van-emily
sudo apt-get remove --yes handbrake


# Install APP handlelidswitch HOST pc-van-hugo
sudo sed --in-place --expression='/^HandleLidSwitch=/d' /etc/systemd/logind.conf
echo 'HandleLidSwitch=ignore' | sudo tee --append /etc/systemd/logind.conf > /dev/null

# Remove APP handlelidswitch HOST pc-van-hugo
sudo sed --in-place --expression='/^HandleLidSwitch=/d' /etc/systemd/logind.conf


# Install APP hostnames HOST pc01 pc06
sudo sed --in-place --expression='/^192.168.1.83/d' /etc/hosts
sudo sed --in-place --expression='/^192.168.1.100/d' /etc/hosts
sudo sed --in-place --expression='2a192.168.1.100 pc01' /etc/hosts
sudo sed --in-place --expression='3a192.168.1.83 pc06' /etc/hosts

# Remove APP hostnames HOST pc01 pc06
sudo sed --in-place --expression='/^192.168.1.83/d' /etc/hosts
sudo sed --in-place --expression='/^192.168.1.100/d' /etc/hosts


# Install APP htop HOST pc06
sudo apt-get install --yes htop

# Remove APP htop HOST pc06
sudo apt-get remove --yes htop


# Install APP krita HOST pc06
sudo apt-get install --yes krita

# Remove APP kvm HOST pc06
sudo apt-get remove --yes krita


# Install APP kvm HOST pc06
# Images are in /var/lib/libvirt/images/
# Dpkg::Options due to interaction due to restore /etc/libvirt configuration files.
sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes --option Dpkg::Options::="--force-confdef" --option Dpkg::Options::="--force-confold" cpu-checker qemu-kvm bridge-utils virt-manager

# Remove APP kvm HOST pc06
sudo apt-get remove --yes cpu-checker qemu-kvm bridge-utils virt-manager
sudo delgroup libvirtd-dnsmasq
sudo deluser "${SUDO_USER:-${SUDO_USER:-$USER}}" libvirtd
sudo delgroup libvirtd


# Install APP libreoffice HOST *
sudo apt-get install --yes aspell-en aspell-nl libreoffice

# Remove APP libreoffice HOST *
sudo apt-get remove --yes aspell-en aspell-nl libreoffice


# Install APP locate HOST pc06
sudo apt-get install --yes mlocate

# Remove APP locate HOST pc06
sudo apt-get remove --yes mlocate


# Install APP monitors HOST pc06
if [[ -f /home/${SUDO_USER:-$USER}/.config/monitors.xml ]]; then sudo cp  --preserve --verbose /home/"${SUDO_USER:-$USER}"/.config/monitors.xml ~gdm/.config/monitors.xml; fi
if [[ -f ~gdm/.config/monitors.xml ]]; then sudo chown --verbose gdm:gdm ~gdm/.config/monitors.xml; fi

# Remove APP monitors HOST pc06
sudo rm --force --verbose ~gdm/.config/monitors.xml


# Install APP nautilus-admin HOST pc06
sudo apt-get install --yes nautilus-admin

# Remove APP nautilus-admin HOST pc06
sudo apt-get remove --yes nautilus-admin


# Install APP procs HOST pc06
sudo snap install procs

# Remove APP procs HOST pc06
sudo snap remove procs


# Install APP repair-ntfs HOST
# Usage:
# findmnt
# TARGET          SOURCE    FSTYPE OPTIONS
# /media/...      /dev/sdb2 ntfs3  rw,nosuid,nodev,relatime,uid=...
# sudo ntfsfix /dev/sdb2
sudo apt-get install --yes ntfs-3g

# Remove APP repair-ntfs HOST
sudo apt-get remove --yes ntfs-3g


# Install APP signal HOST pc06
# Web app: n/a
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main'| sudo tee /etc/apt/sources.list.d/signal-xenial.list > /dev/null
wget --output-document=- 'https://updates.signal.org/desktop/apt/keys.asc' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/signal-desktop-keyring.gpg
sudo apt-get update
sudo apt-get install --yes signal-desktop

# Remove APP signal HOST pc06
sudo apt-get remove --yes signal-desktop
sudo rm --force --verbose /etc/apt/sources.list.d/signal-xenial.list* /usr/share/keyrings/signal-desktop-keyring.gpg*
sudo apt-get update


# Install APP sound-juicer HOST pc-van-emily
sudo apt-get install --yes sound-juicer

# Remove APP sound-juicer HOST pc-van-emily
sudo apt-get remove --yes sound-juicer


# Install APP ssh HOST pc01 pc06
sudo apt-get install --yes ssh
sudo sed --in-place --expression='s/PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
# Check for remote root access
grep --quiet --regexp='PermitRootLogin no' /etc/ssh/sshd_config
sudo systemctl restart ssh.service

# Remove APP ssh HOST pc01 pc06
sudo sed --in-place --expression='s/PermitRootLogin no/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config
sudo apt-get remove --yes ssh


# Install APP sushi HOST pc06
# Select a file, press the space bar, and a preview will appear.
sudo apt-get install --yes gnome-sushi

# Remove APP sushi HOST pc06
sudo apt-get remove --yes gnome-sushi


# Install APP teamviewer HOST *
# Web app: https://web.teamviewer.com
echo 'deb [signed-by=/usr/share/keyrings/teamviewer.gpg] https://linux.teamviewer.com/deb stable main' | sudo tee /etc/apt/sources.list.d/teamviewer.list > /dev/null
wget --output-document=- 'https://download.teamviewer.com/download/linux/signature/TeamViewer2017.asc' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/teamviewer.gpg
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes teamviewer
# The installation adds an apt-key that is no longer needed.
sudo apt-key del 0C1289C0 DEB49217

# Remove APP teamviewer HOST *
sudo apt-get remove --yes teamviewer
sudo rm --force --verbose /etc/apt/sources.list.d/teamviewer.list* /usr/share/keyrings/teamviewer*.gpg*
sudo apt-key del 0C1289C0 DEB49217
sudo apt-get update


# Install APP tree HOST pc06
sudo apt-get install --yes tree

# Remove APP tree HOST pc06
sudo apt-get remove --yes tree


# Install APP ufw HOST pc01 pc06
sudo apt-get install --yes gufw
sudo ufw allow ssh
sudo ufw enable

# Remove APP ufw HOST pc01 pc06
sudo ufw disable
sudo apt-get remove --yes gufw


# Install APP virtualbox HOST pc-van-hugo
# If installation hangs or VBox does not work, check Linux-info.txt.
echo 'virtualbox-ext-pack virtualbox-ext-pack/license select true' | sudo debconf-set-selections
# VirtualBox Guest Additions ISO are in /usr/share/virtualbox/
sudo apt-get install --yes virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso

# Remove APP virtualbox HOST pc-van-hugo
sudo apt-get remove --yes virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso


# Install APP vlc HOST *
sudo snap install vlc

# Remove APP vlc HOST *
sudo snap remove vlc


# Install APP vscode HOST pc01 pc06
sudo snap install --classic code

# Remove APP vscode HOST pc01 pc06
sudo snap remove code


# Install APP wine HOST
sudo apt-get install --yes wine winetricks playonlinux

# Remove APP wine HOST
sudo apt-get remove --yes wine winetricks playonlinux


# Install APP youtube-dl HOST pc-van-emily pc-van-hugo
sudo apt-get install --yes youtubedl-gui

# Remove APP youtube-dl HOST pc-van-emily pc-van-hugo
sudo apt-get remove --yes youtubedl-gui
