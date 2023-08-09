# shellcheck shell=bash
###############################################################################
# Standard uninstaller file for Debian desktop.
#
# This script file is used by script kz-install.
# Use 'man kz install' for more information.
#
# Written by Karel Zimmer <info@karelzimmer.nl>, CC0 1.0 Universal
# <https://creativecommons.org/publicdomain/zero/1.0>, 2023.
###############################################################################

#  APP addrepos
# HOST *
# Exec this first.
sudo apt-add-repository --remove contrib
sudo apt-add-repository --remove non-free
sudo apt-add-repository --remove "deb https://www.deb-multimedia.org $(lsb_release --codename --short) main non-free"
sudo apt-get remove --yes deb-multimedia-keyring
sudo apt-get update

#  APP adduser
# HOST pc07
sudo deluser "${SUDO_USER:-$USER}" adm
sudo deluser "${SUDO_USER:-$USER}" systemd-journal

#  APP completion
# HOST *
sudo apt-get remove --yes bash-completion

#  APP cups
# HOST *
sudo apt-get remove --yes cups

#  APP dashtodock
# HOST *
sudo apt-get remove --yes gnome-shell-extension-dashtodock

#  APP deja-dup
# HOST *
sudo snap remove deja-dup

#  APP gedit
# HOST *
sudo apt-get remove --yes gedit

#  APP gnome-gmail
# HOST pc07
sudo apt-get remove --yes gnome-gmail

#  APP google-chrome
# HOST *
sudo apt-get remove --yes google-chrome-stable chrome-gnome-shell
sudo rm --force /etc/apt/sources.list.d/google-chrome.list* /usr/share/keyrings/google-chrome.gpg* /etc/apt/trusted.gpg.d/google-chrome.gpg
sudo apt-get update

#  APP kvm
# HOST pc07
sudo apt-get remove --yes bridge-utils cpu-checker libvirt-clients libvirt-daemon-system qemu-kvm qemu-system virtinst virt-manager
sudo delgroup libvirtd-dnsmasq
sudo deluser "${SUDO_USER:-$USER}" libvirtd
sudo deluser "${SUDO_USER:-$USER}" libvirtd-qemu
sudo delgroup libvirtd

#  APP libreoffice
# HOST *
sudo apt-get remove --yes aspell-nl libreoffice libreoffice-help-nl libreoffice-l10n-nl

#  APP locate
# HOST pc07
sudo apt-get remove --yes mlocate

#  APP signal
# HOST pc07
sudo apt-get remove --yes signal-desktop
sudo rm --force /etc/apt/sources.list.d/signal-xenial.list* /usr/share/keyrings/signal-desktop-keyring.gpg*
sudo apt-get update

#  APP spice-vdagent
# HOST pc07
sudo apt-get remove --yes spice-vdagent

#  APP teamviewer
# HOST *
sudo apt-get remove --yes teamviewer
sudo rm --force /etc/apt/sources.list.d/teamviewer.list* /usr/share/keyrings/teamviewer.gpg*
sudo apt-key del 0C1289C0 DEB49217
sudo apt-get update

#  APP thunderbird
# HOST *
sudo apt-get remove --yes thunderbird-l10n-nl

#  APP vlc
# HOST pc07
sudo snap remove vlc

#  APP vscode
# HOST pc07
sudo snap remove code

#  APP webmin
# HOST pc07
sudo apt-get remove --yes webmin
sudo rm --force /etc/apt/sources.list.d/webmin.list* /usr/share/keyrings/webmin*
sudo apt-get update
