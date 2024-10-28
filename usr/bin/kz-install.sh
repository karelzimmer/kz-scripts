# shellcheck shell=bash
###############################################################################
# SPDX-FileComment: Install file for use with kz-install script
#
# SPDX-FileCopyrightText: Karel Zimmer <info@karelzimmer.nl>
# SPDX-License-Identifier: CC0-1.0
###############################################################################
# For the format of the records in this file, see the kz install man page.
# To manually running a command, first run the following: source kz_common.sh

# Install disabled-apport on *
# Disable the program crash report.
if $UBUNTU; then sudo systemctl stop apport.service; fi
if $UBUNTU; then sudo systemctl disable apport.service; fi
if $UBUNTU; then sudo rm --force --verbose /var/crash/*; fi
if $UBUNTU; then sudo sed --in-place --expression='s/enabled=1/enabled=0/' /etc/default/apport; fi

# Remove disabled-apport from *
# Enable the program crash report.
if $UBUNTU; then sudo sed --in-place --expression='s/enabled=0/enabled=1/' /etc/default/apport; fi
if $UBUNTU; then sudo systemctl enable --now apport.service; fi

# Install update-system on *
sudo kz update

# Remove update-system from *
# There is no command available to remove update system.

# Install ansible on pc06 pc07
sudo apt-get install --assume-yes ansible

# Remove ansible from pc06 pc07
sudo apt-get remove --assume-yes ansible

# Install anydesk on -nohost
# Remote Wayland display server is not supported.
wget --output-document=- 'https://keys.anydesk.com/repos/DEB-GPG-KEY' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/anydesk.gpg
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/anydesk.gpg] http://deb.anydesk.com/ all main' | sudo tee /etc/apt/sources.list.d/anydesk.list
sudo apt-get update
sudo apt-get install --assume-yes anydesk
# Web app: https://my.anydesk.com/v2

# Remove anydesk from -nohost
sudo apt-get remove --assume-yes anydesk
sudo rm --force --verbose /etc/apt/sources.list.d/anydesk.list* /usr/share/keyrings/anydesk.gpg*
sudo apt-get update

# Install backintime on -nohost
# Back In Time is a simple backup tool for Linux.
# The backup is done by taking snapshots of a specified set of folders.
sudo apt-get install --assume-yes backintime-qt

# Remove backintime on -nohost
sudo apt-get remove --assume-yes backintime-qt

# Install bleachbit on pc-van-hugo
sudo apt-get install --assume-yes bleachbit

# Remove bleachbit from pc-van-hugo
sudo apt-get remove --assume-yes bleachbit

# Install calibre on pc06 pc-van-hugo
sudo apt-get install --assume-yes calibre

# Remove calibre from pc06 pc-van-hugo
sudo apt-get remove --assume-yes calibre

# Install change-grub-timeout on *
sudo sed --in-place --expression='s/GRUB_TIMEOUT=5/GRUB_TIMEOUT=1/' /etc/default/grub
sudo sed --in-place --expression='s/GRUB_TIMEOUT=10/GRUB_TIMEOUT=1/' /etc/default/grub
if $APT; then sudo update-grub; fi
if $RPM; then sudo grub2-mkconfig -o /boot/grub2/grub.cfg; fi

# Remove change-grub-timeout from *
sudo sed --in-place --expression='s/GRUB_TIMEOUT=1/GRUB_TIMEOUT=5/' /etc/default/grub
if $APT; then sudo update-grub; fi
if $RPM; then sudo grub2-mkconfig -o /boot/grub2/grub.cfg; fi

# Install clamav on pc-van-hugo
sudo apt-get install --assume-yes clamtk-gnome

# Remove clamav from pc-van-hugo
sudo apt-get remove --assume-yes clamtk-gnome

# Install cockpit on pc06
sudo apt-get install --assume-yes cockpit cockpit-pcp
# Web app: https://localhost:9090

# Remove cockpit from pc06
sudo apt-get remove --assume-yes cockpit

# Install cups on *
if $DEBIAN; then sudo apt-get install --assume-yes cups; fi

# Remove cups from *
if $DEBIAN; then sudo apt-get remove --assume-yes cups; fi

# Install cups-backend-canon on pc-van-emily
sudo apt-get install --assume-yes cups-backend-bjnp

# Remove cups-backend-canon from pc-van-emily
sudo apt-get remove --assume-yes cups-backend-bjnp

# Install disabled-aer on pc06
# Disable kernel config parameter PCIEAER (Peripheral Component Interconnect Express Advanced Error Reporting).
# To prevent the log gets flooded with 'AER: Corrected errors received'. Usually needed for HP hardware.
sudo sed --in-place --expression='s/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash pci=noaer"/' /etc/default/grub
sudo update-grub
# Check for kernel config parameter pci=noaer.
grep --quiet --regexp='pci=noaer' /etc/default/grub

# Remove disabled-aer from pc06
# Enable kernel config parameter PCIEAER.
sudo sed --in-place --expression='s/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash pci=noaer"/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash pci=noaer"/' /etc/default/grub
sudo update-grub
# Check for kernel config parameter pci=noaer.
! grep --quiet --regexp='pci=noaer' /etc/default/grub

# Install disabled-fwupd on -nohost
# Disable the Firmware update daemon.
sudo systemctl stop fwupd.service
sudo systemctl disable fwupd.service
sudo systemctl mask fwupd.service

# Remove disabled-fwupd from -nohost
# Enable the Firmware update daemon.
sudo systemctl unmask fwupd.service
sudo systemctl enable fwupd.service
sudo systemctl start fwupd.service

# Install disabled-lidswitch on pc-van-hugo
# Do nothing when the lid is closed.
sudo sed --in-place --expression='/^HandleLidSwitch=/d' /etc/systemd/logind.conf
echo 'HandleLidSwitch=ignore' | sudo tee --append /etc/systemd/logind.conf

# Remove disabled-lidswitch from pc-van-hugo
# Restore the default action when the lid is closed.
sudo sed --in-place --expression='/^HandleLidSwitch=/d' /etc/systemd/logind.conf

# Install dual-monitor on pc06
if [[ -f ~karel/.config/monitors.xml ]]; then sudo cp --preserve --verbose ~karel/.config/monitors.xml ~gdm/.config/monitors.xml; fi
if [[ -f ~gdm/.config/monitors.xml ]]; then sudo chown --verbose gdm:gdm ~gdm/.config/monitors.xml; fi

# Remove dual-monitor from pc06
sudo rm --force --verbose ~gdm/.config/monitors.xml

# Install exiftool on pc06 pc07
sudo apt-get install --assume-yes libimage-exiftool-perl

# Remove exiftool from pc06 pc07
sudo apt-get remove --assume-yes libimage-exiftool-perl

# Install fakeroot on pc06 pc07
sudo apt-get install --assume-yes fakeroot

# Remove fakeroot from pc06 pc07
sudo apt-get remove --assume-yes fakeroot

# Install fdupes on -nohost
sudo apt-get install --assume-yes fdupes
# Usage:
# $ fdupes -r /path/to/folder     # Report recursively from /path/to/folder
# $ fdupes -d /path/to/folder     # Delete, interactively, from /path/to/folder
# $ fdupes -d -N /path/to/folder  # Delete, from /path/to/folder

# Remove fdupes from -nohost
sudo apt-get remove --assume-yes fdupes

# Install force-x11 on -nohost
# Force the use of X11 because Wayland is not (yet) supported by remote desktop app AnyDesk.
# Force means no choice @ user login for X11 or Wayland!
sudo sed --in-place --expression='s/^#WaylandEnable=false/WaylandEnable=false/' /etc/gdm3/custom.conf
# To check, after reboot (!), execute: echo $XDG_SESSION_TYPE (should output 'x11')

# Remove force-x11 from -nohost
# Enable choice @ user login for X11 or Wayland.
sudo sed --in-place --expression='s/^WaylandEnable=false/#WaylandEnable=false/' /etc/gdm3/custom.conf
# To check, after reboot (!), execute: echo $XDG_SESSION_TYPE (should output 'wayland')

# Install gdebi on *
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get install --assume-yes gdebi; fi

# Remove gdebi from *
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get remove --assume-yes gdebi; fi

# Install gettext on pc06 pc07
sudo apt-get install --assume-yes gettext

# Remove gettext from pc06 pc07
sudo apt-get remove --assume-yes gettext

# Install gimp on pc-van-hugo pc06
sudo apt-get install --assume-yes gimp gimp-help-en gimp-help-nl

# Remove gimp from pc-van-hugo pc06
sudo apt-get remove --assume-yes gimp gimp-help-en gimp-help-nl

# Install git on pc06 pc07
sudo apt-get install --assume-yes git

# Remove git from pc06 pc07
sudo apt-get remove --assume-yes git

# Install gnome-gmail on pc01 pc06 pc07
sudo apt-get install --assume-yes gnome-gmail

# Remove gnome-gmail from pc01 pc06 pc07
sudo apt-get remove --assume-yes gnome-gmail

# Install gnome-tweaks on pc01 pc06 pc07
sudo apt-get install --assume-yes gnome-tweaks

# Remove gnome-tweaks from pc01 pc06 pc07
sudo apt-get remove --assume-yes gnome-tweaks

# Install google-chrome on *
if $DESKTOP_ENVIRONMENT && $APT; then wget --output-document=- 'https://dl.google.com/linux/linux_signing_key.pub' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/google-chrome.gpg; fi
if $DESKTOP_ENVIRONMENT && $APT; then echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] https://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list; fi
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get update; fi
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get install --assume-yes google-chrome-stable; fi
# Add the source list again because the installation overwrote the newly added source list.
if $DESKTOP_ENVIRONMENT && $APT; then echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] https://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list; fi
# The apt-key added during installation is no longer needed.
if $DESKTOP_ENVIRONMENT && $APT; then sudo rm --force --verbose /etc/apt/trusted.gpg.d/google-chrome.gpg; fi
# Also install chrome-gnome-shell to make extensions.gnome.org work.
if $DESKTOP_ENVIRONMENT && $APT && $GNOME; then sudo apt-get install --assume-yes chrome-gnome-shell; fi
# Import GPG Key.
if $DESKTOP_ENVIRONMENT && $RPM; then sudo rpm --import https://dl.google.com/linux/linux_signing_key.pub; fi
# Install Google Chrome.
if $DESKTOP_ENVIRONMENT && $RPM; then sudo dnf install --assumeyes https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm; fi

# Remove google-chrome from *
if $DESKTOP_ENVIRONMENT && $APT && $GNOME; then apt-get remove --assume-yes chrome-gnome-shell; fi
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get remove --assume-yes google-chrome-stable chrome-gnome-shell; fi
if $DESKTOP_ENVIRONMENT && $APT; then sudo rm --force --verbose /etc/apt/sources.list.d/google-chrome.list* /usr/share/keyrings/google-chrome.gpg* /etc/apt/trusted.gpg.d/google-chrome.gpg; fi
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get update; fi
if $DESKTOP_ENVIRONMENT && $RPM; then sudo dnf remove --assumeyes https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm; fi
if $DESKTOP_ENVIRONMENT && $RPM; then sudo rpm --erase gpg-pubkey-7fac5991-* gpg-pubkey-d38b4796-*; fi

# Install google-earth on -nohost
wget --output-document=- 'https://dl.google.com/linux/linux_signing_key.pub' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/google-earth.gpg
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-earth.gpg] https://dl.google.com/linux/earth/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-earth-pro.list
sudo apt-get update
sudo apt-get install --assume-yes google-earth-pro-stable
# Add the source list again because the installation overwrote the newly added source list.
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-earth.gpg] https://dl.google.com/linux/earth/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-earth-pro.list

# Remove google-earth from -nohost
sudo apt-get remove --assume-yes google-earth-pro-stable
sudo rm --force --verbose /etc/apt/sources.list.d/google-earth-pro.list* /usr/share/keyrings/google-earth.gpg*
sudo apt-get update

# Install handbrake on pc-van-emily
sudo apt-get install --assume-yes handbrake

# Remove handbrake from pc-van-emily
sudo apt-get remove --assume-yes handbrake

# Install htop on pc06 pc07
sudo apt-get install --assume-yes htop

# Remove htop from pc06 pc07
sudo apt-get remove --assume-yes htop

# Install jq on pc06 pc07
sudo apt-get install --assume-yes jq

# Remove jq from pc06 pc07
sudo apt-get remove --assume-yes jq

# Install krita on pc06
sudo apt-get install --assume-yes krita

# Remove krita from pc06
sudo apt-get remove --assume-yes krita

# Install kvm on pc06 pc07
# Dpkg::Options to prevent interaction while restoring /etc/libvirt configuration files.
sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes --option Dpkg::Options::="--force-confdef" --option Dpkg::Options::="--force-confold" bridge-utils cpu-checker libvirt-clients libvirt-daemon-system qemu-kvm qemu-system virtinst virt-manager
sudo usermod --append --groups libvirt,libvirt-qemu karel
# Prevent "Error starting domain: Requested operation is not valid: network 'default' is not active".
sudo virsh --connect=qemu:///system net-autostart default
# Check network 'default' with: sudo virsh --connect=qemu:///system net-info default (should output 'Autostart: yes')
# Images are in: /var/lib/libvirt/images/

# Remove kvm from pc06 pc07
sudo virsh --connect=qemu:///system net-autostart default --disable
sudo apt-get remove --assume-yes bridge-utils cpu-checker libvirt-clients libvirt-daemon-system qemu-kvm qemu-system virtinst virt-manager
sudo delgroup libvirtd-dnsmasq
sudo deluser karel libvirtd
sudo deluser karel libvirtd-qemu
sudo delgroup libvirtd

# Install lftp on pc06 pc07
sudo apt-get install --assume-yes lftp

# Remove lftp from pc06 pc07
sudo apt-get remove --assume-yes lftp

# Install libreoffice on *
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get install --assume-yes aspell-en aspell-nl libreoffice libreoffice-l10n-nl; fi
if $DESKTOP_ENVIRONMENT && $RPM; then sudo dnf install --assumeyes libreoffice; fi

# Remove libreoffice from *
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get remove --assume-yes aspell-en aspell-nl libreoffice libreoffice-l10n-nl; fi
if $DESKTOP_ENVIRONMENT && $RPM; then sudo dnf remove --assumeyes libreoffice; fi

# Install locate on pc06 pc07
sudo apt-get install --assume-yes locate
sudo updatedb

# Remove locate from pc06 pc07
sudo apt-get remove --assume-yes locate

# Install mypy on pc06 pc07
sudo apt-get install --assume-yes mypy

# Remove mypy from pc06 pc07
sudo apt-get remove --assume-yes mypy

# Install nautilus-admin on pc06 pc07
sudo apt-get install --assume-yes nautilus-admin

# Remove nautilus-admin from pc06 pc07
sudo apt-get remove --assume-yes nautilus-admin

# Install nmap on pc06 pc07
sudo apt-get install --assume-yes nmap

# Remove nmap from pc06 pc07
sudo apt-get remove --assume-yes nmap

# Install python on pc06 pc07
sudo apt-get install --assume-yes pycodestyle python3-pycodestyle python3-autopep8 python3-pip python-is-python3
sudo ln --force --relative --symbolic /usr/bin/pycodestyle /usr/bin/pep8
sudo ln --force --relative --symbolic /usr/bin/pip3 /usr/bin/pip

# Remove python from pc06 pc07
sudo apt-get remove --assume-yes pycodestyle python3-pycodestyle python3-autopep8 python3-pip python-is-python3
sudo rm --force --verbose /usr/bin/pep8 /usr/bin/pip

# Install repair-ntfs on -nohost
sudo apt-get install --assume-yes ntfs-3g
# Usage:
# $ findmnt
# TARGET          SOURCE    FSTYPE OPTIONS
# /media/...      /dev/sdb2 ntfs3  rw,nosuid,nodev,relatime,uid=...
# $ sudo ntfsfix /dev/sdb2

# Remove repair-ntfs from -nohost
sudo apt-get remove --assume-yes ntfs-3g

# Install rpm on pc06 pc07
sudo apt-get install --assume-yes rpm

# Remove jq from pc06 pc07
sudo apt-get remove --assume-yes rpm

# Install shellcheck on pc06 pc07
sudo apt-get install --assume-yes shellcheck

# Remove shellcheck from pc06 pc07
sudo apt-get remove --assume-yes shellcheck

# Install sound-juicer on pc-van-emily
sudo apt-get install --assume-yes sound-juicer

# Remove sound-juicer from pc-van-emily
sudo apt-get remove --assume-yes sound-juicer

# Install spice-vdagent on *
if $APT; then sudo apt-get install --assume-yes spice-vdagent; fi
if $RPM; then sudo dnf install --assumeyes spice-vdagent; fi

# Remove spice-vdagent from *
if $APT; then sudo apt-get remove --assume-yes spice-vdagent; fi
if $RPM; then sudo dnf remove --assumeyes spice-vdagent; fi

# Install ssh on pc01 pc06 pc07
sudo apt-get install --assume-yes ssh
sudo sed --in-place --expression='s/PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
sudo sed --in-place --expression='/^192.168.1./d' /etc/hosts
sudo sed --in-place --expression='2a192.168.1.100 pc01' /etc/hosts
sudo sed --in-place --expression='3a192.168.1.2   pc06' /etc/hosts
sudo sed --in-place --expression='4a192.168.1.219 pc07' /etc/hosts
# Check for remote root access.
grep --quiet --regexp='PermitRootLogin no' /etc/ssh/sshd_config
sudo systemctl restart ssh.service

# Remove ssh from pc01 pc06 pc07
sudo sed --in-place --expression='/^192.168.1./d' /etc/hosts
sudo sed --in-place --expression='s/PermitRootLogin no/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config
sudo apt-get remove --assume-yes ssh

# Install sushi on pc06
sudo apt-get install --assume-yes gnome-sushi
# Usage:
# Select a file, press the space bar, and a preview will appear.

# Remove sushi from pc06
sudo apt-get remove --assume-yes gnome-sushi

# Install tab-completion on *
if $DEBIAN; then sudo apt-get install --assume-yes bash-completion; fi

# Remove tab-completion from *
if $DEBIAN; then sudo apt-get remove --assume-yes bash-completion; fi

# Install teamviewer on *
if $DESKTOP_ENVIRONMENT && $APT; then wget --output-document=- 'https://download.teamviewer.com/download/linux/signature/TeamViewer2017.asc' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/teamviewer.gpg; fi
if $DESKTOP_ENVIRONMENT && $APT; then echo 'deb [signed-by=/usr/share/keyrings/teamviewer.gpg] https://linux.teamviewer.com/deb stable main' | sudo tee /etc/apt/sources.list.d/teamviewer.list; fi
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get update; fi
if $DESKTOP_ENVIRONMENT && $APT; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes teamviewer; fi
# The apt-key added during installation is no longer needed.
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-key del 0C1289C0 DEB49217; fi
# EPEL: Extra Packages for Enterprise Linux
if $DESKTOP_ENVIRONMENT && $RPM; then sudo dnf install --assumeyes epel-release; fi
if $DESKTOP_ENVIRONMENT && $RPM; then sudo dnf install --assumeyes https://download.teamviewer.com/download/linux/teamviewer.x86_64.rpm; fi
# Web app: https://web.teamviewer.com

# Remove teamviewer from *
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get remove --assume-yes teamviewer; fi
if $DESKTOP_ENVIRONMENT && $APT; then sudo rm --force --verbose /etc/apt/sources.list.d/teamviewer.list* /usr/share/keyrings/teamviewer*.gpg*; fi
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-key del 0C1289C0 DEB49217; fi
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get update; fi
if $DESKTOP_ENVIRONMENT && $RPM; then sudo dnf remove --assumeyes https://download.teamviewer.com/download/linux/teamviewer.x86_64.rpm; fi

# Install thunderbird on *
if $DESKTOP_ENVIRONMENT && $DEBIAN; then sudo apt-get install --assume-yes thunderbird-l10n-nl; fi
if $DESKTOP_ENVIRONMENT && $UBUNTU; then sudo apt-get install --assume-yes thunderbird-locale-nl; fi

# Remove thunderbird from *
if $DESKTOP_ENVIRONMENT && $DEBIAN; then sudo apt-get remove --assume-yes thunderbird-l10n-nl; fi
if $DESKTOP_ENVIRONMENT && $UBUNTU; then sudo apt-get remove --assume-yes thunderbird-locale-nl; fi

# Install tree on pc06 pc07
sudo apt-get install --assume-yes tree

# Remove tree from pc06 pc07
sudo apt-get remove --assume-yes tree

# Install ufw on pc01 pc06 pc07
sudo apt-get install --assume-yes gufw
sudo ufw allow ssh
sudo ufw enable

# Remove ufw from pc01 pc06 pc07
sudo ufw disable
sudo apt-get remove --assume-yes gufw

# Install usbutils on pc07
# This package contains the lsusb utility.
sudo apt-get install --assume-yes usbutils

# Remove usbutils from pc07
# This package contains the lsusb utility.
sudo apt-get remove --assume-yes usbutils

# Install user-guest on -nohost
export TEXTDOMAIN=kz
export TEXTDOMAINDIR=/usr/share/locale
source /usr/bin/gettext.sh
sudo useradd --create-home --shell /usr/bin/bash --comment "$(gettext 'Guest user')" "$(gettext 'guest')" || true
sudo passwd --delete "$(gettext 'guest')"

# Remove user-guest from -nohost
export TEXTDOMAIN=kz
export TEXTDOMAINDIR=/usr/share/locale
source /usr/bin/gettext.sh
sudo userdel --remove "$(gettext 'guest')"

# Install user-karel on pc01
sudo useradd --create-home --shell /usr/bin/bash --comment 'Karel Zimmer' karel || true
sudo usermod --append --groups adm,cdrom,sudo,dip,plugdev,lpadmin karel
sudo passwd --delete --expire karel

# Remove user-karel from pc01
sudo userdel --remove karel

# Install user-log-access on pc07
sudo usermod --append --groups adm,systemd-journal karel

# Remove user-log-access from pc07
sudo deluser karel adm
sudo deluser karel systemd-journal

# Install user-toos on Laptop
sudo useradd --create-home --shell /usr/bin/bash --comment 'Toos Barendse' toos || true
sudo usermod --append --groups adm,cdrom,sudo,dip,plugdev,lpadmin toos
sudo passwd --delete --expire toos

# Remove user-toos from Laptop
sudo userdel --remove toos

# Install virtualbox on pc-van-hugo
# If the installation hangs or VBox does not work, check the virtualization settings in the BIOS/UEFI.
echo 'virtualbox-ext-pack virtualbox-ext-pack/license select true' | sudo debconf-set-selections
sudo apt-get install --assume-yes virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso
# VirtualBox Guest user Additions ISO are in: /usr/share/virtualbox/

# Remove virtualbox from pc-van-hugo
sudo apt-get remove --assume-yes virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso

# Install vlc on *
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get install --assume-yes vlc; fi
# EPEL: Extra Packages for Enterprise Linux
if $DESKTOP_ENVIRONMENT && $RPM; then sudo dnf install --assumeyes epel-release rpmfusion-free-release; fi
if $DESKTOP_ENVIRONMENT && $RPM; then sudo dnf install --assumeyes vlc; fi

# Remove vlc from *
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get remove --assume-yes vlc; fi
if $DESKTOP_ENVIRONMENT && $RPM; then sudo dnf remove --assumeyes vlc; fi

# Install vscode on pc01 pc06 pc07
sudo apt-get install --assume-yes apt-transport-https
wget --output-document=- 'https://packages.microsoft.com/keys/microsoft.asc' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list
sudo apt-get update
sudo apt-get install --assume-yes code
sudo update-alternatives --set editor /usr/bin/code

# Remove vscode from pc01 pc06 pc07
sudo update-alternatives --remove editor /usr/bin/code
sudo apt-get remove --assume-yes code
sudo rm --force --verbose /etc/apt/sources.list.d/vscode.list* /usr/share/keyrings/packages.microsoft*
sudo apt-get update

# Install webmin on pc07
wget --output-document=- 'https://www.webmin.com/jcameron-key.asc' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/webmin.gpg
echo 'deb [signed-by=/usr/share/keyrings/webmin.gpg] https://download.webmin.com/download/repository sarge contrib' | sudo tee /etc/apt/sources.list.d/webmin.list
sudo apt-get update
sudo apt-get install --assume-yes webmin
# Web app: https://localhost:10000

# Remove webmin from pc07
sudo apt-get remove --assume-yes webmin
sudo rm --force --verbose /etc/apt/sources.list.d/webmin.list* /usr/share/keyrings/webmin*
sudo apt-get update

# Install wine on -nohost
sudo dpkg --add-architecture i386
sudo apt-get install --assume-yes wine winetricks playonlinux

# Remove wine from -nohost
sudo apt-get remove --assume-yes wine winetricks playonlinux
sudo dpkg --remove-architecture i386

# Install youtube-dl on pc-van-emily pc-van-hugo
sudo apt-get install --assume-yes youtubedl-gui

# Remove youtube-dl from pc-van-emily pc-van-hugo
sudo apt-get remove --assume-yes youtubedl-gui
