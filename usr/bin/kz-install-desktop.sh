# shellcheck shell=bash
###############################################################################
# SPDX-FileComment: Install file for a desktop
#
# SPDX-FileCopyrightText: Karel Zimmer <info@karelzimmer.nl>
# SPDX-License-Identifier: CC0-1.0
###############################################################################

# Install disabled-apport on *
#
# Do this first [1/3].
# Suppress the program crash report.
if [[ $(lsb_release --id --short) = 'Ubuntu' ]]; then sudo systemctl stop apport.service; fi
if [[ $(lsb_release --id --short) = 'Ubuntu' ]]; then sudo systemctl disable apport.service; fi
if [[ $(lsb_release --id --short) = 'Ubuntu' ]]; then sudo rm --force --verbose /var/crash/*; fi
if [[ $(lsb_release --id --short) = 'Ubuntu' ]]; then sudo sed --in-place --expression='s/enabled=1/enabled=0/' /etc/default/apport; fi

# Remove disabled-apport from *
#
# Do this first [1/3].
# Enable the program crash report.
if [[ $(lsb_release --id --short) = 'Ubuntu' ]]; then sudo sed --in-place --expression='s/enabled=0/enabled=1/' /etc/default/apport; fi
if [[ $(lsb_release --id --short) = 'Ubuntu' ]]; then sudo systemctl enable --now apport.service; fi

# Install extra-repos on *
#
# Do this first [2/3].
# More repositories with packages to choose from.
if [[ $(lsb_release --id --short) = 'Debian' ]]; then sudo apt-add-repository contrib; fi
if [[ $(lsb_release --id --short) = 'Debian' ]]; then sudo apt-add-repository non-free; fi
if [[ $(lsb_release --id --short) = 'Debian' ]]; then sudo apt-add-repository "deb https://www.deb-multimedia.org $(lsb_release --codename --short) main non-free"; fi
if [[ $(lsb_release --id --short) = 'Debian' ]]; then wget --output-document=/tmp/deb-multimedia-keyring_2016.8.1_all.deb 'https://www.deb-multimedia.org/pool/main/d/deb-multimedia-keyring/deb-multimedia-keyring_2016.8.1_all.deb'; fi
if [[ $(lsb_release --id --short) = 'Debian' ]]; then sudo apt-get install --yes /tmp/deb-multimedia-keyring_2016.8.1_all.deb; fi
if [[ $(lsb_release --id --short) = 'Debian' ]]; then rm /tmp/deb-multimedia-keyring_2016.8.1_all.deb; fi
if [[ $(lsb_release --id --short) = 'Debian' ]]; then sudo apt-get update; fi
if [[ $(lsb_release --id --short) = 'Debian' ]]; then sudo apt-get upgrade --yes; fi

# Remove extra-repos from *
#
# Do this first [2/3].
# Revert to standard repositories.
if [[ $(lsb_release --id --short) = 'Debian' ]]; then sudo apt-add-repository --remove contrib; fi
if [[ $(lsb_release --id --short) = 'Debian' ]]; then sudo apt-add-repository --remove non-free; fi
if [[ $(lsb_release --id --short) = 'Debian' ]]; then sudo apt-add-repository --remove "deb https://www.deb-multimedia.org $(lsb_release --codename --short) main non-free"; fi
if [[ $(lsb_release --id --short) = 'Debian' ]]; then sudo apt-get remove --yes deb-multimedia-keyring; fi
if [[ $(lsb_release --id --short) = 'Debian' ]]; then sudo apt-get update; fi
if [[ $(lsb_release --id --short) = 'Debian' ]]; then sudo apt-get upgrade --yes; fi

# Install update-system on *
#
# Do this first [3/3].
# Update the system.
sudo apt-get update
sudo apt-get upgrade --yes
if [[ $(lsb_release --id --short) = 'Ubuntu' ]]; then sudo snap refresh; fi

# Remove update-system from *
#
# Do this first [3/3].
# There is no command available to remove update system.

# Install ansible on pc06 pc07
sudo apt-get install --yes ansible

# Remove ansible from pc06 pc07
sudo apt-get remove --yes ansible

# Install anydesk on -nohost
#
# Remote Wayland display server is not supported.
wget --output-document=- 'https://keys.anydesk.com/repos/DEB-GPG-KEY' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/anydesk.gpg
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/anydesk.gpg] http://deb.anydesk.com/ all main' | sudo tee /etc/apt/sources.list.d/anydesk.list
sudo apt-get update
sudo apt-get install --yes anydesk
#
# Web app: https://my.anydesk.com/v2

# Remove anydesk from -nohost
sudo apt-get remove --yes anydesk
sudo rm --force --verbose /etc/apt/sources.list.d/anydesk.list* /usr/share/keyrings/anydesk.gpg*
sudo apt-get update

# Install bleachbit on pc-van-hugo
sudo apt-get install --yes bleachbit

# Remove bleachbit from pc-van-hugo
sudo apt-get remove --yes bleachbit

# Install calibre on pc06 pc-van-hugo
sudo apt-get install --yes calibre

# Remove calibre from pc06 pc-van-hugo
sudo apt-get remove --yes calibre

# Install change-grub-timeout on *
if [[ $(lsb_release --id --short) = 'Debian' ]]; then sudo sed --in-place --expression='s/GRUB_TIMEOUT=5/GRUB_TIMEOUT=1/' /etc/default/grub; fi
if [[ $(lsb_release --id --short) = 'Ubuntu' ]]; then sudo sed --in-place --expression='s/GRUB_TIMEOUT=10/GRUB_TIMEOUT=1/' /etc/default/grub; fi
sudo update-grub

# Remove change-grub-timeout from *
if [[ $(lsb_release --id --short) = 'Debian' ]]; then sudo sed --in-place --expression='s/GRUB_TIMEOUT=1/GRUB_TIMEOUT=5/' /etc/default/grub; fi
if [[ $(lsb_release --id --short) = 'Ubuntu' ]]; then sudo sed --in-place --expression='s/GRUB_TIMEOUT=1/GRUB_TIMEOUT=10/' /etc/default/grub; fi
sudo update-grub

# Install clamav on pc-van-hugo
sudo apt-get install --yes clamtk-gnome

# Remove clamav from pc-van-hugo
sudo apt-get remove --yes clamtk-gnome

# Install cockpit on pc06
sudo apt-get install --yes cockpit cockpit-pcp
#
# Web app: https://localhost:9090

# Remove cockpit from pc06
sudo apt-get remove --yes cockpit

# Install cups on *
sudo apt-get install --yes cups

# Remove cups from *
sudo apt-get remove --yes cups

# Install cups-backend-bjnp on pc-van-emily
#
# Add support for Canon USB over IP BJNP protocol.
sudo apt-get install --yes cups-backend-bjnp

# Remove cups-backend-bjnp from pc-van-emily
sudo apt-get remove --yes cups-backend-bjnp

# Install dashtodock on *
if type gnome-session; then sudo apt-get install --yes gnome-shell-extension-dashtodock || true; fi # Not every GNOME machine has this extension available.

# Remove dashtodock from *
if type gnome-session; then sudo apt-get remove --yes gnome-shell-extension-dashtodock || true; fi # Not every GNOME machine has this extension available.

# Install deja-dup on pc07
sudo apt-get install --yes deja-dup

# Remove deja-dup from pc07
sudo apt-get remove --yes deja-dup

# Install disabled-aer on pc06
#
# Disable kernel config parameter PCIEAER (Peripheral Component Interconnect Express Advanced Error Reporting) to prevent the log gets flooded with 'AER: Corrected errors received'. Usually needed for HP hardware.
sudo sed --in-place --expression='s/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash pci=noaer"/' /etc/default/grub
sudo update-grub
#
# Check for kernel config parameter pci=noaer.
grep --quiet --regexp='pci=noaer' /etc/default/grub

# Remove disabled-aer from pc06
sudo sed --in-place --expression='s/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash pci=noaer"/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash pci=noaer"/' /etc/default/grub
sudo update-grub
#
# Check for kernel config parameter pci=noaer.
! grep --quiet --regexp='pci=noaer' /etc/default/grub

# Install disabled-lidswitch on pc-van-hugo
sudo sed --in-place --expression='/^HandleLidSwitch=/d' /etc/systemd/logind.conf
echo 'HandleLidSwitch=ignore' | sudo tee --append /etc/systemd/logind.conf

# Remove disabled-lidswitch from pc-van-hugo
sudo sed --in-place --expression='/^HandleLidSwitch=/d' /etc/systemd/logind.conf

# Install exiftool on pc06 pc07
sudo apt-get install --yes libimage-exiftool-perl

# Remove exiftool from pc06 pc07
sudo apt-get remove --yes libimage-exiftool-perl

# Install fdupes on -nohost
sudo apt-get install --yes fdupes
#
# Usage:
# $ fdupes -r /home               # Report recursively from /home
# $ fdupes -d /path/to/folder     # Remove, interactively, from /path/to/folder
# $ fdupes -d -N /path/to/folder  # Delete, from /path/to/folder

# Remove fdupes from -nohost
sudo apt-get remove --yes fdupes

# Install force-x11 on -nohost
#
# Force the use of X11 because Wayland is not (yet) supported by remote desktop app AnyDesk.
# Force means no choice @ user login for X11 or Wayland!
sudo sed --in-place --expression='s/^#WaylandEnable=false/WaylandEnable=false/' /etc/gdm3/custom.conf
#
# To check, after reboot (!), execute: echo $XDG_SESSION_TYPE (should output 'x11')

# Remove force-x11 from -nohost
sudo sed --in-place --expression='s/^WaylandEnable=false/#WaylandEnable=false/' /etc/gdm3/custom.conf
#
# To check, after reboot (!), execute: echo $XDG_SESSION_TYPE (should output 'wayland')

# Install fwupd on -nohost
#
# Disable the Firmware update daemon.
sudo systemctl stop fwupd.service
sudo systemctl disable fwupd.service
sudo systemctl mask fwupd.service

# Remove fwupd from -nohost
#
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

# Install gimp on pc-van-hugo pc06
sudo apt-get install --yes gimp gimp-help-en gimp-help-nl

# Remove gimp from pc-van-hugo pc06
sudo apt-get remove --yes gimp gimp-help-en gimp-help-nl

# Install git on pc06 pc07
sudo apt-get install --yes git

# Remove git from pc06 pc07
sudo apt-get remove --yes git

# Install gnome-gmail on pc01 pc06 pc07
sudo apt-get install --yes gnome-gmail

# Remove gnome-gmail from pc01 pc06 pc07
sudo apt-get remove --yes gnome-gmail

# Install gnome-tweaks on pc01 pc06 pc07
sudo apt-get install --yes gnome-tweaks

# Remove gnome-tweaks from pc01 pc06 pc07
sudo apt-get remove --yes gnome-tweaks

# Install gnome-web on pc06
sudo apt-get install --yes epiphany-browser

# Remove gnome-web from pc06
sudo apt-get remove --yes epiphany-browser

# Install google-chrome on *
wget --output-document=- 'https://dl.google.com/linux/linux_signing_key.pub' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/google-chrome.gpg
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] https://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
sudo apt-get update
sudo apt-get install --yes google-chrome-stable
#
# Also install chrome-gnome-shell to make extensions.gnome.org work.
if type gnome-session; then sudo apt-get install --yes chrome-gnome-shell; fi
#
# Add the source list again because the installation overwrote the newly added source list.
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] https://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
#
# The apt-key added during installation is no longer needed.
sudo rm --force --verbose /etc/apt/trusted.gpg.d/google-chrome.gpg

# Remove google-chrome from *
if type gnome-session; then apt-get remove --yes chrome-gnome-shell; fi
sudo apt-get remove --yes google-chrome-stable chrome-gnome-shell
sudo rm --force --verbose /etc/apt/sources.list.d/google-chrome.list* /usr/share/keyrings/google-chrome.gpg* /etc/apt/trusted.gpg.d/google-chrome.gpg
sudo apt-get update

# Install google-earth on -nohost
wget --output-document=- 'https://dl.google.com/linux/linux_signing_key.pub' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/google-earth.gpg
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-earth.gpg] https://dl.google.com/linux/earth/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-earth-pro.list
sudo apt-get update
sudo apt-get install --yes google-earth-pro-stable
#
# Add the source list again because the installation overwrote the newly added source list.
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-earth.gpg] https://dl.google.com/linux/earth/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-earth-pro.list

# Remove google-earth from -nohost
sudo apt-get remove --yes google-earth-pro-stable
sudo rm --force --verbose /etc/apt/sources.list.d/google-earth-pro.list* /usr/share/keyrings/google-earth.gpg*
sudo apt-get update

# Install handbrake on pc-van-emily
sudo apt-get install --yes handbrake

# Remove handbrake from pc-van-emily
sudo apt-get remove --yes handbrake

# Install htop on pc06 pc07
sudo apt-get install --yes htop

# Remove htop from pc06 pc07
sudo apt-get remove --yes htop

# Install krita on pc06
sudo apt-get install --yes krita

# Remove krita from pc06
sudo apt-get remove --yes krita

# Install kvm on pc06 pc07
#
# Dpkg::Options to prevent interaction while restoring /etc/libvirt configuration files.
sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes --option Dpkg::Options::="--force-confdef" --option Dpkg::Options::="--force-confold" bridge-utils cpu-checker libvirt-clients libvirt-daemon-system qemu-kvm qemu-system virtinst virt-manager
sudo usermod --append --groups libvirt,libvirt-qemu "${SUDO_USER:-$USER}"
#
# Prevent "Error starting domain: Requested operation is not valid: network 'default' is not active".
sudo virsh --connect=qemu:///system net-autostart default
#
# Check network 'default' with: sudo virsh --connect=qemu:///system net-info default (should output 'Autostart: yes')
# Images are in: /var/lib/libvirt/images/

# Remove kvm from pc06 pc07
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

# Install locate on pc06 pc07
sudo apt-get install --yes locate
sudo updatedb

# Remove locate from pc06 pc07
sudo apt-get remove --yes locate

# Install lshw on pc07
sudo apt-get install --yes lshw

# Remove lshw from pc07
sudo apt-get remove --yes lshw

# Install monitors on pc06
if [[ -f /home/${SUDO_USER:-$USER}/.config/monitors.xml ]]; then sudo cp --preserve --verbose /home/"${SUDO_USER:-$USER}"/.config/monitors.xml ~gdm/.config/monitors.xml; fi
if [[ -f ~gdm/.config/monitors.xml ]]; then sudo chown --verbose gdm:gdm ~gdm/.config/monitors.xml; fi

# Remove monitors from pc06
sudo rm --force --verbose ~gdm/.config/monitors.xml

# Install nautilus-admin on pc06 pc07
sudo apt-get install --yes nautilus-admin

# Remove nautilus-admin from pc06 pc07
sudo apt-get remove --yes nautilus-admin

# Install python on pc06 pc07
sudo apt-get install --yes pycodestyle python3-pycodestyle python3-autopep8 python3-pip python-is-python3
sudo ln --force --relative --symbolic /usr/bin/pycodestyle /usr/bin/pep8
sudo ln --force --relative --symbolic /usr/bin/pip3 /usr/bin/pip

# Remove python from pc06 pc07
sudo apt-get remove --yes pycodestyle python3-pycodestyle python3-autopep8 python3-pip python-is-python3
sudo rm --force --verbose /usr/bin/pep8 /usr/bin/pip

# Install repair-ntfs on -nohost
sudo apt-get install --yes ntfs-3g
#
# Usage:
# $ findmnt
# TARGET          SOURCE    FSTYPE OPTIONS
# /media/...      /dev/sdb2 ntfs3  rw,nosuid,nodev,relatime,uid=...
# $ sudo ntfsfix /dev/sdb2

# Remove repair-ntfs from -nohost
sudo apt-get remove --yes ntfs-3g

# Install shellcheck on pc06 pc07
sudo apt-get install --yes shellcheck

# Remove shellcheck from pc06 pc07
sudo apt-get remove --yes shellcheck

# Install signal on pc06 pc07
wget --output-document=- 'https://updates.signal.org/desktop/apt/keys.asc' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/signal-desktop-keyring.gpg
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main'| sudo tee /etc/apt/sources.list.d/signal-xenial.list
sudo apt-get update
sudo apt-get install --yes signal-desktop

# Remove signal from pc06 pc07
sudo apt-get remove --yes signal-desktop
sudo rm --force --verbose /etc/apt/sources.list.d/signal-xenial.list* /usr/share/keyrings/signal-desktop-keyring.gpg*
sudo apt-get update

# Install sound-juicer on pc-van-emily
sudo apt-get install --yes sound-juicer

# Remove sound-juicer from pc-van-emily
sudo apt-get remove --yes sound-juicer

# Install spice-vdagent on *
sudo apt-get install --yes spice-vdagent

# Remove spice-vdagent from *
sudo apt-get remove --yes spice-vdagent

# Install ssh on pc01 pc06 pc07
sudo apt-get install --yes ssh
sudo sed --in-place --expression='s/PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
sudo sed --in-place --expression='/^192.168.1./d' /etc/hosts
sudo sed --in-place --expression='2a192.168.1.100 pc01' /etc/hosts
sudo sed --in-place --expression='3a192.168.1.2   pc06' /etc/hosts
sudo sed --in-place --expression='4a192.168.1.219 pc07' /etc/hosts
#
# Check for remote root access.
grep --quiet --regexp='PermitRootLogin no' /etc/ssh/sshd_config
sudo systemctl restart ssh.service

# Remove ssh from pc01 pc06 pc07
sudo sed --in-place --expression='/^192.168.1./d' /etc/hosts
sudo sed --in-place --expression='s/PermitRootLogin no/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config
sudo apt-get remove --yes ssh

# Install sushi on pc06
sudo apt-get install --yes gnome-sushi
#
# Usage:
# Select a file, press the space bar, and a preview will appear.

# Remove sushi from pc06
sudo apt-get remove --yes gnome-sushi

# Install teamviewer on *
wget --output-document=- 'https://download.teamviewer.com/download/linux/signature/TeamViewer2017.asc' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/teamviewer.gpg
echo 'deb [signed-by=/usr/share/keyrings/teamviewer.gpg] https://linux.teamviewer.com/deb stable main' | sudo tee /etc/apt/sources.list.d/teamviewer.list
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes teamviewer
#
# The apt-key added during installation is no longer needed.
sudo apt-key del 0C1289C0 DEB49217
#
# Web app: https://web.teamviewer.com

# Remove teamviewer from *
sudo apt-get remove --yes teamviewer
sudo rm --force --verbose /etc/apt/sources.list.d/teamviewer.list* /usr/share/keyrings/teamviewer*.gpg*
sudo apt-key del 0C1289C0 DEB49217
sudo apt-get update

# Install thunderbird on *
if [[ $(lsb_release --id --short) = 'Debian' ]]; then sudo apt-get install --yes thunderbird-l10n-nl; fi
if [[ $(lsb_release --id --short) = 'Ubuntu' ]]; then sudo apt-get install --yes thunderbird-locale-nl; fi

# Remove thunderbird from *
if [[ $(lsb_release --id --short) = 'Debian' ]]; then sudo apt-get remove --yes thunderbird-l10n-nl; fi
if [[ $(lsb_release --id --short) = 'Ubuntu' ]]; then sudo apt-get remove --yes thunderbird-locale-nl; fi

# Install tree on pc06 pc07
sudo apt-get install --yes tree

# Remove tree from pc06 pc07
sudo apt-get remove --yes tree

# Install ufw on pc01 pc06 pc07
sudo apt-get install --yes gufw
sudo ufw allow ssh
sudo ufw enable

# Remove ufw from pc01 pc06 pc07
sudo ufw disable
sudo apt-get remove --yes gufw

# Install usbutils on pc07
sudo apt-get install --yes usbutils

# Remove usbutils from pc07
sudo apt-get remove --yes usbutils

# Install user-guest on -nohost
sudo useradd --create-home --shell /usr/bin/bash --comment "$(gettext --domain=kz 'Guest user')" "$(gettext --domain=kz 'guest')" || true
sudo passwd --delete "$(gettext --domain=kz 'guest')"

# Remove user-guest from -nohost
sudo userdel --remove "$(gettext --domain=kz 'guest')"

# Install user-karel on pc01
sudo useradd --create-home --shell /usr/bin/bash --comment 'Karel Zimmer' karel || true
sudo usermod --append --groups adm,cdrom,sudo,dip,plugdev,lpadmin karel
sudo passwd --delete --expire karel

# Remove user-karel from pc01
sudo userdel --remove karel

# Install user-log-access on *
#
# Enable access to system monitoring tasks like read many log files in /var/log and to the log.
if [[ $(lsb_release --id --short) = 'Debian' ]]; then sudo usermod --append --groups adm,systemd-journal "${SUDO_USER:-$USER}"; fi

# Remove user-log-access from *
if [[ $(lsb_release --id --short) = 'Debian' ]]; then sudo deluser "${SUDO_USER:-$USER}" adm; fi
if [[ $(lsb_release --id --short) = 'Debian' ]]; then sudo deluser "${SUDO_USER:-$USER}" systemd-journal; fi

# Install user-toos on Laptop
sudo useradd --create-home --shell /usr/bin/bash --comment 'Toos Barendse' toos || true
sudo usermod --append --groups adm,cdrom,sudo,dip,plugdev,lpadmin toos
sudo passwd --delete --expire toos

# Remove user-toos from Laptop
sudo userdel --remove toos

# Install virtualbox on pc-van-hugo
#
# If installation hangs or VBox does not work, check Linux-info.txt.
echo 'virtualbox-ext-pack virtualbox-ext-pack/license select true' | sudo debconf-set-selections
sudo apt-get install --yes virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso
#
# VirtualBox Guest user Additions ISO are in: /usr/share/virtualbox/

# Remove virtualbox from pc-van-hugo
sudo apt-get remove --yes virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso

# Install vlc on *
sudo apt-get install --yes vlc

# Remove vlc from *
sudo apt-get remove --yes vlc

# Install vscode on pc01 pc06 pc07
wget --output-document=- 'https://packages.microsoft.com/keys/microsoft.asc' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list
sudo apt-get update
sudo apt-get install --yes code
sudo update-alternatives --set editor /usr/bin/code

# Remove vscode from pc01 pc06 pc07
sudo update-alternatives --remove editor /usr/bin/code
sudo apt-get remove --yes code
sudo rm --force --verbose /etc/apt/sources.list.d/vscode.list* /usr/share/keyrings/packages.microsoft*
sudo apt-get update

# Install webmin on pc07
wget --output-document=- 'https://www.webmin.com/jcameron-key.asc' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/webmin.gpg
echo 'deb [signed-by=/usr/share/keyrings/webmin.gpg] https://download.webmin.com/download/repository sarge contrib' | sudo tee /etc/apt/sources.list.d/webmin.list
sudo apt-get update
sudo apt-get install --yes webmin
#
# Web app: https://localhost:10000

# Remove webmin from pc07
sudo apt-get remove --yes webmin
sudo rm --force --verbose /etc/apt/sources.list.d/webmin.list* /usr/share/keyrings/webmin*
sudo apt-get update

# Install wine on -nohost
sudo apt-get install --yes wine winetricks playonlinux

# Remove wine from -nohost
sudo apt-get remove --yes wine winetricks playonlinux

# Install youtube-dl on pc-van-emily pc-van-hugo
sudo apt-get install --yes youtubedl-gui

# Remove youtube-dl from pc-van-emily pc-van-hugo
sudo apt-get remove --yes youtubedl-gui
