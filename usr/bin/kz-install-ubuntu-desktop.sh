# shellcheck shell=bash
###############################################################################
# SPDX-FileComment: Install file for Ubuntu desktop
#
# SPDX-FileCopyrightText: Karel Zimmer <info@karelzimmer.nl>
# SPDX-License-Identifier: CC0-1.0
###############################################################################

########################## Execute this block first ###########################
# Install disabled-apport *
# Suppress the program crash report.
sudo systemctl stop apport.service
sudo systemctl disable apport.service
sudo rm --force --verbose /var/crash/*
sudo sed --in-place --expression='s/enabled=1/enabled=0/' /etc/default/apport

# Remove disabled-apport *
# Enable the program crash report.
sudo sed --in-place --expression='s/enabled=0/enabled=1/' /etc/default/apport
sudo systemctl enable --now apport.service


# Install update-system *
sudo apt-get update
sudo apt-get upgrade --yes
sudo snap refresh

# Remove update-system *
# There is no command available to remove update system.


# Install ubuntu-desktop *
# Necessary if "Default selection", i.e. ubuntu-desktop-minimal, was chosen during installation.
sudo apt-get install --yes ubuntu-desktop

# Remove ubuntu-desktop *
# sudo apt-get remove --yes ubuntu-desktop
########################## Execute this block first ###########################


# Install ansible pc06
sudo apt-get install --yes ansible

# Remove ansible pc06
sudo apt-get remove --yes ansible


# Install anydesk -nohost
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/anydesk.gpg] http://deb.anydesk.com/ all main' | sudo tee /etc/apt/sources.list.d/anydesk.list > /dev/null
wget --output-document=- 'https://keys.anydesk.com/repos/DEB-GPG-KEY' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/anydesk.gpg
sudo apt-get update
sudo apt-get install --yes anydesk
# Web app: https://my.anydesk.com/v2

# Remove anydesk -nohost
sudo apt-get remove --yes anydesk
sudo rm --force --verbose /etc/apt/sources.list.d/anydesk.list* /usr/share/keyrings/anydesk.gpg*
sudo apt-get update


# Install bleachbit pc-van-hugo
sudo apt-get install --yes bleachbit

# Remove bleachbit pc-van-hugo
sudo apt-get remove --yes bleachbit


# Install calibre pc06 pc-van-hugo
sudo apt-get install --yes calibre

# Remove calibre pc06 pc-van-hugo
sudo apt-get remove --yes calibre


# Install change-grub-timeout *
sudo sed --in-place --expression='s/GRUB_TIMEOUT=10/GRUB_TIMEOUT=3/' /etc/default/grub
sudo update-grub

# Remove change-grub-timeout *
sudo sed --in-place --expression='s/GRUB_TIMEOUT=3/GRUB_TIMEOUT=10/' /etc/default/grub
sudo update-grub


# Install clamav pc-van-hugo
sudo apt-get install --yes clamtk-gnome

# Remove clamav pc-van-hugo
sudo apt-get remove --yes clamtk-gnome


# Install cockpit pc06
sudo apt-get install --yes cockpit cockpit-pcp
# Web app: https://localhost:9090

# Remove cockpit pc06
sudo apt-get remove --yes cockpit


# Install cups-backend-bjnp pc-van-emily
# Add support for Canon USB over IP BJNP protocol.
sudo apt-get install --yes cups-backend-bjnp

# Remove cups-backend-bjnp pc-van-emily
sudo apt-get remove --yes cups-backend-bjnp


# Install disabled-aer pc06
# Disable kernel config parameter PCIEAER (Peripheral Component Interconnect Express Advanced Error Reporting) to prevent the log gets flooded with 'AER: Corrected errors received'. Usually needed for HP hardware.
sudo sed --in-place --expression='s/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash pci=noaer"/' /etc/default/grub
sudo update-grub
# Check for kernel config parameter pci=noaer.
grep --quiet --regexp='pci=noaer' /etc/default/grub

# Remove disabled-aer pc06
sudo sed --in-place --expression='s/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash pci=noaer"/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash pci=noaer"/' /etc/default/grub
sudo update-grub
# Check for kernel config parameter pci=noaer.
! grep --quiet --regexp='pci=noaer' /etc/default/grub


# Install disabled-lidswitch pc-van-hugo
sudo sed --in-place --expression='/^HandleLidSwitch=/d' /etc/systemd/logind.conf
echo 'HandleLidSwitch=ignore' | sudo tee --append /etc/systemd/logind.conf > /dev/null

# Remove disabled-lidswitch pc-van-hugo
sudo sed --in-place --expression='/^HandleLidSwitch=/d' /etc/systemd/logind.conf


# Install exiftool pc06
sudo apt-get install --yes libimage-exiftool-perl

# Remove exiftool pc06
sudo apt-get remove --yes libimage-exiftool-perl


# Install fdupes -nohost
sudo apt-get install --yes fdupes
# Usage:
# $ fdupes -r /home               # Report recursively from /home
# $ fdupes -d /path/to/folder     # Remove, interactively, from /path/to/folder
# $ fdupes -d -N /path/to/folder  # Delete, from /path/to/folder

# Remove fdupes -nohost
sudo apt-get remove --yes fdupes


# Install force-x11 -nohost
# Force the use of X11 because Wayland is not (yet) supported by remote desktop app AnyDesk.
# Force means no choice @ user login for X11 or Wayland!
sudo sed --in-place --expression='s/^#WaylandEnable=false/WaylandEnable=false/' /etc/gdm3/custom.conf
# To check, after reboot (!), execute: echo $XDG_SESSION_TYPE (should output 'x11')

# Remove force-x11 -nohost
sudo sed --in-place --expression='s/^WaylandEnable=false/#WaylandEnable=false/' /etc/gdm3/custom.conf
# To check, after reboot (!), execute: echo $XDG_SESSION_TYPE (should output 'wayland')


# Install fwupd -nohost
# Disable the Firmware update daemon.
sudo systemctl stop fwupd.service
sudo systemctl disable fwupd.service
sudo systemctl mask fwupd.service

# Remove fwupd -nohost
# Enable the Firmware update daemon.
sudo systemctl unmask fwupd.service
sudo systemctl enable fwupd.service
sudo systemctl start fwupd.service


# Install gdebi *
sudo apt-get install --yes gdebi

# Remove gdebi *
sudo apt-get remove --yes gdebi


# Install gimp pc06 pc-van-hugo
sudo apt-get install --yes gimp gimp-help-en gimp-help-nl

# Remove gimp pc06 pc-van-hugo
sudo apt-get remove --yes gimp gimp-help-en gimp-help-nl


# Install gnome-gmail pc01 pc06
sudo apt-get install --yes gnome-gmail

# Remove gnome-gmail pc01 pc06
sudo apt-get remove --yes gnome-gmail


# Install gnome-tweaks *
sudo apt-get install --yes gnome-tweaks

# Remove gnome-tweaks *
sudo apt-get remove --yes gnome-tweaks


# Install gnome-web pc06
sudo apt-get install --yes epiphany-browser

# Remove gnome-web pc06
sudo apt-get remove --yes epiphany-browser


# Install google-chrome pc01 pc02 pc06
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] https://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list > /dev/null
wget --output-document=- 'https://dl.google.com/linux/linux_signing_key.pub' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/google-chrome.gpg
sudo apt-get update
# Also install chrome-gnome-shell to make extensions.gnome.org work.
sudo apt-get install --yes google-chrome-stable chrome-gnome-shell
# Add the source list again because the installation overwrote the newly added source list.
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] https://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list > /dev/null
# Remove the apt-key added during installation as an apt-key is no longer needed.
sudo rm --force --verbose /etc/apt/trusted.gpg.d/google-chrome.gpg

# Remove google-chrome pc01 pc02 pc06
sudo apt-get remove --yes google-chrome-stable chrome-gnome-shell
sudo rm --force --verbose /etc/apt/sources.list.d/google-chrome.list* /usr/share/keyrings/google-chrome.gpg* /etc/apt/trusted.gpg.d/google-chrome.gpg
sudo apt-get update


# Install google-earth -nohost
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-earth.gpg] https://dl.google.com/linux/earth/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-earth-pro.list > /dev/null
wget --output-document=- 'https://dl.google.com/linux/linux_signing_key.pub' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/google-earth.gpg
sudo apt-get update
sudo apt-get install --yes google-earth-pro-stable
# Add the source list again because the installation overwrote the newly added source list.
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-earth.gpg] https://dl.google.com/linux/earth/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-earth-pro.list > /dev/null

# Remove google-earth -nohost
sudo apt-get remove --yes google-earth-pro-stable
sudo rm --force --verbose /etc/apt/sources.list.d/google-earth-pro.list* /usr/share/keyrings/google-earth.gpg*
sudo apt-get update


# Install handbrake pc-van-emily
sudo apt-get install --yes handbrake

# Remove handbrake pc-van-emily
sudo apt-get remove --yes handbrake


# Install hostnames pc01 pc06
sudo sed --in-place --expression='/^192.168.1.83/d' /etc/hosts
sudo sed --in-place --expression='/^192.168.1.100/d' /etc/hosts
sudo sed --in-place --expression='2a192.168.1.100 pc01' /etc/hosts
sudo sed --in-place --expression='3a192.168.1.83 pc06' /etc/hosts

# Remove hostnames pc01 pc06
sudo sed --in-place --expression='/^192.168.1.83/d' /etc/hosts
sudo sed --in-place --expression='/^192.168.1.100/d' /etc/hosts


# Install htop pc06
sudo apt-get install --yes htop

# Remove htop pc06
sudo apt-get remove --yes htop


# Install krita pc06
sudo apt-get install --yes krita

# Remove kvm pc06
sudo apt-get remove --yes krita


# Install kvm pc06
# Dpkg::Options due to interaction due to restoring /etc/libvirt configuration files.
sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes --option Dpkg::Options::="--force-confdef" --option Dpkg::Options::="--force-confold" bridge-utils cpu-checker libvirt-clients libvirt-daemon-system qemu-kvm qemu-system virtinst virt-manager
sudo usermod --append --groups libvirt,libvirt-qemu "${SUDO_USER:-$USER}"
# Images are in: /var/lib/libvirt/images/

# Remove kvm pc06
sudo apt-get remove --yes cpu-checker qemu-kvm bridge-utils virt-manager
sudo delgroup libvirtd-dnsmasq
sudo deluser "${SUDO_USER:-${SUDO_USER:-$USER}}" libvirtd
sudo delgroup libvirtd


# Install libreoffice *
sudo apt-get install --yes aspell-en aspell-nl libreoffice libreoffice-help-nl libreoffice-l10n-nl

# Remove libreoffice *
sudo apt-get remove --yes aspell-en aspell-nl libreoffice libreoffice-help-nl libreoffice-l10n-nl


# Install locate pc06
sudo apt-get install --yes locate
sudo updatedb

# Remove locate pc06
sudo apt-get remove --yes locate


# Install monitors pc06
if [[ -f /home/${SUDO_USER:-$USER}/.config/monitors.xml ]]; then sudo cp --preserve --verbose /home/"${SUDO_USER:-$USER}"/.config/monitors.xml ~gdm/.config/monitors.xml; fi
if [[ -f ~gdm/.config/monitors.xml ]]; then sudo chown --verbose gdm:gdm ~gdm/.config/monitors.xml; fi

# Remove monitors pc06
sudo rm --force --verbose ~gdm/.config/monitors.xml


# Install nautilus-admin pc06
sudo apt-get install --yes nautilus-admin

# Remove nautilus-admin pc06
sudo apt-get remove --yes nautilus-admin


# Install procs pc06
sudo snap install procs

# Remove procs pc06
sudo snap remove procs


# Install repair-ntfs -nohost
sudo apt-get install --yes ntfs-3g
# Usage:
# $ findmnt
#   TARGET          SOURCE    FSTYPE OPTIONS
#   /media/...      /dev/sdb2 ntfs3  rw,nosuid,nodev,relatime,uid=...
# $ sudo ntfsfix /dev/sdb2

# Remove repair-ntfs -nohost
sudo apt-get remove --yes ntfs-3g


# Install signal pc06
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main'| sudo tee /etc/apt/sources.list.d/signal-xenial.list > /dev/null
wget --output-document=- 'https://updates.signal.org/desktop/apt/keys.asc' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/signal-desktop-keyring.gpg
sudo apt-get update
sudo apt-get install --yes signal-desktop

# Remove signal pc06
sudo apt-get remove --yes signal-desktop
sudo rm --force --verbose /etc/apt/sources.list.d/signal-xenial.list* /usr/share/keyrings/signal-desktop-keyring.gpg*
sudo apt-get update


# Install sound-juicer pc-van-emily
sudo apt-get install --yes sound-juicer

# Remove sound-juicer pc-van-emily
sudo apt-get remove --yes sound-juicer


# Install ssh pc01 pc06
sudo apt-get install --yes ssh
sudo sed --in-place --expression='s/PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
# Check for remote root access.
grep --quiet --regexp='PermitRootLogin no' /etc/ssh/sshd_config
sudo systemctl restart ssh.service

# Remove ssh pc01 pc06
sudo sed --in-place --expression='s/PermitRootLogin no/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config
sudo apt-get remove --yes ssh


# Install sushi pc06
sudo apt-get install --yes gnome-sushi
# Usage:
#   Select a file, press the space bar, and a preview will appear.

# Remove sushi pc06
sudo apt-get remove --yes gnome-sushi


# Install teamviewer *
echo 'deb [signed-by=/usr/share/keyrings/teamviewer.gpg] https://linux.teamviewer.com/deb stable main' | sudo tee /etc/apt/sources.list.d/teamviewer.list > /dev/null
wget --output-document=- 'https://download.teamviewer.com/download/linux/signature/TeamViewer2017.asc' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/teamviewer.gpg
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes teamviewer
# Remove the apt-key added during installation as an apt-key is no longer needed.
sudo apt-key del 0C1289C0 DEB49217
# Web app: https://web.teamviewer.com

# Remove teamviewer *
sudo apt-get remove --yes teamviewer
sudo rm --force --verbose /etc/apt/sources.list.d/teamviewer.list* /usr/share/keyrings/teamviewer*.gpg*
sudo apt-key del 0C1289C0 DEB49217
sudo apt-get update


# Install tree pc06
sudo apt-get install --yes tree

# Remove tree pc06
sudo apt-get remove --yes tree


# Install ufw pc01 pc06
sudo apt-get install --yes gufw
sudo ufw allow ssh
sudo ufw enable

# Remove ufw pc01 pc06
sudo ufw disable
sudo apt-get remove --yes gufw


# Install user-guest -nohost
sudo useradd --create-home --shell /usr/bin/bash --comment "$(gettext --domain=kz 'Guest')" "$(gettext --domain=kz 'guest')" || true
sudo usermod --groups pipo,users pipo
sudo passwd --delete "$(gettext --domain=kz 'guest')"

# Remove user-guest -nohost
# sudo userdel --remove "$(gettext --domain=kz 'guest')"


# Install user-karel pc01
sudo useradd --create-home --shell /usr/bin/bash --comment 'Karel Zimmer' karel || true
sudo usermod --append --groups adm,cdrom,sudo,dip,plugdev,lpadmin karel
sudo passwd --delete --expire karel

# Remove user-karel pc01
# sudo userdel --remove karel


# Install user-toos Laptop
sudo useradd --create-home --shell /usr/bin/bash --comment 'Toos Barendse' toos || true
sudo usermod --append --groups adm,cdrom,sudo,dip,plugdev,lpadmin toos
sudo passwd --delete --expire toos

# Remove user-toos Laptop
# sudo userdel --remove toos


# Install virtualbox pc-van-hugo
# If installation hangs or VBox does not work, check Linux-info.txt.
echo 'virtualbox-ext-pack virtualbox-ext-pack/license select true' | sudo debconf-set-selections
sudo apt-get install --yes virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso
# VirtualBox Guest Additions ISO are in: /usr/share/virtualbox/

# Remove virtualbox pc-van-hugo
sudo apt-get remove --yes virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso


# Install vlc *
sudo snap install vlc

# Remove vlc *
sudo snap remove vlc


# Install vscode pc01 pc06
sudo snap install --classic code

# Remove vscode pc01 pc06
sudo snap remove code


# Install wine -nohost
sudo apt-get install --yes wine winetricks playonlinux

# Remove wine -nohost
sudo apt-get remove --yes wine winetricks playonlinux


# Install youtube-dl pc-van-emily pc-van-hugo
sudo apt-get install --yes youtubedl-gui

# Remove youtube-dl pc-van-emily pc-van-hugo
sudo apt-get remove --yes youtubedl-gui
