# shellcheck shell=bash
###############################################################################
# SPDX-FileComment: Install file for Debian desktop
#
# SPDX-FileCopyrightText: Karel Zimmer <info@karelzimmer.nl>
# SPDX-License-Identifier: CC0-1.0
###############################################################################

# Install extra-repos on *
# Do this first [1/2].
# More repositories with packages to choose from.
sudo apt-add-repository contrib
sudo apt-add-repository non-free
sudo apt-add-repository "deb https://www.deb-multimedia.org $(lsb_release --codename --short) main non-free"
wget --output-document=/tmp/deb-multimedia-keyring_2016.8.1_all.deb 'https://www.deb-multimedia.org/pool/main/d/deb-multimedia-keyring/deb-multimedia-keyring_2016.8.1_all.deb'
sudo apt-get install --yes /tmp/deb-multimedia-keyring_2016.8.1_all.deb
rm /tmp/deb-multimedia-keyring_2016.8.1_all.deb
sudo apt-get update
sudo apt-get upgrade --yes

# Remove extra-repos from *
# Do this first [1/2].
# Revert to standard repositories.
sudo apt-add-repository --remove contrib
sudo apt-add-repository --remove non-free
sudo apt-add-repository --remove "deb https://www.deb-multimedia.org $(lsb_release --codename --short) main non-free"
sudo apt-get remove --yes deb-multimedia-keyring
sudo apt-get update
sudo apt-get upgrade --yes

# Install update-system on *
# Do this first [2/2].
# Update the system.
sudo apt-get update
sudo apt-get upgrade --yes
sudo snap refresh

# Remove update-system from *
# Do this first [2/2].
# There is no command available to remove update system.

# Install anydesk on -nohost
# Remote Wayland display server is not supported.
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/anydesk.gpg] http://deb.anydesk.com/ all main' | sudo tee /etc/apt/sources.list.d/anydesk.list > /dev/null
wget --output-document=- 'https://keys.anydesk.com/repos/DEB-GPG-KEY' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/anydesk.gpg
sudo apt-get update
sudo apt-get install --yes anydesk
# Web app: https://my.anydesk.com/v2

# Remove anydesk from -nohost
sudo apt-get remove --yes anydesk
sudo rm --force --verbose /etc/apt/sources.list.d/anydesk.list* /usr/share/keyrings/anydesk.gpg*
sudo apt-get update

# Install bash-completion on *
sudo apt-get install --yes bash-completion

# Remove bash-completion from *
sudo apt-get remove --yes bash-completion

# Install change-grub-timeout on *
sudo sed --in-place --expression='s/GRUB_TIMEOUT=5/GRUB_TIMEOUT=3/' /etc/default/grub
sudo update-grub

# Remove change-grub-timeout from *
sudo sed --in-place --expression='s/GRUB_TIMEOUT=3/GRUB_TIMEOUT=5/' /etc/default/grub
sudo update-grub

# Install cups on *
sudo apt-get install --yes cups

# Remove cups from *
sudo apt-get remove --yes cups

# Install dashtodock on *
sudo apt-get install --yes gnome-shell-extension-dashtodock

# Remove dashtodock from *
sudo apt-get remove --yes gnome-shell-extension-dashtodock

# Install deja-dup on *
sudo snap install --classic deja-dup

# Remove deja-dup from *
sudo snap remove deja-dup

# Install fdupes on -nohost
sudo apt-get install --yes fdupes
# Usage:
# $ fdupes -r /home               # Report recursively from /home
# $ fdupes -d /path/to/folder     # Remove, interactively, from /path/to/folder
# $ fdupes -d -N /path/to/folder  # Delete, from /path/to/folder

# Remove fdupes from -nohost
sudo apt-get remove --yes fdupes

# Install force-x11 on -nohost
# Force the use of X11 because Wayland is not (yet) supported by remote desktop app AnyDesk.
# Force means no choice @ user login for X11 or Wayland!
sudo sed --in-place --expression='s/^#WaylandEnable=false/WaylandEnable=false/' /etc/gdm3/custom.conf
# To check, after reboot (!), execute: echo $XDG_SESSION_TYPE (should output 'x11')

# Remove force-x11 from -nohost
sudo sed --in-place --expression='s/^WaylandEnable=false/#WaylandEnable=false/' /etc/gdm3/custom.conf
# To check, after reboot (!), execute: echo $XDG_SESSION_TYPE (should output 'wayland')

# Install fwupd on -nohost
# Disable the Firmware update daemon.
sudo systemctl stop fwupd.service
sudo systemctl disable fwupd.service
sudo systemctl mask fwupd.service

# Remove fwupd from -nohost
# Enable the Firmware update daemon.
sudo systemctl unmask fwupd.service
sudo systemctl enable fwupd.service
sudo systemctl start fwupd.service

# Install gdebi on *
sudo apt-get install --yes gdebi

# Remove gdebi from *
sudo apt-get remove --yes gdebi

# Install gedit on *
sudo apt-get install --yes gedit

# Remove gedit from *
sudo apt-get remove --yes gedit

# Install gnome-gmail on pc07
sudo apt-get install --yes gnome-gmail

# Remove gnome-gmail from pc07
sudo apt-get remove --yes gnome-gmail

# Install google-chrome on *
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] https://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list > /dev/null
wget --output-document=- 'https://dl.google.com/linux/linux_signing_key.pub' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/google-chrome.gpg
sudo apt-get update
# Also install chrome-gnome-shell to make extensions.gnome.org work.
sudo apt-get install --yes google-chrome-stable chrome-gnome-shell
# Add the source list again because the installation overwrote the newly added source list.
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] https://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list > /dev/null
# Remove the apt-key added during installation as an apt-key is no longer needed.
sudo rm --force --verbose /etc/apt/trusted.gpg.d/google-chrome.gpg

# Remove google-chrome from *
sudo apt-get remove --yes google-chrome-stable chrome-gnome-shell
sudo rm --force --verbose /etc/apt/sources.list.d/google-chrome.list* /usr/share/keyrings/google-chrome.gpg* /etc/apt/trusted.gpg.d/google-chrome.gpg
sudo apt-get update

# Install kvm on pc07
# Dpkg::Options to prevent interaction while restoring /etc/libvirt configuration files.
sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes --option Dpkg::Options::="--force-confdef" --option Dpkg::Options::="--force-confold" bridge-utils cpu-checker libvirt-clients libvirt-daemon-system qemu-kvm qemu-system virtinst virt-manager
sudo usermod --append --groups libvirt,libvirt-qemu "${SUDO_USER:-$USER}"
# Prevent "Error starting domain: Requested operation is not valid: network 'default' is not active".
sudo virsh --connect=qemu:///system net-autostart default
# Check network 'default' with: sudo virsh --connect=qemu:///system net-info default (should output 'Autostart: yes')
# Images are in: /var/lib/libvirt/images/

# Remove kvm from pc07
sudo virsh --connect=qemu:///system net-autostart default --disable
sudo apt-get remove --yes bridge-utils cpu-checker libvirt-clients libvirt-daemon-system qemu-kvm qemu-system virtinst virt-manager
sudo delgroup libvirtd-dnsmasq
sudo deluser "${SUDO_USER:-$USER}" libvirtd
sudo deluser "${SUDO_USER:-$USER}" libvirtd-qemu
sudo delgroup libvirtd

# Install libreoffice on *
sudo apt-get install --yes aspell-en aspell-nl libreoffice libreoffice-help-nl libreoffice-l10n-nl

# Remove libreoffice from *
sudo apt-get remove --yes aspell-en aspell-nl libreoffice libreoffice-help-nl libreoffice-l10n-nl

# Install locate on pc07
sudo apt-get install --yes locate
sudo updatedb

# Remove locate from pc07
sudo apt-get remove --yes locate

# Install lshw on *
sudo apt-get install --yes lshw

# Remove lshw from *
sudo apt-get remove --yes lshw

# Install repair-ntfs on -nohost
sudo apt-get install --yes ntfs-3g
# Usage:
# $ findmnt
#   TARGET          SOURCE    FSTYPE OPTIONS
#   /media/...      /dev/sdb2 ntfs3  rw,nosuid,nodev,relatime,uid=...
# $ sudo ntfsfix /dev/sdb2

# Remove repair-ntfs from -nohost
sudo apt-get remove --yes ntfs-3g

# Install signal on pc07
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main'| sudo tee /etc/apt/sources.list.d/signal-xenial.list > /dev/null
wget --output-document=- 'https://updates.signal.org/desktop/apt/keys.asc' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/signal-desktop-keyring.gpg
sudo apt-get update
sudo apt-get install --yes signal-desktop

# Remove signal from pc07
sudo apt-get remove --yes signal-desktop
sudo rm --force --verbose /etc/apt/sources.list.d/signal-xenial.list* /usr/share/keyrings/signal-desktop-keyring.gpg*
sudo apt-get update

# Install spice-vdagent on *
sudo apt-get install --yes spice-vdagent

# Remove spice-vdagent from *
sudo apt-get remove --yes spice-vdagent

# Install ssh on pc07
sudo apt-get install --yes ssh
sudo sed --in-place --expression='s/PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
sudo sed --in-place --expression='/^192.168.1./d' /etc/hosts
sudo sed --in-place --expression='2a192.168.1.100 pc01' /etc/hosts
sudo sed --in-place --expression='3a192.168.1.2   pc06' /etc/hosts
sudo sed --in-place --expression='4a192.168.1.219 pc07' /etc/hosts
# Check for remote root access.
grep --quiet --regexp='PermitRootLogin no' /etc/ssh/sshd_config
sudo systemctl restart ssh.service

# Remove ssh from pc07
sudo sed --in-place --expression='/^192.168.1./d' /etc/hosts
sudo sed --in-place --expression='s/PermitRootLogin no/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config
sudo apt-get remove --yes ssh

# Install teamviewer on *
echo 'deb [signed-by=/usr/share/keyrings/teamviewer.gpg] https://linux.teamviewer.com/deb stable main' | sudo tee /etc/apt/sources.list.d/teamviewer.list > /dev/null
wget --output-document=- 'https://download.teamviewer.com/download/linux/signature/TeamViewer2017.asc' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/teamviewer.gpg
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes teamviewer
# Remove the apt-key added during installation as an apt-key is no longer needed.
sudo apt-key del 0C1289C0 DEB49217
# Web app: https://web.teamviewer.com

# Remove teamviewer from *
sudo apt-get remove --yes teamviewer
sudo rm --force --verbose /etc/apt/sources.list.d/teamviewer.list* /usr/share/keyrings/teamviewer*.gpg*
sudo apt-key del 0C1289C0 DEB49217
sudo apt-get update

# Install thunderbird on *
sudo apt-get install --yes thunderbird-l10n-nl

# Remove thunderbird from *
sudo apt-get remove --yes thunderbird-l10n-nl

# Install usbutils on *
sudo apt-get install --yes usbutils

# Remove usbutils from *
sudo apt-get remove --yes usbutils

# Install user-guest on -nohost
sudo useradd --create-home --shell /usr/bin/bash --comment "$(gettext --domain=kz 'Guest user')" "$(gettext --domain=kz 'guest')" || true
sudo passwd --delete "$(gettext --domain=kz 'guest')"

# Remove user-guest from -nohost
sudo userdel --remove "$(gettext --domain=kz 'guest')"

# Install vlc on *
sudo snap remove vlc
sudo apt-get install --yes vlc

# Remove vlc from *
sudo snap remove vlc
sudo apt-get remove --yes vlc

# Install vscode on pc07
sudo snap install --classic code

# Remove vscode from pc07
sudo snap remove code

# Install webmin on pc07
echo 'deb [signed-by=/usr/share/keyrings/webmin.gpg] https://download.webmin.com/download/repository sarge contrib' | sudo tee /etc/apt/sources.list.d/webmin.list > /dev/null
wget --output-document=- 'https://www.webmin.com/jcameron-key.asc' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/webmin.gpg
sudo apt-get update
sudo apt-get install --yes webmin
# Web app: https://localhost:10000

# Remove webmin from pc07
sudo apt-get remove --yes webmin
sudo rm --force --verbose /etc/apt/sources.list.d/webmin.list* /usr/share/keyrings/webmin*
sudo apt-get update

# Install user-log-access on *
# Enable access to system monitoring tasks like read many log files in /var/log and to the log.
sudo usermod --append --groups adm,systemd-journal "${SUDO_USER:-$USER}"

# Remove user-log-access from *
sudo deluser "${SUDO_USER:-$USER}" adm
sudo deluser "${SUDO_USER:-$USER}" systemd-journal
