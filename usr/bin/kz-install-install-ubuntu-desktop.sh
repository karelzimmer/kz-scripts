# shellcheck shell=bash
###############################################################################
# Installation file for Ubuntu desktop.
#
# Written by Karel Zimmer <info@karelzimmer.nl>, CC0 1.0 Universal
# <https://creativecommons.org/publicdomain/zero/1.0>, 2009-2023.
###############################################################################

# APP ansible HOST pc06
sudo apt-get install --yes ansible


# APP anydesk HOST *
# Web app: https://my.anydesk.com/v2
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/anydesk.gpg] http://deb.anydesk.com/ all main' | sudo tee /etc/apt/sources.list.d/anydesk.list > /dev/null
wget --output-document=- 'https://keys.anydesk.com/repos/DEB-GPG-KEY' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/anydesk.gpg
sudo apt-get update
sudo apt-get install --yes anydesk


# APP apport HOST *
sudo systemctl stop apport.service
sudo systemctl disable apport.service
sudo rm --force /var/crash/*
sudo sed --in-place --expression='s/enabled=1/enabled=0/' /etc/default/apport


# APP bleachbit HOST pc-van-hugo
sudo apt-get install --yes bleachbit


# APP calibre HOST pc06 pc-van-hugo
sudo apt-get install --yes calibre


# APP clamav HOST pc-van-hugo
sudo apt-get install --yes clamtk-gnome


# APP cockpit HOST pc06
# Web app: https://localhost:9090
sudo apt-get install --yes cockpit cockpit-pcp


# APP cups-backend-bjnp HOST pc-van-emily
# Add support for Canon USB over IP BJNP protocol
sudo apt-get install --yes cups-backend-bjnp


# APP exiftool HOST pc06
sudo apt-get install --yes libimage-exiftool-perl


# APP force-x11 HOST
# Force the use of X11 because Wayland is not (yet) supported by remote desktop apps such as AnyDesk and TeamViewer.
# Force means no choice @ user login for X11 or Wayland!
# To check, after reboot (!), execute: echo $XDG_SESSION_TYPE (should output 'x11')
sudo sed --in-place --expression='s/^#WaylandEnable=false/WaylandEnable=false/' /etc/gdm3/custom.conf


# APP gimp HOST pc06 pc-van-hugo
sudo apt-get install --yes gimp gimp-help-en gimp-help-nl


# APP gnome-gmail HOST pc01 pc06
sudo apt-get install --yes gnome-gmail


# APP gnome-tweaks HOST *
sudo apt-get install --yes gnome-tweaks


# APP gnome-web HOST pc06
sudo apt-get install --yes epiphany-browser


# APP google-chrome HOST *
# Extensions and policies are applied by "kz.deb" policy file policies.json, for Chrome in /etc/opt/chrome/policies/managed/, for Firefox in /etc/firefox/policies/.
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] https://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list > /dev/null
wget --output-document=- 'https://dl.google.com/linux/linux_signing_key.pub' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/google-chrome.gpg
sudo apt-get update
# Also install chrome-gnome-shell to make extensions.gnome.org work.
sudo apt-get install --yes google-chrome-stable chrome-gnome-shell
# The installation overwrites the newly added source-list.
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] https://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list > /dev/null
# The installation adds an apt-key that is no longer needed.
sudo rm --force /etc/apt/trusted.gpg.d/google-chrome.gpg


# APP google-earth HOST
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-earth.gpg] https://dl.google.com/linux/earth/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-earth-pro.list > /dev/null
wget --output-document=- 'https://dl.google.com/linux/linux_signing_key.pub' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/google-earth.gpg
sudo apt-get update
sudo apt-get install --yes google-earth-pro-stable
# The installation overwrites the newly added source-list.
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-earth.gpg] https://dl.google.com/linux/earth/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-earth-pro.list > /dev/null


# APP guest HOST
sudo useradd --create-home --shell /usr/bin/bash --comment "$(gettext --domain=kz 'Guest')" "$(gettext --domain=kz 'guest')" || true
sudo passwd --delete "$(gettext --domain=kz 'guest')"


# APP handbrake HOST pc-van-emily
sudo apt-get install --yes handbrake


# APP handlelidswitch HOST pc-van-hugo
sudo sed --in-place --expression='/^HandleLidSwitch=/d' /etc/systemd/logind.conf
echo 'HandleLidSwitch=ignore' | sudo tee --append /etc/systemd/logind.conf > /dev/null


# APP hostnames HOST pc01 pc06
sudo sed --in-place --expression='/^192.168.1.83/d' /etc/hosts
sudo sed --in-place --expression='/^192.168.1.100/d' /etc/hosts
sudo sed --in-place --expression='3s/^/192.168.1.100 pc01\n/' /etc/hosts
sudo sed --in-place --expression='4s/^/192.168.1.83 pc06\n/' /etc/hosts


# APP kvm HOST pc06
# Images are in /var/lib/libvirt/images/
# Dpkg::Options due to interaction due to restore /etc/libvirt configuration files.
sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes --option Dpkg::Options::="--force-confdef" --option Dpkg::Options::="--force-confold" cpu-checker qemu-kvm bridge-utils virt-manager


# APP libreoffice HOST *
sudo apt-get install --yes aspell-en aspell-nl libreoffice


# APP locate HOST pc06
sudo apt-get install --yes mlocate


# APP monitors HOST pc06
if [[ -f /home/${SUDO_USER:-$USER}/.config/monitors.xml ]]; then sudo cp /home/"${SUDO_USER:-$USER}"/.config/monitors.xml ~gdm/.config/monitors.xml; fi
if [[ -f ~gdm/.config/monitors.xml ]]; then sudo chown gdm:gdm ~gdm/.config/monitors.xml; fi


# APP nautilus-admin HOST pc06
sudo apt-get install --yes nautilus-admin


# APP signal HOST pc06
# Web app: n/a
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main'| sudo tee /etc/apt/sources.list.d/signal-xenial.list > /dev/null
wget --output-document=- 'https://updates.signal.org/desktop/apt/keys.asc' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/signal-desktop-keyring.gpg
sudo apt-get update
sudo apt-get install --yes signal-desktop


# APP sound-juicer HOST pc-van-emily
sudo apt-get install --yes sound-juicer


# APP ssh HOST pc01 pc06
sudo apt-get install --yes ssh
sudo sed --in-place --expression='s/PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
# Check for remote root access
grep --quiet --regexp='PermitRootLogin no' /etc/ssh/sshd_config
sudo systemctl restart ssh.service


# APP sushi HOST pc06
# Select a file, press the space bar, and a preview will appear.
sudo apt-get install --yes gnome-sushi


# APP teamviewer HOST pc06
# Web app: https://web.teamviewer.com
echo 'deb [signed-by=/usr/share/keyrings/teamviewer.gpg] https://linux.teamviewer.com/deb stable main' | sudo tee /etc/apt/sources.list.d/teamviewer.list > /dev/null
wget --output-document=- 'https://download.teamviewer.com/download/linux/signature/TeamViewer2017.asc' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/teamviewer.gpg
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes teamviewer
# The installation adds an apt-key that is no longer needed.
sudo apt-key del 0C1289C0 DEB49217


# APP tree HOST pc06
sudo apt-get install --yes tree


# APP totem HOST *
# No ubuntu-restricted-extras due to unreliable installation of ttf-mscorefonts-installer, do install libavcodec-extra from that metapackage.
sudo apt-get install --yes ubuntu-restricted-addons libavcodec-extra libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libgstreamer-plugins-bad1.0-dev gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-libav gstreamer1.0-tools gstreamer1.0-x gstreamer1.0-alsa gstreamer1.0-gl gstreamer1.0-gtk3 gstreamer1.0-qt5 gstreamer1.0-pulseaudio


# APP ufw HOST pc01 pc06
sudo apt-get install --yes gufw
sudo ufw allow ssh
sudo ufw enable


# APP virtualbox HOST pc-van-hugo
# If installation hangs or VBox does not work, check Linux-info.txt.
echo 'virtualbox-ext-pack virtualbox-ext-pack/license select true' | sudo debconf-set-selections
# VirtualBox Guest Additions ISO are in /usr/share/virtualbox/
sudo apt-get install --yes virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso


# APP vlc HOST pc06
sudo snap install vlc


# APP vscode HOST pc01 pc06
sudo snap install --classic code


# APP wine HOST
sudo apt-get install --yes wine winetricks playonlinux


# APP youtube-dl HOST pc-van-emily pc-van-hugo
sudo apt-get install --yes youtubedl-gui
