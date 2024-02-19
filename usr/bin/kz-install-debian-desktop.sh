# shellcheck shell=bash
###############################################################################
# Install file for Debian desktop.
#
# Written by Karel Zimmer <info@karelzimmer.nl>, CC0 1.0 Universal
# <https://creativecommons.org/publicdomain/zero/1.0>, 2013-2024.
###############################################################################
# Format: #<operation> APP <app> HOST [<host>...]
# Where operation '+' means install, and '-' means remove.

#+ APP anydesk HOST
# Web app: https://my.anydesk.com/v2
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/anydesk.gpg] http://deb.anydesk.com/ all main' | sudo tee /etc/apt/sources.list.d/anydesk.list > /dev/null
wget --output-document=- 'https://keys.anydesk.com/repos/DEB-GPG-KEY' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/anydesk.gpg
sudo apt-get update
sudo apt-get install --yes anydesk

#- APP anydesk HOST
sudo apt-get remove --yes anydesk
sudo rm --force --verbose /etc/apt/sources.list.d/anydesk.list* /usr/share/keyrings/anydesk.gpg*
sudo apt-get update


#+ APP bash-completion HOST *
sudo apt-get install --yes bash-completion

#- APP bash-completion HOST *
sudo apt-get remove --yes bash-completion


#+ APP cups HOST *
sudo apt-get install --yes cups

#- APP cups HOST *
sudo apt-get remove --yes cups


#+ APP dashtodock HOST *
sudo apt-get install --yes gnome-shell-extension-dashtodock

#- APP dashtodock HOST *
sudo apt-get remove --yes gnome-shell-extension-dashtodock


#+ APP deja-dup HOST *
sudo snap install --classic deja-dup

#- APP deja-dup HOST *
sudo snap remove deja-dup


#+ APP fdupes HOST
# Usage:
# fdupes -r /home               # Report recursively from /home
# fdupes -d /path/to/folder     # Remove, interactively, from /path/to/folder
# fdupes -d -N /path/to/folder  # Delete, from /path/to/folder
sudo apt-get install --yes fdupes

#- APP fdupes HOST
sudo apt-get remove --yes fdupes


#+ APP force-x11 HOST
# Force the use of X11 because Wayland is not (yet) supported by remote desktop app AnyDesk.
# Force means no choice @ user login for X11 or Wayland!
# To check, after reboot (!), execute: echo $XDG_SESSION_TYPE (should output 'x11')
sudo sed --in-place --expression='s/^#WaylandEnable=false/WaylandEnable=false/' /etc/gdm3/custom.conf

#- APP force-x11 HOST
# To check, after reboot (!), execute: echo $XDG_SESSION_TYPE (should output 'wayland')
sudo sed --in-place --expression='s/^WaylandEnable=false/#WaylandEnable=false/' /etc/gdm3/custom.conf


#+ APP fwupd HOST
# Disable the Firmware update daemon
sudo systemctl stop fwupd.service       # Stop the service
sudo systemctl disable fwupd.service    # Disable automatic start upon boot
sudo systemctl mask fwupd.service       # Disable manual invoking

#- APP fwupd HOST
# Enable the Firmware update daemon
systemctl unmask fwupd.service
sudo systemctl enable fwupd.service
sudo systemctl start fwupd.service


#+ APP gedit HOST *
sudo apt-get install --yes gedit

#- APP gedit HOST *
sudo apt-get remove --yes gedit


#+ APP gnome-gmail HOST pc07
sudo apt-get install --yes gnome-gmail

#- APP gnome-gmail HOST pc07
sudo apt-get remove --yes gnome-gmail


#+ APP google-chrome HOST pc07
# Extensions and policies are applied by "kz.deb" policy file policies.json, for Chrome in /etc/opt/chrome/policies/managed/, for Firefox in /etc/firefox/policies/.
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] https://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list > /dev/null
wget --output-document=- 'https://dl.google.com/linux/linux_signing_key.pub' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/google-chrome.gpg
sudo apt-get update
# Also install chrome-gnome-shell to make extensions.gnome.org work.
sudo apt-get install --yes google-chrome-stable chrome-gnome-shell
# The installation overwrites the newly added source-list.
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] https://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list > /dev/null
# The installation adds an apt-key that is no longer needed.
sudo rm --force --verbose /etc/apt/trusted.gpg.d/google-chrome.gpg

#- APP google-chrome HOST pc07
sudo apt-get remove --yes google-chrome-stable chrome-gnome-shell
sudo rm --force --verbose /etc/apt/sources.list.d/google-chrome.list* /usr/share/keyrings/google-chrome.gpg* /etc/apt/trusted.gpg.d/google-chrome.gpg
sudo apt-get update


#+ APP guest HOST
sudo useradd --create-home --shell /usr/bin/bash --comment "$(gettext --domain=kz 'Guest')" "$(gettext --domain=kz 'guest')" || true
sudo passwd --delete "$(gettext --domain=kz 'guest')"

#- APP guest HOST
sudo userdel --remove "$(gettext --domain=kz 'guest')"


#+ APP kvm HOST pc07
# Images are in /var/lib/libvirt/images/
# Dpkg::Options due to interaction due to restore /etc/libvirt configuration files.
sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes --option Dpkg::Options::="--force-confdef" --option Dpkg::Options::="--force-confold" bridge-utils cpu-checker libvirt-clients libvirt-daemon-system qemu-kvm qemu-system virtinst virt-manager
sudo usermod --append --groups libvirt,libvirt-qemu "${SUDO_USER:-$USER}"

#- APP kvm HOST pc07
sudo apt-get remove --yes bridge-utils cpu-checker libvirt-clients libvirt-daemon-system qemu-kvm qemu-system virtinst virt-manager
sudo delgroup libvirtd-dnsmasq
sudo deluser "${SUDO_USER:-$USER}" libvirtd
sudo deluser "${SUDO_USER:-$USER}" libvirtd-qemu
sudo delgroup libvirtd


#+ APP libreoffice HOST *
sudo apt-get install --yes aspell-en aspell-nl libreoffice libreoffice-help-nl libreoffice-l10n-nl

#- APP libreoffice HOST *
sudo apt-get remove --yes aspell-en aspell-nl libreoffice libreoffice-help-nl libreoffice-l10n-nl


#+ APP locate HOST pc07
sudo apt-get install --yes mlocate

#- APP locate HOST pc07
sudo apt-get remove --yes mlocate


#+ APP repair-ntfs HOST
# Usage:
# findmnt
# TARGET          SOURCE    FSTYPE OPTIONS
# /media/...      /dev/sdb2 ntfs3  rw,nosuid,nodev,relatime,uid=...
# sudo ntfsfix /dev/sdb2
sudo apt-get install --yes ntfs-3g

#- APP repair-ntfs HOST
sudo apt-get remove --yes ntfs-3g


#+ APP repositories HOST *
sudo apt-add-repository contrib
sudo apt-add-repository non-free
sudo apt-add-repository "deb https://www.deb-multimedia.org $(lsb_release --codename --short) main non-free"
wget --output-document=/tmp/deb-multimedia-keyring_2016.8.1_all.deb 'https://www.deb-multimedia.org/pool/main/d/deb-multimedia-keyring/deb-multimedia-keyring_2016.8.1_all.deb'
sudo apt-get install --yes /tmp/deb-multimedia-keyring_2016.8.1_all.deb
rm /tmp/deb-multimedia-keyring_2016.8.1_all.deb
sudo apt-get update

#- APP repositories HOST *
sudo apt-add-repository --remove contrib
sudo apt-add-repository --remove non-free
sudo apt-add-repository --remove "deb https://www.deb-multimedia.org $(lsb_release --codename --short) main non-free"
sudo apt-get remove --yes deb-multimedia-keyring
sudo apt-get update


#+ APP signal HOST pc07
# Web app: n/a
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main'| sudo tee /etc/apt/sources.list.d/signal-xenial.list > /dev/null
wget --output-document=- 'https://updates.signal.org/desktop/apt/keys.asc' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/signal-desktop-keyring.gpg
sudo apt-get update
sudo apt-get install --yes signal-desktop

#- APP signal HOST pc07
sudo apt-get remove --yes signal-desktop
sudo rm --force --verbose /etc/apt/sources.list.d/signal-xenial.list* /usr/share/keyrings/signal-desktop-keyring.gpg*
sudo apt-get update


#+ APP spice-vdagent HOST *
sudo apt-get install --yes spice-vdagent

#- APP spice-vdagent HOST *
sudo apt-get remove --yes spice-vdagent


#+ APP teamviewer HOST *
# Web app: https://web.teamviewer.com
echo 'deb [signed-by=/usr/share/keyrings/teamviewer.gpg] https://linux.teamviewer.com/deb stable main' | sudo tee /etc/apt/sources.list.d/teamviewer.list > /dev/null
wget --output-document=- 'https://download.teamviewer.com/download/linux/signature/TeamViewer2017.asc' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/teamviewer.gpg
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes teamviewer
# The installation adds an apt-key that is no longer needed.
sudo apt-key del 0C1289C0 DEB49217

#- APP teamviewer HOST *
sudo apt-get remove --yes teamviewer
sudo rm --force --verbose /etc/apt/sources.list.d/teamviewer.list* /usr/share/keyrings/teamviewer*.gpg*
sudo apt-key del 0C1289C0 DEB49217
sudo apt-get update


#+ APP thunderbird HOST *
sudo apt-get install --yes thunderbird-l10n-nl

#- APP thunderbird HOST *
sudo apt-get remove --yes thunderbird-l10n-nl


#+ APP users HOST *
# Enable access to system monitoring tasks like read many log files in /var/log and to the log.
sudo usermod --append --groups adm,systemd-journal "${SUDO_USER:-$USER}"

#- APP users HOST *
sudo deluser "${SUDO_USER:-$USER}" adm
sudo deluser "${SUDO_USER:-$USER}" systemd-journal


#+ APP vlc HOST *
sudo snap install vlc

#- APP vlc HOST pc07
sudo snap remove vlc


#+ APP vscode HOST pc07
sudo snap install --classic code

#- APP vscode HOST pc07
sudo snap remove code


#+ APP webmin HOST pc07
# Web app: https://localhost:10000
echo 'deb [signed-by=/usr/share/keyrings/webmin.gpg] https://download.webmin.com/download/repository sarge contrib' | sudo tee /etc/apt/sources.list.d/webmin.list > /dev/null
wget --output-document=- 'https://www.webmin.com/jcameron-key.asc' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/webmin.gpg
sudo apt-get update
sudo apt-get install --yes webmin

#- APP webmin HOST pc07
sudo apt-get remove --yes webmin
sudo rm --force --verbose /etc/apt/sources.list.d/webmin.list* /usr/share/keyrings/webmin*
sudo apt-get update
