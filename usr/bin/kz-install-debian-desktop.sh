# shellcheck shell=bash
###############################################################################
# SPDX-FileComment: Install file for Debian desktop
#
# SPDX-FileCopyrightText: Karel Zimmer <info@karelzimmer.nl>
# SPDX-License-Identifier: CC0-1.0
###############################################################################

# Install APP anydesk HOST
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/anydesk.gpg] http://deb.anydesk.com/ all main' | sudo tee /etc/apt/sources.list.d/anydesk.list > /dev/null
wget --output-document=- 'https://keys.anydesk.com/repos/DEB-GPG-KEY' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/anydesk.gpg
sudo apt-get update
sudo apt-get install --yes anydesk
: # Web app: https://my.anydesk.com/v2

# Remove APP anydesk HOST
sudo apt-get remove --yes anydesk
sudo rm --force --verbose /etc/apt/sources.list.d/anydesk.list* /usr/share/keyrings/anydesk.gpg*
sudo apt-get update


# Install APP bash-completion HOST *
sudo apt-get install --yes bash-completion

# Remove APP bash-completion HOST *
sudo apt-get remove --yes bash-completion


# Install APP cups HOST *
sudo apt-get install --yes cups

# Remove APP cups HOST *
sudo apt-get remove --yes cups


# Install APP dashtodock HOST *
sudo apt-get install --yes gnome-shell-extension-dashtodock

# Remove APP dashtodock HOST *
sudo apt-get remove --yes gnome-shell-extension-dashtodock


# Install APP deja-dup HOST *
sudo snap install --classic deja-dup

# Remove APP deja-dup HOST *
sudo snap remove deja-dup


# Install APP fdupes HOST
sudo apt-get install --yes fdupes
: # Usage:
: # fdupes -r /home               # Report recursively from /home
: # fdupes -d /path/to/folder     # Remove, interactively, from /path/to/folder
: # fdupes -d -N /path/to/folder  # Delete, from /path/to/folder

# Remove APP fdupes HOST
sudo apt-get remove --yes fdupes


# Install APP force-x11 HOST
: # Force the use of X11 because Wayland is not (yet) supported by remote desktop app AnyDesk.
: # Force means no choice @ user login for X11 or Wayland!
sudo sed --in-place --expression='s/^#WaylandEnable=false/WaylandEnable=false/' /etc/gdm3/custom.conf
: # To check, after reboot (!), execute: echo $XDG_SESSION_TYPE (should output 'x11')

# Remove APP force-x11 HOST
sudo sed --in-place --expression='s/^WaylandEnable=false/#WaylandEnable=false/' /etc/gdm3/custom.conf
: # To check, after reboot (!), execute: echo $XDG_SESSION_TYPE (should output 'wayland')


# Install APP fwupd HOST
: # Disable the Firmware update daemon
sudo systemctl stop fwupd.service
sudo systemctl disable fwupd.service
sudo systemctl mask fwupd.service

# Remove APP fwupd HOST
: # Enable the Firmware update daemon
systemctl unmask fwupd.service
sudo systemctl enable fwupd.service
sudo systemctl start fwupd.service


# Install APP gedit HOST *
sudo apt-get install --yes gedit

# Remove APP gedit HOST *
sudo apt-get remove --yes gedit


# Install APP gnome-gmail HOST pc07
sudo apt-get install --yes gnome-gmail

# Remove APP gnome-gmail HOST pc07
sudo apt-get remove --yes gnome-gmail


# Install APP google-chrome HOST pc07
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] https://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list > /dev/null
wget --output-document=- 'https://dl.google.com/linux/linux_signing_key.pub' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/google-chrome.gpg
sudo apt-get update
: # Also install chrome-gnome-shell to make extensions.gnome.org work.
sudo apt-get install --yes google-chrome-stable chrome-gnome-shell
: # Add the source list again because the installation overwrote the newly added source list.
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] https://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list > /dev/null
: # Remove the apt-key added during installation as an apt-key is no longer needed.
sudo rm --force --verbose /etc/apt/trusted.gpg.d/google-chrome.gpg

# Remove APP google-chrome HOST pc07
sudo apt-get remove --yes google-chrome-stable chrome-gnome-shell
sudo rm --force --verbose /etc/apt/sources.list.d/google-chrome.list* /usr/share/keyrings/google-chrome.gpg* /etc/apt/trusted.gpg.d/google-chrome.gpg
sudo apt-get update


# Install APP guest HOST
sudo useradd --create-home --shell /usr/bin/bash --comment "$(gettext --domain=kz 'Guest')" "$(gettext --domain=kz 'guest')" || true
sudo passwd --delete "$(gettext --domain=kz 'guest')"

# Remove APP guest HOST
sudo userdel --remove "$(gettext --domain=kz 'guest')"


# Install APP kvm HOST pc07
: # Dpkg::Options due to interaction due to restoring /etc/libvirt configuration files.
sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes --option Dpkg::Options::="--force-confdef" --option Dpkg::Options::="--force-confold" bridge-utils cpu-checker libvirt-clients libvirt-daemon-system qemu-kvm qemu-system virtinst virt-manager
sudo usermod --append --groups libvirt,libvirt-qemu "${SUDO_USER:-$USER}"
: # Images are in /var/lib/libvirt/images/

# Remove APP kvm HOST pc07
sudo apt-get remove --yes bridge-utils cpu-checker libvirt-clients libvirt-daemon-system qemu-kvm qemu-system virtinst virt-manager
sudo delgroup libvirtd-dnsmasq
sudo deluser "${SUDO_USER:-$USER}" libvirtd
sudo deluser "${SUDO_USER:-$USER}" libvirtd-qemu
sudo delgroup libvirtd


# Install APP libreoffice HOST *
sudo apt-get install --yes aspell-en aspell-nl libreoffice libreoffice-help-nl libreoffice-l10n-nl

# Remove APP libreoffice HOST *
sudo apt-get remove --yes aspell-en aspell-nl libreoffice libreoffice-help-nl libreoffice-l10n-nl


# Install APP locate HOST pc07
sudo apt-get install --yes mlocate

# Remove APP locate HOST pc07
sudo apt-get remove --yes mlocate


# Install APP repair-ntfs HOST
sudo apt-get install --yes ntfs-3g
: # Usage:
: # findmnt
: # TARGET          SOURCE    FSTYPE OPTIONS
: # /media/...      /dev/sdb2 ntfs3  rw,nosuid,nodev,relatime,uid=...
: # sudo ntfsfix /dev/sdb2

# Remove APP repair-ntfs HOST
sudo apt-get remove --yes ntfs-3g


# Install APP repositories HOST *
sudo apt-add-repository contrib
sudo apt-add-repository non-free
sudo apt-add-repository "deb https://www.deb-multimedia.org $(lsb_release --codename --short) main non-free"
wget --output-document=/tmp/deb-multimedia-keyring_2016.8.1_all.deb 'https://www.deb-multimedia.org/pool/main/d/deb-multimedia-keyring/deb-multimedia-keyring_2016.8.1_all.deb'
sudo apt-get install --yes /tmp/deb-multimedia-keyring_2016.8.1_all.deb
rm /tmp/deb-multimedia-keyring_2016.8.1_all.deb
sudo apt-get update

# Remove APP repositories HOST *
sudo apt-add-repository --remove contrib
sudo apt-add-repository --remove non-free
sudo apt-add-repository --remove "deb https://www.deb-multimedia.org $(lsb_release --codename --short) main non-free"
sudo apt-get remove --yes deb-multimedia-keyring
sudo apt-get update


# Install APP signal HOST pc07
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main'| sudo tee /etc/apt/sources.list.d/signal-xenial.list > /dev/null
wget --output-document=- 'https://updates.signal.org/desktop/apt/keys.asc' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/signal-desktop-keyring.gpg
sudo apt-get update
sudo apt-get install --yes signal-desktop

# Remove APP signal HOST pc07
sudo apt-get remove --yes signal-desktop
sudo rm --force --verbose /etc/apt/sources.list.d/signal-xenial.list* /usr/share/keyrings/signal-desktop-keyring.gpg*
sudo apt-get update


# Install APP spice-vdagent HOST *
sudo apt-get install --yes spice-vdagent

# Remove APP spice-vdagent HOST *
sudo apt-get remove --yes spice-vdagent


# Install APP teamviewer HOST *
echo 'deb [signed-by=/usr/share/keyrings/teamviewer.gpg] https://linux.teamviewer.com/deb stable main' | sudo tee /etc/apt/sources.list.d/teamviewer.list > /dev/null
wget --output-document=- 'https://download.teamviewer.com/download/linux/signature/TeamViewer2017.asc' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/teamviewer.gpg
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes teamviewer
: # Remove the apt-key added during installation as an apt-key is no longer needed.
sudo apt-key del 0C1289C0 DEB49217
: # Web app: https://web.teamviewer.com

# Remove APP teamviewer HOST *
sudo apt-get remove --yes teamviewer
sudo rm --force --verbose /etc/apt/sources.list.d/teamviewer.list* /usr/share/keyrings/teamviewer*.gpg*
sudo apt-key del 0C1289C0 DEB49217
sudo apt-get update


# Install APP thunderbird HOST *
sudo apt-get install --yes thunderbird-l10n-nl

# Remove APP thunderbird HOST *
sudo apt-get remove --yes thunderbird-l10n-nl


# Install APP users HOST *
: # Enable access to system monitoring tasks like read many log files in /var/log and to the log.
sudo usermod --append --groups adm,systemd-journal "${SUDO_USER:-$USER}"

# Remove APP users HOST *
sudo deluser "${SUDO_USER:-$USER}" adm
sudo deluser "${SUDO_USER:-$USER}" systemd-journal


# Install APP vlc HOST *
sudo snap install vlc

# Remove APP vlc HOST pc07
sudo snap remove vlc


# Install APP vscode HOST pc07
sudo snap install --classic code

# Remove APP vscode HOST pc07
sudo snap remove code


# Install APP webmin HOST pc07
echo 'deb [signed-by=/usr/share/keyrings/webmin.gpg] https://download.webmin.com/download/repository sarge contrib' | sudo tee /etc/apt/sources.list.d/webmin.list > /dev/null
wget --output-document=- 'https://www.webmin.com/jcameron-key.asc' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/webmin.gpg
sudo apt-get update
sudo apt-get install --yes webmin
: # Web app: https://localhost:10000

# Remove APP webmin HOST pc07
sudo apt-get remove --yes webmin
sudo rm --force --verbose /etc/apt/sources.list.d/webmin.list* /usr/share/keyrings/webmin*
sudo apt-get update
