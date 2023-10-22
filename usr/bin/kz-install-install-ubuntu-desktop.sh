# shellcheck shell=bash
###############################################################################
# Standard installation file for Ubuntu desktop.
#
# Written by Karel Zimmer <info@karelzimmer.nl>, CC0 1.0 Universal
# <https://creativecommons.org/publicdomain/zero/1.0>, 2009-2023.
###############################################################################

# APP apport *
# EXEC THIS FIRST.
sudo systemctl stop apport.service
sudo systemctl disable apport.service
sudo rm --force /var/crash/*
sudo sed --in-place --expression='s/enabled=1/enabled=0/' /etc/default/apport


# APP add-host pc01 pc06
sudo sed --in-place --expression='/^192.168.1.83/d' /etc/hosts
sudo sed --in-place --expression='/^192.168.1.100/d' /etc/hosts
sudo sed --in-place --expression='3s/^/192.168.1.100 pc01\n/' /etc/hosts
sudo sed --in-place --expression='4s/^/192.168.1.83 pc06\n/' /etc/hosts


# APP ansible pc06
sudo apt-get install --yes ansible


# APP anydesk *
# Web app: https://my.anydesk.com/v2
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/anydesk.gpg] http://deb.anydesk.com/ all main' | sudo tee /etc/apt/sources.list.d/anydesk.list
wget --output-document=- 'https://keys.anydesk.com/repos/DEB-GPG-KEY' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/anydesk.gpg
sudo apt-get update
sudo apt-get install --yes anydesk


# APP bleachbit pc-van-hugo
sudo apt-get install --yes bleachbit


# APP calibre pc04 pc06 pc-van-hugo
sudo apt-get install --yes calibre


# APP cifs pc-van-hugo
# Needed for kz-nas.
sudo apt-get install --yes cifs-utils samba


# APP clamav pc-van-hugo
sudo apt-get install --yes clamtk-gnome


# APP cockpit pc06
# Web app: https://localhost:9090
sudo apt-get install --yes cockpit cockpit-pcp


# APP cups-backend-bjnp pc-van-emily
# Add support for Canon USB over IP BJNP protocol
sudo apt-get install --yes cups-backend-bjnp


# APP dual-monitor pc06
if [[ -f /home/${SUDO_USER:-$USER}/.config/monitors.xml ]]; then sudo cp /home/"${SUDO_USER:-$USER}"/.config/monitors.xml ~gdm/.config/monitors.xml; fi
if [[ -f ~gdm/.config/monitors.xml ]]; then sudo chown gdm:gdm ~gdm/.config/monitors.xml; fi


# APP epiphany-browser pc06
sudo apt-get install --yes epiphany-browser


# APP exiftool pc06
sudo apt-get install --yes libimage-exiftool-perl


# APP gimp pc06 pc-van-hugo
sudo apt-get install --yes gimp gimp-help-en gimp-help-nl


# APP gnome-gmail pc01 pc04 pc06
sudo apt-get install --yes gnome-gmail


# APP gnome-tweaks pc06
sudo apt-get install --yes gnome-tweaks


# APP google-chrome *
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


# APP google-earth pc04
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-earth.gpg] https://dl.google.com/linux/earth/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-earth-pro.list
wget --output-document=- 'https://dl.google.com/linux/linux_signing_key.pub' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/google-earth.gpg
sudo apt-get update
sudo apt-get install --yes google-earth-pro-stable
# The installation overwrites the newly added source-list.
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-earth.gpg] https://dl.google.com/linux/earth/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-earth-pro.list


# APP handbrake pc-van-emily
sudo apt-get install --yes handbrake


# APP ignore-close-laptop-lid pc04 pc-van-hugo
sudo sed --in-place --expression='/^HandleLidSwitch=/d' /etc/systemd/logind.conf
echo 'HandleLidSwitch=ignore' | sudo tee --append /etc/systemd/logind.conf


# APP kvm pc06
# Images are in /var/lib/libvirt/images/
# Dpkg::Options due to interaction due to restore /etc/libvirt configuration files.
sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes --option Dpkg::Options::="--force-confdef" --option Dpkg::Options::="--force-confold" cpu-checker qemu-kvm bridge-utils virt-manager


# APP libreoffice *
sudo apt-get install --yes aspell-en aspell-nl libreoffice


# APP locate pc06
sudo apt-get install --yes mlocate


# APP nautilus-admin pc06
sudo apt-get install --yes nautilus-admin


# APP restricted-addons *
# No ubuntu-restricted-extras due to unreliable installation of ttf-mscorefonts-installer, do install libavcodec-extra from that metapackage
sudo apt-get install --yes ubuntu-restricted-addons libavcodec-extra


# APP ros pc04
:


# APP signal pc06
# Web app: n/a
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main'| sudo tee /etc/apt/sources.list.d/signal-xenial.list
wget --output-document=- 'https://updates.signal.org/desktop/apt/keys.asc' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/signal-desktop-keyring.gpg
sudo apt-get update
sudo apt-get install --yes signal-desktop


# APP sound-juicer pc-van-emily
sudo apt-get install --yes sound-juicer


# APP ssh pc01 pc06
sudo apt-get install --yes ssh
sudo sed --in-place --expression='s/PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
# Check for remote root access
grep --quiet --regexp='PermitRootLogin no' /etc/ssh/sshd_config
sudo systemctl restart ssh.service


# APP sushi pc06
# Select a file, press the space bar, and a preview will appear.
sudo apt-get install --yes gnome-sushi


# APP tree pc06
sudo apt-get install --yes tree


# APP ufw pc01 pc06
sudo apt-get install --yes gufw
sudo ufw allow ssh
sudo ufw enable


# APP virtualbox pc-van-hugo
# If installation hangs or VBox does not work, check Linux-info.txt.
echo 'virtualbox-ext-pack virtualbox-ext-pack/license select true' | sudo debconf-set-selections
# VirtualBox Guest Additions ISO are in /usr/share/virtualbox/
sudo apt-get install --yes virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso


# APP vlc pc06
sudo snap install vlc


# APP vscode pc01 pc06
sudo snap install --classic code


# APP wine pc04
sudo apt-get install --yes wine winetricks playonlinux


# APP youtube-dl pc-van-emily pc-van-hugo
sudo apt-get install --yes youtubedl-gui
