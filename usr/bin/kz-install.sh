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
# Only Ubuntu disables the program's crash report ==> ' || true'.
sudo systemctl stop apport.service || true
sudo systemctl disable apport.service || true
sudo sed --in-place --expression='s/enabled=1/enabled=0/' /etc/default/apport || true
sudo rm --force --verbose /var/crash/*

# Remove disabled-apport from *
# Only Ubuntu enables the program's crash report ==> ' || true'.
sudo sed --in-place --expression='s/enabled=0/enabled=1/' /etc/default/apport || true
sudo systemctl enable --now apport.service || true

# Install update-system on *
sudo kz-update

# Remove update-system from *
# There is no command available to remove update system.

# Install ansible on pc06 pc07
if $APT; then sudo apt-get install --assume-yes ansible; fi

# Remove ansible from pc06 pc07
if $APT; then sudo apt-get remove --assume-yes ansible; fi

# Install anydesk on -nohost
# Remote Wayland display server is not supported.
if $APT; then wget --output-document=- 'https://keys.anydesk.com/repos/DEB-GPG-KEY' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/anydesk.gpg; fi
if $APT; then echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/anydesk.gpg] http://deb.anydesk.com/ all main' | sudo tee /etc/apt/sources.list.d/anydesk.list; fi
if $APT; then sudo apt-get update; fi
if $APT; then sudo apt-get install --assume-yes anydesk; fi
# Web app: https://my.anydesk.com/v2

# Remove anydesk from -nohost
if $APT; then sudo apt-get remove --assume-yes anydesk; fi
if $APT; then sudo rm --force --verbose /etc/apt/sources.list.d/anydesk.list* /usr/share/keyrings/anydesk.gpg*; fi
if $APT; then sudo apt-get update; fi

# Install backintime on -nohost
# Back In Time is a simple backup tool for Linux.
# The backup is done by taking snapshots of a specified set of folders.
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get install --assume-yes backintime-qt; fi

# Remove backintime on -nohost
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get remove --assume-yes backintime-qt; fi

# Install bleachbit on pc-van-hugo
if $APT; then sudo apt-get install --assume-yes bleachbit; fi

# Remove bleachbit from pc-van-hugo
if $APT; then sudo apt-get remove --assume-yes bleachbit; fi

# Install calibre on pc06 pc-van-hugo
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get install --assume-yes calibre; fi

# Remove calibre from pc06 pc-van-hugo
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get remove --assume-yes calibre; fi

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
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get install --assume-yes clamtk-gnome; fi

# Remove clamav from pc-van-hugo
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get remove --assume-yes clamtk-gnome; fi

# Install cockpit on pc06
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get install --assume-yes cockpit cockpit-pcp; fi
# Web app: https://localhost:9090

# Remove cockpit from pc06
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get remove --assume-yes cockpit; fi

# Install cups on *
if $APT; then sudo apt-get install --assume-yes cups; fi

# Remove cups from *
if $APT; then sudo apt-get remove --assume-yes cups; fi

# Install cups-backend-canon on pc-van-emily
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get install --assume-yes cups-backend-bjnp; fi

# Remove cups-backend-canon from pc-van-emily
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get remove --assume-yes cups-backend-bjnp; fi

# Install disabled-aer on pc06
# Disable kernel config parameter PCIEAER (Peripheral Component Interconnect Express Advanced Error Reporting).
# To prevent the log gets flooded with 'AER: Corrected errors received'. Usually needed for HP hardware.
sudo sed --in-place --expression='s/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash pci=noaer"/' /etc/default/grub
if $APT; then sudo update-grub; fi
if $RPM; then sudo grub2-mkconfig -o /boot/grub2/grub.cfg; fi
# Check for kernel config parameter pci=noaer.
grep --quiet --regexp='pci=noaer' /etc/default/grub

# Remove disabled-aer from pc06
# Enable kernel config parameter PCIEAER.
sudo sed --in-place --expression='s/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash pci=noaer"/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash pci=noaer"/' /etc/default/grub
if $APT; then sudo update-grub; fi
if $RPM; then sudo grub2-mkconfig -o /boot/grub2/grub.cfg; fi
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
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get install --assume-yes libimage-exiftool-perl; fi

# Remove exiftool from pc06 pc07
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get remove --assume-yes libimage-exiftool-perl; fi

# Install fakeroot on pc06 pc07
if $APT; then sudo apt-get install --assume-yes fakeroot; fi

# Remove fakeroot from pc06 pc07
if $APT; then sudo apt-get remove --assume-yes fakeroot; fi

# Install fdupes on -nohost
if $APT; then sudo apt-get install --assume-yes fdupes; fi
# Usage:
# $ fdupes -r /path/to/folder     # Report recursively from /path/to/folder
# $ fdupes -d /path/to/folder     # Delete, interactively, from /path/to/folder
# $ fdupes -d -N /path/to/folder  # Delete, from /path/to/folder

# Remove fdupes from -nohost
if $APT; then sudo apt-get remove --assume-yes fdupes; fi

# Install force-x11 on -nohost
# Force the use of X11 because Wayland is not (yet) supported by remote desktop app AnyDesk.
# Force means no choice @ user login for X11 or Wayland!
if $DESKTOP_ENVIRONMENT; then sudo sed --in-place --expression='s/^#WaylandEnable=false/WaylandEnable=false/' /etc/gdm3/custom.conf; fi
# To check, after reboot (!), execute: echo $XDG_SESSION_TYPE (should output 'x11')

# Remove force-x11 from -nohost
# Enable choice @ user login for X11 or Wayland.
if  $DESKTOP_ENVIRONMENT; then sudo sed --in-place --expression='s/^WaylandEnable=false/#WaylandEnable=false/' /etc/gdm3/custom.conf; fi
# To check, after reboot (!), execute: echo $XDG_SESSION_TYPE (should output 'wayland')

# Install gdebi on *
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get install --assume-yes gdebi; fi

# Remove gdebi from *
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get remove --assume-yes gdebi; fi

# Install gettext on pc06 pc07
if $APT; then sudo apt-get install --assume-yes gettext; fi

# Remove gettext from pc06 pc07
if $APT; then sudo apt-get remove --assume-yes gettext; fi

# Install gimp on pc-van-hugo pc06
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get install --assume-yes gimp gimp-help-en gimp-help-nl; fi

# Remove gimp from pc-van-hugo pc06
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get remove --assume-yes gimp gimp-help-en gimp-help-nl; fi

# Install git on pc06 pc07
if $APT; then sudo apt-get install --assume-yes git; fi

# Remove git from pc06 pc07
if $APT; then sudo apt-get remove --assume-yes git; fi

# Install gnome-gmail on pc01 pc06 pc07
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get install --assume-yes gnome-gmail; fi

# Remove gnome-gmail from pc01 pc06 pc07
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get remove --assume-yes gnome-gmail; fi

# Install gnome-tweaks on pc01 pc06 pc07
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get install --assume-yes gnome-tweaks; fi

# Remove gnome-tweaks from pc01 pc06 pc07
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get remove --assume-yes gnome-tweaks; fi

# Install google-chrome on *
if $DESKTOP_ENVIRONMENT && $APT; then wget --output-document=- 'https://dl.google.com/linux/linux_signing_key.pub' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/google-chrome.gpg; fi
if $DESKTOP_ENVIRONMENT && $APT; then echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] https://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list; fi
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get update; fi
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get install --assume-yes google-chrome-stable; fi
# Add the source list again because the installation overwrote the newly added source list.
if $DESKTOP_ENVIRONMENT && $APT; then echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] https://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list; fi
# The apt-key added during installation is no longer needed.
if $DESKTOP_ENVIRONMENT && $APT; then sudo rm --force --verbose /etc/apt/trusted.gpg.d/google-chrome.gpg; fi
# Import GPG Key.
if $DESKTOP_ENVIRONMENT && $RPM; then sudo rpm --import https://dl.google.com/linux/linux_signing_key.pub; fi
# Install Google Chrome.
if $DESKTOP_ENVIRONMENT && $RPM; then sudo dnf install --assumeyes https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm; fi

# Remove google-chrome from *
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get remove --assume-yes google-chrome-stable chrome-gnome-shell; fi
if $DESKTOP_ENVIRONMENT && $APT; then sudo rm --force --verbose /etc/apt/sources.list.d/google-chrome.list* /usr/share/keyrings/google-chrome.gpg* /etc/apt/trusted.gpg.d/google-chrome.gpg; fi
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get update; fi
if $DESKTOP_ENVIRONMENT && $RPM; then sudo dnf remove --assumeyes https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm; fi
if $DESKTOP_ENVIRONMENT && $RPM; then sudo rpm --erase gpg-pubkey-7fac5991-* gpg-pubkey-d38b4796-*; fi

# Install google-earth on -nohost
if $DESKTOP_ENVIRONMENT && $APT; then wget --output-document=- 'https://dl.google.com/linux/linux_signing_key.pub' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/google-earth.gpg; fi
if $DESKTOP_ENVIRONMENT && $APT; then echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-earth.gpg] https://dl.google.com/linux/earth/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-earth-pro.list; fi
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get update; fi
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get install --assume-yes google-earth-pro-stable; fi
# Add the source list again because the installation overwrote the newly added source list.
if $DESKTOP_ENVIRONMENT && $APT; then echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-earth.gpg] https://dl.google.com/linux/earth/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-earth-pro.list; fi

# Remove google-earth from -nohost
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get remove --assume-yes google-earth-pro-stable; fi
if $DESKTOP_ENVIRONMENT && $APT; then sudo rm --force --verbose /etc/apt/sources.list.d/google-earth-pro.list* /usr/share/keyrings/google-earth.gpg*; fi
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get update; fi

# Install handbrake on pc-van-emily
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get install --assume-yes handbrake; fi

# Remove handbrake from pc-van-emily
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get remove --assume-yes handbrake; fi

# Install htop on pc06 pc07
if $APT; then sudo apt-get install --assume-yes htop; fi

# Remove htop from pc06 pc07
if $APT; then sudo apt-get remove --assume-yes htop; fi

# Install jq on pc06 pc07
if $APT; then sudo apt-get install --assume-yes jq; fi

# Remove jq from pc06 pc07
if $APT; then sudo apt-get remove --assume-yes jq; fi

# Install krita on pc06
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get install --assume-yes krita; fi

# Remove krita from pc06
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get remove --assume-yes krita; fi

# Install kvm on pc06 pc07
# Dpkg::Options to prevent interaction while restoring /etc/libvirt configuration files.
if $DESKTOP_ENVIRONMENT && $APT; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes --option Dpkg::Options::="--force-confdef" --option Dpkg::Options::="--force-confold" bridge-utils cpu-checker libvirt-clients libvirt-daemon-system qemu-kvm qemu-system virtinst virt-manager; fi
if $DESKTOP_ENVIRONMENT && $APT; then sudo usermod --append --groups libvirt,libvirt-qemu karel; fi
# Prevent "Error starting domain: Requested operation is not valid: network 'default' is not active".
if $DESKTOP_ENVIRONMENT && $APT; then sudo virsh --connect=qemu:///system net-autostart default; fi
# Check network 'default' with: sudo virsh --connect=qemu:///system net-info default (should output 'Autostart: yes')
# Images are in: /var/lib/libvirt/images/

# Remove kvm from pc06 pc07
if $DESKTOP_ENVIRONMENT && $APT; then sudo virsh --connect=qemu:///system net-autostart default --disable; fi
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get remove --assume-yes bridge-utils cpu-checker libvirt-clients libvirt-daemon-system qemu-kvm qemu-system virtinst virt-manager; fi
if $DESKTOP_ENVIRONMENT && $APT; then sudo delgroup libvirtd-dnsmasq; fi
if $DESKTOP_ENVIRONMENT && $APT; then sudo deluser karel libvirtd; fi
if $DESKTOP_ENVIRONMENT && $APT; then sudo deluser karel libvirtd-qemu; fi
if $DESKTOP_ENVIRONMENT && $APT; then sudo delgroup libvirtd; fi

# Install lftp on pc06 pc07
if $APT; then sudo apt-get install --assume-yes lftp; fi

# Remove lftp from pc06 pc07
if $APT; then sudo apt-get remove --assume-yes lftp; fi

# Install libreoffice on *
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get install --assume-yes aspell-en aspell-nl libreoffice libreoffice-l10n-nl; fi
if $DESKTOP_ENVIRONMENT && $RPM; then sudo dnf install --assumeyes libreoffice; fi

# Remove libreoffice from *
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get remove --assume-yes aspell-en aspell-nl libreoffice libreoffice-l10n-nl; fi
if $DESKTOP_ENVIRONMENT && $RPM; then sudo dnf remove --assumeyes libreoffice; fi

# Install locate on pc06 pc07
if $APT; then sudo apt-get install --assume-yes locate; fi
sudo updatedb

# Remove locate from pc06 pc07
if $APT; then sudo apt-get remove --assume-yes locate; fi

# Install mypy on pc06 pc07
if $APT; then sudo apt-get install --assume-yes mypy; fi

# Remove mypy from pc06 pc07
if $APT; then sudo apt-get remove --assume-yes mypy; fi

# Install nautilus-admin on pc06 pc07
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get install --assume-yes nautilus-admin; fi

# Remove nautilus-admin from pc06 pc07
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get remove --assume-yes nautilus-admin; fi

# Install nmap on pc06 pc07
if $APT; then sudo apt-get install --assume-yes nmap; fi

# Remove nmap from pc06 pc07
if $APT; then sudo apt-get remove --assume-yes nmap; fi

# Install python on pc06 pc07
if $APT; then sudo apt-get install --assume-yes pycodestyle python3-pycodestyle python3-autopep8 python3-pip python-is-python3; fi
if $APT; then sudo ln --force --relative --symbolic /usr/bin/pycodestyle /usr/bin/pep8; fi
if $APT; then sudo ln --force --relative --symbolic /usr/bin/pip3 /usr/bin/pip; fi

# Remove python from pc06 pc07
if $APT; then sudo apt-get remove --assume-yes pycodestyle python3-pycodestyle python3-autopep8 python3-pip python-is-python3; fi
if $APT; then sudo rm --force --verbose /usr/bin/pep8 /usr/bin/pip; fi

# Install repair-ntfs on -nohost
if $APT; then sudo apt-get install --assume-yes ntfs-3g; fi
# Usage:
# $ findmnt
# TARGET          SOURCE    FSTYPE OPTIONS
# /media/...      /dev/sdb2 ntfs3  rw,nosuid,nodev,relatime,uid=...
# $ sudo ntfsfix /dev/sdb2

# Remove repair-ntfs from -nohost
if $APT; then sudo apt-get remove --assume-yes ntfs-3g; fi

# Install rpm on pc06 pc07
if $APT; then sudo apt-get install --assume-yes rpm; fi

# Remove jq from pc06 pc07
if $APT; then sudo apt-get remove --assume-yes rpm; fi

# Install shellcheck on pc06 pc07
if $APT; then sudo apt-get install --assume-yes shellcheck; fi

# Remove shellcheck from pc06 pc07
if $APT; then sudo apt-get remove --assume-yes shellcheck; fi

# Install sound-juicer on pc-van-emily
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get install --assume-yes sound-juicer; fi

# Remove sound-juicer from pc-van-emily
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get remove --assume-yes sound-juicer; fi

# Install spice-vdagent on *
if $APT; then sudo apt-get install --assume-yes spice-vdagent; fi
if $RPM; then sudo dnf install --assumeyes spice-vdagent; fi

# Remove spice-vdagent from *
if $APT; then sudo apt-get remove --assume-yes spice-vdagent; fi
if $RPM; then sudo dnf remove --assumeyes spice-vdagent; fi

# Install ssh on pc01 pc06 pc07
if $APT; then sudo apt-get install --assume-yes ssh; fi
if $RPM; then sudo dnf install --assumeyes openssh; fi
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
if $APT; then sudo apt-get remove --assume-yes ssh; fi
if $RPM; then sudo dnf remove --assumeyes openssh; fi

# Install sushi on pc06
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get install --assume-yes gnome-sushi; fi
# Usage:
# Select a file, press the space bar, and a preview will appear.

# Remove sushi from pc06
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get remove --assume-yes gnome-sushi; fi

# Install tab-completion on *
if $APT; then sudo apt-get install --assume-yes bash-completion; fi

# Remove tab-completion from *
if $APT; then sudo apt-get remove --assume-yes bash-completion; fi

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

# Install tree on pc06 pc07
if $APT; then sudo apt-get install --assume-yes tree; fi

# Remove tree from pc06 pc07
if $APT; then sudo apt-get remove --assume-yes tree; fi

# Install ufw on pc01 pc06 pc07
if $APT; then sudo apt-get install --assume-yes gufw; fi
if $RPM; then sudo dnf install --assumeyes gufw; fi
sudo ufw allow ssh
sudo ufw enable

# Remove ufw from pc01 pc06 pc07
sudo ufw disable
if $APT; then sudo apt-get remove --assume-yes gufw; fi
if $RPM; then sudo dnf remove --assumeyes gufw; fi

# Install usbutils on pc07
# This package contains the lsusb utility.
if $APT; then sudo apt-get install --assume-yes usbutils; fi

# Remove usbutils from pc07
# This package contains the lsusb utility.
if $APT; then sudo apt-get remove --assume-yes usbutils; fi

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
if $DESKTOP_ENVIRONMENT && $APT; then echo 'virtualbox-ext-pack virtualbox-ext-pack/license select true' | sudo debconf-set-selections; fi
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get install --assume-yes virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso; fi
# VirtualBox Guest user Additions ISO are in: /usr/share/virtualbox/

# Remove virtualbox from pc-van-hugo
if $APT; then sudo apt-get remove --assume-yes virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso; fi

# Install vlc on *
if $DESKTOP_ENVIRONMENT && $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get install --assume-yes vlc; fi
# EPEL: Extra Packages for Enterprise Linux
if $DESKTOP_ENVIRONMENT && $DESKTOP_ENVIRONMENT && $RPM; then sudo dnf install --assumeyes epel-release rpmfusion-free-release; fi
if $DESKTOP_ENVIRONMENT && $DESKTOP_ENVIRONMENT && $RPM; then sudo dnf install --assumeyes vlc; fi

# Remove vlc from *
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get remove --assume-yes vlc; fi
if $DESKTOP_ENVIRONMENT && $RPM; then sudo dnf remove --assumeyes vlc; fi

# Install vscode on pc01 pc06 pc07
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get install --assume-yes apt-transport-https; fi
if $DESKTOP_ENVIRONMENT && $APT; then wget --output-document=- 'https://packages.microsoft.com/keys/microsoft.asc' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/packages.microsoft.gpg; fi
if $DESKTOP_ENVIRONMENT && $APT; then echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list; fi
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get update; fi
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get install --assume-yes code; fi
if $DESKTOP_ENVIRONMENT && $APT; then sudo update-alternatives --set editor /usr/bin/code; fi

# Remove vscode from pc01 pc06 pc07
if $DESKTOP_ENVIRONMENT && $APT; then sudo update-alternatives --remove editor /usr/bin/code; fi
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get remove --assume-yes code; fi
if $DESKTOP_ENVIRONMENT && $APT; then sudo rm --force --verbose /etc/apt/sources.list.d/vscode.list* /usr/share/keyrings/packages.microsoft*; fi
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get update; fi

# Install webmin on pc07
if $DESKTOP_ENVIRONMENT && $APT; then wget --output-document=- 'https://www.webmin.com/jcameron-key.asc' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/webmin.gpg; fi
if $DESKTOP_ENVIRONMENT && $APT; then echo 'deb [signed-by=/usr/share/keyrings/webmin.gpg] https://download.webmin.com/download/repository sarge contrib' | sudo tee /etc/apt/sources.list.d/webmin.list; fi
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get update; fi
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get install --assume-yes webmin; fi
# Web app: https://localhost:10000

# Remove webmin from pc07
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get remove --assume-yes webmin; fi
if $DESKTOP_ENVIRONMENT && $APT; then sudo rm --force --verbose /etc/apt/sources.list.d/webmin.list* /usr/share/keyrings/webmin*; fi
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get update; fi

# Install wine on -nohost
if $DESKTOP_ENVIRONMENT && $APT; then sudo dpkg --add-architecture i386; fi
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get install --assume-yes wine winetricks playonlinux; fi

# Remove wine from -nohost
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get remove --assume-yes wine winetricks playonlinux; fi
if $DESKTOP_ENVIRONMENT && $APT; then sudo dpkg --remove-architecture i386; fi

# Install youtube-dl on pc-van-emily pc-van-hugo
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get install --assume-yes youtubedl-gui; fi

# Remove youtube-dl from pc-van-emily pc-van-hugo
if $DESKTOP_ENVIRONMENT && $APT; then sudo apt-get remove --assume-yes youtubedl-gui; fi
