# shellcheck shell=bash
###############################################################################
# Uninstaller file for Debian desktop.
#
# Written by Karel Zimmer <info@karelzimmer.nl>, CC0 1.0 Universal
# <https://creativecommons.org/publicdomain/zero/1.0>, 2023.
###############################################################################

# APP anydesk HOST *
sudo apt-get remove --purge --yes anydesk
sudo apt-get autoremove --yes
sudo rm --force /etc/apt/sources.list.d/anydesk.list* /usr/share/keyrings/anydesk.gpg*
sudo apt-get update


# APP bash-completion HOST *
sudo apt-get remove --purge --yes bash-completion
sudo apt-get autoremove --yes


# APP cups HOST *
sudo apt-get remove --purge --yes cups
sudo apt-get autoremove --yes


# APP dashtodock HOST *
sudo apt-get remove --purge --yes gnome-shell-extension-dashtodock
sudo apt-get autoremove --yes


# APP deja-dup HOST *
sudo snap remove --purge deja-dup


# APP fdupes HOST
sudo apt-get remove --purge --yes fdupes
sudo apt-get autoremove --yes


# APP force-x11 HOST
# To check, after reboot (!), execute: echo $XDG_SESSION_TYPE (should output 'wayland')
sudo sed --in-place --expression='s/^WaylandEnable=false/#WaylandEnable=false/' /etc/gdm3/custom.conf


# APP fwupd HOST
systemctl unmask fwupd.service
sudo systemctl enable fwupd.service
sudo systemctl start fwupd.service


# APP gedit HOST *
sudo apt-get remove --purge --yes gedit
sudo apt-get autoremove --yes


# APP gnome-gmail HOST pc07
sudo apt-get remove --purge --yes gnome-gmail
sudo apt-get autoremove --yes


# APP google-chrome HOST *
sudo apt-get remove --purge --yes google-chrome-stable chrome-gnome-shell
sudo apt-get autoremove --yes
sudo rm --force /etc/apt/sources.list.d/google-chrome.list* /usr/share/keyrings/google-chrome.gpg* /etc/apt/trusted.gpg.d/google-chrome.gpg
sudo apt-get update


# APP guest HOST
sudo userdel --remove "$(gettext --domain=kz 'guest')"


# APP kvm HOST pc07
sudo apt-get remove --purge --yes bridge-utils cpu-checker libvirt-clients libvirt-daemon-system qemu-kvm qemu-system virtinst virt-manager
sudo apt-get autoremove --yes
sudo delgroup libvirtd-dnsmasq
sudo deluser "${SUDO_USER:-$USER}" libvirtd
sudo deluser "${SUDO_USER:-$USER}" libvirtd-qemu
sudo delgroup libvirtd


# APP libreoffice HOST *
sudo apt-get remove --purge --yes aspell-en aspell-nl libreoffice libreoffice-help-nl libreoffice-l10n-nl
sudo apt-get autoremove --yes


# APP locate HOST pc07
sudo apt-get remove --purge --yes mlocate
sudo apt-get autoremove --yes


# APP repair-ntfs HOST
sudo apt-get remove --purge --yes ntfs-3g
sudo apt-get autoremove --yes


# APP repositories HOST *
sudo apt-add-repository --remove contrib
sudo apt-add-repository --remove non-free
sudo apt-add-repository --remove "deb https://www.deb-multimedia.org $(lsb_release --codename --short) main non-free"
sudo apt-get remove --purge --yes deb-multimedia-keyring
sudo apt-get autoremove --yes
sudo apt-get update


# APP signal HOST pc07
sudo apt-get remove --purge --yes signal-desktop
sudo apt-get autoremove --yes
sudo rm --force /etc/apt/sources.list.d/signal-xenial.list* /usr/share/keyrings/signal-desktop-keyring.gpg*
sudo apt-get update


# APP spice-vdagent HOST *
sudo apt-get remove --purge --yes spice-vdagent
sudo apt-get autoremove --yes


# APP teamviewer HOST pc06
sudo apt-get remove --yes teamviewer
sudo rm --force /etc/apt/sources.list.d/teamviewer.list* /usr/share/keyrings/teamviewer*.gpg*
sudo apt-key del 0C1289C0 DEB49217
sudo apt-get update


# APP thunderbird HOST *
sudo apt-get remove --purge --yes thunderbird-l10n-nl
sudo apt-get autoremove --yes


# APP totem HOST *
sudo apt-get remove --purge --yes libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libgstreamer-plugins-bad1.0-dev gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-libav gstreamer1.0-tools gstreamer1.0-x gstreamer1.0-alsa gstreamer1.0-gl gstreamer1.0-gtk3 gstreamer1.0-qt5 gstreamer1.0-pulseaudio
sudo apt-get autoremove --yes


# APP users HOST *
sudo deluser "${SUDO_USER:-$USER}" adm
sudo deluser "${SUDO_USER:-$USER}" systemd-journal


# APP vlc HOST pc07
sudo snap remove --purge vlc


# APP vscode HOST pc07
sudo snap remove --purge code


# APP webmin HOST pc07
sudo apt-get remove --purge --yes webmin
sudo apt-get autoremove --yes
sudo rm --force /etc/apt/sources.list.d/webmin.list* /usr/share/keyrings/webmin*
sudo apt-get update
