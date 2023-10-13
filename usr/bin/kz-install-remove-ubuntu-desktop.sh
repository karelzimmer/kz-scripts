# shellcheck shell=bash
###############################################################################
# Standard uninstaller file for Ubuntu desktop.
#
# Written by Karel Zimmer <info@karelzimmer.nl>, CC0 1.0 Universal
# <https://creativecommons.org/publicdomain/zero/1.0>, 2023.
###############################################################################

# APP apport *
# EXEC THIS FIRST.
sudo sed --in-place --expression='s/enabled=0/enabled=1/' /etc/default/apport
sudo systemctl enable --now apport.service


# APP ansible pc06
sudo apt-get remove --purge --yes ansible
sudo apt-get autoremove --yes


# APP anydesk *
# Web app: https://my.anydesk.com/v2
sudo apt-get remove --purge --yes anydesk
sudo apt-get autoremove --yes
sudo rm --force /etc/apt/sources.list.d/anydesk.list* /usr/share/keyrings/anydesk.gpg*
sudo apt-get update


# APP bleachbit pc-van-hugo
sudo apt-get remove --purge --yes bleachbit
sudo apt-get autoremove --yes


# APP bluetooth pc01
# Enable internal bluetooth adapter, see: lsusb
sudo rm --force /etc/udev/rules.d/81-bluetooth-hci.rules


# APP brightness pc06
echo '' | sudo tee /etc/rc.local
sudo chmod -x /etc/rc.local


# APP calibre pc-van-hugo pc04 pc06
sudo apt-get remove --purge --yes calibre
sudo apt-get autoremove --yes


# APP citrix pc-van-ria-en-toos
sudo apt-get remove --purge --yes icaclient libidn11
sudo apt-get autoremove --yes


# APP clamav pc-van-hugo
sudo apt-get remove --purge --yes clamtk-gnome
sudo apt-get autoremove --yes


# APP cockpit pc06
# Web app: https://localhost:9090
sudo apt-get remove --purge --yes cockpit
sudo apt-get autoremove --yes


# APP cups pc-van-emily
# Remove support for Canon BJNP protocol
sudo apt-get remove --purge --yes cups-backend-bjnp
sudo apt-get autoremove --yes


# APP dual-monitor pc06
sudo rm --force ~gdm/.config/monitors.xml


# APP exiftool pc06
sudo apt-get remove --purge --yes libimage-exiftool-perl
sudo apt-get autoremove --yes


# APP gast pc01 pc06
sudo userdel --remove gast


# APP gimp pc-van-hugo pc06
sudo apt-get remove --purge --yes gimp gimp-help-en gimp-help-nl
sudo apt-get autoremove --yes


# APP gnome-gmail pc01 pc04 pc06
sudo apt-get remove --purge --yes gnome-gmail
sudo apt-get autoremove --yes


# APP gnome-tweaks pc06
sudo apt-get remove --purge --yes gnome-tweaks
sudo apt-get autoremove --yes


# APP google-chrome *
sudo apt-get remove --purge --yes google-chrome-stable chrome-gnome-shell
sudo apt-get autoremove --yes
sudo rm --force /etc/apt/sources.list.d/google-chrome.list* /usr/share/keyrings/google-chrome.gpg* /etc/apt/trusted.gpg.d/google-chrome.gpg
sudo apt-get update


# APP google-earth pc04
sudo apt-get remove --purge --yes google-earth-pro-stable
sudo apt-get autoremove --yes
sudo rm --force /etc/apt/sources.list.d/google-earth-pro.list* /usr/share/keyrings/google-earth.gpg*
sudo apt-get update


# APP handbrake pc-van-emily
sudo apt-get remove --purge --yes handbrake
sudo apt-get autoremove --yes


# APP hosts pc01 pc06
sudo sed --in-place --expression='/^192.168.1.83/d' /etc/hosts
sudo sed --in-place --expression='/^192.168.1.64/d' /etc/hosts


# APP kvm pc06
sudo apt-get remove --purge --yes cpu-checker qemu-kvm bridge-utils virt-manager
sudo apt-get autoremove --yes
sudo delgroup libvirtd-dnsmasq
sudo deluser "${SUDO_USER:-${SUDO_USER:-$USER}}" libvirtd
sudo delgroup libvirtd


# APP libreoffice *
sudo apt-get remove --purge --yes aspell-nl libreoffice
sudo apt-get autoremove --yes


# APP lidswitch pc-van-hugo pc04
sudo sed --in-place --expression='/^HandleLidSwitch=/d' /etc/systemd/logind.conf


# APP locate pc06
sudo apt-get remove --purge --yes mlocate
sudo apt-get autoremove --yes


# APP nautilus-admin pc06
sudo apt-get remove --purge --yes nautilus-admin
sudo apt-get autoremove --yes


# APP restricted-addons *
sudo apt-get remove --purge --yes ubuntu-restricted-addons libavcodec-extra
sudo apt-get autoremove --yes


# APP ros pc04
:


# APP signal pc06
sudo apt-get remove --purge --yes signal-desktop
sudo apt-get autoremove --yes
sudo rm --force /etc/apt/sources.list.d/signal-xenial.list* /usr/share/keyrings/signal-desktop-keyring.gpg*
sudo apt-get update


# APP sound-juicer pc-van-emily
sudo apt-get remove --purge --yes sound-juicer
sudo apt-get autoremove --yes


# APP ssh pc01 pc06
sudo sed --in-place --expression='s/PermitRootLogin no/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config
sudo apt-get remove --purge --yes ssh
sudo apt-get autoremove --yes


# APP sushi pc06
# Select a file, press the space bar, and a preview will appear.
sudo apt-get remove --purge --yes gnome-sushi
sudo apt-get autoremove --yes


# APP teamviewer *
sudo apt-get remove --purge --yes teamviewer
sudo apt-get autoremove --yes
sudo rm --force /etc/apt/sources.list.d/teamviewer.list* /usr/share/keyrings/teamviewer*.gpg*
sudo apt-key del 0C1289C0 DEB49217
sudo apt-get update


# APP tree pc06
sudo apt-get remove --purge --yes tree
sudo apt-get autoremove --yes


# APP ufw pc01 pc06
sudo ufw disable
sudo apt-get remove --purge --yes gufw
sudo apt-get autoremove --yes


# APP virtualbox pc-van-hugo
sudo apt-get remove --purge --yes virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso
sudo apt-get autoremove --yes


# APP vlc pc06
sudo snap remove --purge vlc


# APP vscode pc01 pc07
sudo snap remove --purge code


# APP wayland *
# Remove the forced use of X11 because Wayland is not (yet) supported by remote desktop apps such as AnyDesk and TeamViewer.
# To check, after reboot (!), execute: echo $XDG_SESSION_TYPE (should output 'wayland')
sudo sed --in-place --expression='s/^WaylandEnable=false/#WaylandEnable=false/' /etc/gdm3/custom.conf


# APP web pc06
sudo apt-get remove --purge --yes epiphany-browser
sudo apt-get autoremove --yes


# APP wine pc04
sudo apt-get remove --purge --yes wine winetricks playonlinux
sudo apt-get autoremove --yes


# APP youtube-downloader pc-van-emily pc-van-hugo
sudo apt-get remove --purge --yes youtubedl-gui
sudo apt-get autoremove --yes
