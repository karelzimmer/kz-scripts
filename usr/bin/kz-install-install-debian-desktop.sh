# shellcheck shell=bash
###############################################################################
# Install apps file for Debian desktop.
#
# This script file is used by script kz-install.
# Use 'man kz-install' for more information.
#
# Written by Karel Zimmer <info@karelzimmer.nl>, CC0 1.0 Universal
# <https://creativecommons.org/publicdomain/zero/1.0>, 2013-2023.
###############################################################################

#  APP repos
# HOST *
# Exec this first.
sudo apt-add-repository contrib
sudo apt-add-repository non-free
sudo apt-add-repository "deb https://www.deb-multimedia.org $(lsb_release --codename --short) main non-free"
wget --output-document=/tmp/deb-multimedia-keyring_2016.8.1_all.deb 'https://www.deb-multimedia.org/pool/main/d/deb-multimedia-keyring/deb-multimedia-keyring_2016.8.1_all.deb'
sudo apt-get install --yes /tmp/deb-multimedia-keyring_2016.8.1_all.deb
rm /tmp/deb-multimedia-keyring_2016.8.1_all.deb
sudo apt-get update

#  APP adm
# HOST pc07
sudo adduser "${SUDO_USER:-$USER}" adm

#  APP completion
# HOST *
sudo apt-get install --yes bash-completion

#  APP cups
# HOST *
sudo apt-get install --yes cups

#  APP dashtodock
# HOST *
sudo apt-get install --yes gnome-shell-extension-dashtodock

#  APP gnome-gmail
# HOST pc07
sudo apt-get install --yes gnome-gmail

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

#  APP journalctl
# HOST *
# Enable access to the log
sudo adduser "${SUDO_USER:-$USER}" systemd-journal

#  APP kvm
# HOST pc07
# Images are in /var/lib/libvirt/images/
# Dpkg::Options due to interaction due to restore /etc/libvirt configuration files.
sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes --option Dpkg::Options::="--force-confdef" --option Dpkg::Options::="--force-confold" bridge-utils cpu-checker libvirt-clients libvirt-daemon-system qemu-kvm qemu-system virtinst virt-manager
sudo adduser "${SUDO_USER:-$USER}" libvirt
sudo adduser "${SUDO_USER:-$USER}" libvirt-qemu

#  APP libreoffice
# HOST *
sudo apt-get install --yes aspell-nl libreoffice libreoffice-help-nl libreoffice-l10n-nl

#  APP locate
# HOST pc07
sudo apt-get install --yes mlocate

#  APP signal
# HOST pc07
# Web App: n/a
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main'| sudo tee /etc/apt/sources.list.d/signal-xenial.list
wget --output-document=- 'https://updates.signal.org/desktop/apt/keys.asc' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/signal-desktop-keyring.gpg
sudo apt-get update
sudo apt-get install --yes signal-desktop

#  APP spice-vdagent
# HOST pc07
sudo apt-get install --yes spice-vdagent

#  APP teamviewer
# HOST *
# Web App: https://web.teamviewer.com
echo 'deb [signed-by=/usr/share/keyrings/teamviewer.gpg] https://linux.teamviewer.com/deb stable main' | sudo tee /etc/apt/sources.list.d/teamviewer.list
wget --output-document=- 'https://download.teamviewer.com/download/linux/signature/TeamViewer2017.asc' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/teamviewer.gpg
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes teamviewer
# The installation adds an apt-key that is no longer needed.
sudo apt-key del 0C1289C0 DEB49217

#  APP thunderbird
# HOST *
sudo apt-get install --yes thunderbird-l10n-nl

#  APP vlc
# HOST pc07
sudo snap install vlc

#  APP vscode
# HOST pc07
sudo snap install --classic code

#  APP webmin
# HOST pc07
# Web App: https://localhost:10000
echo 'deb [signed-by=/usr/share/keyrings/webmin.gpg] https://download.webmin.com/download/repository sarge contrib' | sudo tee /etc/apt/sources.list.d/webmin.list
wget --output-document=- 'https://www.webmin.com/jcameron-key.asc' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/webmin.gpg
sudo apt-get update
sudo apt-get install --yes webmin
