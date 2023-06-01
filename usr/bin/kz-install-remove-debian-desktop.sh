# shellcheck shell=bash
###############################################################################
# Remove apps file for Debian desktop.
#
# Written by Karel Zimmer <info@karelzimmer.nl>, CC0 1.0 Universal
# <https://creativecommons.org/publicdomain/zero/1.0>, 2023.
###############################################################################
# Record types:
# # APP <app>       Remove <app>, or
# #-APP <app>       Ditto, not used with option --apps and argument APP
# # HOST <host>...  Where to execute <Command>s (e.g. pc02 or *)
# # <Description>   Description of the <app>
# <Command>         Command line [1-n]
###############################################################################

#-APP extra-repos
# HOST *
# Add extra repositories (exececute this first)
sudo apt-add-repository --remove contrib
sudo apt-add-repository --remove non-free
sudo apt-get update

#-APP adm-group
# HOST pc07
# Add user to group adm
sudo deluser "${SUDO_USER:-$USER}" adm

#-APP bash-completion
# HOST *
# Enable tab completion
sudo apt-get remove --yes bash-completion

#-APP cups
# HOST *
# Common UNIX Printing System
sudo apt-get remove --yes cups

#-APP dashtodock
# HOST *
# Transform dash to dock
sudo apt-get remove --yes gnome-shell-extension-dashtodock

#-APP deact-eth0
# HOST pc07
# Remove activate eth0 from startup
sudo sed --in-place --expression='s/^#auto eth0$/auto eth0/' /etc/network/interfaces.d/setup
sudo sed --in-place --expression='s/^#iface eth0 net dhcp$/iface eth0 net dhcp/' /etc/network/interfaces.d/setup

# APP gnome-gmail
# HOST pc07
# Gmail as the preferred email application in GNOME
sudo apt-get remove --yes gnome-gmail

# APP google-chrome
# HOST *
# Google's webbrowser
sudo apt-get remove --yes google-chrome-stable chrome-gnome-shell
sudo rm --force /etc/apt/sources.list.d/google-chrome.list* /usr/share/keyrings/google-chrome.gpg* /etc/apt/trusted.gpg.d/google-chrome.gpg
sudo apt-get update

#-APP journalctl
# HOST *
# Enable access to the log
sudo deluser "${SUDO_USER:-$USER}" systemd-journal

# APP kvm
# HOST pc07
# Virtualization
sudo apt-get remove --yes bridge-utils cpu-checker libvirt-clients libvirt-daemon-system qemu-kvm qemu-system virtinst virt-manager
sudo delgroup libvirtd-dnsmasq
sudo deluser "${SUDO_USER:-$USER}" libvirtd
sudo deluser "${SUDO_USER:-$USER}" libvirtd-qemu
sudo delgroup libvirtd

# APP libreoffice
# HOST *
# Office suite
sudo apt-get remove --yes aspell-nl libreoffice libreoffice-help-nl libreoffice-l10n-nl

# APP locate
# HOST pc07
# Find files quick
sudo apt-get remove --yes mlocate

# APP signal
# HOST pc07
# Messaging
sudo apt-get remove --yes signal-desktop
sudo rm --force /etc/apt/sources.list.d/signal-xenial.list* /usr/share/keyrings/signal-desktop-keyring.gpg*
sudo apt-get update

# APP spice-vdagent
# HOST pc07
# Copy from host to guest and v.v.
sudo apt-get remove --yes spice-vdagent

# APP teamviewer
# HOST *
# Remote control
sudo apt-get remove --yes teamviewer
sudo rm --force /etc/apt/sources.list.d/teamviewer.list* /usr/share/keyrings/teamviewer.gpg*
sudo apt-key del 0C1289C0 DEB49217
sudo apt-get update

# APP thunderbird
# HOST *
# E-mail
sudo apt-get remove --yes thunderbird-l10n-nl

# APP vlc
# HOST pc07
# Media player
sudo snap remove vlc

# APP webmin
# HOST pc07
# Web-based administration
sudo apt-get remove --yes webmin
sudo rm --force /etc/apt/sources.list.d/webmin.list* /usr/share/keyrings/webmin*
sudo apt-get update
