# shellcheck shell=bash
###############################################################################
# SPDX-FileComment: Install file for use with kz-install script
#
# SPDX-FileCopyrightText: Karel Zimmer <info@karelzimmer.nl>
# SPDX-License-Identifier: CC0-1.0
###############################################################################
# Use "man kz-install.sh" to learn more about the format of this file.

# Install 1-disabled-apport on *
# Disable Ubuntu's automatic crash report generation.
if systemctl cat apport &> /dev/null; then sudo systemctl stop apport.service; fi
if systemctl cat apport &> /dev/null; then sudo systemctl disable apport.service; fi
if systemctl cat apport &> /dev/null; then sudo sed --in-place 's/enabled=1/enabled=0/' /etc/default/apport; fi
if systemctl cat apport &> /dev/null; then sudo rm --force --verbose /var/crash/*; fi

# Remove 1-disabled-apport from *
# Enable Ubuntu's automatic crash report generation.
if systemctl cat apport &> /dev/null; then sudo sed --in-place 's/enabled=0/enabled=1/' /etc/default/apport; fi
if systemctl cat apport &> /dev/null; then sudo systemctl enable --now apport.service; fi


# Install 2-update-system on *
# Update and cleanup system.
# This may take a while...
if grep --quiet debian /etc/os-release; then sudo apt-get update; fi
if grep --quiet debian /etc/os-release; then sudo apt-get upgrade --assume-yes; fi
if grep --quiet debian /etc/os-release && type snap &> /dev/null; then sudo snap refresh; fi

if grep --quiet rhel   /etc/os-release; then sudo dnf upgrade --assumeyes --refresh; fi
if grep --quiet rhel   /etc/os-release && type snap &> /dev/null; then sudo snap refresh; fi

# Remove 2-update-system from *
# Update and cleanup system.
echo 'The update-system app cannot be removed.'


# Install 7zip on *
# File archiver.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes p7zip-full; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes p7zip; fi

# Remove 7zip from *
# File archiver.
if grep --quiet debian /etc/os-release; then sudo apt-get remove --purge --assume-yes p7zip-full; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes p7zip; fi


# Install ansible on ?
# Configuration management, deployment, and task execution.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes ansible; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes ansible; fi

# Remove ansible from ?
# Configuration management, deployment, and task execution.
if grep --quiet debian /etc/os-release; then sudo apt-get remove --purge --assume-yes ansible; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes ansible; fi


# Install anydesk on ?
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

# Remove anydesk from ?
# Remote desktop.
# Only outgoing sessions are supported if using Wayland.
# Incoming sessions are only possible when using Xorg/X11.
# Web app: https://my.anydesk.com/v2
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes anydesk; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo rm --force --verbose /etc/apt/sources.list.d/anydesk*.list*; fi

if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf remove --assumeyes anydesk; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo rm --force --verbose /etc/yum.repos.d/AnyDesk-RHEL.repo*; fi


# Install apt on ?
# Package manager.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes apt; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes apt; fi

# Remove apt from ?
# Package manager.
if grep --quiet debian /etc/os-release; then echo 'The apt app cannot be removed from an Debian or Debian-based system.'; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes apt; fi


# Install backintime on ?
# Backups/snapshots.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes backintime-qt; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf install --assumeyes backintime-qt; fi

# Remove backintime from ?
# Backups/snapshots.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes backintime-qt; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf remove --assumeyes backintime-qt; fi


# Install bleachbit on ?
# Delete files.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes bleachbit; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf install --assumeyes bleachbit; fi

# Remove bleachbit from ?
# Delete files.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes bleachbit; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf remove --assumeyes bleachbit; fi


# Install calibre on ?
# E-book manager.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes calibre; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo --validate && wget --output-document=- https://download.calibre-ebook.com/linux-installer.sh | sudo sh; fi

# Remove calibre from ?
# E-book manager.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes calibre; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo calibre-uninstall; fi


# Install cockpit on ?
# Web console.
# Web app: https://localhost:9090
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes cockpit cockpit-pcp; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf install --assumeyes cockpit cockpit-pcp; fi

# Remove cockpit from ?
# Web console.
# Web app: https://localhost:9090
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes cockpit; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf remove --assumeyes cockpit; fi


# Install cups on *
# Common UNIX Printing System.
# Web app: http://localhost:631
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes cups; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes cups; fi

# Remove cups from *
# Common UNIX Printing System.
# Web app: http://localhost:631
if grep --quiet debian /etc/os-release; then sudo apt-get remove --purge --assume-yes cups; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes cups; fi


# Install cups-backend-bjnp on ?
# Printer backend.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes cups-backend-bjnp; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then echo 'The cups-backend-bjnp app is not available.'; fi

# Remove cups-backend-bjnp from ?
# Printer backend.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes cups-backend-bjnp; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then echo 'The cups-backend-bjnp app is not available.'; fi


# Install dash-to-dock on ?
# Desktop dock.
# Reboot required!
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]] && ! apt-cache show gnome-shell-extension-ubuntu-dock; then sudo apt-get install --assume-yes gnome-shell-extension-dashtodock; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]] && apt-cache show gnome-shell-extension-no-overview; then sudo apt-get install --assume-yes gnome-shell-extension-no-overview; fi

if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf install --assumeyes gnome-shell-extension-dash-to-dock gnome-shell-extension-no-overview; fi

# Remove dash-to-dock from ?
# Desktop dock.
# Reboot required!
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]] && ! apt-cache show gnome-shell-extension-ubuntu-dock; then sudo apt-get remove --purge --assume-yes gnome-shell-extension-dashtodock; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]] && apt-cache show gnome-shell-extension-no-overview; then sudo apt-get remove --purge --assume-yes gnome-shell-extension-no-overview; fi

if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf remove --assumeyes gnome-shell-extension-dash-to-dock gnome-shell-extension-no-overview; fi


# Install desktop-backgrounds on *
# Desktop backgrounds.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes '*-backgrounds'; fi
if grep --quiet ubuntu /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes ubuntu-wallpapers-* '*-backgrounds'; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf install --assumeyes desktop-backgrounds-* gnome-backgrounds*; fi

# Remove desktop-backgrounds from *
# Desktop backgrounds.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes '*-backgrounds'; fi
if grep --quiet ubuntu /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes ubuntu-wallpapers-* '*-backgrounds'; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf remove --assumeyes desktop-backgrounds-* gnome-backgrounds*; fi


# Install disabled-aer on ?
# Disable kernel config parameter PCIEAER (Peripheral Component Interconnect
# Express Advanced Error Reporting) to prevent the log gets flooded with
# 'AER: Corrected errors received'. Usually needed for HP hardware.
sudo sed --in-place 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash pci=noaer"/' /etc/default/grub
if grep --quiet debian /etc/os-release; then sudo update-grub; fi
if grep --quiet rhel   /etc/os-release; then sudo grub2-mkconfig -o /boot/grub2/grub.cfg; fi
# Check for kernel config parameter pci=noaer.
grep 'pci=noaer' /etc/default/grub

# Remove disabled-aer from ?
# Enable kernel config parameter PCIEAER.
# Disable kernel config parameter PCIEAER (Peripheral Component Interconnect
# Express Advanced Error Reporting) to "allow" the log gets flooded with
# 'AER: Corrected errors received'. Usually needed for HP hardware.
sudo sed --in-place 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash pci=noaer"/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash pci=noaer"/' /etc/default/grub
if grep --quiet debian /etc/os-release; then sudo update-grub; fi
if grep --quiet rhel   /etc/os-release; then sudo grub2-mkconfig -o /boot/grub2/grub.cfg; fi
# Check for kernel config parameter pci=noaer.
! grep 'pci=noaer' /etc/default/grub


# Install disabled-fwupd on ?
# Disable FirmWare UPdate Daemon.
sudo systemctl stop fwupd.service
sudo systemctl disable fwupd.service
sudo systemctl mask fwupd.service

# Remove disabled-fwupd from ?
# Disable FirmWare UPdate Daemon.
sudo systemctl unmask fwupd.service
sudo systemctl enable fwupd.service
sudo systemctl start fwupd.service


# Install disabled-lidswitch on ?
# Do nothing when the laptop lid is closed.
sudo sed --in-place '/^HandleLidSwitch=/d' /etc/systemd/logind.conf
echo 'HandleLidSwitch=ignore' | sudo tee --append /etc/systemd/logind.conf > /dev/null

# Remove disabled-lidswitch from ?
# Restore the default action when the laptop lid is closed.
sudo sed --in-place '/^HandleLidSwitch=/d' /etc/systemd/logind.conf


# Install dual-monitor on ?
# Preserve dual monitor settings.
if [[ -f ~karel/.config/monitors.xml ]]; then sudo cp --preserve --verbose ~karel/.config/monitors.xml ~gdm/.config/monitors.xml; fi
if [[ -f ~gdm/.config/monitors.xml   ]]; then sudo chown --verbose gdm:gdm ~gdm/.config/monitors.xml; fi

# Remove dual-monitor from ?
# Remove dual monitor settings.
sudo rm --force --verbose ~gdm/.config/monitors.xml


# Install exiftool on ?
# Read and write meta information.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes libimage-exiftool-perl; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf install --assumeyes perl-Image-ExifTool; fi

# Remove exiftool from ?
# Read and write meta information.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes libimage-exiftool-perl; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf remove --assumeyes perl-Image-ExifTool; fi


# Install fakeroot on ?
# Simulate superuser privileges.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes fakeroot; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes fakeroot; fi

# Remove fakeroot from ?
# Simulate superuser privileges.
if grep --quiet debian /etc/os-release; then sudo apt-get remove --purge --assume-yes fakeroot; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes fakeroot; fi


# Install fdupes on ?
# Find duplicate files.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes fdupes; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes fdupes; fi
# Usage:
# $ fdupes -r /path/to/folder   # Report recursively from /path/to/folder
# $ fdupes -rd /path/to/folder  # Delete, interactively, from /path/to/folder
# $ fdupes -rdN /path/to/folder # Delete, from /path/to/folder, keep first dup

# Remove fdupes from ?
# Find duplicate files.
if grep --quiet debian /etc/os-release; then sudo apt-get remove --purge --assume-yes fdupes; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes fdupes; fi


# Install force-x11 on ?
# Disable choice on user login screen for Xorg/X11 or Wayland, and force X11.
# Force means no choice on user login screen for Xorg/X11 or Wayland!
# Reboot required!
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo sed --in-place 's/^#WaylandEnable=false/WaylandEnable=false/' /etc/gdm3/custom.conf; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo sed --in-place 's/^#WaylandEnable=false/WaylandEnable=false/' /etc/gdm/custom.conf; fi
# To check, after reboot!, execute "echo $XDG_SESSION_TYPE", should output
# 'x11'.

# Remove force-x11 from ?
# Enable choice on user login screen for Xorg/X11 or Wayland.
# Force means no choice on user login screen for Xorg/X11 or Wayland!
# Reboot required!
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo sed --in-place 's/^WaylandEnable=false/#WaylandEnable=false/' /etc/gdm3/custom.conf; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo sed --in-place 's/^WaylandEnable=false/#WaylandEnable=false/' /etc/gdm/custom.conf; fi
# To check, after reboot!, execute "echo $XDG_SESSION_TYPE", should output
# 'wayland'.


# Install gdebi on *
# View and install deb files.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes gdebi; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then echo 'The gdebi app is not available.'; fi

# Remove gdebi from *
# View and install deb files.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes gdebi; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then echo 'The gdebi app is not available.'; fi


# Install gettext on ?
# GNU Internationalization.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes gettext; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes gettext; fi

# Remove gettext from ?
# GNU Internationalization.
if grep --quiet debian /etc/os-release; then sudo apt-get remove --purge --assume-yes gettext; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes gettext; fi


# Install gimp on ?
# GNU Image Manipulation Program.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes gimp gimp-help-en gimp-help-nl; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf install --assumeyes gimp; fi

# Remove gimp from ?
# GNU Image Manipulation Program.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes gimp gimp-help-en gimp-help-nl; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf remove --assumeyes gimp; fi


# Install git on ?
# Distributed revision control system.
# Web app: https://github.com
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes git; fi
if grep --quiet rhel   /etc/os-release; then sudo sudo dnf install --assumeyes git; fi

# Remove git from ?
# Distributed revision control system.
# Web app: https://github.com
if grep --quiet debian /etc/os-release; then sudo apt-get remove --purge --assume-yes git; fi
if grep --quiet rhel   /etc/os-release; then sudo sudo dnf remove --assumeyes git; fi


# Install gnome-gmail on ?
# Gmail for e-mail.
# Web app: https://mail.google.com
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes gnome-gmail; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then echo 'The gnome-gmail app is not available.'; fi

# Remove gnome-gmail from ?
# Gmail for e-mail.
# Web app: https://mail.google.com
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes gnome-gmail; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then echo 'The gnome-gmail app is not available.'; fi


# Install gnome-tweaks on ?
# Adjust advanced settings.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes gnome-tweaks; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf install --assumeyes gnome-tweaks; fi

# Remove gnome-tweaks from ?
# Adjust advanced settings.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes gnome-tweaks; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf remove --assumeyes gnome-tweaks; fi


# Install google-chrome on *
# Web browser.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then wget --no-verbose --output-document=/tmp/google-chrome.deb https://dl.google.com/dl/linux/direct/google-chrome-stable_current_amd64.deb; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes /tmp/google-chrome.deb; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then rm --verbose /tmp/google-chrome.deb; fi

if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo rpm --import https://dl.google.com/linux/linux_signing_key.pub; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf install --assumeyes https://dl.google.com/dl/linux/direct/google-chrome-stable_current_x86_64.rpm; fi

# Remove google-chrome from *
# Web browser.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes google-chrome-stable; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf remove --assumeyes google-chrome-stable; fi


# Install google-earth on ?
# Explore the planet.
# Web app: https://earth.google.com
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then wget --no-verbose --output-document=/tmp/google-earth.deb https://dl.google.com/dl/linux/direct/google-earth-pro-stable_current_amd64.deb; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes /tmp/google-earth.deb; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then rm --verbose /tmp/google-earth.deb; fi

if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo rpm --import https://dl.google.com/linux/linux_signing_key.pub; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf install --assumeyes https://dl.google.com/dl/linux/direct/google-earth-pro-stable-current.x86_64.rpm; fi

# Remove google-earth from ?
# Explore the planet.
# Web app: https://earth.google.com
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes google-earth-pro-stable; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf remove --assumeyes google-earth-pro-stable; fi


# Install groff on ?
# Compose manual pages with GNU roff.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes groff; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes groff; fi

# Remove groff from ?
# Compose manual pages with GNU roff.
if grep --quiet debian /etc/os-release; then sudo apt-get remove --purge --assume-yes groff; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes groff; fi


# Install handbrake on ?
# Video-dvd ripper and transcoder.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes handbrake; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then echo 'The handbrake app is not available.'; fi

# Remove handbrake from ?
# Video-dvd ripper and transcoder.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes handbrake; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then echo 'The handbrake app is not available.'; fi


# Install htop on ?
# Process viewer.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes htop; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes htop; fi

# Remove htop from ?
# Process viewer.
if grep --quiet debian /etc/os-release; then sudo apt-get remove --purge --assume-yes htop; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes htop; fi


# Install imagination on ?
# Slideshow maker.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes imagination; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then echo 'The imagination app is not available.'; fi

# Remove imagination from ?
# Slideshow maker.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes imagination; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then echo 'The imagination app is not available.'; fi


# Install jq on ?
# JSON processor.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes jq; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes jq; fi

# Remove jq from ?
# JSON processor.
if grep --quiet debian /etc/os-release; then sudo apt-get remove --purge --assume-yes jq; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes jq; fi


# Install krita on ?
# Image manipulation.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes krita; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then echo 'The krita app is not available.'; fi

# Remove krita from ?
# Image manipulation.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes krita; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then echo 'The krita app is not available.'; fi


# Install kvm on ?
# Kernel-based Virtual Machine.
# Images are in: /var/lib/libvirt/images/
# Reboot required!
# Dpkg::Options to prevent interaction while restoring /etc/libvirt
# configuration files.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes --option Dpkg::Options::="--force-confdef" --option Dpkg::Options::="--force-confold" bridge-utils cpu-checker libvirt-clients libvirt-daemon-system qemu-kvm qemu-system virtinst virt-manager; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo usermod --append --groups libvirt,libvirt-qemu karel; fi
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

# Remove kvm from ?
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


# Install lftp on ?
# FTP/HTTP/BitTorrent client.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes lftp; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes lftp; fi

# Remove lftp from ?
# FTP/HTTP/BitTorrent client.
if grep --quiet debian /etc/os-release; then sudo apt-get remove --purge --assume-yes lftp; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes lftp; fi


# Install libreoffice on *
# Office suite.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes aspell-en aspell-nl libreoffice libreoffice-l10n-nl; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf install --assumeyes libreoffice; fi

# Remove libreoffice from *
# Office suite.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes aspell-en aspell-nl libreoffice libreoffice-l10n-nl; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf remove --assumeyes libreoffice; fi


# Install locate on ?
# Find files.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes locate; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes mlocate; fi
sudo updatedb

# Remove locate from ?
# Find files.
if grep --quiet debian /etc/os-release; then sudo apt-get remove --purge --assume-yes locate; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes mlocate; fi


# Install log-access-for-user on ?
# Log access.
sudo usermod --append --groups adm,systemd-journal "${SUDO_USER:-$USER}"

# Remove log-access-for-user from ?
# Log access.
sudo deluser "${SUDO_USER:-$USER}" adm
sudo deluser "${SUDO_USER:-$USER}" systemd-journal


# Install mypy on ?
# Python static typing.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes mypy; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes python3-mypy; fi

# Remove mypy from ?
# Python static typing.
if grep --quiet debian /etc/os-release; then sudo apt-get remove --purge --assume-yes mypy; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes python3-mypy; fi


# Install nautilus-admin on ?
# Administrative operations.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes nautilus-admin; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then echo 'The nautilus-admin app is not available.'; fi

# Remove nautilus-admin from ?
# Administrative operations.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes nautilus-admin; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then echo 'The nautilus-admin app is not available.'; fi


# Install nmap on ?
# Network MAPper.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes nmap; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes nmap; fi

# Remove nmap from ?
# Network MAPper.
if grep --quiet debian /etc/os-release; then sudo apt-get remove --purge --assume-yes nmap; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes nmap; fi


# Install ntfs on ?
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

# Remove ntfs from ?
# NTFS support.
if grep --quiet debian /etc/os-release; then sudo apt-get remove --purge --assume-yes ntfs-3g; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes ntfs-3g ntfsprogs; fi


# Install poedit on ?
# Gettext catalogs editor.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes poedit; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes poedit; fi

# Remove poedit from ?
# Gettext catalogs editor.
if grep --quiet debian /etc/os-release; then sudo apt-get remove --purge --assume-yes poedit; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes poedit; fi


# Install python on ?
# Programming language.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes pycodestyle python3-pycodestyle python3-autopep8 python3-pip python-is-python3; fi
if grep --quiet debian /etc/os-release; then sudo ln --force --relative --symbolic /usr/bin/pycodestyle /usr/bin/pep8; fi
if grep --quiet debian /etc/os-release; then sudo ln --force --relative --symbolic /usr/bin/pip3 /usr/bin/pip; fi

if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes python3 python3-pycodestyle python3-pip; fi

# Remove python from ?
# Programming language.
if grep --quiet debian /etc/os-release; then sudo apt-get remove --purge --assume-yes pycodestyle python3-pycodestyle python3-autopep8 python3-pip python-is-python3; fi
if grep --quiet debian /etc/os-release; then sudo rm --force --verbose /usr/bin/pep8 /usr/bin/pip; fi

if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes python3 python3-pycodestyle python3-pip; fi


# Install rpm on ?
# Package manager.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes rpm; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes rpm; fi

# Remove rpm from ?
# Package manager for RPM.
if grep --quiet debian /etc/os-release; then sudo apt-get remove --purge --assume-yes rpm; fi
if grep --quiet rhel   /etc/os-release; then echo 'The rpm app cannot be removed.'; fi


# Install simplescreenrecorder on ?
# Screen recorder.
# Requires the use of Xorg/X11.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes simplescreenrecorder; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then echo 'The simplescreenrecorder app is not available.'; fi

# Remove simplescreenrecorder from ?
# Screen recorder.
# Required the use of Xorg/X11. Enable Wayland again?
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes simplescreenrecorder; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then echo 'The simplescreenrecorder app is not available.'; fi


# Install shellcheck on ?
# Shell script linter.
# Web app: https://www.shellcheck.net
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes shellcheck; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes shellcheck; fi

# Remove shellcheck from ?
# Shell script linter.
# Web app: https://www.shellcheck.net
if grep --quiet debian /etc/os-release; then sudo apt-get remove --purge --assume-yes shellcheck; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes shellcheck; fi


# Install sound-juicer on ?
# Audio-cd ripper and player.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes sound-juicer; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then echo 'The sound-juicer app is not available.'; fi

# Remove sound-juicer from ?
# Audio-cd ripper and player.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes sound-juicer; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then echo 'The sound-juicer app is not available.'; fi


# Install spice-vdagent on *
# Spice agent.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes spice-vdagent; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes spice-vdagent; fi

# Remove spice-vdagent from *
# Spice agent.
if grep --quiet debian /etc/os-release; then sudo apt-get remove --purge --assume-yes spice-vdagent; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes spice-vdagent; fi


# Install spotify on ?
# Music and podcasts.
# Web app: https://open.spotify.com
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then wget --output-document=- https://download.spotify.com/debian/pubkey_C85668DF69375001.gpg | sudo gpg --dearmor --yes --output=/usr/share/keyrings/spotify.gpg; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/spotify.gpg] https://repository.spotify.com stable non-free' | sudo tee /etc/apt/sources.list.d/spotify.list > /dev/null; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get update; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes spotify-client; fi

if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then echo 'The spotify app is available as a web app.'; fi

# Remove spotify from ?
# Music and podcasts.
# Web app: https://open.spotify.com
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes spotify-client; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo rm --force --verbose /etc/apt/sources.list.d/spotify*.list*; fi

if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then echo 'The spotify web app cannot be removed.'; fi


# Install ssh on ?
# Secure SHell.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes ssh; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes openssh; fi
sudo sed --in-place 's/PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
# Check for remote root access.
grep 'PermitRootLogin no' /etc/ssh/sshd_config
sudo systemctl restart ssh.service

# Remove ssh from ?
# Secure SHell.
sudo sed --in-place 's/PermitRootLogin no/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config
if grep --quiet debian /etc/os-release; then sudo apt-get remove --purge --assume-yes ssh; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes openssh; fi


# Install sushi on ?
# Quick preview.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes gnome-sushi; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf install --assumeyes sushi; fi
# Usage:
# Select a file, press the space bar, and a preview will appear.

# Remove sushi from ?
# Quick preview.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes gnome-sushi; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf remove --assumeyes sushi; fi


# Install tab-completion on *
# Bash completion.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes bash-completion; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes bash-completion; fi

# Remove tab-completion from *
# Bash completion.
if grep --quiet debian /etc/os-release; then sudo apt-get remove --purge --assume-yes bash-completion; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes bash-completion; fi


# Install teamviewer on *
# Remote desktop.
# Web app: https://web.teamviewer.com
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then wget --no-verbose --output-document=/tmp/teamviewer.deb https://download.teamviewer.com/download/linux/teamviewer_amd64.deb; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes /tmp/teamviewer.deb; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then rm --verbose /tmp/teamviewer.deb; fi

# SKIP Error: Failed to download metadata for repo 'teamviewer': repomd.xml GPG
# signature verification error: Bad GPG signature
# if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf install --assumeyes https://download.teamviewer.com/download/linux/teamviewer.x86_64.rpm; fi

# Remove teamviewer from *
# Remote desktop.
# Web app: https://web.teamviewer.com
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes teamviewer; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf remove --assumeyes teamviewer; fi


# Install thunderbird on *
# E-mail and news.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes thunderbird; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf install --assumeyes thunderbird; fi

# Remove thunderbird from *
# E-mail and news.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes thunderbird; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf remove --assumeyes thunderbird; fi


# Install tree on ?
# Display directory tree.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes tree; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes tree; fi

# Remove tree from ?
# Display directory tree.
if grep --quiet debian /etc/os-release; then sudo apt-get remove --purge --assume-yes tree; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes tree; fi


# Install ufw on ?
# Uncomplicated FireWall.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes gufw; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf install --assumeyes gufw; fi
if [[ ${DISPLAY-} ]]; then sudo ufw allow ssh; fi
if [[ ${DISPLAY-} ]]; then sudo ufw enable; fi

# Remove ufw from ?
# Uncomplicated FireWall.
sudo ufw disable
if grep --quiet debian /etc/os-release; then sudo apt-get remove --purge --assume-yes gufw; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes gufw; fi


# Install usbutils on ?
# USB utilities.
# This package contains the lsusb utility.
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes usbutils; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes usbutils; fi

# Remove usbutils from ?
# USB utilities.
# This package contains the lsusb utility.
if grep --quiet debian /etc/os-release; then sudo apt-get remove --purge --assume-yes usbutils; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes usbutils; fi


# Install user-guest on ?
# Add guest user.
if ! id "$(gettext 'guest')" &> /dev/null; then sudo useradd --create-home --shell /usr/bin/bash --comment "$(gettext 'Guest user')" "$(gettext 'guest')"; fi
if   id "$(gettext 'guest')" &> /dev/null; then sudo passwd --delete "$(gettext 'guest')"; fi

# Remove user-guest from ?
# Remove guest user.
if id "$(gettext 'guest')" &> /dev/null; then sudo userdel --remove "$(gettext 'guest')"; fi


# Install virtualbox on ?
# Virtualization.
# VirtualBox Guest user Additions ISO are in '/usr/share/virtualbox/'.
# If the installation hangs or VBox does not work, check the virtualization
# settings in the BIOS/UEFI.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then echo 'virtualbox-ext-pack virtualbox-ext-pack/license select true' | sudo debconf-set-selections; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso; fi

if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf install --assumeyes VirtualBox; fi

# Remove virtualbox from ?
# Virtualization.
# VirtualBox Guest user Additions ISO are in '/usr/share/virtualbox/'.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf remove --assumeyes VirtualBox; fi


# Install vlc on *
# Multimedia player.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes vlc; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf install --assumeyes vlc; fi

# Remove vlc from *
# Multimedia player.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes vlc; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf remove --assumeyes vlc; fi


# Install vscode on ?
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

# Remove vscode from ?
# Editor.
# Web app: https://vscode.dev
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo update-alternatives --remove editor /usr/bin/code; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo rm --force --verbose /etc/apt/sources.list.d/vscode*.list*; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes code; fi

if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf remove --assumeyes code; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo rm --force --verbose /etc/yum.repos.d/vscode.repo*; fi


# Install webmin on ?
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

# Remove webmin from ?
# Web console.
# Web app: https://localhost:10000
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes webmin; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo rm --force --verbose /etc/apt/sources.list.d/webmin*.list*; fi

if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf remove --assumeyes webmin; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo rm --force --verbose /etc/yum.repos.d/webmin.repo*; fi


# Install wine on ?
# Run Windows applications.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dpkg --add-architecture i386; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes wine winetricks playonlinux; fi

if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf install --assumeyes wine playonlinux; fi

# Remove wine from ?
# Run Windows applications.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes wine winetricks playonlinux; fi
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dpkg --remove-architecture i386; fi

if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf remove --assumeyes wine playonlinux; fi


# Install youtube-dl on ?
# Download videos.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get install --assume-yes youtubedl-gui; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf install --assumeyes youtube-dl; fi

# Remove youtube-dl from ?
# Download videos.
if grep --quiet debian /etc/os-release && [[ ${DISPLAY-} ]]; then sudo apt-get remove --purge --assume-yes youtubedl-gui; fi
if grep --quiet rhel   /etc/os-release && [[ ${DISPLAY-} ]]; then sudo dnf remove --assumeyes youtube-dl; fi
