# shellcheck shell=bash
###############################################################################
# SPDX-FileComment: Install file for use with kz-install script
#
# SPDX-FileCopyrightText: Karel Zimmer <info@karelzimmer.nl>
# SPDX-License-Identifier: CC0-1.0
###############################################################################
# Use "man kz install.sh" to learn more about the format of this file.

# Install app 1-disabled-apport on host *
# Disable Ubuntu's automatic crash report generation.
if systemctl cat apport &> /dev/null; then sudo systemctl stop apport.service; fi
if systemctl cat apport &> /dev/null; then sudo systemctl disable apport.service; fi
if systemctl cat apport &> /dev/null; then sudo sed --in-place 's/enabled=1/enabled=0/' /etc/default/apport; fi
if systemctl cat apport &> /dev/null; then sudo rm --force --verbose /var/crash/*; fi


# Install app 2-update-system on host *
# Update and cleanup system.
# This may take a while...
if grep --quiet debian /etc/os-release; then sudo apt-get update; fi
if grep --quiet debian /etc/os-release; then sudo apt-get upgrade --assume-yes; fi
if grep --quiet debian /etc/os-release && type snap &> /dev/null; then sudo snap refresh; fi

if grep --quiet rhel   /etc/os-release; then sudo dnf upgrade --assumeyes --refresh; fi
if grep --quiet rhel   /etc/os-release && type snap &> /dev/null; then sudo snap refresh; fi

# Install app 7zip on host *
# File archiver.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes p7zip-full; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes p7zip; fi

# Install app ansible on host pc06 pc07
# Configuration management, deployment, and task execution.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes ansible; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes ansible; fi

# Install app anydesk on host pc06 pc07
# Remote desktop.
# Only outgoing sessions are supported if using Wayland.
# Incoming sessions are only possible when using Xorg/X11.
# Web app: https://my.anydesk.com/v2
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then wget --output-document=- https://keys.anydesk.com/repos/DEB-GPG-KEY | sudo gpg --dearmor --yes --output=/usr/share/keyrings/anydesk.gpg; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/anydesk.gpg] http://deb.anydesk.com/ all main' | sudo tee /etc/apt/sources.list.d/anydesk.list > /dev/null; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get update; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes anydesk; fi

if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then echo -e '[anydesk]\nname=AnyDesk RHEL - stable\nbaseurl=http://rpm.anydesk.com/rhel/x86_64/\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://keys.anydesk.com/repos/RPM-GPG-KEY' | sudo tee /etc/yum.repos.d/AnyDesk-RHEL.repo > /dev/null; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf install --assumeyes anydesk; fi

# Install app apt on host #none
# Package manager.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes apt; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes apt; fi

# Install app backintime on host #none
# Backups/snapshots.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes backintime-qt; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf install --assumeyes backintime-qt; fi

# Install app bleachbit on host #none
# Delete files.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes bleachbit; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf install --assumeyes bleachbit; fi

# Install app calibre on host pc06
# E-book manager.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes calibre; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo --validate && wget --output-document=- https://download.calibre-ebook.com/linux-installer.sh | sudo sh; fi

# Install app cockpit on host pc06
# Web console.
# Web app: https://localhost:9090
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes cockpit cockpit-pcp; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf install --assumeyes cockpit cockpit-pcp; fi

# Install app cups on host *
# Common UNIX Printing System.
# Web app: http://localhost:631
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes cups; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes cups; fi

# Install app cups-backend-bjnp on host #none
# Printer backend.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes cups-backend-bjnp; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then echo 'The cups-backend-bjnp app is not available.'; fi

# Install app dash-to-dock on host pc07
# Desktop dock.
# Reboot required!
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]] && ! apt-cache show gnome-shell-extension-ubuntu-dock; then sudo apt-get install --assume-yes gnome-shell-extension-dashtodock; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]] && apt-cache show gnome-shell-extension-no-overview; then sudo apt-get install --assume-yes gnome-shell-extension-no-overview; fi

if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf install --assumeyes gnome-shell-extension-dash-to-dock gnome-shell-extension-no-overview; fi

# Install app desktop-backgrounds on host *
# Desktop backgrounds.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes '*-backgrounds'; fi
if grep --quiet ubuntu /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes ubuntu-wallpapers-* '*-backgrounds'; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf install --assumeyes desktop-backgrounds-* gnome-backgrounds*; fi

# Install app disabled-aer on host pc06
# Disable kernel config parameter PCIEAER (Peripheral Component Interconnect
# Express Advanced Error Reporting) to prevent the log gets flooded with
# 'AER: Corrected errors received'. Usually needed for HP hardware.
sudo sed --in-place 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash pci=noaer"/' /etc/default/grub
if grep --quiet debian /etc/os-release; then sudo update-grub; fi
if grep --quiet rhel   /etc/os-release; then sudo grub2-mkconfig -o /boot/grub2/grub.cfg; fi
# Check for kernel config parameter pci=noaer.
grep 'pci=noaer' /etc/default/grub

# Install app disabled-fwupd on host #none
# Disable FirmWare UPdate Daemon.
sudo systemctl stop fwupd.service
sudo systemctl disable fwupd.service
sudo systemctl mask fwupd.service

# Install app disabled-lidswitch on host #none
# Do nothing when the laptop lid is closed.
sudo sed --in-place '/^HandleLidSwitch=/d' /etc/systemd/logind.conf
echo 'HandleLidSwitch=ignore' | sudo tee --append /etc/systemd/logind.conf > /dev/null

# Install app dual-monitor on host pc06
# Preserve dual monitor settings.
if [[ -f $HOME/.config/monitors.xml ]]; then sudo cp --preserve --verbose "$HOME"/.config/monitors.xml ~gdm/.config/monitors.xml; fi
if [[ -f  ~gdm/.config/monitors.xml ]]; then sudo chown --verbose gdm:gdm ~gdm/.config/monitors.xml; fi

# Install app exiftool on host pc06 pc07
# Read and write meta information.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes libimage-exiftool-perl; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf install --assumeyes perl-Image-ExifTool; fi

# Install app fakeroot on host pc06 pc07
# Simulate superuser privileges.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes fakeroot; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes fakeroot; fi

# Install app fdupes on host #none
# Find duplicate files.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes fdupes; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes fdupes; fi
# Usage:
# $ fdupes -r /path/to/folder   # Report recursively from /path/to/folder
# $ fdupes -rd /path/to/folder  # Delete, interactively, from /path/to/folder
# $ fdupes -rdN /path/to/folder # Delete, from /path/to/folder, keep first dup

# Install app force-x11 on host #none
# Disable choice on user login screen for Xorg/X11 or Wayland, and force X11.
# Force means no choice on user login screen for Xorg/X11 or Wayland!
# Reboot required!
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo sed --in-place 's/^#WaylandEnable=false/WaylandEnable=false/' /etc/gdm3/custom.conf; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo sed --in-place 's/^#WaylandEnable=false/WaylandEnable=false/' /etc/gdm/custom.conf; fi
# To check, after reboot!, execute "echo $XDG_SESSION_TYPE", should output
# 'x11'.

# Install app gdebi on host *
# View and install deb files.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes gdebi; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then echo 'The gdebi app is not available.'; fi

# Install app gettext on host pc06 pc07
# GNU Internationalization.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes gettext; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes gettext; fi

# Install app gimp on host pc06
# GNU Image Manipulation Program.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes gimp gimp-help-en gimp-help-nl; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf install --assumeyes gimp; fi

# Install app git on host pc06 pc07
# Distributed revision control system.
# Web app: https://github.com
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes git; fi
if grep --quiet rhel   /etc/os-release; then sudo sudo dnf install --assumeyes git; fi

# Install app gnome-gmail on host pc01 pc06 pc07
# Gmail for e-mail.
# Web app: https://mail.google.com
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes gnome-gmail; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then echo 'The gnome-gmail app is not available.'; fi

# Install app gnome-tweaks on host pc01 pc06 pc07
# Adjust advanced settings.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes gnome-tweaks; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf install --assumeyes gnome-tweaks; fi

# Install app google-chrome on host *
# Web browser.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then wget --no-verbose --output-document=/tmp/google-chrome.deb https://dl.google.com/dl/linux/direct/google-chrome-stable_current_amd64.deb; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes /tmp/google-chrome.deb; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then rm --verbose /tmp/google-chrome.deb; fi

if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo rpm --import https://dl.google.com/linux/linux_signing_key.pub; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf install --assumeyes https://dl.google.com/dl/linux/direct/google-chrome-stable_current_x86_64.rpm; fi

# Install app google-earth on host #none
# Explore the planet.
# Web app: https://earth.google.com
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then wget --no-verbose --output-document=/tmp/google-earth.deb https://dl.google.com/dl/linux/direct/google-earth-pro-stable_current_amd64.deb; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes /tmp/google-earth.deb; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then rm --verbose /tmp/google-earth.deb; fi

if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo rpm --import https://dl.google.com/linux/linux_signing_key.pub; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf install --assumeyes https://dl.google.com/dl/linux/direct/google-earth-pro-stable-current.x86_64.rpm; fi

# Install app groff on host pc06 pc07
# Compose manual pages with GNU roff.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes groff; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes groff; fi

# Install app handbrake on host #none
# Video-dvd ripper and transcoder.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes handbrake; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then echo 'The handbrake app is not available.'; fi

# Install app htop on host pc06 pc07
# Process viewer.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes htop; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes htop; fi

# Install app imagination on host pc06 pc07
# Slideshow maker.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes imagination; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then echo 'The imagination app is not available.'; fi

# Install app jq on host pc06 pc07
# JSON processor.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes jq; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes jq; fi

# Install app krita on host pc06
# Image manipulation.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes krita; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then echo 'The krita app is not available.'; fi

# Install app kvm on host pc06 pc07
# Kernel-based Virtual Machine.
# Images are in: /var/lib/libvirt/images/
# Reboot required!
# Dpkg::Options to prevent interaction while restoring /etc/libvirt
# configuration files.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes --option Dpkg::Options::="--force-confdef" --option Dpkg::Options::="--force-confold" bridge-utils cpu-checker libvirt-clients libvirt-daemon-system qemu-kvm qemu-system virtinst virt-manager; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo usermod --append --groups libvirt,libvirt-qemu "$USER"; fi
# Prevent "Error starting domain: Requested operation is not valid: network
# 'default' is not active".
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo virsh --connect=qemu:///system net-autostart default; fi
# Check network 'default' with
# "sudo virsh --connect=qemu:///system net-info default", should output
# 'Autostart: yes'.

if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf groupinstall "Virtualization Host"; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo systemctl enable --now libvirtd; fi
# Prevent "Error starting domain: Requested operation is not valid: network
# 'default' is not active".
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo virsh --connect=qemu:///system net-autostart default; fi
# Check network 'default' with
# "sudo virsh --connect=qemu:///system net-info default", should output
# 'Autostart: yes'.
# Install app lftp on host pc06 pc07
# FTP/HTTP/BitTorrent client.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes lftp; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes lftp; fi

# Install app libreoffice on host *
# Office suite.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes aspell-en aspell-nl libreoffice libreoffice-l10n-nl; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf install --assumeyes libreoffice; fi

# Install app locate on host pc06 pc07
# Find files.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes locate; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes mlocate; fi
sudo updatedb

# Install app log-access-for-user on host pc07
# Log access.
sudo usermod --append --groups adm,systemd-journal "${SUDO_USER:-$USER}"

# Install app mypy on host pc06 pc07
# Python static typing.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes mypy; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes python3-mypy; fi

# Install app nautilus-admin on host pc06 pc07
# Administrative operations.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes nautilus-admin; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then echo 'The nautilus-admin app is not available.'; fi

# Install app nmap on host pc06 pc07
# Network MAPper.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes nmap; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes nmap; fi

# Install app ntfs on host #none
# NTFS support.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes ntfs-3g; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes ntfs-3g ntfsprogs; fi
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

# Install app poedit on host pc06 pc07
# Gettext catalogs editor.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes poedit; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes poedit; fi

# Install app python on host pc06 pc07
# Programming language.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes pycodestyle python3-pycodestyle python3-autopep8 python3-pip python-is-python3; fi
if grep --quiet debian /etc/os-release; then sudo ln --force --relative --symbolic /usr/bin/pycodestyle /usr/bin/pep8; fi
if grep --quiet debian /etc/os-release; then sudo ln --force --relative --symbolic /usr/bin/pip3 /usr/bin/pip; fi

if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes python3 python3-pycodestyle python3-pip; fi

# Install app rpm on host pc06 pc07
# Package manager.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes rpm; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes rpm; fi

# Install app simplescreenrecorder on host #none
# Screen recorder.
# Requires the use of Xorg/X11.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes simplescreenrecorder; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then echo 'The simplescreenrecorder app is not available.'; fi

# Install app shellcheck on host pc06 pc07
# Shell script linter.
# Web app: https://www.shellcheck.net
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes shellcheck; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes shellcheck; fi

# Install app sound-juicer on host #none
# Audio-cd ripper and player.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes sound-juicer; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then echo 'The sound-juicer app is not available.'; fi

# Install app spice-vdagent on host *
# Spice agent.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes spice-vdagent; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes spice-vdagent; fi

# Install app spotify on host pc01 pc02 pc06 pc07
# Music and podcasts.
# Web app: https://open.spotify.com
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then wget --output-document=- https://download.spotify.com/debian/pubkey_C85668DF69375001.gpg | sudo gpg --dearmor --yes --output=/usr/share/keyrings/spotify.gpg; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/spotify.gpg] https://repository.spotify.com stable non-free' | sudo tee /etc/apt/sources.list.d/spotify.list > /dev/null; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get update; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes spotify-client; fi

if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then echo 'The spotify app is available as a web app.'; fi

# Install app ssh on host pc01 pc06 pc07
# Secure SHell.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes ssh; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes openssh; fi
sudo sed --in-place 's/PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
# Check for remote root access.
grep 'PermitRootLogin no' /etc/ssh/sshd_config
sudo systemctl restart ssh.service

# Install app sushi on host pc06
# Quick preview.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes gnome-sushi; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf install --assumeyes sushi; fi
# Usage:
# Select a file, press the space bar, and a preview will appear.

# Install app tab-completion on host *
# Bash completion.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes bash-completion; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes bash-completion; fi

# Install app teamviewer on host *
# Remote desktop.
# Web app: https://web.teamviewer.com
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then wget --no-verbose --output-document=/tmp/teamviewer.deb https://download.teamviewer.com/download/linux/teamviewer_amd64.deb; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes /tmp/teamviewer.deb; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then rm --verbose /tmp/teamviewer.deb; fi

# SKIP Error: Failed to download metadata for repo 'teamviewer': repomd.xml GPG
# signature verification error: Bad GPG signature
# if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf install --assumeyes https://download.teamviewer.com/download/linux/teamviewer.x86_64.rpm; fi

# Install app thunderbird on host *
# E-mail and news.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes thunderbird; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf install --assumeyes thunderbird; fi

# Install app tree on host pc06 pc07
# Display directory tree.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes tree; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes tree; fi

# Install app ufw on host pc01 pc06 pc07
# Uncomplicated FireWall.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes gufw; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf install --assumeyes gufw; fi
if [[ ${DISPLAY-} ]]; then sudo ufw allow ssh; fi
if [[ ${DISPLAY-} ]]; then sudo ufw enable; fi

# Install app usbutils on host pc07
# USB utilities.
# This package contains the lsusb utility.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes usbutils; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes usbutils; fi

# Install app user-guest on host #none
# Add guest user.
if ! id "$(gettext 'guest')" &> /dev/null; then sudo useradd --create-home --shell /usr/bin/bash --comment "$(gettext 'Guest user')" "$(gettext 'guest')"; fi
if   id "$(gettext 'guest')" &> /dev/null; then sudo passwd --delete "$(gettext 'guest')"; fi

# Install app virtualbox on host #none
# Virtualization.
# VirtualBox Guest user Additions ISO are in '/usr/share/virtualbox/'.
# If the installation hangs or VBox does not work, check the virtualization
# settings in the BIOS/UEFI.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then echo 'virtualbox-ext-pack virtualbox-ext-pack/license select true' | sudo debconf-set-selections; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso; fi

if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf install --assumeyes VirtualBox; fi

# Install app vlc on host *
# Multimedia player.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes vlc; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf install --assumeyes vlc; fi

# Install app vscode on host pc01 pc06 pc07
# Editor.
# Web app: https://vscode.dev
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes apt-transport-https; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then wget --output-document=- https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor --yes --output=/usr/share/keyrings/packages.microsoft.gpg; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get update; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes code; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo update-alternatives --set editor /usr/bin/code; fi

if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then echo -e '[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc' | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf install --assumeyes code; fi

# Install app webmin on host pc07
# Web console.
# Web app: https://localhost:10000
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then wget --output-document=/tmp/setup-repos.sh https://raw.githubusercontent.com/webmin/webmin/master/setup-repos.sh; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo sh /tmp/setup-repos.sh --force; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo rm --force --verbose /tmp/setup-repos.sh; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes webmin; fi

if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then wget --output-document=/tmp/setup-repos.sh https://raw.githubusercontent.com/webmin/webmin/master/setup-repos.sh; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo sh /tmp/setup-repos.sh --force; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo rm --force --verbose /tmp/setup-repos.sh; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf install --assumeyes webmin; fi

# Install app wine on host #none
# Run Windows applications.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dpkg --add-architecture i386; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes wine winetricks playonlinux; fi

if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf install --assumeyes wine playonlinux; fi

# Install app youtube-dl on host #none
# Download videos.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes youtubedl-gui; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf install --assumeyes youtube-dl; fi
