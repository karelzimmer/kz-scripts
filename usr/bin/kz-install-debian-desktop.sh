# shellcheck shell=bash
###############################################################################
# SPDX-FileComment: Install file for Debian desktop
#
# SPDX-FileCopyrightText: Karel Zimmer <info@karelzimmer.nl>
# SPDX-License-Identifier: CC0-1.0
###############################################################################

########################## Execute this block first ###########################
# Install extra-repos *
# Add additional repositories.
sudo apt-add-repository contrib
sudo apt-add-repository non-free
sudo apt-add-repository "deb https://www.deb-multimedia.org $(lsb_release --codename --short) main non-free"
wget --output-document=/tmp/deb-multimedia-keyring_2016.8.1_all.deb 'https://www.deb-multimedia.org/pool/main/d/deb-multimedia-keyring/deb-multimedia-keyring_2016.8.1_all.deb'
sudo apt-get install --yes /tmp/deb-multimedia-keyring_2016.8.1_all.deb
rm /tmp/deb-multimedia-keyring_2016.8.1_all.deb
sudo apt-get update
sudo apt-get upgrade --yes

# Remove extra-repos *
# Remove additional repositories.
sudo apt-add-repository --remove contrib
sudo apt-add-repository --remove non-free
sudo apt-add-repository --remove "deb https://www.deb-multimedia.org $(lsb_release --codename --short) main non-free"
sudo apt-get remove --yes deb-multimedia-keyring
sudo apt-get update
sudo apt-get upgrade --yes


# Install update-system *
sudo apt-get update
sudo apt-get upgrade --yes
sudo snap refresh

# Remove update-system *
# There is no command available to remove update system.
########################## Execute this block first ###########################


# Install anydesk -nohost
# Remote Wayland display server is not supported.
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/anydesk.gpg] http://deb.anydesk.com/ all main' | sudo tee /etc/apt/sources.list.d/anydesk.list > /dev/null
wget --output-document=- 'https://keys.anydesk.com/repos/DEB-GPG-KEY' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/anydesk.gpg
sudo apt-get update
sudo apt-get install --yes anydesk
# Web app: https://my.anydesk.com/v2

# Remove anydesk -nohost
sudo apt-get remove --yes anydesk
sudo rm --force --verbose /etc/apt/sources.list.d/anydesk.list* /usr/share/keyrings/anydesk.gpg*
sudo apt-get update


# Install bash-completion *
sudo apt-get install --yes bash-completion

# Remove bash-completion *
sudo apt-get remove --yes bash-completion


# Install change-grub-timeout *
sudo sed --in-place --expression='s/GRUB_TIMEOUT=5/GRUB_TIMEOUT=3/' /etc/default/grub
sudo update-grub

# Remove change-grub-timeout *
sudo sed --in-place --expression='s/GRUB_TIMEOUT=3/GRUB_TIMEOUT=5/' /etc/default/grub
sudo update-grub


# Install cups *
sudo apt-get install --yes cups

# Remove cups *
sudo apt-get remove --yes cups


# Install dashtodock *
sudo apt-get install --yes gnome-shell-extension-dashtodock

# Remove dashtodock *
sudo apt-get remove --yes gnome-shell-extension-dashtodock


# Install deja-dup *
sudo snap install --classic deja-dup

# Remove deja-dup *
sudo snap remove deja-dup


# Install fdupes -nohost
sudo apt-get install --yes fdupes
# Usage:
# $ fdupes -r /home               # Report recursively from /home
# $ fdupes -d /path/to/folder     # Remove, interactively, from /path/to/folder
# $ fdupes -d -N /path/to/folder  # Delete, from /path/to/folder

# Remove fdupes -nohost
sudo apt-get remove --yes fdupes


# Install force-x11 -nohost
# Force the use of X11 because Wayland is not (yet) supported by remote desktop app AnyDesk.
# Force means no choice @ user login for X11 or Wayland!
sudo sed --in-place --expression='s/^#WaylandEnable=false/WaylandEnable=false/' /etc/gdm3/custom.conf
# To check, after reboot (!), execute: echo $XDG_SESSION_TYPE (should output 'x11')

# Remove force-x11 -nohost
sudo sed --in-place --expression='s/^WaylandEnable=false/#WaylandEnable=false/' /etc/gdm3/custom.conf
# To check, after reboot (!), execute: echo $XDG_SESSION_TYPE (should output 'wayland')


# Install fwupd -nohost
# Disable the Firmware update daemon.
sudo systemctl stop fwupd.service
sudo systemctl disable fwupd.service
sudo systemctl mask fwupd.service

# Remove fwupd -nohost
# Enable the Firmware update daemon.
sudo systemctl unmask fwupd.service
sudo systemctl enable fwupd.service
sudo systemctl start fwupd.service


# Install gdebi *
sudo apt-get install --yes gdebi

# Remove gdebi *
sudo apt-get remove --yes gdebi


# Install gedit *
sudo apt-get install --yes gedit

# Remove gedit *
sudo apt-get remove --yes gedit


# Install gnome-gmail pc07
sudo apt-get install --yes gnome-gmail

# Remove gnome-gmail pc07
sudo apt-get remove --yes gnome-gmail


# Install google-chrome pc07
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] https://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list > /dev/null
wget --output-document=- 'https://dl.google.com/linux/linux_signing_key.pub' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/google-chrome.gpg
sudo apt-get update
# Also install chrome-gnome-shell to make extensions.gnome.org work.
sudo apt-get install --yes google-chrome-stable chrome-gnome-shell
# Add the source list again because the installation overwrote the newly added source list.
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] https://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list > /dev/null
# Remove the apt-key added during installation as an apt-key is no longer needed.
sudo rm --force --verbose /etc/apt/trusted.gpg.d/google-chrome.gpg

# Remove google-chrome pc07
sudo apt-get remove --yes google-chrome-stable chrome-gnome-shell
sudo rm --force --verbose /etc/apt/sources.list.d/google-chrome.list* /usr/share/keyrings/google-chrome.gpg* /etc/apt/trusted.gpg.d/google-chrome.gpg
sudo apt-get update


# Install kvm pc07
# Dpkg::Options due to interaction due to restoring /etc/libvirt configuration files.
sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes --option Dpkg::Options::="--force-confdef" --option Dpkg::Options::="--force-confold" bridge-utils cpu-checker libvirt-clients libvirt-daemon-system qemu-kvm qemu-system virtinst virt-manager
sudo usermod --append --groups libvirt,libvirt-qemu "${SUDO_USER:-$USER}"
# Images are in: /var/lib/libvirt/images/

# Remove kvm pc07
sudo apt-get remove --yes bridge-utils cpu-checker libvirt-clients libvirt-daemon-system qemu-kvm qemu-system virtinst virt-manager
sudo delgroup libvirtd-dnsmasq
sudo deluser "${SUDO_USER:-$USER}" libvirtd
sudo deluser "${SUDO_USER:-$USER}" libvirtd-qemu
sudo delgroup libvirtd


# Install libreoffice *
sudo apt-get install --yes aspell-en aspell-nl libreoffice libreoffice-help-nl libreoffice-l10n-nl

# Remove libreoffice *
sudo apt-get remove --yes aspell-en aspell-nl libreoffice libreoffice-help-nl libreoffice-l10n-nl


# Install locate pc07
sudo apt-get install --yes locate
sudo updatedb

# Remove locate pc07
sudo apt-get remove --yes locate


# Install log-access *
# Enable access to system monitoring tasks like read many log files in /var/log and to the log.
sudo usermod --append --groups adm,systemd-journal "${SUDO_USER:-$USER}"

# Remove log-access *
sudo deluser "${SUDO_USER:-$USER}" adm
sudo deluser "${SUDO_USER:-$USER}" systemd-journal


# Install lshw *
sudo apt-get install --yes lshw

# Remove lshw *
sudo apt-get remove --yes lshw


# Install repair-ntfs -nohost
sudo apt-get install --yes ntfs-3g
# Usage:
# $ findmnt
#   TARGET          SOURCE    FSTYPE OPTIONS
#   /media/...      /dev/sdb2 ntfs3  rw,nosuid,nodev,relatime,uid=...
# $ sudo ntfsfix /dev/sdb2

# Remove repair-ntfs -nohost
sudo apt-get remove --yes ntfs-3g


# Install signal pc07
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main'| sudo tee /etc/apt/sources.list.d/signal-xenial.list > /dev/null
wget --output-document=- 'https://updates.signal.org/desktop/apt/keys.asc' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/signal-desktop-keyring.gpg
sudo apt-get update
sudo apt-get install --yes signal-desktop

# Remove signal pc07
sudo apt-get remove --yes signal-desktop
sudo rm --force --verbose /etc/apt/sources.list.d/signal-xenial.list* /usr/share/keyrings/signal-desktop-keyring.gpg*
sudo apt-get update


# Install spice-vdagent *
sudo apt-get install --yes spice-vdagent

# Remove spice-vdagent *
sudo apt-get remove --yes spice-vdagent


# Install ssh pc07
sudo apt-get install --yes ssh
sudo sed --in-place --expression='s/PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
sudo sed --in-place --expression='/^192.168.1./d' /etc/hosts
sudo sed --in-place --expression='2a192.168.1.100 pc01' /etc/hosts
sudo sed --in-place --expression='3a192.168.1.2   pc06' /etc/hosts
sudo sed --in-place --expression='4a192.168.1.219 pc07' /etc/hosts
# Check for remote root access.
grep --quiet --regexp='PermitRootLogin no' /etc/ssh/sshd_config
sudo systemctl restart ssh.service

# Remove ssh pc07
sudo sed --in-place --expression='/^192.168.1./d' /etc/hosts
sudo sed --in-place --expression='s/PermitRootLogin no/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config
sudo apt-get remove --yes ssh


# Install teamviewer *
echo 'deb [signed-by=/usr/share/keyrings/teamviewer.gpg] https://linux.teamviewer.com/deb stable main' | sudo tee /etc/apt/sources.list.d/teamviewer.list > /dev/null
wget --output-document=- 'https://download.teamviewer.com/download/linux/signature/TeamViewer2017.asc' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/teamviewer.gpg
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes teamviewer
# Remove the apt-key added during installation as an apt-key is no longer needed.
sudo apt-key del 0C1289C0 DEB49217
# Web app: https://web.teamviewer.com

# Remove teamviewer *
sudo apt-get remove --yes teamviewer
sudo rm --force --verbose /etc/apt/sources.list.d/teamviewer.list* /usr/share/keyrings/teamviewer*.gpg*
sudo apt-key del 0C1289C0 DEB49217
sudo apt-get update


# Install thunderbird *
sudo apt-get install --yes thunderbird-l10n-nl

# Remove thunderbird *
sudo apt-get remove --yes thunderbird-l10n-nl


# Install usbutils *
sudo apt-get install --yes usbutils

# Remove usbutils *
sudo apt-get remove --yes usbutils


# Install user-guest -nohost
sudo useradd --create-home --shell /usr/bin/bash --comment "$(gettext --domain=kz 'Guest user')" "$(gettext --domain=kz 'guest')" || true
sudo passwd --delete "$(gettext --domain=kz 'guest')"

# Remove user-guest -nohost
sudo userdel --remove "$(gettext --domain=kz 'guest')"


# Install vlc *
sudo snap remove vlc
sudo apt-get install --yes vlc

# Remove vlc *
sudo snap remove vlc
sudo apt-get remove --yes vlc


# Install vscode pc07
sudo snap install --classic code

# Remove vscode pc07
sudo snap remove code


# Install webmin pc07
echo 'deb [signed-by=/usr/share/keyrings/webmin.gpg] https://download.webmin.com/download/repository sarge contrib' | sudo tee /etc/apt/sources.list.d/webmin.list > /dev/null
wget --output-document=- 'https://www.webmin.com/jcameron-key.asc' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/webmin.gpg
sudo apt-get update
sudo apt-get install --yes webmin
# Web app: https://localhost:10000

# Remove webmin pc07
sudo apt-get remove --yes webmin
sudo rm --force --verbose /etc/apt/sources.list.d/webmin.list* /usr/share/keyrings/webmin*
sudo apt-get update
