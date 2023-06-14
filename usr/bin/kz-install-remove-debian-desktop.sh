# shellcheck shell=bash
###############################################################################
# Remove apps file for Debian desktop.
#
# Written by Karel Zimmer <info@karelzimmer.nl>, CC0 1.0 Universal
# <https://creativecommons.org/publicdomain/zero/1.0>, 2023.
###############################################################################

#  APP extra-repos
# DESC Add extra repositories
# HOST *
sudo apt-add-repository --remove contrib
sudo apt-add-repository --remove non-free
sudo apt-get update

#  APP adm-group
# DESC Add user to group adm
# HOST pc07
sudo deluser "${SUDO_USER:-$USER}" adm

#  APP bash-completion
# DESC Enable tab completion
# HOST *
sudo apt-get remove --yes bash-completion

#  APP cups
# DESC Common UNIX Printing System
# HOST *
sudo apt-get remove --yes cups

#  APP dashtodock
# DESC Transform dash to dock
# HOST *
sudo apt-get remove --yes gnome-shell-extension-dashtodock

#  APP gnome-gmail
# DESC Gmail as the preferred email application in GNOME
# HOST pc07
sudo apt-get remove --yes gnome-gmail

#  APP google-chrome
# DESC Google's webbrowser
# HOST *
sudo apt-get remove --yes google-chrome-stable chrome-gnome-shell
sudo rm --force /etc/apt/sources.list.d/google-chrome.list* /usr/share/keyrings/google-chrome.gpg* /etc/apt/trusted.gpg.d/google-chrome.gpg
sudo apt-get update

#  APP journalctl
# DESC Enable access to the log
# HOST *
sudo deluser "${SUDO_USER:-$USER}" systemd-journal

#  APP kvm
# DESC Virtualization
# HOST pc07
sudo apt-get remove --yes bridge-utils cpu-checker libvirt-clients libvirt-daemon-system qemu-kvm qemu-system virtinst virt-manager
sudo delgroup libvirtd-dnsmasq
sudo deluser "${SUDO_USER:-$USER}" libvirtd
sudo deluser "${SUDO_USER:-$USER}" libvirtd-qemu
sudo delgroup libvirtd

#  APP libreoffice
# DESC Office suite
# HOST *
sudo apt-get remove --yes aspell-nl libreoffice libreoffice-help-nl libreoffice-l10n-nl

#  APP locate
# DESC Find files quick
# HOST pc07
sudo apt-get remove --yes mlocate

#  APP signal
# DESC Messaging
# HOST pc07
sudo apt-get remove --yes signal-desktop
sudo rm --force /etc/apt/sources.list.d/signal-xenial.list* /usr/share/keyrings/signal-desktop-keyring.gpg*
sudo apt-get update

#  APP spice-vdagent
# DESC Copy from host to guest and v.v.
# HOST pc07
sudo apt-get remove --yes spice-vdagent

#  APP teamviewer
# DESC Remote control
# HOST *
sudo apt-get remove --yes teamviewer
sudo rm --force /etc/apt/sources.list.d/teamviewer.list* /usr/share/keyrings/teamviewer.gpg*
sudo apt-key del 0C1289C0 DEB49217
sudo apt-get update

#  APP thunderbird
# DESC E-mail
# HOST *
sudo apt-get remove --yes thunderbird-l10n-nl

#  APP vlc
# DESC Media player
# HOST pc07
sudo snap remove vlc

#  APP vscode
# DESC Editor
# HOST pc07
sudo snap remove code

#  APP webmin
# DESC Web-based administration
# HOST pc07
sudo apt-get remove --yes webmin
sudo rm --force /etc/apt/sources.list.d/webmin.list* /usr/share/keyrings/webmin*
sudo apt-get update
