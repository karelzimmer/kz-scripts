# shellcheck shell=bash
###############################################################################
# SPDX-FileComment: Install file for use with kz-install script
#
# SPDX-FileCopyrightText: Karel Zimmer <info@karelzimmer.nl>
# SPDX-License-Identifier: CC0-1.0
###############################################################################
# Use "man kz install.sh" to learn more about the format of this file.

# Install app disabled-apport on host *
# Disable Ubuntu's automatic crash report generation.
if systemctl cat apport &> /dev/null; then sudo systemctl stop apport.service; fi
if systemctl cat apport &> /dev/null; then sudo systemctl disable apport.service; fi
if systemctl cat apport &> /dev/null; then sudo sed --in-place 's/enabled=1/enabled=0/' /etc/default/apport; fi
if systemctl cat apport &> /dev/null; then sudo rm --force --verbose /var/crash/*; fi

# Remove app disabled-apport from host *
# Enable Ubuntu's automatic crash report generation.
if systemctl cat apport &> /dev/null; then sudo sed --in-place 's/enabled=0/enabled=1/' /etc/default/apport; fi
if systemctl cat apport &> /dev/null; then sudo systemctl enable --now apport.service; fi

# Install app update-system on host *
# Update and cleanup system.
# This may take a while...
if grep --quiet debian /etc/os-release; then sudo apt-get update; fi
if grep --quiet debian /etc/os-release; then sudo apt-get upgrade --assume-yes; fi
if grep --quiet debian /etc/os-release && type snap &> /dev/null; then sudo snap refresh; fi

if grep --quiet rhel   /etc/os-release; then sudo dnf upgrade --assumeyes --refresh; fi
if grep --quiet rhel   /etc/os-release && type snap &> /dev/null; then sudo snap refresh; fi

# Remove app update-system from host *
# Update and cleanup system.
echo 'The update-system app cannot be removed.'
# Install app 7zip on host *
# File archiver.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes p7zip-full; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes p7zip; fi

# Remove app 7zip from host *
# File archiver.
if grep --quiet debian /etc/os-release; then sudo apt-get remove --purge --assume-yes p7zip-full; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes p7zip; fi

# Install app ansible on host pc06 pc07
# Configuration management, deployment, and task execution.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes ansible; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes ansible; fi

# Remove app ansible from host pc06 pc07
# Configuration management, deployment, and task execution.
if grep --quiet debian /etc/os-release; then sudo apt-get remove --purge --assume-yes ansible; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes ansible; fi

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

# Remove app anydesk from host pc06 pc07
# Remote desktop.
# Only outgoing sessions are supported if using Wayland.
# Incoming sessions are only possible when using Xorg/X11.
# Web app: https://my.anydesk.com/v2
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes anydesk; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo rm --force --verbose /etc/apt/sources.list.d/anydesk*.list*; fi

if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf remove --assumeyes anydesk; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo rm --force --verbose /etc/yum.repos.d/AnyDesk-RHEL.repo*; fi

# Install app apt on host #none
# Package manager.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes apt; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes apt; fi

# Remove app apt from host #none
# Package manager.
if grep --quiet debian /etc/os-release; then echo 'The apt app cannot be removed from host an Debian or Debian-based system.'; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes apt; fi

# Install app backintime on host #none
# Backups/snapshots.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes backintime-qt; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf install --assumeyes backintime-qt; fi

# Remove app backintime from host #none
# Backups/snapshots.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes backintime-qt; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf remove --assumeyes backintime-qt; fi

# Install app bleachbit on host #none
# Delete files.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes bleachbit; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf install --assumeyes bleachbit; fi

# Remove app bleachbit from host #none
# Delete files.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes bleachbit; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf remove --assumeyes bleachbit; fi

# Install app calibre on host pc06
# E-book manager.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes calibre; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo --validate && wget --output-document=- https://download.calibre-ebook.com/linux-installer.sh | sudo sh; fi

# Remove app calibre from host pc06
# E-book manager.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes calibre; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo calibre-uninstall; fi

# Install app cockpit on host pc06
# Web console.
# Web app: https://localhost:9090
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes cockpit cockpit-pcp; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf install --assumeyes cockpit cockpit-pcp; fi

# Remove app cockpit from host pc06
# Web console.
# Web app: https://localhost:9090
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes cockpit; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf remove --assumeyes cockpit; fi

# Install app cups on host *
# Common Unix Printing System.
# Web app: http://localhost:631
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes cups; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes cups; fi

# Remove app cups from host *
# Common Unix Printing System.
# Web app: http://localhost:631
if grep --quiet debian /etc/os-release; then sudo apt-get remove --purge --assume-yes cups; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes cups; fi

# Install app cups-backend-bjnp on host #none
# Printer backend.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes cups-backend-bjnp; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then echo 'The cups-backend-bjnp app is not available.'; fi

# Remove app cups-backend-bjnp from host #none
# Printer backend.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes cups-backend-bjnp; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then echo 'The cups-backend-bjnp app is not available.'; fi

# Install app dash-to-dock on host pc07
# Desktop dock.
# Reboot required!
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]] && ! apt-cache show gnome-shell-extension-ubuntu-dock; then sudo apt-get install --assume-yes gnome-shell-extension-dashtodock; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]] && apt-cache show gnome-shell-extension-no-overview; then sudo apt-get install --assume-yes gnome-shell-extension-no-overview; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf install --assumeyes gnome-shell-extension-dash-to-dock gnome-shell-extension-no-overview; fi

# Remove app dash-to-dock from host pc07
# Desktop dock.
# Reboot required!
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]] && ! apt-cache show gnome-shell-extension-ubuntu-dock; then sudo apt-get remove --purge --assume-yes gnome-shell-extension-dashtodock; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]] && apt-cache show gnome-shell-extension-no-overview; then sudo apt-get remove --purge --assume-yes gnome-shell-extension-no-overview; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf remove --assumeyes gnome-shell-extension-dash-to-dock gnome-shell-extension-no-overview; fi

# Install app desktop-backgrounds on host *
# Desktop backgrounds.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes '*-backgrounds'; fi
if grep --quiet ubuntu /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes ubuntu-wallpapers-* '*-backgrounds'; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf install --assumeyes desktop-backgrounds-* gnome-backgrounds*; fi

# Remove app desktop-backgrounds from host *
# Desktop backgrounds.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes '*-backgrounds'; fi
if grep --quiet ubuntu /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes ubuntu-wallpapers-* '*-backgrounds'; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf remove --assumeyes desktop-backgrounds-* gnome-backgrounds*; fi

# Install app disabled-aer on host pc06
# Disable kernel config parameter PCIEAER (Peripheral Component Interconnect
# Express Advanced Error Reporting) to prevent the log gets flooded with
# 'AER: Corrected errors received'. App disabled-aer is usually needed for HP hardware.
sudo sed --in-place 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash pci=noaer"/' /etc/default/grub
if grep --quiet debian /etc/os-release; then sudo update-grub; fi
if grep --quiet rhel   /etc/os-release; then sudo grub2-mkconfig -o /boot/grub2/grub.cfg; fi
# Check for kernel config parameter pci=noaer.
grep 'pci=noaer' /etc/default/grub

# Remove app disabled-aer from host pc06
# Enable kernel config parameter PCIEAER.
# Disable kernel config parameter PCIEAER (Peripheral Component Interconnect
# Express Advanced Error Reporting) to "allow" the log gets flooded with
# 'AER: Corrected errors received'. App disabled-aer is usually needed for HP hardware.
sudo sed --in-place 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash pci=noaer"/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash pci=noaer"/' /etc/default/grub
if grep --quiet debian /etc/os-release; then sudo update-grub; fi
if grep --quiet rhel   /etc/os-release; then sudo grub2-mkconfig -o /boot/grub2/grub.cfg; fi
# Check for kernel config parameter pci=noaer.
! grep 'pci=noaer' /etc/default/grub

# Install app disabled-fwupd on host #none
# Disable FirmWare UPdate Daemon.
sudo systemctl stop fwupd.service
sudo systemctl disable fwupd.service
sudo systemctl mask fwupd.service

# Remove app disabled-fwupd from host #none
# Disable FirmWare UPdate Daemon.
sudo systemctl unmask fwupd.service
sudo systemctl enable fwupd.service
sudo systemctl start fwupd.service

# Install app disabled-lidswitch on host #none
# Do nothing when the laptop lid is closed.
sudo sed --in-place '/^HandleLidSwitch=/d' /etc/systemd/logind.conf
echo 'HandleLidSwitch=ignore' | sudo tee --append /etc/systemd/logind.conf > /dev/null

# Remove app disabled-lidswitch from host #none
# Restore the default action when the laptop lid is closed.
sudo sed --in-place '/^HandleLidSwitch=/d' /etc/systemd/logind.conf

# Install app dual-monitor on host pc06
# Preserve dual monitor settings.
if [[ -f $HOME/.config/monitors.xml ]]; then sudo cp --preserve --verbose "$HOME"/.config/monitors.xml ~gdm/.config/monitors.xml; fi
if [[ -f  ~gdm/.config/monitors.xml ]]; then sudo chown --verbose gdm:gdm ~gdm/.config/monitors.xml; fi

# Remove app dual-monitor from host pc06
# Remove dual monitor settings.
sudo rm --force --verbose ~gdm/.config/monitors.xml

# Install app exiftool on host pc06 pc07
# Read and write meta information.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes libimage-exiftool-perl; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf install --assumeyes perl-Image-ExifTool; fi

# Remove app exiftool from host pc06 pc07
# Read and write meta information.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes libimage-exiftool-perl; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf remove --assumeyes perl-Image-ExifTool; fi

# Install app fakeroot on host pc06 pc07
# Simulate superuser privileges.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes fakeroot; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes fakeroot; fi

# Remove app fakeroot from host pc06 pc07
# Simulate superuser privileges.
if grep --quiet debian /etc/os-release; then sudo apt-get remove --purge --assume-yes fakeroot; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes fakeroot; fi

# Install app fdupes on host #none
# Find duplicate files.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes fdupes; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes fdupes; fi
# Usage:
# $ fdupes -r /path/to/folder   # Report recursively from /path/to/folder
# $ fdupes -rd /path/to/folder  # Delete, interactively, from /path/to/folder
# $ fdupes -rdN /path/to/folder # Delete, from /path/to/folder, keep first dup

# Remove app fdupes from host #none
# Find duplicate files.
if grep --quiet debian /etc/os-release; then sudo apt-get remove --purge --assume-yes fdupes; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes fdupes; fi

# Install app force-x11 on host #none
# Disable choice on user login screen for Xorg/X11 or Wayland, and force X11.
# Force means no choice on user login screen for Xorg/X11 or Wayland!
# Reboot required!
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo sed --in-place 's/^#WaylandEnable=false/WaylandEnable=false/' /etc/gdm3/custom.conf; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo sed --in-place 's/^#WaylandEnable=false/WaylandEnable=false/' /etc/gdm/custom.conf; fi
# To check, after reboot!, execute "echo $XDG_SESSION_TYPE", should output
# 'x11'.

# Remove app force-x11 from host #none
# Enable choice on user login screen for Xorg/X11 or Wayland.
# Force means no choice on user login screen for Xorg/X11 or Wayland!
# Reboot required!
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo sed --in-place 's/^WaylandEnable=false/#WaylandEnable=false/' /etc/gdm3/custom.conf; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo sed --in-place 's/^WaylandEnable=false/#WaylandEnable=false/' /etc/gdm/custom.conf; fi
# To check, after reboot!, execute "echo $XDG_SESSION_TYPE", should output
# 'wayland'.

# Install app gdebi on host *
# View and install deb files.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes gdebi; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then echo 'The gdebi app is not available.'; fi

# Remove app gdebi from host *
# View and install deb files.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes gdebi; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then echo 'The gdebi app is not available.'; fi

# Install app gettext on host pc06 pc07
# GNU Internationalization.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes gettext; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes gettext; fi

# Remove app gettext from host pc06 pc07
# GNU Internationalization.
if grep --quiet debian /etc/os-release; then sudo apt-get remove --purge --assume-yes gettext; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes gettext; fi

# Install app gimp on host pc06
# GNU Image Manipulation Program.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes gimp gimp-help-en gimp-help-nl; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf install --assumeyes gimp; fi

# Remove app gimp from host pc06
# GNU Image Manipulation Program.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes gimp gimp-help-en gimp-help-nl; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf remove --assumeyes gimp; fi

# Install app git on host pc06 pc07
# Distributed revision control system.
# Web app: https://github.com
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes git; fi
if grep --quiet rhel   /etc/os-release; then sudo sudo dnf install --assumeyes git; fi

# Remove app git from host pc06 pc07
# Distributed revision control system.
# Web app: https://github.com
if grep --quiet debian /etc/os-release; then sudo apt-get remove --purge --assume-yes git; fi
if grep --quiet rhel   /etc/os-release; then sudo sudo dnf remove --assumeyes git; fi

# Install app gnome-gmail on host pc01 pc06 pc07
# Gmail for e-mail.
# Web app: https://mail.google.com
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes gnome-gmail; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then echo 'The gnome-gmail app is not available.'; fi

# Remove app gnome-gmail from host pc01 pc06 pc07
# Gmail for e-mail.
# Web app: https://mail.google.com
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes gnome-gmail; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then echo 'The gnome-gmail app is not available.'; fi

# Install app gnome-tweaks on host pc01 pc06 pc07
# Adjust advanced settings.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes gnome-tweaks; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf install --assumeyes gnome-tweaks; fi

# Remove app gnome-tweaks from host pc01 pc06 pc07
# Adjust advanced settings.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes gnome-tweaks; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf remove --assumeyes gnome-tweaks; fi

# Install app google-chrome on host *
# Web browser.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then wget --no-verbose --output-document=/tmp/google-chrome.deb https://dl.google.com/dl/linux/direct/google-chrome-stable_current_amd64.deb; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes /tmp/google-chrome.deb; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then rm --verbose /tmp/google-chrome.deb; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo rpm --import https://dl.google.com/linux/linux_signing_key.pub; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf install --assumeyes https://dl.google.com/dl/linux/direct/google-chrome-stable_current_x86_64.rpm; fi

# Remove app google-chrome from host *
# Web browser.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes google-chrome-stable; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf remove --assumeyes google-chrome-stable; fi

# Install app google-earth on host #none
# Explore the planet.
# Web app: https://earth.google.com
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then wget --no-verbose --output-document=/tmp/google-earth.deb https://dl.google.com/dl/linux/direct/google-earth-pro-stable_current_amd64.deb; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes /tmp/google-earth.deb; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then rm --verbose /tmp/google-earth.deb; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo rpm --import https://dl.google.com/linux/linux_signing_key.pub; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf install --assumeyes https://dl.google.com/dl/linux/direct/google-earth-pro-stable-current.x86_64.rpm; fi

# Remove app google-earth from host #none
# Explore the planet.
# Web app: https://earth.google.com
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes google-earth-pro-stable; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf remove --assumeyes google-earth-pro-stable; fi

# Install app groff on host pc06 pc07
# Compose manual pages with GNU roff.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes groff; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes groff; fi

# Remove app groff from host pc06 pc07
# Compose manual pages with GNU roff.
if grep --quiet debian /etc/os-release; then sudo apt-get remove --purge --assume-yes groff; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes groff; fi

# Install app handbrake on host #none
# Video-dvd ripper and transcoder.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes handbrake; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then echo 'The handbrake app is not available.'; fi

# Remove app handbrake from host #none
# Video-dvd ripper and transcoder.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes handbrake; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then echo 'The handbrake app is not available.'; fi

# Install app htop on host pc06 pc07
# Process viewer.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes htop; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes htop; fi

# Remove app htop from host pc06 pc07
# Process viewer.
if grep --quiet debian /etc/os-release; then sudo apt-get remove --purge --assume-yes htop; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes htop; fi

# Install app imagination on host pc06 pc07
# Slideshow maker.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes imagination; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then echo 'The imagination app is not available.'; fi

# Remove app imagination from host pc06 pc07
# Slideshow maker.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes imagination; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then echo 'The imagination app is not available.'; fi

# Install app jq on host pc06 pc07
# JSON processor.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes jq; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes jq; fi

# Remove app jq from host pc06 pc07
# JSON processor.
if grep --quiet debian /etc/os-release; then sudo apt-get remove --purge --assume-yes jq; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes jq; fi

# Install app krita on host pc06
# Image manipulation.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes krita; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then echo 'The krita app is not available.'; fi

# Remove app krita from host pc06
# Image manipulation.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes krita; fi
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

# Remove app kvm from host pc06 pc07
# Kernel-based Virtual Machine.
# Images are in: /var/lib/libvirt/images/
# Reboot required!
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo virsh --connect=qemu:///system net-autostart default --disable; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes bridge-utils cpu-checker libvirt-clients libvirt-daemon-system qemu-kvm qemu-system virtinst virt-manager; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo delgroup libvirtd-dnsmasq; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo deluser "$USER" libvirt; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo deluser "$USER" libvirtd-qemu; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo delgroup libvirtd; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo systemctl disable --now libvirtd; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf groupremove "Virtualization Host"; fi

# Install app lftp on host pc06 pc07
# FTP/HTTP/BitTorrent client.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes lftp; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes lftp; fi

# Remove app lftp from host pc06 pc07
# FTP/HTTP/BitTorrent client.
if grep --quiet debian /etc/os-release; then sudo apt-get remove --purge --assume-yes lftp; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes lftp; fi

# Install app libreoffice on host *
# Office suite.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes aspell-en aspell-nl libreoffice libreoffice-l10n-nl; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf install --assumeyes libreoffice; fi

# Remove app libreoffice from host *
# Office suite.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes aspell-en aspell-nl libreoffice libreoffice-l10n-nl; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf remove --assumeyes libreoffice; fi

# Install app locate on host pc06 pc07
# Find files.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes locate; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes mlocate; fi
sudo updatedb

# Remove app locate from host pc06 pc07
# Find files.
if grep --quiet debian /etc/os-release; then sudo apt-get remove --purge --assume-yes locate; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes mlocate; fi

# Install app log-access-for-user on host pc07
# Log access.
sudo usermod --append --groups adm,systemd-journal "${SUDO_USER:-$USER}"

# Remove app log-access-for-user from host pc07
# Log access.
sudo deluser "${SUDO_USER:-$USER}" adm
sudo deluser "${SUDO_USER:-$USER}" systemd-journal

# Install app mypy on host pc06 pc07
# Python static typing.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes mypy; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes python3-mypy; fi

# Remove app mypy from host pc06 pc07
# Python static typing.
if grep --quiet debian /etc/os-release; then sudo apt-get remove --purge --assume-yes mypy; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes python3-mypy; fi

# Install app nautilus-admin on host pc06 pc07
# Administrative operations.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes nautilus-admin; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then echo 'The nautilus-admin app is not available.'; fi

# Remove app nautilus-admin from host pc06 pc07
# Administrative operations.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes nautilus-admin; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then echo 'The nautilus-admin app is not available.'; fi

# Install app nmap on host pc06 pc07
# Network MAPper.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes nmap; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes nmap; fi

# Remove app nmap from host pc06 pc07
# Network MAPper.
if grep --quiet debian /etc/os-release; then sudo apt-get remove --purge --assume-yes nmap; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes nmap; fi

# Install app ntfs on host #none
# NTFS support.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes ntfs-3g; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes ntfs-3g ntfsprogs; fi
# Usage:
# $ findmnt (or lsblk)
# TARGET          SOURCE    FSTYPE OPTIONS
# /media/...      /dev/sda1 ntfs3  rw,nosuid,nodev,relatime,uid=...
# $ lsblk
# NAME                        MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINTS
# sda                           8:0    0 931,5G  0 disk
# +-sda1                        8:1    0 931,5G  0 part  /media/...
# $ sudo ntfsfix /dev/sdba1     # Fix an NTFS partition
# $ sudo -b ntfsfix /dev/sdba1  # Clear the bad sector list
# $ sudo -d ntfsfix /dev/sdba1  # Clear the volume dirty flag

# Remove app ntfs from host #none
# NTFS support.
if grep --quiet debian /etc/os-release; then sudo apt-get remove --purge --assume-yes ntfs-3g; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes ntfs-3g ntfsprogs; fi

# Install app poedit on host pc06 pc07
# Gettext catalogs editor.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes poedit; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes poedit; fi

# Remove app poedit from host pc06 pc07
# Gettext catalogs editor.
if grep --quiet debian /etc/os-release; then sudo apt-get remove --purge --assume-yes poedit; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes poedit; fi

# Install app python on host pc06 pc07
# Programming language.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes pycodestyle python3-pycodestyle python3-autopep8 python3-pip python-is-python3; fi
if grep --quiet debian /etc/os-release; then sudo ln --force --relative --symbolic /usr/bin/pycodestyle /usr/bin/pep8; fi
if grep --quiet debian /etc/os-release; then sudo ln --force --relative --symbolic /usr/bin/pip3 /usr/bin/pip; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes python3 python3-pycodestyle python3-pip; fi

# Remove app python from host pc06 pc07
# Programming language.
if grep --quiet debian /etc/os-release; then sudo apt-get remove --purge --assume-yes pycodestyle python3-pycodestyle python3-autopep8 python3-pip python-is-python3; fi
if grep --quiet debian /etc/os-release; then sudo rm --force --verbose /usr/bin/pep8 /usr/bin/pip; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes python3 python3-pycodestyle python3-pip; fi

# Install app rpm on host pc06 pc07
# Package manager.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes rpm; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes rpm; fi

# Remove app rpm from host pc06 pc07
# Package manager for RPM.
if grep --quiet debian /etc/os-release; then sudo apt-get remove --purge --assume-yes rpm; fi
if grep --quiet rhel   /etc/os-release; then echo 'The rpm app cannot be removed.'; fi

# Install app simplescreenrecorder on host #none
# Screen recorder.
# Requires the use of Xorg/X11.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes simplescreenrecorder; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then echo 'The simplescreenrecorder app is not available.'; fi

# Remove app simplescreenrecorder from host #none
# Screen recorder.
# Required the use of Xorg/X11. Enable Wayland again?
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes simplescreenrecorder; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then echo 'The simplescreenrecorder app is not available.'; fi

# Install app shellcheck on host pc06 pc07
# Shell script linter.
# Web app: https://www.shellcheck.net
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes shellcheck; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes shellcheck; fi

# Remove app shellcheck from host pc06 pc07
# Shell script linter.
# Web app: https://www.shellcheck.net
if grep --quiet debian /etc/os-release; then sudo apt-get remove --purge --assume-yes shellcheck; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes shellcheck; fi

# Install app sound-juicer on host #none
# Audio-cd ripper and player.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes sound-juicer; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then echo 'The sound-juicer app is not available.'; fi

# Remove app sound-juicer from host #none
# Audio-cd ripper and player.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes sound-juicer; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then echo 'The sound-juicer app is not available.'; fi

# Install app spice-vdagent on host *
# Spice agent.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes spice-vdagent; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes spice-vdagent; fi

# Remove app spice-vdagent from host *
# Spice agent.
if grep --quiet debian /etc/os-release; then sudo apt-get remove --purge --assume-yes spice-vdagent; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes spice-vdagent; fi

# Install app spotify on host pc01 pc02 pc06 pc07
# Music and podcasts.
# Web app: https://open.spotify.com
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then wget --output-document=- https://download.spotify.com/debian/pubkey_C85668DF69375001.gpg | sudo gpg --dearmor --yes --output=/usr/share/keyrings/spotify.gpg; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/spotify.gpg] https://repository.spotify.com stable non-free' | sudo tee /etc/apt/sources.list.d/spotify.list > /dev/null; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get update; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes spotify-client; fi

if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then echo 'The spotify app is available as a web app.'; fi

# Remove app spotify from host pc01 pc02 pc06 pc07
# Music and podcasts.
# Web app: https://open.spotify.com
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes spotify-client; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo rm --force --verbose /etc/apt/sources.list.d/spotify*.list*; fi

if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then echo 'The spotify web app cannot be removed.'; fi

# Install app ssh on host pc01 pc06 pc07
# Secure SHell.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes ssh; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes openssh; fi
sudo sed --in-place 's/PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
# Check for remote root access.
grep 'PermitRootLogin no' /etc/ssh/sshd_config
sudo systemctl restart ssh.service


# Remove app ssh from host pc01 pc06 pc07
# Secure SHell.
if [[ 'pc01 pc06 pc07' =~ $HOSTNAME ]]; then sudo sed --in-place '/^192.168.1./d' /etc/hosts; fi
sudo sed --in-place 's/PermitRootLogin no/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config
if grep --quiet debian /etc/os-release; then sudo apt-get remove --purge --assume-yes ssh; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes openssh; fi

# Install app sushi on host pc06
# Quick preview.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes gnome-sushi; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf install --assumeyes sushi; fi
# Usage:
# Select a file, press the space bar, and a preview will appear.

# Remove app sushi from host pc06
# Quick preview.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes gnome-sushi; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf remove --assumeyes sushi; fi

# Install app tab-completion on host *
# Bash completion.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes bash-completion; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes bash-completion; fi

# Remove app tab-completion from host *
# Bash completion.
if grep --quiet debian /etc/os-release; then sudo apt-get remove --purge --assume-yes bash-completion; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes bash-completion; fi

# Install app teamviewer on host *
# Remote desktop.
# Web app: https://web.teamviewer.com
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then wget --no-verbose --output-document=/tmp/teamviewer.deb https://download.teamviewer.com/download/linux/teamviewer_amd64.deb; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes /tmp/teamviewer.deb; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then rm --verbose /tmp/teamviewer.deb; fi
# SKIP Error: Failed to download metadata for repo 'teamviewer': repomd.xml GPG
# signature verification error: Bad GPG signature
# if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf install --assumeyes https://download.teamviewer.com/download/linux/teamviewer.x86_64.rpm; fi

# Remove app teamviewer from host *
# Remote desktop.
# Web app: https://web.teamviewer.com
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes teamviewer; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf remove --assumeyes teamviewer; fi

# Install app thunderbird on host *
# E-mail and news.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes thunderbird; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf install --assumeyes thunderbird; fi

# Remove app thunderbird from host *
# E-mail and news.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes thunderbird; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf remove --assumeyes thunderbird; fi

# Install app tree on host pc06 pc07
# Display directory tree.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes tree; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes tree; fi

# Remove app tree from host pc06 pc07
# Display directory tree.
if grep --quiet debian /etc/os-release; then sudo apt-get remove --purge --assume-yes tree; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes tree; fi

# Install app ufw on host pc01 pc06 pc07
# Uncomplicated FireWall.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes gufw; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf install --assumeyes gufw; fi
if [[ ${DISPLAY-} ]]; then sudo ufw allow ssh; fi
if [[ ${DISPLAY-} ]]; then sudo ufw enable; fi

# Remove app ufw from host pc01 pc06 pc07
# Uncomplicated FireWall.
sudo ufw disable
if grep --quiet debian /etc/os-release; then sudo apt-get remove --purge --assume-yes gufw; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes gufw; fi

# Install app usbutils on host pc07
# USB utilities.
# This package contains the lsusb utility.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes usbutils; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes usbutils; fi

# Remove app usbutils from host pc07
# USB utilities.
# This package contains the lsusb utility.
if grep --quiet debian /etc/os-release; then sudo apt-get remove --purge --assume-yes usbutils; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes usbutils; fi

# Install app user-guest on host #none
# Add guest user.
if ! id "$(gettext 'guest')" &> /dev/null; then sudo useradd --create-home --shell /usr/bin/bash --comment "$(gettext 'Guest user')" "$(gettext 'guest')"; fi
if id "$(gettext 'guest')" &> /dev/null; then sudo passwd --delete "$(gettext 'guest')"; fi

# Remove app user-guest from host #none
# Remove guest user.
if id "$(gettext 'guest')" &> /dev/null; then sudo userdel --remove "$(gettext 'guest')"; fi

# Install app virtualbox on host #none
# Virtualization.
# VirtualBox Guest user Additions ISO are in '/usr/share/virtualbox/'.
# If the installation hangs or VBox does not work, check the virtualization
# settings in the BIOS/UEFI.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then echo 'virtualbox-ext-pack virtualbox-ext-pack/license select true' | sudo debconf-set-selections; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf install --assumeyes VirtualBox; fi

# Remove app virtualbox from host #none
# Virtualization.
# VirtualBox Guest user Additions ISO are in '/usr/share/virtualbox/'.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf remove --assumeyes VirtualBox; fi

# Install app vlc on host *
# Multimedia player.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes vlc; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf install --assumeyes vlc; fi

# Remove app vlc from host *
# Multimedia player.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes vlc; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf remove --assumeyes vlc; fi

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

# Remove app vscode from host pc01 pc06 pc07
# Editor.
# Web app: https://vscode.dev
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo update-alternatives --remove editor /usr/bin/code; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo rm --force --verbose /etc/apt/sources.list.d/vscode*.list*; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes code; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf remove --assumeyes code; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo rm --force --verbose /etc/yum.repos.d/vscode.repo*; fi

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

# Remove app webmin from host pc07
# Web console.
# Web app: https://localhost:10000
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes webmin; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo rm --force --verbose /etc/apt/sources.list.d/webmin*.list*; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf remove --assumeyes webmin; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo rm --force --verbose /etc/yum.repos.d/webmin.repo*; fi

# Install app wine on host #none
# Run Windows applications.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dpkg --add-architecture i386; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes wine winetricks playonlinux; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf install --assumeyes wine playonlinux; fi

# Remove app wine from host #none
# Run Windows applications.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes wine winetricks playonlinux; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dpkg --remove-architecture i386; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf remove --assumeyes wine playonlinux; fi

# Install app youtube-dl on host #none
# Download videos.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes youtubedl-gui; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf install --assumeyes youtube-dl; fi

# Remove app youtube-dl from host #none
# Download videos.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes youtubedl-gui; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf remove --assumeyes youtube-dl; fi
