# shellcheck shell=bash
###############################################################################
# Install file for Ubuntu desktop on pc06.
#
# Written in 2009 by Karel Zimmer <info@karelzimmer.nl>, Creative Commons
# Public Domain Dedication <https://creativecommons.org/publicdomain/zero/1.0>.
###############################################################################

#1-add-hosts
sudo sed --in-place --expression='/^192.168.1.83/d' /etc/hosts
sudo sed --in-place --expression='/^192.168.1.64/d' /etc/hosts
echo '192.168.1.83 pc06' | sudo tee --append /etc/hosts
echo '192.168.1.64 pc01' | sudo tee --append /etc/hosts
#2 sudo sed --in-place --expression='/^192.168.1.83/d' /etc/hosts
#2 sudo sed --in-place --expression='/^192.168.1.64/d' /etc/hosts

#1 ansible
sudo apt-get install --yes ansible
#2 sudo apt-get remove --yes ansible

#1-brightness
echo '#!/bin/sh' | sudo tee /etc/rc.local
echo 'echo 1900 > /sys/class/backlight/intel_backlight/brightness' | sudo tee --append /etc/rc.local
sudo chmod +x /etc/rc.local
#2 echo '' | sudo tee /etc/rc.local
#2 sudo chmod -x /etc/rc.local

#1 cockpit
sudo apt-get install --yes cockpit cockpit-pcp
#2 sudo apt-get remove --yes cockpit

#1 exiftool
sudo apt-get install --yes libimage-exiftool-perl
#2 sudo apt-get remove --yes libimage-exiftool-perl

#1-gast
sudo useradd --create-home --shell /bin/bash --comment 'Gast' gast || true
sudo passwd --delete gast
#2 sudo userdel --remove gast

#1 gdm
## Dual monitor login screen
if [[ -f /home/${SUDO_USER:-$USER}/.config/monitors.xml ]]; then sudo cp /home/"${SUDO_USER:-$USER}"/.config/monitors.xml ~gdm/.config/monitors.xml; fi
if [[ -f ~gdm/.config/monitors.xml ]]; then sudo chown gdm:gdm ~gdm/.config/monitors.xml; fi
#2 sudo rm --force ~gdm/.config/monitors.xml

#1 gimp
sudo apt-get install --yes gimp gimp-help-en gimp-help-nl
#2 sudo apt-get remove --yes gimp gimp-help-en gimp-help-nl

#1 gnome-gmail
sudo apt-get install --yes gnome-gmail
#2 sudo apt-get remove --yes gnome-gmail

#1 gnome-tweaks
sudo apt-get install --yes gnome-tweaks
#2 sudo apt-get remove --yes gnome-tweaks

#1 kvm
## Images are in /var/lib/libvirt/images/
## Dpkg::Options due to interaction due to restore /etc/libvirt configuration files.
sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes --option Dpkg::Options::="--force-confdef" --option Dpkg::Options::="--force-confold" cpu-checker qemu-kvm bridge-utils virt-manager
#2 sudo apt-get remove --yes cpu-checker qemu-kvm bridge-utils virt-manager
#2 sudo delgroup libvirtd-dnsmasq
#2 sudo deluser ${SUDO_USER:-${SUDO_USER:-$USER}} libvirtd
#2 sudo delgroup libvirtd

#1 locate
sudo apt-get install --yes mlocate
#2 sudo apt-get remove --yes mlocate

#1 nautilus-admin
sudo apt-get install --yes nautilus-admin
#2 sudo apt-get remove --yes nautilus-admin

#1 signal
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main'| sudo tee /etc/apt/sources.list.d/signal-xenial.list
wget --output-document=- 'https://updates.signal.org/desktop/apt/keys.asc' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/signal-desktop-keyring.gpg
sudo apt-get update
sudo apt-get install --yes signal-desktop
#2 sudo apt-get remove --yes signal-desktop
#2 sudo rm --force /etc/apt/sources.list.d/signal-xenial.list* /usr/share/keyrings/signal-desktop-keyring.gpg*
#2 sudo apt-get update

#1 ssh
sudo apt-get install --yes ssh
sudo sed --in-place --expression='s/PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
## Check op remote root-toegang.
grep --quiet --regexp='PermitRootLogin no' /etc/ssh/sshd_config
sudo systemctl restart ssh.service
#2 sudo sed --in-place --expression='s/PermitRootLogin no/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config
#2 sudo apt-get remove --yes ssh

#1 sushi
## Select a file, press the space bar, and a preview will appear
sudo apt-get install --yes gnome-sushi
#2 sudo apt-get remove --yes gnome-sushi

#1 tree
sudo apt-get install --yes tree
#2 sudo apt-get remove --yes tree

#1 ufw
sudo apt-get install --yes gufw
sudo ufw allow ssh
sudo ufw enable
#2 sudo ufw disable

#1 vlc
sudo snap install vlc
#2 sudo snap remove vlc
