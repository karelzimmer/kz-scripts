# shellcheck shell=bash
###############################################################################
# Standard uninstaller file for Debian desktop.
#
# Written by Karel Zimmer <info@karelzimmer.nl>, CC0 1.0 Universal
# <https://creativecommons.org/publicdomain/zero/1.0>, 2023.
###############################################################################

# APP add-repository *
# EXEC THIS FIRST.
sudo apt-add-repository --remove contrib
sudo apt-add-repository --remove non-free
sudo apt-add-repository --remove "deb https://www.deb-multimedia.org $(lsb_release --codename --short) main non-free"
sudo apt-get remove --purge --yes deb-multimedia-keyring
sudo apt-get autoremove --yes
sudo apt-get update


# APP anydesk *
sudo apt-get remove --purge --yes anydesk
sudo apt-get autoremove --yes
sudo rm --force /etc/apt/sources.list.d/anydesk.list* /usr/share/keyrings/anydesk.gpg*
sudo apt-get update


# APP bash-completion *
sudo apt-get remove --purge --yes bash-completion
sudo apt-get autoremove --yes


# APP cups *
sudo apt-get remove --purge --yes cups
sudo apt-get autoremove --yes


# APP dashtodock *
sudo apt-get remove --purge --yes gnome-shell-extension-dashtodock
sudo apt-get autoremove --yes


# APP deja-dup *
sudo snap remove --purge deja-dup


# APP gedit *
sudo apt-get remove --purge --yes gedit
sudo apt-get autoremove --yes


# APP gnome-gmail pc07 debian
sudo apt-get remove --purge --yes gnome-gmail
sudo apt-get autoremove --yes


# APP google-chrome *
sudo apt-get remove --purge --yes google-chrome-stable chrome-gnome-shell
sudo apt-get autoremove --yes
sudo rm --force /etc/apt/sources.list.d/google-chrome.list* /usr/share/keyrings/google-chrome.gpg* /etc/apt/trusted.gpg.d/google-chrome.gpg
sudo apt-get update


# APP kvm pc07
sudo apt-get remove --purge --yes bridge-utils cpu-checker libvirt-clients libvirt-daemon-system qemu-kvm qemu-system virtinst virt-manager
sudo apt-get autoremove --yes
sudo delgroup libvirtd-dnsmasq
sudo deluser "${SUDO_USER:-$USER}" libvirtd
sudo deluser "${SUDO_USER:-$USER}" libvirtd-qemu
sudo delgroup libvirtd


# APP libreoffice *
sudo apt-get remove --purge --yes aspell-nl libreoffice libreoffice-help-nl libreoffice-l10n-nl
sudo apt-get autoremove --yes


# APP locate pc07 debian
sudo apt-get remove --purge --yes mlocate
sudo apt-get autoremove --yes


# APP logging *
sudo deluser "${SUDO_USER:-$USER}" adm
sudo deluser "${SUDO_USER:-$USER}" systemd-journal


# APP signal pc07
sudo apt-get remove --purge --yes signal-desktop
sudo apt-get autoremove --yes
sudo rm --force /etc/apt/sources.list.d/signal-xenial.list* /usr/share/keyrings/signal-desktop-keyring.gpg*
sudo apt-get update


# APP spice-vdagent *
sudo apt-get remove --purge --yes spice-vdagent
sudo apt-get autoremove --yes


# APP teamviewer *
sudo apt-get remove --purge --yes teamviewer
sudo apt-get autoremove --yes
sudo rm --force /etc/apt/sources.list.d/teamviewer.list* /usr/share/keyrings/teamviewer*.gpg*
sudo apt-key del 0C1289C0 DEB49217
sudo apt-get update


# APP thunderbird *
sudo apt-get remove --purge --yes thunderbird-l10n-nl
sudo apt-get autoremove --yes


# APP vlc pc07
sudo snap remove --purge vlc


# APP vscode pc07 debian
sudo snap remove --purge code


# APP webmin pc07
sudo apt-get remove --purge --yes webmin
sudo apt-get autoremove --yes
sudo rm --force /etc/apt/sources.list.d/webmin.list* /usr/share/keyrings/webmin*
sudo apt-get update
