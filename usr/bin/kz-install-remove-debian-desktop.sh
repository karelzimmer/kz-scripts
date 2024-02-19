# shellcheck shell=bash
###############################################################################
# Uninstall file for Debian desktop.
#
# Written by Karel Zimmer <info@karelzimmer.nl>, CC0 1.0 Universal
# <https://creativecommons.org/publicdomain/zero/1.0>, 2023-2024.
###############################################################################


# APP anydesk HOST
sudo apt-get remove --yes anydesk
sudo rm --force --verbose /etc/apt/sources.list.d/anydesk.list* /usr/share/keyrings/anydesk.gpg*
sudo apt-get update


# APP bash-completion HOST *
sudo apt-get remove --yes bash-completion


# APP cups HOST *
sudo apt-get remove --yes cups


# APP dashtodock HOST *
sudo apt-get remove --yes gnome-shell-extension-dashtodock


# APP deja-dup HOST *
sudo snap remove deja-dup


# APP fdupes HOST
sudo apt-get remove --yes fdupes


# APP force-x11 HOST
# To check, after reboot (!), execute: echo $XDG_SESSION_TYPE (should output 'wayland')
sudo sed --in-place --expression='s/^WaylandEnable=false/#WaylandEnable=false/' /etc/gdm3/custom.conf


# APP fwupd HOST
# Enable the Firmware update daemon
systemctl unmask fwupd.service
sudo systemctl enable fwupd.service
sudo systemctl start fwupd.service


# APP gedit HOST *
sudo apt-get remove --yes gedit


# APP gnome-gmail HOST pc07
sudo apt-get remove --yes gnome-gmail


# APP google-chrome HOST pc07
sudo apt-get remove --yes google-chrome-stable chrome-gnome-shell
sudo rm --force --verbose /etc/apt/sources.list.d/google-chrome.list* /usr/share/keyrings/google-chrome.gpg* /etc/apt/trusted.gpg.d/google-chrome.gpg
sudo apt-get update


# APP guest HOST
sudo userdel --remove "$(gettext --domain=kz 'guest')"


# APP kvm HOST pc07
sudo apt-get remove --yes bridge-utils cpu-checker libvirt-clients libvirt-daemon-system qemu-kvm qemu-system virtinst virt-manager
sudo delgroup libvirtd-dnsmasq
sudo deluser "${SUDO_USER:-$USER}" libvirtd
sudo deluser "${SUDO_USER:-$USER}" libvirtd-qemu
sudo delgroup libvirtd


# APP libreoffice HOST *
sudo apt-get remove --yes aspell-en aspell-nl libreoffice libreoffice-help-nl libreoffice-l10n-nl


# APP locate HOST pc07
sudo apt-get remove --yes mlocate


# APP repair-ntfs HOST
sudo apt-get remove --yes ntfs-3g


# APP repositories HOST *
sudo apt-add-repository --remove contrib
sudo apt-add-repository --remove non-free
sudo apt-add-repository --remove "deb https://www.deb-multimedia.org $(lsb_release --codename --short) main non-free"
sudo apt-get remove --yes deb-multimedia-keyring
sudo apt-get update


# APP signal HOST pc07
sudo apt-get remove --yes signal-desktop
sudo rm --force --verbose /etc/apt/sources.list.d/signal-xenial.list* /usr/share/keyrings/signal-desktop-keyring.gpg*
sudo apt-get update


# APP spice-vdagent HOST *
sudo apt-get remove --yes spice-vdagent


# APP teamviewer HOST *
sudo apt-get remove --yes teamviewer
sudo rm --force --verbose /etc/apt/sources.list.d/teamviewer.list* /usr/share/keyrings/teamviewer*.gpg*
sudo apt-key del 0C1289C0 DEB49217
sudo apt-get update


# APP thunderbird HOST *
sudo apt-get remove --yes thunderbird-l10n-nl


# APP users HOST *
sudo deluser "${SUDO_USER:-$USER}" adm
sudo deluser "${SUDO_USER:-$USER}" systemd-journal


# APP vlc HOST pc07
sudo snap remove vlc


# APP vscode HOST pc07
sudo snap remove code


# APP webmin HOST pc07
sudo apt-get remove --yes webmin
sudo rm --force --verbose /etc/apt/sources.list.d/webmin.list* /usr/share/keyrings/webmin*
sudo apt-get update
