# shellcheck shell=bash
###############################################################################
# SPDX-FileComment: Install file for use with kz-install script
#
# SPDX-FileCopyrightText: Karel Zimmer <info@karelzimmer.nl>
# SPDX-License-Identifier: CC0-1.0
###############################################################################
# [note] To manually run a command line, first run: source kz_common.sh
# [info] To learn more about the format of this file, run: man kz install

# First install app disabled-apport, then app update-system.
# The rest of the apps are in alphabetical order of app name.

# Install disabled-apport on *
# Disable Ubuntu's automatic crash report generation.
if $UBUNTU ; then sudo systemctl stop apport.service ; fi
if $UBUNTU ; then sudo systemctl disable apport.service ; fi
if $UBUNTU ; then sudo sed --in-place --expression='s/enabled=1/enabled=0/' /etc/default/apport ; fi
if $UBUNTU ; then sudo rm --force --verbose /var/crash/* ; fi

# Remove disabled-apport from *
# Enable Ubuntu's automatic crash report generation.
if $UBUNTU ; then sudo sed --in-place --expression='s/enabled=0/enabled=1/' /etc/default/apport ; fi
if $UBUNTU ; then sudo systemctl enable --now apport.service ; fi


# Install update-system on *
# Update system.
sudo kz-update

# Remove update-system from *
# Update system.
echo 'The update-system app cannot be removed.'


# Install 7zip on *
# File archiver.
if $APT ; then sudo apt-get install --assume-yes p7zip-full ; fi
if $RPM ; then sudo dnf install --assumeyes p7zip ; fi

# Remove 7zip from *
# File archiver.
if $APT ; then sudo apt-get remove --purge --assume-yes p7zip-full ; fi
if $RPM ; then sudo dnf remove --assumeyes p7zip ; fi


# Install ansible on pc06 pc07
# Configuration management, deployment, and task execution.
if $APT ; then sudo apt-get install --assume-yes ansible ; fi
if $RPM ; then sudo dnf install --assumeyes ansible ; fi

# Remove ansible from pc06 pc07
# Configuration management, deployment, and task execution.
if $APT ; then sudo apt-get remove --purge --assume-yes ansible ; fi
if $RPM ; then sudo dnf remove --assumeyes ansible ; fi


# Install anydesk on pc06 pc07
# Remote desktop.
# Web app: https://my.anydesk.com/v2
# Remote display server Wayland is not supported. Consider installing the force-x11 app.
if $DESKTOP && $APT ; then wget --output-document=- https://keys.anydesk.com/repos/DEB-GPG-KEY | sudo gpg --dearmor --yes --output=/usr/share/keyrings/anydesk.gpg ; fi
if $DESKTOP && $APT ; then echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/anydesk.gpg] http://deb.anydesk.com/ all main' | sudo tee /etc/apt/sources.list.d/anydesk.list ; fi
if $DESKTOP && $APT ; then sudo apt-get update ; fi
if $DESKTOP && $APT ; then sudo apt-get install --assume-yes anydesk ; fi

if $DESKTOP && $RPM ; then echo -e '[anydesk]\nname=AnyDesk RHEL - stable\nbaseurl=http://rpm.anydesk.com/rhel/x86_64/\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://keys.anydesk.com/repos/RPM-GPG-KEY' | sudo tee /etc/yum.repos.d/AnyDesk-RHEL.repo ; fi
if $DESKTOP && $RPM ; then sudo dnf install --assumeyes anydesk ; fi

# Remove anydesk from pc06 pc07
# Remote desktop. Consider removing the force-x11 app.
if $DESKTOP && $APT ; then sudo apt-get remove --purge --assume-yes anydesk ; fi

if $DESKTOP && $RPM ; then sudo dnf remove --assumeyes anydesk ; fi
if $DESKTOP && $RPM ; then sudo rm --force --verbose /etc/yum.repos.d/AnyDesk-RHEL.repo* ; fi


# Install apt on -none
# Package manager.
if $APT ; then sudo apt-get install --assume-yes apt ; fi
if $RPM ; then sudo dnf install --assumeyes apt ; fi

# Remove apt from -none
# Package manager.
if $APT ; then echo 'The apt app cannot be removed from an APT system.' ; fi
if $RPM ; then sudo dnf remove --assumeyes apt ; fi


# Install backintime on -none
# Backups/snapshots.
if $DESKTOP && $APT ; then sudo apt-get install --assume-yes backintime-qt ; fi
if $DESKTOP && $RPM ; then sudo dnf install --assumeyes backintime-qt ; fi

# Remove backintime from -none
# Backups/snapshots.
if $DESKTOP && $APT ; then sudo apt-get remove --purge --assume-yes backintime-qt ; fi
if $DESKTOP && $RPM ; then sudo dnf remove --assumeyes backintime-qt ; fi


# Install bleachbit on pc-van-hugo
# Delete files.
if $DESKTOP && $APT ; then sudo apt-get install --assume-yes bleachbit ; fi
if $DESKTOP && $RPM ; then sudo dnf install --assumeyes bleachbit ; fi

# Remove bleachbit from pc-van-hugo
# Delete files.
if $DESKTOP && $APT ; then sudo apt-get remove --purge --assume-yes bleachbit ; fi
if $DESKTOP && $RPM ; then sudo dnf remove --assumeyes bleachbit ; fi


# Install calibre on pc06 pc-van-hugo
# E-book manager.
if $DESKTOP && $APT ; then sudo apt-get install --assume-yes calibre ; fi
if $DESKTOP && $RPM ; then sudo --validate && wget --output-document=- https://download.calibre-ebook.com/linux-installer.sh | sudo sh ; fi

# Remove calibre from pc06 pc-van-hugo
# E-book manager.
if $DESKTOP && $APT ; then sudo apt-get remove --purge --assume-yes calibre ; fi
if $DESKTOP && $RPM ; then sudo calibre-uninstall ; fi


# Install change-grub-timeout on *
# GRand Unified Bootloader.
sudo sed --in-place --expression='s/GRUB_TIMEOUT=5/GRUB_TIMEOUT=1/' /etc/default/grub
sudo sed --in-place --expression='s/GRUB_TIMEOUT=10/GRUB_TIMEOUT=1/' /etc/default/grub
if $APT ; then sudo update-grub ; fi
if $RPM ; then sudo grub2-mkconfig -o /boot/grub2/grub.cfg ; fi

# Remove change-grub-timeout from *
# GRand Unified Bootloader.
sudo sed --in-place --expression='s/GRUB_TIMEOUT=1/GRUB_TIMEOUT=5/' /etc/default/grub
if $APT ; then sudo update-grub ; fi
if $RPM ; then sudo grub2-mkconfig -o /boot/grub2/grub.cfg ; fi


# Install cockpit on pc06
# Web console.
# Web app: https://localhost:9090
if $DESKTOP && $APT ; then sudo apt-get install --assume-yes cockpit cockpit-pcp ; fi
if $DESKTOP && $RPM ; then sudo dnf install --assumeyes cockpit cockpit-pcp ; fi

# Remove cockpit from pc06
# Web console.
if $DESKTOP && $APT ; then sudo apt-get remove --purge --assume-yes cockpit ; fi
if $DESKTOP && $RPM ; then sudo dnf remove --assumeyes cockpit ; fi


# Install cups on *
# Common UNIX Printing System.
# Web app: http://localhost:631
if $APT ; then sudo apt-get install --assume-yes cups ; fi
if $RPM ; then sudo dnf install --assumeyes cups ; fi

# Remove cups from *
# Common UNIX Printing System.
if $APT ; then sudo apt-get remove --purge --assume-yes cups ; fi
if $RPM ; then sudo dnf remove --assumeyes cups ; fi


# Install cups-backend-bjnp on pc-van-emily
# Printer backend.
if $DESKTOP && $APT ; then sudo apt-get install --assume-yes cups-backend-bjnp ; fi
if $DESKTOP && $RPM ; then echo 'The cups-backend-bjnp app is not available.' ; fi

# Remove cups-backend-bjnp from pc-van-emily
# Printer backend.
if $DESKTOP && $APT ; then sudo apt-get remove --purge --assume-yes cups-backend-bjnp ; fi
if $DESKTOP && $RPM ; then echo 'The cups-backend-bjnp app is not available.' ; fi


# Install dash-to-dock on *
# Desktop dock.
# Reboot required!
if $DESKTOP && $DEBIAN ; then sudo apt-get install --assume-yes gnome-shell-extension-dashtodock gnome-shell-extension-no-overview ; fi
if $DESKTOP && $ROCKY ; then sudo dnf install --assumeyes gnome-shell-extension-dash-to-dock ; fi

# Remove dash-to-dock from *
# Desktop dock.
# Reboot required!
if $DESKTOP && $DEBIAN ; then sudo apt-get remove --purge --assume-yes gnome-shell-extension-dashtodock ; fi
if $DESKTOP && $ROCKY ; then sudo dnf remove --assumeyes gnome-shell-extension-dash-to-dock ; fi


# Install disabled-aer on pc06
# Disable kernel config parameter PCIEAER (Peripheral Component Interconnect Express Advanced Error Reporting).
# To prevent the log gets flooded with 'AER: Corrected errors received'. Usually needed for HP hardware.
sudo sed --in-place --expression='s/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash pci=noaer"/' /etc/default/grub
if $APT ; then sudo update-grub ; fi
if $RPM ; then sudo grub2-mkconfig -o /boot/grub2/grub.cfg ; fi
# Check for kernel config parameter pci=noaer.
grep --quiet --regexp='pci=noaer' /etc/default/grub

# Remove disabled-aer from pc06
# Enable kernel config parameter PCIEAER.
sudo sed --in-place --expression='s/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash pci=noaer"/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash pci=noaer"/' /etc/default/grub
if $APT ; then sudo update-grub ; fi
if $RPM ; then sudo grub2-mkconfig -o /boot/grub2/grub.cfg ; fi
# Check for kernel config parameter pci=noaer.
! grep --quiet --regexp='pci=noaer' /etc/default/grub


# Install disabled-fwupd on -none
# Disable FirmWare UPdate Daemon.
sudo systemctl stop fwupd.service
sudo systemctl disable fwupd.service
sudo systemctl mask fwupd.service

# Remove disabled-fwupd from -none
# Disable FirmWare UPdate Daemon.
sudo systemctl unmask fwupd.service
sudo systemctl enable fwupd.service
sudo systemctl start fwupd.service


# Install disabled-lidswitch on pc-van-hugo
# Do nothing when the laptop lid is closed.
sudo sed --in-place --expression='/^HandleLidSwitch=/d' /etc/systemd/logind.conf
echo 'HandleLidSwitch=ignore' | sudo tee --append /etc/systemd/logind.conf

# Remove disabled-lidswitch from pc-van-hugo
# Restore the default action when the laptop lid is closed.
sudo sed --in-place --expression='/^HandleLidSwitch=/d' /etc/systemd/logind.conf


# Install dual-monitor on pc06
# Preserve dual monitor settings.
if [[ -f ~karel/.config/monitors.xml ]] ; then sudo cp --preserve --verbose ~karel/.config/monitors.xml ~gdm/.config/monitors.xml ; fi
if [[ -f ~gdm/.config/monitors.xml ]] ; then sudo chown --verbose gdm:gdm ~gdm/.config/monitors.xml ; fi

# Remove dual-monitor from pc06
# Remove dual monitor settings.
sudo rm --force --verbose ~gdm/.config/monitors.xml


# Install exiftool on pc06 pc07
# Read and write meta information.
if $DESKTOP && $APT ; then sudo apt-get install --assume-yes libimage-exiftool-perl ; fi
if $DESKTOP && $RPM ; then sudo dnf install --assumeyes perl-Image-ExifTool ; fi

# Remove exiftool from pc06 pc07
# Read and write meta information.
if $DESKTOP && $APT ; then sudo apt-get remove --purge --assume-yes libimage-exiftool-perl ; fi
if $DESKTOP && $RPM ; then sudo dnf remove --assumeyes perl-Image-ExifTool ; fi


# Install fakeroot on pc06 pc07
# Simulate superuser privileges.
if $APT ; then sudo apt-get install --assume-yes fakeroot ; fi
if $RPM ; then sudo dnf install --assumeyes fakeroot ; fi

# Remove fakeroot from pc06 pc07
# Simulate superuser privileges.
if $APT ; then sudo apt-get remove --purge --assume-yes fakeroot ; fi
if $RPM ; then sudo dnf remove --assumeyes fakeroot ; fi


# Install fdupes on -none
# Find duplicate files.
if $APT ; then sudo apt-get install --assume-yes fdupes ; fi
if $RPM ; then sudo dnf install --assumeyes fdupes ; fi
# Usage:
# $ fdupes -r /path/to/folder   # Report recursively from /path/to/folder
# $ fdupes -rd /path/to/folder  # Delete, interactively, from /path/to/folder
# $ fdupes -rdN /path/to/folder # Delete, from /path/to/folder, keep first dup

# Remove fdupes from -none
# Find duplicate files.
if $APT ; then sudo apt-get remove --purge --assume-yes fdupes ; fi
if $RPM ; then sudo dnf remove --assumeyes fdupes ; fi


# Install force-x11 on -none
# Disable choice on user login screen for X11 or Wayland and force X11.
# Force means no choice on user login screen for X11 or Wayland!
# Reboot required!
if $DESKTOP && $APT ; then sudo sed --in-place --expression='s/^#WaylandEnable=false/WaylandEnable=false/' /etc/gdm3/custom.conf ; fi
if $DESKTOP && $RPM ; then sudo sed --in-place --expression='s/^#WaylandEnable=false/WaylandEnable=false/' /etc/gdm/custom.conf ; fi
# To check, after reboot (!), execute: echo $XDG_SESSION_TYPE (should output 'x11')

# Remove force-x11 from -none
# Enable choice on user login screen for X11 or Wayland.
# Reboot required!
if $DESKTOP && $APT ; then sudo sed --in-place --expression='s/^WaylandEnable=false/#WaylandEnable=false/' /etc/gdm3/custom.conf ; fi
if $DESKTOP && $RPM ; then sudo sed --in-place --expression='s/^WaylandEnable=false/#WaylandEnable=false/' /etc/gdm/custom.conf ; fi
# To check, after reboot (!), execute: echo $XDG_SESSION_TYPE (should output 'wayland')


# Install gdebi on *
# View and install deb files.
if $DESKTOP && $APT ; then sudo apt-get install --assume-yes gdebi ; fi
if $DESKTOP && $RPM ; then echo 'The gdebi app is not available.' ; fi

# Remove gdebi from *
# View and install deb files.
if $DESKTOP && $APT ; then sudo apt-get remove --purge --assume-yes gdebi ; fi
if $DESKTOP && $RPM ; then echo 'The gdebi app is not available.' ; fi


# Install gettext on pc06 pc07
# GNU Internationalization.
if $APT ; then sudo apt-get install --assume-yes gettext ; fi
if $RPM ; then sudo dnf install --assumeyes gettext ; fi

# Remove gettext from pc06 pc07
# GNU Internationalization.
if $APT ; then sudo apt-get remove --purge --assume-yes gettext ; fi
if $RPM ; then sudo dnf remove --assumeyes gettext ; fi


# Install gimp on pc-van-hugo pc06
# GNU Image Manipulation Program.
if $DESKTOP && $APT ; then sudo apt-get install --assume-yes gimp gimp-help-en gimp-help-nl ; fi
if $DESKTOP && $RPM ; then sudo dnf install --assumeyes gimp ; fi

# Remove gimp from pc-van-hugo pc06
# GNU Image Manipulation Program.
if $DESKTOP && $APT ; then sudo apt-get remove --purge --assume-yes gimp gimp-help-en gimp-help-nl ; fi
if $DESKTOP && $RPM ; then sudo dnf remove --assumeyes gimp ; fi


# Install git on pc06 pc07
# Distributed revision control system.
# Web app: https://github.com
if $APT ; then sudo apt-get install --assume-yes git ; fi
if $RPM ; then sudo sudo dnf install --assumeyes git ; fi

# Remove git from pc06 pc07
# Distributed revision control system.
if $APT ; then sudo apt-get remove --purge --assume-yes git ; fi
if $RPM ; then sudo sudo dnf remove --assumeyes git ; fi


# Install gnome-gmail on pc01 pc06 pc07
# Gmail for e-mail.
# Web app: https://mail.google.com
if $DESKTOP && $APT ; then sudo apt-get install --assume-yes gnome-gmail ; fi
if $DESKTOP && $RPM ; then echo 'The gnome-gmail app is not available.' ; fi

# Remove gnome-gmail from pc01 pc06 pc07
# Gmail for e-mail.
if $DESKTOP && $APT ; then sudo apt-get remove --purge --assume-yes gnome-gmail ; fi
if $DESKTOP && $RPM ; then echo 'The gnome-gmail app is not available.' ; fi


# Install gnome-tweaks on pc01 pc06 pc07
# Adjust advanced settings.
if $DESKTOP && $APT ; then sudo apt-get install --assume-yes gnome-tweaks ; fi
if $DESKTOP && $RPM ; then sudo dnf install --assumeyes gnome-tweaks ; fi

# Remove gnome-tweaks from pc01 pc06 pc07
# Adjust advanced settings.
if $DESKTOP && $APT ; then sudo apt-get remove --purge --assume-yes gnome-tweaks ; fi
if $DESKTOP && $RPM ; then sudo dnf remove --assumeyes gnome-tweaks ; fi


# Install google-chrome on *
# Web browser.
if $DESKTOP && $APT ; then wget --output-document=/tmp/google-chrome.deb https://dl.google.com/dl/linux/direct/google-chrome-stable_current_amd64.deb ; fi
if $DESKTOP && $APT ; then sudo apt-get install --assume-yes /tmp/google-chrome.deb ; fi
if $DESKTOP && $APT ; then rm --verbose /tmp/google-chrome.deb ; fi

if $DESKTOP && $RPM ; then sudo rpm --import https://dl.google.com/linux/linux_signing_key.pub ; fi
if $DESKTOP && $RPM ; then sudo dnf install --assumeyes https://dl.google.com/dl/linux/direct/google-chrome-stable_current_x86_64.rpm ; fi

# Remove google-chrome from *
# Web browser.
if $DESKTOP && $APT ; then sudo apt-get remove --purge --assume-yes google-chrome-stable ; fi
if $DESKTOP && $RPM ; then sudo dnf remove --assumeyes google-chrome-stable ; fi


# Install google-earth on -none
# Explore the planet.
# Web app: https://earth.google.com
if $DESKTOP && $APT ; then wget --output-document=/tmp/google-earth.deb https://dl.google.com/dl/linux/direct/google-earth-pro-stable_current_amd64.deb ; fi
if $DESKTOP && $APT ; then sudo apt-get install --assume-yes /tmp/google-earth.deb ; fi
if $DESKTOP && $APT ; then rm --verbose /tmp/google-earth.deb ; fi

if $DESKTOP && $RPM ; then sudo rpm --import https://dl.google.com/linux/linux_signing_key.pub ; fi
if $DESKTOP && $RPM ; then sudo dnf install --assumeyes https://dl.google.com/dl/linux/direct/google-earth-pro-stable-current.x86_64.rpm ; fi

# Remove google-earth from -none
# Explore the planet.
if $DESKTOP && $APT ; then sudo apt-get remove --purge --assume-yes google-earth-pro-stable ; fi
if $DESKTOP && $RPM ; then sudo dnf remove --assumeyes google-earth-pro-stable ; fi


# Install handbrake on pc-van-emily
# Video-dvd ripper and transcoder.
if $DESKTOP && $APT ; then sudo apt-get install --assume-yes handbrake ; fi
if $DESKTOP && $RPM ; then echo 'The handbrake app is not available.' ; fi

# Remove handbrake from pc-van-emily
# Video-dvd ripper and transcoder.
if $DESKTOP && $APT ; then sudo apt-get remove --purge --assume-yes handbrake ; fi
if $DESKTOP && $RPM ; then echo 'The handbrake app is not available.' ; fi


# Install htop on pc06 pc07
# Process viewer.
if $APT ; then sudo apt-get install --assume-yes htop ; fi
if $RPM ; then sudo dnf install --assumeyes htop ; fi

# Remove htop from pc06 pc07
# Process viewer.
if $APT ; then sudo apt-get remove --purge --assume-yes htop ; fi
if $RPM ; then sudo dnf remove --assumeyes htop ; fi

# Install imagination on pc06 pc07
# Slideshow maker.
if $DESKTOP && $APT ; then sudo apt-get install --assume-yes imagination ; fi
if $DESKTOP && $RPM ; then echo 'The imagination app is not available.' ; fi

# Remove imagination from pc06 pc07
# Slideshow maker.
if $DESKTOP && $APT ; then sudo apt-get remove --purge --assume-yes imagination ; fi
if $DESKTOP && $RPM ; then echo 'The imagination app is not available.' ; fi


# Install jq on pc06 pc07
# JSON processor.
if $APT ; then sudo apt-get install --assume-yes jq ; fi
if $RPM ; then sudo dnf install --assumeyes jq ; fi

# Remove jq from pc06 pc07
# JSON processor.
if $APT ; then sudo apt-get remove --purge --assume-yes jq ; fi
if $RPM ; then sudo dnf remove --assumeyes jq ; fi


# Install krita on pc06
# Image manipulation.
if $DESKTOP && $APT ; then sudo apt-get install --assume-yes krita ; fi
if $DESKTOP && $RPM ; then echo 'The krita app is not available.' ; fi

# Remove krita from pc06
# Image manipulation.
if $DESKTOP && $APT ; then sudo apt-get remove --purge --assume-yes krita ; fi
if $DESKTOP && $RPM ; then echo 'The krita app is not available.' ; fi


# Install kvm on pc06 pc07
# Kernel-based Virtual Machine.
# Images are in: /var/lib/libvirt/images/
# Reboot required!
# Dpkg::Options to prevent interaction while restoring /etc/libvirt configuration files.
if $DESKTOP && $APT ; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes --option Dpkg::Options::="--force-confdef" --option Dpkg::Options::="--force-confold" bridge-utils cpu-checker libvirt-clients libvirt-daemon-system qemu-kvm qemu-system virtinst virt-manager ; fi
if $DESKTOP && $APT ; then sudo usermod --append --groups libvirt,libvirt-qemu karel ; fi
# Prevent "Error starting domain: Requested operation is not valid: network 'default' is not active".
if $DESKTOP && $APT ; then sudo virsh --connect=qemu:///system net-autostart default ; fi
# Check network 'default' with: sudo virsh --connect=qemu:///system net-info default (should output 'Autostart: yes')

if $DESKTOP && $RPM ; then sudo dnf groupinstall "Virtualization Host" ; fi
if $DESKTOP && $RPM ; then sudo systemctl enable --now libvirtd ; fi
# Prevent "Error starting domain: Requested operation is not valid: network 'default' is not active".
if $DESKTOP && $RPM ; then sudo virsh --connect=qemu:///system net-autostart default ; fi
# Check network 'default' with: sudo virsh --connect=qemu:///system net-info default (should output 'Autostart: yes')

# Remove kvm from pc06 pc07
# Kernel-based Virtual Machine.
# Reboot required!
if $DESKTOP && $APT ; then sudo virsh --connect=qemu:///system net-autostart default --disable ; fi
if $DESKTOP && $APT ; then sudo apt-get remove --purge --assume-yes bridge-utils cpu-checker libvirt-clients libvirt-daemon-system qemu-kvm qemu-system virtinst virt-manager ; fi
if $DESKTOP && $APT ; then sudo delgroup libvirtd-dnsmasq ; fi
if $DESKTOP && $APT ; then sudo deluser karel libvirtd ; fi
if $DESKTOP && $APT ; then sudo deluser karel libvirtd-qemu ; fi
if $DESKTOP && $APT ; then sudo delgroup libvirtd ; fi

if $DESKTOP && $RPM ; then sudo systemctl disable --now libvirtd ; fi
if $DESKTOP && $RPM ; then sudo dnf groupremove "Virtualization Host" ; fi


# Install lftp on pc06 pc07
# FTP/HTTP/BitTorrent client.
if $APT ; then sudo apt-get install --assume-yes lftp ; fi
if $RPM ; then sudo dnf install --assumeyes lftp ; fi

# Remove lftp from pc06 pc07
# FTP/HTTP/BitTorrent client.
if $APT ; then sudo apt-get remove --purge --assume-yes lftp ; fi
if $RPM ; then sudo dnf remove --assumeyes lftp ; fi


# Install libreoffice on *
# Office suite.
if $DESKTOP && $APT ; then sudo apt-get install --assume-yes aspell-en aspell-nl libreoffice libreoffice-l10n-nl ; fi
if $DESKTOP && $RPM ; then sudo dnf install --assumeyes libreoffice ; fi

# Remove libreoffice from *
# Office suite.
if $DESKTOP && $APT ; then sudo apt-get remove --purge --assume-yes aspell-en aspell-nl libreoffice libreoffice-l10n-nl ; fi
if $DESKTOP && $RPM ; then sudo dnf remove --assumeyes libreoffice ; fi


# Install locate on pc06 pc07
# Find files.
if $APT ; then sudo apt-get install --assume-yes locate ; fi
if $RPM ; then sudo dnf install --assumeyes mlocate ; fi

sudo updatedb

# Remove locate from pc06 pc07
# Find files.
if $APT ; then sudo apt-get remove --purge --assume-yes locate ; fi
if $RPM ; then sudo dnf remove --assumeyes mlocate ; fi


# Install log-access-for-user on pc07
# Log access.
if [[ $HOSTNAME = 'pc07' ]] ; then sudo usermod --append --groups adm,systemd-journal karel ; fi

# Remove log-access-for-user from pc07
# Log access.
if [[ $HOSTNAME = 'pc07' ]] ; then sudo deluser karel adm ; fi
if [[ $HOSTNAME = 'pc07' ]] ; then sudo deluser karel systemd-journal ; fi


# Install mypy on pc06 pc07
# Python static typing.
if $APT ; then sudo apt-get install --assume-yes mypy ; fi
if $RPM ; then sudo dnf install --assumeyes python3-mypy ; fi

# Remove mypy from pc06 pc07
# Python static typing.
if $APT ; then sudo apt-get remove --purge --assume-yes mypy ; fi
if $RPM ; then sudo dnf remove --assumeyes python3-mypy ; fi


# Install nautilus-admin on pc06 pc07
# Administrative operations.
if $DESKTOP && $APT ; then sudo apt-get install --assume-yes nautilus-admin ; fi
if $DESKTOP && $RPM ; then echo 'The nautilus-admin app is not available.' ; fi

# Remove nautilus-admin from pc06 pc07
# Administrative operations.
if $DESKTOP && $APT ; then sudo apt-get remove --purge --assume-yes nautilus-admin ; fi
if $DESKTOP && $RPM ; then echo 'The nautilus-admin app is not available.' ; fi


# Install nmap on pc06 pc07
# Network MAPper.
if $APT ; then sudo apt-get install --assume-yes nmap ; fi
if $RPM ; then sudo dnf install --assumeyes nmap ; fi

# Remove nmap from pc06 pc07
# Network MAPper.
if $APT ; then sudo apt-get remove --purge --assume-yes nmap ; fi
if $RPM ; then sudo dnf remove --assumeyes nmap ; fi


# Install ntfs on -none
# NTFS support.
if $APT ; then sudo apt-get install --assume-yes ntfs-3g ; fi
if $RPM ; then sudo dnf install --assumeyes ntfs-3g ntfsprogs ; fi
# Usage:
# $ findmnt (or lsblk)
# TARGET          SOURCE    FSTYPE OPTIONS
# /media/...      /dev/sdba ntfs3  rw,nosuid,nodev,relatime,uid=...
# $ lsblk
# NAME                        MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINTS
# sda                           8:0    0 931,5G  0 disk
# └─sda1                        8:1    0 931,5G  0 part  /media/...
# $ sudo ntfsfix /dev/sdba1     # Fix an NTFS partition
# $ sudo -b ntfsfix /dev/sdba1  # Clear the bad sector list
# $ sudo -d ntfsfix /dev/sdba1  # Clear the volume dirty flag

# Remove ntfs from -none
# NTFS support.
if $APT ; then sudo apt-get remove --purge --assume-yes ntfs-3g ; fi
if $RPM ; then sudo dnf remove --assumeyes ntfs-3g ntfsprogs ; fi


# Install python on pc06 pc07
# Programming language.
if $APT ; then sudo apt-get install --assume-yes pycodestyle python3-pycodestyle python3-autopep8 python3-pip python-is-python3 ; fi
if $APT ; then sudo ln --force --relative --symbolic /usr/bin/pycodestyle /usr/bin/pep8 ; fi
if $APT ; then sudo ln --force --relative --symbolic /usr/bin/pip3 /usr/bin/pip ; fi

if $RPM ; then sudo dnf install --assumeyes python3 python3-pycodestyle python3-pip ; fi

# Remove python from pc06 pc07
# Programming language.
if $APT ; then sudo apt-get remove --purge --assume-yes pycodestyle python3-pycodestyle python3-autopep8 python3-pip python-is-python3 ; fi
if $APT ; then sudo rm --force --verbose /usr/bin/pep8 /usr/bin/pip ; fi

if $RPM ; then sudo dnf remove --assumeyes python3 python3-pycodestyle python3-pip ; fi


# Install rpm on pc06 pc07
# Package manager.
if $APT ; then sudo apt-get install --assume-yes rpm ; fi
if $RPM ; then sudo dnf install --assumeyes rpm ; fi

# Remove rpm from pc06 pc07
# Package manager for RPM.
if $APT ; then sudo apt-get remove --purge --assume-yes rpm ; fi
if $RPM ; then echo 'The rpm app cannot be removed.' ; fi


# Install shellcheck on pc06 pc07
# Shell script linter.
# Web app: https://www.shellcheck.net
if $APT ; then sudo apt-get install --assume-yes shellcheck ; fi
if $RPM ; then sudo dnf install --assumeyes shellcheck ; fi

# Remove shellcheck from pc06 pc07
# Shell script linter.
if $APT ; then sudo apt-get remove --purge --assume-yes shellcheck ; fi
if $RPM ; then sudo dnf remove --assumeyes shellcheck ; fi


# Install sound-juicer on pc-van-emily
# Audio-cd ripper and player.
if $DESKTOP && $APT ; then sudo apt-get install --assume-yes sound-juicer ; fi
if $DESKTOP && $RPM ; then echo 'The sound-juicer app is not available.' ; fi

# Remove sound-juicer from pc-van-emily
# Audio-cd ripper and player.
if $DESKTOP && $APT ; then sudo apt-get remove --purge --assume-yes sound-juicer ; fi
if $DESKTOP && $RPM ; then echo 'The sound-juicer app is not available.' ; fi


# Install spice-vdagent on *
# Spice agent.
if $APT ; then sudo apt-get install --assume-yes spice-vdagent ; fi
if $RPM ; then sudo dnf install --assumeyes spice-vdagent ; fi

# Remove spice-vdagent from *
# Spice agent.
if $APT ; then sudo apt-get remove --purge --assume-yes spice-vdagent ; fi
if $RPM ; then sudo dnf remove --assumeyes spice-vdagent ; fi


# Install spotify on pc01 pc02 pc06 pc07
# Music and podcasts.
# Web app: https://open.spotify.com
if $DESKTOP && $APT ; then wget --output-document=- https://download.spotify.com/debian/pubkey_C85668DF69375001.gpg | sudo gpg --dearmor --yes --output=/usr/share/keyrings/spotify.gpg ; fi
if $DESKTOP && $APT ; then echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/spotify.gpg] http://repository.spotify.com stable non-free' | sudo tee /etc/apt/sources.list.d/spotify.list ; fi
if $DESKTOP && $APT ; then sudo apt-get update ; fi
if $DESKTOP && $APT ; then sudo apt-get install --assume-yes spotify-client ; fi

if $DESKTOP && $RPM ; then echo 'The spotify app is available as a web app.' ; fi

# Remove spotify from pc01 pc02 pc06 pc07
# Music and podcasts.
if $DESKTOP && $APT ; then sudo apt-get remove --purge --assume-yes spotify-client ; fi
if $DESKTOP && $RPM ; then echo 'The spotify web app cannot be removed.' ; fi


# Install ssh on pc01 pc06 pc07
# Secure SHell.
if $APT ; then sudo apt-get install --assume-yes ssh ; fi
if $RPM ; then sudo dnf install --assumeyes openssh ; fi
sudo sed --in-place --expression='s/PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
if [[ 'pc01 pc06 pc07' =~ $HOSTNAME ]] ; then sudo sed --in-place --expression='/^192.168.1./d' /etc/hosts ; fi
if [[ 'pc01 pc06 pc07' =~ $HOSTNAME ]] ; then sudo sed --in-place --expression='2a192.168.1.100 pc01' /etc/hosts ; fi
if [[ 'pc01 pc06 pc07' =~ $HOSTNAME ]] ; then sudo sed --in-place --expression='3a192.168.1.2   pc06' /etc/hosts ; fi
if [[ 'pc01 pc06 pc07' =~ $HOSTNAME ]] ; then sudo sed --in-place --expression='4a192.168.1.219 pc07' /etc/hosts ; fi
# Check for remote root access.
grep --quiet --regexp='PermitRootLogin no' /etc/ssh/sshd_config
sudo systemctl restart ssh.service

# Remove ssh from pc01 pc06 pc07
# Secure SHell.
if [[ 'pc01 pc06 pc07' =~ $HOSTNAME ]] ; then sudo sed --in-place --expression='/^192.168.1./d' /etc/hosts ; fi
sudo sed --in-place --expression='s/PermitRootLogin no/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config
if $APT ; then sudo apt-get remove --purge --assume-yes ssh ; fi
if $RPM ; then sudo dnf remove --assumeyes openssh ; fi


# Install sushi on pc06
# Quick preview.
if $DESKTOP && $APT ; then sudo apt-get install --assume-yes gnome-sushi ; fi
if $DESKTOP && $RPM ; then sudo dnf install --assumeyes sushi ; fi
# Usage:
# Select a file, press the space bar, and a preview will appear.

# Remove sushi from pc06
# Quick preview.
if $DESKTOP && $APT ; then sudo apt-get remove --purge --assume-yes gnome-sushi ; fi
if $DESKTOP && $RPM ; then sudo dnf remove --assumeyes sushi ; fi


# Install tab-completion on *
# Bash completion.
if $APT ; then sudo apt-get install --assume-yes bash-completion ; fi
if $RPM ; then sudo dnf install --assumeyes bash-completion ; fi

# Remove tab-completion from *
# Bash completion.
if $APT ; then sudo apt-get remove --purge --assume-yes bash-completion ; fi
if $RPM ; then sudo dnf remove --assumeyes bash-completion ; fi


# Install teamviewer on *
# Remote desktop.
# Web app: https://web.teamviewer.com
if $DESKTOP && $APT ; then wget --output-document=/tmp/teamviewer.deb https://download.teamviewer.com/download/linux/teamviewer_amd64.deb ; fi
if $DESKTOP && $APT ; then sudo apt-get install --assume-yes /tmp/teamviewer.deb ; fi
if $DESKTOP && $APT ; then rm --verbose /tmp/teamviewer.deb ; fi

# Extra Packages for Enterprise Linux
if $DESKTOP && $RPM ; then sudo dnf install --assumeyes epel-release ; fi
if $DESKTOP && $RPM ; then sudo dnf install --assumeyes https://download.teamviewer.com/download/linux/teamviewer.x86_64.rpm ; fi

# Remove teamviewer from *
# Remote desktop.
if $DESKTOP && $APT ; then sudo apt-get remove --purge --assume-yes teamviewer ; fi
if $DESKTOP && $RPM ; then sudo dnf remove --assumeyes teamviewer ; fi


# Install thunderbird on *
# E-mail and news.
if $DESKTOP && $DEBIAN ; then sudo apt-get install --assume-yes thunderbird thunderbird-l10n-nl ; fi
if $DESKTOP && $UBUNTU ; then sudo apt-get install --assume-yes thunderbird thunderbird-locale-nl ; fi
if $DESKTOP && $ROCKY ; then sudo dnf install --assumeyes thunderbird ; fi

# Remove thunderbird from *
# E-mail and news.
if $DESKTOP && $DEBIAN ; then sudo apt-get remove --purge --assume-yes thunderbird-l10n-nl ; fi
if $DESKTOP && $UBUNTU ; then sudo apt-get remove --purge --assume-yes thunderbird-locale-nl ; fi
if $DESKTOP && $ROCKY ; then sudo dnf remove --assumeyes thunderbird ; fi


# Install tree on pc06 pc07
# Display directory tree.
if $APT ; then sudo apt-get install --assume-yes tree ; fi
if $RPM ; then sudo dnf install --assumeyes tree ; fi

# Remove tree from pc06 pc07
# Display directory tree.
if $APT ; then sudo apt-get remove --purge --assume-yes tree ; fi
if $RPM ; then sudo dnf remove --assumeyes tree ; fi

# Install ufw on pc01 pc06 pc07
# Uncomplicated FireWall.
if $DESKTOP && $APT ; then sudo apt-get install --assume-yes gufw ; fi
if $DESKTOP && $RPM ; then sudo dnf install --assumeyes gufw ; fi
if $DESKTOP ; then sudo ufw allow ssh ; fi
if $DESKTOP ; then sudo ufw enable ; fi

# Remove ufw from pc01 pc06 pc07
# Uncomplicated FireWall.
sudo ufw disable
if $APT ; then sudo apt-get remove --purge --assume-yes gufw ; fi
if $RPM ; then sudo dnf remove --assumeyes gufw ; fi


# Install usbutils on pc07
# USB utilities.
# This package contains the lsusb utility.
if $APT ; then sudo apt-get install --assume-yes usbutils ; fi
if $RPM ; then sudo dnf install --assumeyes usbutils ; fi

# Remove usbutils from pc07
# USB utilities.
# This package contains the lsusb utility.
if $APT ; then sudo apt-get remove --purge --assume-yes usbutils ; fi
if $RPM ; then sudo dnf remove --assumeyes usbutils ; fi


# Install user-guest on -none
# Add guest user.
sudo useradd --create-home --shell /usr/bin/bash --comment "$(gettext 'Guest user')" "$(gettext 'guest')" || true
sudo passwd --delete "$(gettext 'guest')"

# Remove user-guest from -none
# Remove guest user.
sudo userdel --remove "$(gettext 'guest')"


# Install user-karel on pc01
# Add user Karel.
if [[ $HOSTNAME = 'pc01' ]] ; then sudo useradd --create-home --shell /usr/bin/bash --comment 'Karel Zimmer' karel || true ; fi
if [[ $HOSTNAME = 'pc01' ]] ; then sudo usermod --append --groups adm,cdrom,sudo,dip,plugdev,lpadmin karel ; fi
if [[ $HOSTNAME = 'pc01' ]] ; then sudo passwd --delete --expire karel ; fi

# Remove user-karel from pc01
# Remove user Karel.
if [[ $HOSTNAME = 'pc01' ]] ; then sudo userdel --remove karel ; fi


# Install user-toos on Laptop
# Add user Toos.
if [[ $HOSTNAME = 'Laptop' ]] ; then sudo useradd --create-home --shell /usr/bin/bash --comment 'Toos Barendse' toos || true ; fi
if [[ $HOSTNAME = 'Laptop' ]] ; then sudo usermod --append --groups adm,cdrom,sudo,dip,plugdev,lpadmin toos ; fi
if [[ $HOSTNAME = 'Laptop' ]] ; then sudo passwd --delete --expire toos ; fi

# Remove user-toos from Laptop
# Remove user Toos.
if [[ $HOSTNAME = 'Laptop' ]] ; then sudo userdel --remove toos ; fi


# Install virtualbox on pc-van-hugo
# Virtualization.
# VirtualBox Guest user Additions ISO are in: /usr/share/virtualbox/
# If the installation hangs or VBox does not work, check the virtualization settings in the BIOS/UEFI.
if $DESKTOP && $APT ; then echo 'virtualbox-ext-pack virtualbox-ext-pack/license select true' | sudo debconf-set-selections ; fi
if $DESKTOP && $APT ; then sudo apt-get install --assume-yes virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso ; fi

if $DESKTOP && $RPM ; then sudo dnf install --assumeyes VirtualBox ; fi

# Remove virtualbox from pc-van-hugo
# Virtualization.
if $DESKTOP && $APT ; then sudo apt-get remove --purge --assume-yes virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso ; fi
if $DESKTOP && $RPM ; then sudo dnf remove --assumeyes VirtualBox ; fi


# Install vlc on *
# Multimedia player.
if $DESKTOP && $DESKTOP && $APT ; then sudo apt-get install --assume-yes vlc ; fi

# Extra Packages for Enterprise Linux
if $DESKTOP && $DESKTOP && $RPM ; then sudo dnf install --assumeyes epel-release rpmfusion-free-release ; fi
if $DESKTOP && $DESKTOP && $RPM ; then sudo dnf install --assumeyes vlc ; fi

# Remove vlc from *
# Multimedia player.
if $DESKTOP && $APT ; then sudo apt-get remove --purge --assume-yes vlc ; fi
if $DESKTOP && $RPM ; then sudo dnf remove --assumeyes vlc ; fi


# Install vscode on pc01 pc06 pc07
# Editor.
if $DESKTOP && $APT ; then sudo apt-get install --assume-yes apt-transport-https ; fi
if $DESKTOP && $APT ; then wget --output-document=- 'https://packages.microsoft.com/keys/microsoft.asc' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/packages.microsoft.gpg ; fi
if $DESKTOP && $APT ; then echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list ; fi
if $DESKTOP && $APT ; then sudo apt-get update ; fi
if $DESKTOP && $APT ; then sudo apt-get install --assume-yes code ; fi
if $DESKTOP && $APT ; then sudo update-alternatives --set editor /usr/bin/code ; fi

if $DESKTOP && $RPM ; then sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc ; fi
if $DESKTOP && $RPM ; then echo -e '[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc' | sudo tee /etc/yum.repos.d/vscode.repo ; fi
if $DESKTOP && $RPM ; then sudo dnf install --assumeyes code ; fi

# Remove vscode from pc01 pc06 pc07
# Editor.
# Web app: https://vscode.dev
if $DESKTOP && $APT ; then sudo update-alternatives --remove editor /usr/bin/code ; fi
if $DESKTOP && $APT ; then sudo apt-get remove --purge --assume-yes code ; fi

if $DESKTOP && $RPM ; then sudo dnf remove --assumeyes code ; fi
if $DESKTOP && $RPM ; then sudo rm --force --verbose /etc/yum.repos.d/vscode.repo* ; fi


# Install webmin on pc07
# Web console.
# Web app: https://localhost:10000
if $DESKTOP && $APT ; then wget --output-document=- 'https://www.webmin.com/jcameron-key.asc' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/webmin.gpg ; fi
if $DESKTOP && $APT ; then echo 'deb [signed-by=/usr/share/keyrings/webmin.gpg] https://download.webmin.com/download/repository sarge contrib' | sudo tee /etc/apt/sources.list.d/webmin.list ; fi
if $DESKTOP && $APT ; then sudo apt-get update ; fi
if $DESKTOP && $APT ; then sudo apt-get install --assume-yes webmin ; fi

if $DESKTOP && $RPM ; then wget --output-document=/tmp/setup-repos.sh https://raw.githubusercontent.com/webmin/webmin/master/setup-repos.sh ; fi
if $DESKTOP && $RPM ; then yes | sudo bash /tmp/setup-repos.sh ; fi
if $DESKTOP && $RPM ; then sudo rm --force --verbose /tmp/setup-repos.sh ; fi
if $DESKTOP && $RPM ; then sudo dnf install --assumeyes webmin ; fi

# Remove webmin from pc07
# Web console.
if $DESKTOP && $APT ; then sudo apt-get remove --purge --assume-yes webmin ; fi

if $DESKTOP && $RPM ; then sudo dnf remove --assumeyes webmin ; fi
if $DESKTOP && $RPM ; then sudo rm --force --verbose /etc/yum.repos.d/webmin.repo* ; fi


# Install wine on -none
# Run Windows applications.
if $DESKTOP && $APT ; then sudo dpkg --add-architecture i386 ; fi
if $DESKTOP && $APT ; then sudo apt-get install --assume-yes wine winetricks playonlinux ; fi

if $DESKTOP && $RPM ; then sudo dnf install --assumeyes wine playonlinux ; fi

# Remove wine from -none
# Run Windows applications.
if $DESKTOP && $APT ; then sudo apt-get remove --purge --assume-yes wine winetricks playonlinux ; fi
if $DESKTOP && $APT ; then sudo dpkg --remove-architecture i386 ; fi

if $DESKTOP && $RPM ; then sudo dnf remove --assumeyes wine playonlinux ; fi


# Install youtube-dl on pc-van-emily pc-van-hugo
# Download videos.
if $DESKTOP && $APT ; then sudo apt-get install --assume-yes youtubedl-gui ; fi
if $DESKTOP && $RPM ; then sudo dnf install --assumeyes youtube-dl ; fi

# Remove youtube-dl from pc-van-emily pc-van-hugo
# Download videos.
if $DESKTOP && $APT ; then sudo apt-get remove --purge --assume-yes youtubedl-gui ; fi
if $DESKTOP && $RPM ; then sudo dnf remove --assumeyes youtube-dl ; fi
