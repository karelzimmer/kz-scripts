# shellcheck shell=bash
###############################################################################
# Uninstall file for Ubuntu desktop.
#
# Written by Karel Zimmer <info@karelzimmer.nl>, CC0 1.0 Universal
# <https://creativecommons.org/publicdomain/zero/1.0>, 2023-2024.
###############################################################################


# APP ansible HOST pc06
sudo apt-get remove --yes ansible


# APP anydesk HOST
sudo apt-get remove --yes anydesk
sudo rm --force --verbose /etc/apt/sources.list.d/anydesk.list* /usr/share/keyrings/anydesk.gpg*
sudo apt-get update


# APP apport HOST *
sudo sed --in-place --expression='s/enabled=0/enabled=1/' /etc/default/apport
sudo systemctl enable --now apport.service


# APP bleachbit HOST pc-van-hugo
sudo apt-get remove --yes bleachbit


# APP calibre HOST pc06 pc-van-hugo
sudo apt-get remove --yes calibre


# APP clamav HOST pc-van-hugo
sudo apt-get remove --yes clamtk-gnome


# APP cockpit HOST pc06
sudo apt-get remove --yes cockpit


# APP cups-backend-bjnp HOST pc-van-emily
sudo apt-get remove --yes cups-backend-bjnp


# APP disable-aer HOST pc06
sudo sed --in-place --expression='s/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash pci=noaer"/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash pci=noaer"/' /etc/default/grub
sudo update-grub
# Check for kernel config parameter pci=noaer.
! grep --quiet --regexp='pci=noaer' /etc/default/grub


# APP exiftool HOST pc06
sudo apt-get remove --yes libimage-exiftool-perl


# APP fdupes HOST
sudo apt-get remove --yes fdupes


# APP force-x11 HOST
# Force the use of X11 because Wayland is not (yet) supported by remote desktop apps such as AnyDesk and TeamViewer.
# Force means no choice @ user login for X11 or Wayland!
# To check, after reboot (!), execute: echo $XDG_SESSION_TYPE (should output 'wayland')
sudo sed --in-place --expression='s/^WaylandEnable=false/#WaylandEnable=false/' /etc/gdm3/custom.conf


# APP fwupd HOST
# Enable the Firmware update daemon
systemctl unmask fwupd.service
sudo systemctl enable fwupd.service
sudo systemctl start fwupd.service


# APP gimp HOST pc06 pc-van-hugo
sudo apt-get remove --yes gimp gimp-help-en gimp-help-nl


# APP gnome-gmail HOST pc01 pc06
sudo apt-get remove --yes gnome-gmail


# APP gnome-tweaks HOST *
sudo apt-get remove --yes gnome-tweaks


# APP gnome-web HOST pc06
sudo apt-get remove --yes epiphany-browser


# APP google-chrome HOST pc01 pc02 pc06
sudo apt-get remove --yes google-chrome-stable chrome-gnome-shell
sudo rm --force --verbose /etc/apt/sources.list.d/google-chrome.list* /usr/share/keyrings/google-chrome.gpg* /etc/apt/trusted.gpg.d/google-chrome.gpg
sudo apt-get update


# APP google-earth HOST
sudo apt-get remove --yes google-earth-pro-stable
sudo rm --force --verbose /etc/apt/sources.list.d/google-earth-pro.list* /usr/share/keyrings/google-earth.gpg*
sudo apt-get update


# APP grub-timeout HOST *
sudo sed --in-place --expression='s/GRUB_TIMEOUT=3/GRUB_TIMEOUT=10/' /etc/default/grub
sudo update-grub


# APP guest HOST
sudo userdel --remove "$(gettext --domain=kz 'guest')"


# APP handbrake HOST pc-van-emily
sudo apt-get remove --yes handbrake


# APP handlelidswitch HOST pc-van-hugo
sudo sed --in-place --expression='/^HandleLidSwitch=/d' /etc/systemd/logind.conf


# APP hostnames HOST pc01 pc06
sudo sed --in-place --expression='/^192.168.1.83/d' /etc/hosts
sudo sed --in-place --expression='/^192.168.1.100/d' /etc/hosts


# APP htop HOST pc06
sudo apt-get remove --yes htop


# APP kvm HOST pc06
sudo apt-get remove --yes cpu-checker qemu-kvm bridge-utils virt-manager
sudo delgroup libvirtd-dnsmasq
sudo deluser "${SUDO_USER:-${SUDO_USER:-$USER}}" libvirtd
sudo delgroup libvirtd


# APP libreoffice HOST *
sudo apt-get remove --yes aspell-en aspell-nl libreoffice


# APP locate HOST pc06
sudo apt-get remove --yes mlocate


# APP monitors HOST pc06
sudo rm --force --verbose ~gdm/.config/monitors.xml


# APP nautilus-admin HOST pc06
sudo apt-get remove --yes nautilus-admin


# APP repair-ntfs HOST
sudo apt-get remove --yes ntfs-3g


# APP signal HOST pc06
sudo apt-get remove --yes signal-desktop
sudo rm --force --verbose /etc/apt/sources.list.d/signal-xenial.list* /usr/share/keyrings/signal-desktop-keyring.gpg*
sudo apt-get update


# APP sound-juicer HOST pc-van-emily
sudo apt-get remove --yes sound-juicer


# APP ssh HOST pc01 pc06
sudo sed --in-place --expression='s/PermitRootLogin no/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config
sudo apt-get remove --yes ssh


# APP sushi HOST pc06
sudo apt-get remove --yes gnome-sushi


# APP teamviewer HOST *
sudo apt-get remove --yes teamviewer
sudo rm --force --verbose /etc/apt/sources.list.d/teamviewer.list* /usr/share/keyrings/teamviewer*.gpg*
sudo apt-key del 0C1289C0 DEB49217
sudo apt-get update


# APP tree HOST pc06
sudo apt-get remove --yes tree


# APP ufw HOST pc01 pc06
sudo ufw disable
sudo apt-get remove --yes gufw


# APP virtualbox HOST pc-van-hugo
sudo apt-get remove --yes virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso


# APP vlc HOST pc06
sudo snap remove vlc


# APP vscode HOST pc01 pc06
sudo snap remove code


# APP wine HOST
sudo apt-get remove --yes wine winetricks playonlinux


# APP youtube-dl HOST pc-van-emily pc-van-hugo
sudo apt-get remove --yes youtubedl-gui
