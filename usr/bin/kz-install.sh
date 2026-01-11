# shellcheck shell=bash disable=SC2034
# #############################################################################
# SPDX-FileComment: Installation file for use with kz install
#
# SPDX-FileCopyrightText: Karel Zimmer <info@karelzimmer.nl>
# SPDX-License-Identifier: CC0-1.0
# #############################################################################

# =============================================================================
# Use "man kz install.sh" and "man kz install.sh.gpg" to learn more about the
# format of this file.
# =============================================================================

# INSTALL apt-sources *
# -----------------------------------------------------------------------------
# Add Debian components to package sources and update package lists.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=Debian /etc/os-release && [[ -f /etc/apt/sources.list   ]]; then sudo sed --in-place --expression='s/main non-free-firmware/contrib main non-free non-free-firmware/' /etc/apt/sources.list; fi
if grep --quiet --regexp=Debian /etc/os-release && [[ -f /etc/apt/debian.sources ]]; then sudo sed --in-place --expression='s/main non-free-firmware/contrib main non-free non-free-firmware/' /etc/apt/debian.sources; fi
if grep --quiet --regexp=Debian /etc/os-release; then sudo apt-get update; fi

# REMOVE apt-sources *
# -----------------------------------------------------------------------------
# Remove Debian components from package sources and update package lists.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=Debian /etc/os-release && [[ -f /etc/apt/sources.list   ]]; then sudo sed --in-place --expression='s/contrib main non-free non-free-firmware/main non-free-firmware/' /etc/apt/sources.list; fi
if grep --quiet --regexp=Debian /etc/os-release && [[ -f /etc/apt/debian.sources ]]; then sudo sed --in-place --expression='s/contrib main non-free non-free-firmware/main non-free-firmware/' /etc/apt/debian.sources; fi
if grep --quiet --regexp=Debian /etc/os-release; then sudo apt-get update; fi

# INSTALL updates *
# -----------------------------------------------------------------------------
# Update package lists and upgrade all packages.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get update; fi
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get upgrade --assume-yes; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     check-update || true; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     upgrade --assumeyes --refresh; fi

# REMOVE updates *
# -----------------------------------------------------------------------------
# Update package lists and upgrade all packages.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get update; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     check-update || true; fi

# INSTALL aer-settings #none
# -----------------------------------------------------------------------------
# Disable Advanced Error Reporting.
# -----------------------------------------------------------------------------
# Disable kernel config parameter PCIEAER (Peripheral Component Interconnect
# Express Advanced Error Reporting) prevents the log gets flooded with
# 'AER: Corrected errors received'. This is usually needed for HP hardware.
# -----------------------------------------------------------------------------
if ! grep --quiet --regexp='pci=noaer' /etc/default/grub; then sudo sed --in-place --expression='s/loglevel=3/loglevel=3 pci=noaer/' /etc/default/grub; fi
if ! grep --quiet --regexp='pci=noaer' /etc/default/grub; then sudo sed --in-place --expression='s/quiet/quiet pci=noaer/' /etc/default/grub; fi
if   grep --quiet --regexp=debian      /etc/os-release; then sudo update-grub; fi
if   grep --quiet --regexp=rhel        /etc/os-release; then sudo grub2-mkconfig -o /boot/grub2/grub.cfg; fi
# -----------------------------------------------------------------------------
# Check for kernel config parameter pci=noaer.
# -----------------------------------------------------------------------------
grep --quiet --regexp='pci=noaer' /etc/default/grub
REBOOT=true

# REMOVE aer-settings #none
# -----------------------------------------------------------------------------
# Enable Advanced Error Reporting.
# -----------------------------------------------------------------------------
# Enable kernel config parameter PCIEAER (Peripheral Component Interconnect
# Express Advanced Error Reporting) to "allow" the log gets flooded with
# 'AER: Corrected errors received'. This is usually needed for HP hardware.
# -----------------------------------------------------------------------------
if grep --quiet --regexp='pci=noaer' /etc/default/grub; then sudo sed --in-place --expression='s/ pci=noaer//' /etc/default/grub; fi
if grep --quiet --regexp=debian      /etc/os-release; then sudo update-grub; fi
if grep --quiet --regexp=rhel        /etc/os-release; then sudo grub2-mkconfig -o /boot/grub2/grub.cfg; fi
# -----------------------------------------------------------------------------
# Check for kernel config parameter pci=noaer.
# -----------------------------------------------------------------------------
! grep --quiet --regexp='pci=noaer' /etc/default/grub
REBOOT=true

# INSTALL angryipscan pc06 pc07
# -----------------------------------------------------------------------------
# Fast and friendly network scanner.
# -----------------------------------------------------------------------------
sudo apt-get install    --assume-yes    flatpak
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
sudo flatpak install    --assumeyes     org.angryip.ipscan

# REMOVE angryipscan pc06 pc07
# -----------------------------------------------------------------------------
# Fast and friendly network scanner.
# -----------------------------------------------------------------------------
sudo flatpak uninstall --assumeyes org.angryip.ipscan

# INSTALL ansible pc06 pc07
# -----------------------------------------------------------------------------
# Configuration management, deployment, and task execution.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get install --assume-yes ansible; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     install --assumeyes  ansible; fi

# REMOVE ansible pc06 pc07
# -----------------------------------------------------------------------------
# Configuration management, deployment, and task execution.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get remove --assume-yes ansible; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     remove --assumeyes  ansible; fi

# INSTALL apport-settings #none
# -----------------------------------------------------------------------------
# Disable automatic crash report generation for Ubuntu.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=Ubuntu /etc/os-release; then sudo systemctl stop    apport.service; fi
if grep --quiet --regexp=Ubuntu /etc/os-release; then sudo systemctl disable apport.service; fi
if grep --quiet --regexp=Ubuntu /etc/os-release; then sudo sed --in-place --expression='s/enabled=1/enabled=0/' /etc/default/apport; fi
if grep --quiet --regexp=Ubuntu /etc/os-release; then sudo rm  --force --verbose /var/crash/*; fi

# REMOVE apport-settings #none
# -----------------------------------------------------------------------------
# Enable automatic crash report generation for Ubuntu.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=Ubuntu /etc/os-release; then sudo sed --in-place --expression='s/enabled=0/enabled=1/' /etc/default/apport; fi
if grep --quiet --regexp=Ubuntu /etc/os-release; then sudo systemctl enable --now apport.service; fi

# INSTALL backintime #none
# -----------------------------------------------------------------------------
# Backups/snapshots.
# -----------------------------------------------------------------------------
if (grep --regexp=debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get install --assume-yes backintime-qt; fi
if (grep --regexp=rhel   /etc/os-release && type gnome-session) &> /dev/null; then sudo dnf     install --assumeyes  backintime-qt; fi

# REMOVE backintime #none
# -----------------------------------------------------------------------------
# Backups/snapshots.
# -----------------------------------------------------------------------------
if (grep --regexp=debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get remove --assume-yes backintime-qt; fi
if (grep --regexp=rhel   /etc/os-release && type gnome-session) &> /dev/null; then sudo dnf     remove --assumeyes  backintime-qt; fi

# INSTALL bash-completion pc01 pc06 pc07
# -----------------------------------------------------------------------------
# Tab-completion.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get install --assume-yes bash-completion; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     install --assumeyes  bash-completion; fi

# REMOVE bash-completion pc01 pc06 pc07
# -----------------------------------------------------------------------------
# Tab-completion.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get remove --assume-yes bash-completion; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     remove --assumeyes  bash-completion; fi

# INSTALL bitwarden *
# -----------------------------------------------------------------------------
# Password manager.
# -----------------------------------------------------------------------------
sudo apt-get install    --assume-yes    flatpak
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
sudo flatpak install    --assumeyes     com.bitwarden.desktop
REBOOT=true

# REMOVE bitwarden *
# -----------------------------------------------------------------------------
# Password manager.
# -----------------------------------------------------------------------------
sudo flatpak uninstall --assumeyes com.bitwarden.desktop
REBOOT=true

# INSTALL bleachbit #gpg
# -----------------------------------------------------------------------------
# Delete files.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get install --assume-yes bleachbit; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     install --assumeyes  bleachbit; fi

# REMOVE bleachbit #gpg
# -----------------------------------------------------------------------------
# Delete files.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get remove --assume-yes bleachbit; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     remove --assumeyes  bleachbit; fi

# INSTALL broadcom-sta-dkms pc01 #gpg
# -----------------------------------------------------------------------------
# Enable wifi adapter.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get install --assume-yes linux-headers-generic; fi
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get install --assume-yes broadcom-sta-dkms; fi
REBOOT=true

# REMOVE broadcom-sta-dkms pc01 #gpg
# -----------------------------------------------------------------------------
# Disable wifi adapter.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get remove --assume-yes broadcom-sta-dkms; fi
REBOOT=true

# INSTALL calibre pc06
# -----------------------------------------------------------------------------
# E-book manager.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get install --assume-yes calibre; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo --validate && wget --no-verbose --output-document=- https://download.calibre-ebook.com/linux-installer.sh | sudo sh; fi

# REMOVE calibre pc06
# -----------------------------------------------------------------------------
# E-book manager.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get remove --assume-yes calibre; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo calibre-uninstall; fi

# INSTALL cockpit pc06
# -----------------------------------------------------------------------------
# Web console.
# -----------------------------------------------------------------------------
# Web app: https://localhost:9090
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get install --assume-yes cockpit cockpit-pcp; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     install --assumeyes  cockpit cockpit-pcp; fi

# REMOVE cockpit pc06
# -----------------------------------------------------------------------------
# Web console.
# -----------------------------------------------------------------------------
# Web app: https://localhost:9090
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get remove --assume-yes cockpit; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     remove --assumeyes  cockpit; fi

# INSTALL cups pc06 pc07
# -----------------------------------------------------------------------------
# Common Unix Printing System.
# -----------------------------------------------------------------------------
# Web app: http://localhost:631
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get install --assume-yes cups; fi
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get install --assume-yes libcupsimage2; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     install --assumeyes  cups; fi

# REMOVE cups pc06 pc07
# -----------------------------------------------------------------------------
# Common Unix Printing System.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get remove --assume-yes cups; fi
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get remove --assume-yes libcupsimage2; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     remove --assumeyes  cups; fi

# INSTALL cups-backend-bjnp #gpg
# -----------------------------------------------------------------------------
# Printer backend for Canon BJNP protocol.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get install --assume-yes cups-backend-bjnp; fi

# REMOVE cups-backend-bjnp #gpg
# -----------------------------------------------------------------------------
# Printer backend for Canon BJNP protocol.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get remove --assume-yes cups-backend-bjnp; fi

# INSTALL dash-to-dock *
# -----------------------------------------------------------------------------
# Move the dash out of the overview transforming it in a dock.
# -----------------------------------------------------------------------------
if (grep --regexp=debian /etc/os-release && type gnome-session && ! apt-cache show gnome-shell-extension-ubuntu-dock) &> /dev/null; then sudo apt-get install --assume-yes gnome-shell-extension-dashtodock; fi
if (grep --regexp=debian /etc/os-release && type gnome-session &&   apt-cache show gnome-shell-extension-no-overview) &> /dev/null; then sudo apt-get install --assume-yes gnome-shell-extension-no-overview; fi
if (grep --regexp=rhel   /etc/os-release && type gnome-session &&   dnf list  gnome-shell-extension-dash-to-dock)     &> /dev/null; then sudo dnf     install --assumeyes  gnome-shell-extension-dash-to-dock; fi
if (grep --regexp=rhel   /etc/os-release && type gnome-session &&   dnf list  gnome-shell-extension-no-overview )     &> /dev/null; then sudo dnf     install --assumeyes  gnome-shell-extension-no-overview; fi
REBOOT=true

# REMOVE dash-to-dock *
# -----------------------------------------------------------------------------
# Move the dash out of the overview transforming it in a dock.
# -----------------------------------------------------------------------------
if (grep --regexp=debian /etc/os-release && type gnome-session && ! apt-cache show gnome-shell-extension-ubuntu-dock) &> /dev/null; then sudo apt-get remove --assume-yes gnome-shell-extension-dashtodock; fi
if (grep --regexp=debian /etc/os-release && type gnome-session &&   apt-cache show gnome-shell-extension-no-overview) &> /dev/null; then sudo apt-get remove --assume-yes gnome-shell-extension-no-overview; fi
if (grep --regexp=rhel   /etc/os-release && type gnome-session &&   dnf list  gnome-shell-extension-dash-to-dock)     &> /dev/null; then sudo dnf     remove --assumeyes  gnome-shell-extension-dash-to-dock; fi
if (grep --regexp=rhel   /etc/os-release && type gnome-session &&   dnf list  gnome-shell-extension-no-overview)      &> /dev/null; then sudo dnf     remove --assumeyes  gnome-shell-extension-no-overview; fi
REBOOT=true

# INSTALL dos2unix pc06 pc07
# -----------------------------------------------------------------------------
# Convert text file line endings between CRLF and LF.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get install --assume-yes dos2unix; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     install --assumeyes  dos2unix; fi

# REMOVE dos2unix pc06 pc07
# -----------------------------------------------------------------------------
# Convert text file line endings between CRLF and LF.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get remove --assume-yes dos2unix; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     remove --assumeyes  dos2unix; fi

# INSTALL exiftool pc06 pc07
# -----------------------------------------------------------------------------
# Read and write meta information.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get install --assume-yes libimage-exiftool-perl; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     install --assumeyes  perl-Image-ExifTool; fi

# REMOVE exiftool pc06 pc07
# -----------------------------------------------------------------------------
# Read and write meta information.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get remove --assume-yes libimage-exiftool-perl; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     remove --assumeyes  perl-Image-ExifTool; fi

# INSTALL fakeroot pc06 pc07
# -----------------------------------------------------------------------------
# Simulate superuser privileges.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get install --assume-yes fakeroot; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     install --assumeyes  fakeroot; fi

# REMOVE fakeroot pc06 pc07
# -----------------------------------------------------------------------------
# Simulate superuser privileges.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get remove --assume-yes fakeroot; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     remove --assumeyes  fakeroot; fi

# INSTALL fastfetch pc06 pc07
# -----------------------------------------------------------------------------
# A neofetch like system information tool.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get install --assume-yes fastfetch; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     install --assumeyes  fastfetch; fi

# REMOVE fastfetch pc06 pc07
# -----------------------------------------------------------------------------
# A neofetch like system information tool.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get remove --assume-yes fastfetch; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     remove --assumeyes  fastfetch; fi

# INSTALL fdupes #none
# -----------------------------------------------------------------------------
# Find duplicate files.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get install --assume-yes fdupes; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     install --assumeyes  fdupes; fi
# -----------------------------------------------------------------------------
# Usage:
# $ fdupes -r   /path/to/folder # Report recursively from /path/to/folder
# $ fdupes -rd  /path/to/folder # Delete, interactively, from /path/to/folder
# $ fdupes -rdN /path/to/folder # Delete, from /path/to/folder, keep first dup
# -----------------------------------------------------------------------------

# REMOVE fdupes #none
# -----------------------------------------------------------------------------
# Find duplicate files.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get remove --assume-yes fdupes; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     remove --assumeyes  fdupes; fi

# INSTALL firefox *
# -----------------------------------------------------------------------------
# Web browser (ESR=Extended Support Release).
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release && apt-cache pkgnames | grep --quiet '^firefox$'    ; then sudo apt-get install --assume-yes firefox firefox-l10n-"${LANG:0:2}"; fi
if grep --quiet --regexp=debian /etc/os-release && apt-cache pkgnames | grep --quiet '^firefox-esr$'; then sudo apt-get install --assume-yes firefox-esr firefox-esr-l10n-"${LANG:0:2}"; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf install --assumeyes firefox; fi

# REMOVE firefox *
# -----------------------------------------------------------------------------
# E-mail, calendar, contacts, and task management.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release && apt-cache pkgnames | grep --quiet '^firefox$'    ; then sudo apt-get remove --assume-yes firefox firefox-l10n-"${LANG:0:2}"; fi
if grep --quiet --regexp=debian /etc/os-release && apt-cache pkgnames | grep --quiet '^firefox-esr$'; then sudo apt-get remove --assume-yes firefox-esr firefox-esr-l10n-"${LANG:0:2}"; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf remove --assumeyes firefox; fi

# INSTALL fwupd-settings #none
# -----------------------------------------------------------------------------
# Disable FirmWare UPdate Daemon.
# -----------------------------------------------------------------------------
sudo systemctl stop    fwupd.service
sudo systemctl disable fwupd.service
sudo systemctl mask    fwupd.service

# REMOVE fwupd-settings #none
# -----------------------------------------------------------------------------
# Enable FirmWare UPdate Daemon.
# -----------------------------------------------------------------------------
sudo systemctl unmask fwupd.service
sudo systemctl enable fwupd.service
sudo systemctl start  fwupd.service

# INSTALL gdebi #none
# -----------------------------------------------------------------------------
# View and install deb files.
# -----------------------------------------------------------------------------
if (grep --regexp=debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get install --assume-yes gdebi; fi

# REMOVE gdebi #none
# -----------------------------------------------------------------------------
# View and install deb files.
# -----------------------------------------------------------------------------
if (grep --regexp=debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get remove --assume-yes gdebi; fi

# INSTALL gettext pc06 pc07
# -----------------------------------------------------------------------------
# GNU Internationalization.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get install --assume-yes gettext; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     install --assumeyes  gettext; fi

# REMOVE gettext pc06 pc07
# -----------------------------------------------------------------------------
# GNU Internationalization.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get remove --assume-yes gettext; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     remove --assumeyes  gettext; fi

# INSTALL gimp pc06
# -----------------------------------------------------------------------------
# GNU Image Manipulation Program.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get install --assume-yes gimp gimp-help-en gimp-help-"${LANG:0:2}"; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     install --assumeyes  gimp; fi

# REMOVE gimp pc06
# -----------------------------------------------------------------------------
# GNU Image Manipulation Program.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get remove --assume-yes gimp gimp-help-en gimp-help-"${LANG:0:2}"; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     remove --assumeyes  gimp; fi

# INSTALL git pc06 pc07
# -----------------------------------------------------------------------------
# Distributed revision control system.
# -----------------------------------------------------------------------------
# Web app: https://github.com
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get install --assume-yes git; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     install --assumeyes  git; fi

# REMOVE git pc06 pc07
# -----------------------------------------------------------------------------
# Distributed revision control system.
# -----------------------------------------------------------------------------
# Web app: https://github.com
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get remove --assume-yes git; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     remove --assumeyes  git; fi

# INSTALL gnome-tweaks pc06 pc07
# -----------------------------------------------------------------------------
# Adjust advanced settings.
# -----------------------------------------------------------------------------
if (grep --regexp=debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get install --assume-yes gnome-tweaks; fi
if (grep --regexp=rhel   /etc/os-release && type gnome-session) &> /dev/null; then sudo dnf     install --assumeyes  gnome-tweaks; fi

# REMOVE gnome-tweaks pc06 pc07
# -----------------------------------------------------------------------------
# Adjust advanced settings.
# -----------------------------------------------------------------------------
if (grep --regexp=debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get install --assume-yes gnome-tweaks; fi
if (grep --regexp=rhel   /etc/os-release && type gnome-session) &> /dev/null; then sudo dnf     install --assumeyes  gnome-tweaks; fi

# INSTALL google-chrome *
# -----------------------------------------------------------------------------
# Web browser.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then wget --no-verbose --output-document=/tmp/google-chrome.deb https://dl.google.com/dl/linux/direct/google-chrome-stable_current_amd64.deb; fi
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get install --assume-yes /tmp/google-chrome.deb; fi
if grep --quiet --regexp=debian /etc/os-release; then rm   --verbose /tmp/google-chrome.deb; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo rpm --import https://dl.google.com/linux/linux_signing_key.pub; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf install --assumeyes https://dl.google.com/dl/linux/direct/google-chrome-stable_current_x86_64.rpm; fi

# REMOVE google-chrome *
# -----------------------------------------------------------------------------
# Web browser.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get remove --assume-yes google-chrome-stable; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     remove --assumeyes  google-chrome-stable; fi

# INSTALL google-earth pc04
# -----------------------------------------------------------------------------
# Explore the planet.
# -----------------------------------------------------------------------------
# Web app: https://earth.google.com
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then wget --no-verbose --output-document=/tmp/google-earth.deb https://dl.google.com/dl/linux/direct/google-earth-pro-stable_current_amd64.deb; fi
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get install --assume-yes /tmp/google-earth.deb; fi
if grep --quiet --regexp=debian /etc/os-release; then rm   --verbose /tmp/google-earth.deb; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo rpm --import https://dl.google.com/linux/linux_signing_key.pub; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf install --assumeyes https://dl.google.com/dl/linux/direct/google-earth-pro-stable-current.x86_64.rpm; fi

# REMOVE google-earth pc04
# -----------------------------------------------------------------------------
# Explore the planet.
# -----------------------------------------------------------------------------
# Web app: https://earth.google.com
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get remove --assume-yes google-earth-pro-stable; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     remove --assumeyes  google-earth-pro-stable; fi

# INSTALL groff pc06 pc07
# -----------------------------------------------------------------------------
# Compose manual pages with GNU roff.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get install --assume-yes groff; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     install --assumeyes  groff; fi

# REMOVE groff pc06 pc07
# -----------------------------------------------------------------------------
# Compose manual pages with GNU roff.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get remove --assume-yes groff; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     remove --assumeyes  groff; fi

# INSTALL grub-settings *
# -----------------------------------------------------------------------------
# Reduce GRUB menu display time.
# -----------------------------------------------------------------------------
sudo sed --in-place --expression='s/GRUB_TIMEOUT=.*$/GRUB_TIMEOUT=2/' /etc/default/grub
# -----------------------------------------------------------------------------
# Suppress warnings.
# -----------------------------------------------------------------------------
if ! grep --quiet 'loglevel=3' /etc/default/grub; then sudo sed --in-place --expression='s/quiet/quiet loglevel=3/' /etc/default/grub; fi
if   grep --quiet --regexp=debian /etc/os-release; then sudo update-grub; fi
if   grep --quiet --regexp=rhel   /etc/os-release; then sudo grub2-mkconfig -o /boot/grub2/grub.cfg; fi
REBOOT=true

# REMOVE grub-settings *
# -----------------------------------------------------------------------------
# Restore default GRUB menu display time.
# -----------------------------------------------------------------------------
sudo sed --in-place --expression='s/GRUB_TIMEOUT=.*$/GRUB_TIMEOUT=5/' /etc/default/grub
# -----------------------------------------------------------------------------
# Enable warnings.
# -----------------------------------------------------------------------------
sudo sed  --in-place --expression='s/ loglevel=3//' /etc/default/grub
if grep --quiet --regexp=debian /etc/os-release; then sudo update-grub; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo grub2-mkconfig -o /boot/grub2/grub.cfg; fi
REBOOT=true

# INSTALL handbrake #gpg
# -----------------------------------------------------------------------------
# Video-dvd ripper and transcoder.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get install --assume-yes handbrake; fi

# REMOVE handbrake #gpg
# -----------------------------------------------------------------------------
# Video-dvd ripper and transcoder.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get remove --assume-yes handbrake; fi

# INSTALL htop pc01 pc06 pc07
# -----------------------------------------------------------------------------
# Process viewer.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get install --assume-yes htop; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     install --assumeyes  htop; fi

# REMOVE htop pc01 pc06 pc07
# -----------------------------------------------------------------------------
# Process viewer.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get remove --assume-yes htop; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     remove --assumeyes  htop; fi

# INSTALL imagination pc06 pc07
# -----------------------------------------------------------------------------
# Slideshow maker.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get install --assume-yes imagination; fi

# REMOVE imagination pc06 pc07
# -----------------------------------------------------------------------------
# Slideshow maker.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get remove --assume-yes imagination; fi

# INSTALL jq pc06 pc07
# -----------------------------------------------------------------------------
# JSON processor.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get install --assume-yes jq; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     install --assumeyes  jq; fi

# REMOVE jq pc06 pc07
# -----------------------------------------------------------------------------
# JSON processor.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get remove --assume-yes jq; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     remove --assumeyes  jq; fi

# INSTALL krita pc06
# -----------------------------------------------------------------------------
# Image manipulation.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get install --assume-yes krita; fi

# REMOVE krita pc06
# -----------------------------------------------------------------------------
# Image manipulation.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get remove --assume-yes krita; fi

# INSTALL kvm pc06 pc07
# -----------------------------------------------------------------------------
# Virtualization.
# -----------------------------------------------------------------------------
# Kernel-based Virtual Machine.
# Images are in: /var/lib/libvirt/images/
# Dpkg::Options to prevent interaction while restoring /etc/libvirt
# configuration files.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes --option Dpkg::Options::="--force-confdef" --option Dpkg::Options::="--force-confold" bridge-utils cpu-checker libvirt-clients libvirt-daemon-system qemu-kvm qemu-system virtinst virt-manager; fi
# -----------------------------------------------------------------------------
# Prevent "Error starting domain: Requested operation is not valid: network
# 'default' is not active".
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo virsh --connect=qemu:///system net-autostart default; fi
# -----------------------------------------------------------------------------
# Check network 'default' with
# "sudo virsh --connect=qemu:///system net-info default", should output
# 'Autostart: yes'.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf groupinstall "Virtualization Host"; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo systemctl enable --now libvirtd; fi
# -----------------------------------------------------------------------------
# Prevent "Error starting domain: Requested operation is not valid: network
# 'default' is not active".
# -----------------------------------------------------------------------------
if grep --quiet --regexp=rhel   /etc/os-release; then sudo virsh --connect=qemu:///system net-autostart default; fi
# -----------------------------------------------------------------------------
# Check network 'default' with
# "sudo virsh --connect=qemu:///system net-info default", should output
# 'Autostart: yes'.
# -----------------------------------------------------------------------------
REBOOT=true

# REMOVE kvm pc06 pc07
# -----------------------------------------------------------------------------
# Virtualization.
# -----------------------------------------------------------------------------
# Kernel-based Virtual Machine.
# Images are in: /var/lib/libvirt/images/
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo virsh --connect=qemu:///system net-autostart default --disable; fi
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get remove --assume-yes bridge-utils cpu-checker libvirt-clients libvirt-daemon-system qemu-kvm qemu-system virtinst virt-manager; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo systemctl disable --now libvirtd; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf groupremove "Virtualization Host"; fi
REBOOT=true

# INSTALL lftp pc06 pc07
# -----------------------------------------------------------------------------
# FTP/HTTP/BitTorrent client.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get install --assume-yes lftp; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     install --assumeyes  lftp; fi

# REMOVE lftp pc06 pc07
# -----------------------------------------------------------------------------
# FTP/HTTP/BitTorrent client.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get remove --assume-yes lftp; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     remove --assumeyes  lftp; fi

# INSTALL libreoffice *
# -----------------------------------------------------------------------------
# Office suite.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get install    --assume-yes    libreoffice; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo flatpak install    --assumeyes     app/org.libreoffice.LibreOffice; fi

# REMOVE libreoffice *
# -----------------------------------------------------------------------------
# Office suite.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get remove    --assume-yes libreoffice; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo flatpak uninstall --assumeyes  app/org.libreoffice.LibreOffice; fi

# INSTALL lidswitch-settings #gpg
# -----------------------------------------------------------------------------
# Do nothing when the laptop lid is closed.
# -----------------------------------------------------------------------------
sudo sed --in-place --expression='/^HandleLidSwitch=/d' /etc/systemd/logind.conf
echo 'HandleLidSwitch=ignore' | sudo tee --append /etc/systemd/logind.conf 1> /dev/null

# REMOVE lidswitch-settings #gpg
# -----------------------------------------------------------------------------
# Restore the default action when the laptop lid is closed.
# -----------------------------------------------------------------------------
sudo sed --in-place --expression='/^HandleLidSwitch=/d' /etc/systemd/logind.conf

# INSTALL locate pc06 pc07
# -----------------------------------------------------------------------------
# Find files.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get install --assume-yes locate; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     install --assumeyes  mlocate; fi
sudo updatedb

# REMOVE locate pc06 pc07
# -----------------------------------------------------------------------------
# Find files.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get remove --assume-yes locate; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     remove --assumeyes  mlocate; fi

# INSTALL lshw pc06 pc07
# -----------------------------------------------------------------------------
# Hardware lister.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get install --assume-yes lshw; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     install --assumeyes  lshw; fi

# REMOVE lshw pc06 pc07
# -----------------------------------------------------------------------------
# Hardware lister.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get remove --assume-yes lshw; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     remove --assumeyes  lshw; fi

# INSTALL microsoft-edge *
# -----------------------------------------------------------------------------
# Web browser.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then wget --no-verbose --output-document=- https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor --yes --output=/usr/share/keyrings/microsoft.gpg; fi
if grep --quiet --regexp=debian /etc/os-release; then echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/edge stable main" | sudo tee /etc/apt/sources.list.d/microsoft-edge.list 1> /dev/null; fi
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get update; fi
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get install    --assume-yes    microsoft-edge-stable; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo flatpak install    --assumeyes     flathub com.microsoft.Edge; fi

# REMOVE microsoft-edge *
# -----------------------------------------------------------------------------
# Web browser.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get remove    --assume-yes microsoft-edge-stable; fi
if grep --quiet --regexp=debian /etc/os-release; then sudo rm  --force --verbose /etc/apt/sources.list.d/microsoft-edge.list; fi
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get update; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo flatpak uninstall --assumeyes  flathub com.microsoft.Edge; fi

# INSTALL mint-codecs #none
# -----------------------------------------------------------------------------
# Enhancements for the Linux Mint Cinnamon Desktop Environment.
# -----------------------------------------------------------------------------
if (grep linuxmint /etc/os-release && type cinnamon-session) &> /dev/null; then sudo apt-get install --assume-yes mint-meta-codecs; fi

# REMOVE mint-codecs #none
# -----------------------------------------------------------------------------
# Enhancements for the Linux Mint Cinnamon Desktop Environment.
# -----------------------------------------------------------------------------
if (grep linuxmint /etc/os-release && type cinnamon-session) &> /dev/null; then sudo apt-get remove --assume-yes mint-meta-codecs; fi

# INSTALL nmap pc06 pc07
# -----------------------------------------------------------------------------
# Network MAPper.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get install --assume-yes nmap; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     install --assumeyes  nmap; fi

# REMOVE nmap pc06 pc07
# -----------------------------------------------------------------------------
# Network MAPper.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get remove --assume-yes nmap; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     remove --assumeyes  nmap; fi

# INSTALL ntfs #none
# -----------------------------------------------------------------------------
# NTFS support.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get install --assume-yes ntfs-3g; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     install --assumeyes  ntfs-3g ntfsprogs; fi
# -----------------------------------------------------------------------------
# Usage:
# $ findmnt # or lsblk
# TARGET SOURCE FSTYPE OPTIONS
# /media/... /dev/sda1 ntfs3 rw,nosuid,nodev,relatime,uid=...
#
# $ lsblk   # or findmnt
# NAME MAJ:MIN RM SIZE RO TYPE MOUNTPOINTS
# sda 8:0 0 931,5G 0 disk
# +-sda1 8:1 0 931,5G 0 part /media/...
#
# $ sudo    ntfsfix /dev/sda1 # Fix an NTFS partition
# $ sudo -b ntfsfix /dev/sda1 # Clear the bad sector list
# $ sudo -d ntfsfix /dev/sda1 # Clear the volume dirty flag
# -----------------------------------------------------------------------------

# REMOVE ntfs #none
# -----------------------------------------------------------------------------
# NTFS support.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get remove --assume-yes ntfs-3g; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     remove --assumeyes  ntfs-3g ntfsprogs; fi

# INSTALL ntp *
# -----------------------------------------------------------------------------
# Network Time Protocol (NTP) service.
# -----------------------------------------------------------------------------
if grep --regexp=debian /etc/os-release &> /dev/null; then sudo apt-get install --assume-yes systemd-timesyncd; fi
if grep --regexp=rhel   /etc/os-release &> /dev/null; then sudo dnf     install --assumeyes  systemd-timesyncd; fi

# REMOVE ntp *
# -----------------------------------------------------------------------------
# Network Time Protocol (NTP) service.
# -----------------------------------------------------------------------------
if grep --regexp=debian /etc/os-release &> /dev/null; then sudo apt-get remove --assume-yes systemd-timesyncd; fi
if grep --regexp=rhel   /etc/os-release &> /dev/null; then sudo dnf     remove --assumeyes  systemd-timesyncd; fi

# INSTALL poedit pc06 pc07
# -----------------------------------------------------------------------------
# Gettext catalogs editor.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get install --assume-yes poedit; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     install --assumeyes  poedit; fi

# REMOVE poedit pc06 pc07
# -----------------------------------------------------------------------------
# Gettext catalogs editor.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get remove --assume-yes poedit; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     remove --assumeyes  poedit; fi

# INSTALL pst-utils pc06 pc07
# -----------------------------------------------------------------------------
# Tools based on libpst to read data from Microsoft Outlook PST files.
# -----------------------------------------------------------------------------
# - readpst - export data from PST files to a variety of formats, including
#   mbox, MH and KMail. Other packages like mb2md are available for subsequent
#   conversions to Maildir and other formats.
# - lspst - list data in PST files.
# - pst2ldif - extract contacts from a PST file and prepare them for input in
#   LDAP
# - pst2dii - export data from PST files to Summation dii load file format
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get install --assume-yes pst-utils; fi
if grep --quiet --regexp=rhel   /etc/os-release; then echo 'Download pst-utils.rpm from https://www.rpmfind.net/ and install with "sudo dnf install ./pst-utils-0.5.2-6.x86_64.rpm".'; fi

# REMOVE pst-utils pc06 pc07
# -----------------------------------------------------------------------------
# Tools based on libpst to read data from Microsoft Outlook PST files.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get remove --assume-yes pst-utils; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     remove --assumeyes  pst-utils; fi

# INSTALL python pc06 pc07
# -----------------------------------------------------------------------------
# Programming language.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get install --assume-yes python3 mypy pycodestyle python3-autopep8 python3-pip python-is-python3; fi
if grep --quiet --regexp=debian /etc/os-release; then sudo ln --force --relative --symbolic /usr/bin/pycodestyle /usr/bin/pep8; fi
if grep --quiet --regexp=debian /etc/os-release; then sudo ln --force --relative --symbolic /usr/bin/pip3 /usr/bin/pip; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     install --assumeyes  python3 python3-mypy pycodestyle python3-pip; fi

# REMOVE python pc06 pc07
# -----------------------------------------------------------------------------
# Programming language.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get remove --assume-yes python mypy pycodestyle python3-autopep8 python3-pip python-is-python3; fi
if grep --quiet --regexp=debian /etc/os-release; then sudo rm     --force --verbose /usr/bin/pep8 /usr/bin/pip; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     remove --assumeyes  python3 python3-mypy pycodestyle python3-pip; fi

# INSTALL rpm pc06 pc07
# -----------------------------------------------------------------------------
# Package manager.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get install --assume-yes rpm; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     install --assumeyes  rpm; fi

# REMOVE rpm pc06 pc07
# -----------------------------------------------------------------------------
# Package manager.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get remove --assume-yes rpm; fi

# INSTALL shellcheck pc06 pc07
# -----------------------------------------------------------------------------
# Shell script linter.
# -----------------------------------------------------------------------------
# Web app: https://www.shellcheck.net
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get install --assume-yes shellcheck; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     install --assumeyes  shellcheck; fi

# REMOVE shellcheck pc06 pc07
# -----------------------------------------------------------------------------
# Shell script linter.
# -----------------------------------------------------------------------------
# Web app: https://www.shellcheck.net
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get remove --assume-yes shellcheck; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     remove --assumeyes  shellcheck; fi

# INSTALL simplescreenrecorder #none
# -----------------------------------------------------------------------------
# Screen recorder.
# -----------------------------------------------------------------------------
# Requires the use of Xorg/X11.
# -----------------------------------------------------------------------------
if (grep --regexp=debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get install --assume-yes simplescreenrecorder; fi

# REMOVE simplescreenrecorder #none
# -----------------------------------------------------------------------------
# Screen recorder.
# -----------------------------------------------------------------------------
# Required the use of Xorg/X11. Enable Wayland again?
# -----------------------------------------------------------------------------
if (grep --regexp=debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get remove --assume-yes simplescreenrecorder; fi

# INSTALL sound-juicer #gpg
# -----------------------------------------------------------------------------
# Audio-cd ripper and player.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get install --assume-yes sound-juicer; fi

# REMOVE sound-juicer #gpg
# -----------------------------------------------------------------------------
# Audio-cd ripper and player.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get remove --assume-yes sound-juicer; fi

# INSTALL spice-vdagent pc06 pc07
# -----------------------------------------------------------------------------
# Enhancements for virtualized guest systems.
# -----------------------------------------------------------------------------
# Spice (Simple Protocol for Independent Computing Environments) agent for
# virtualized guest systems.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get install --assume-yes spice-vdagent; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     install --assumeyes  spice-vdagent; fi

# REMOVE spice-vdagent pc06 pc07
# -----------------------------------------------------------------------------
# Enhancements for virtualized guest systems.
# -----------------------------------------------------------------------------
# Spice (Simple Protocol for Independent Computing Environments) agent for
# virtualized guest systems.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get remove --assume-yes spice-vdagent; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     remove --assumeyes  spice-vdagent; fi

# INSTALL spotify *
# -----------------------------------------------------------------------------
# Music and podcasts.
# -----------------------------------------------------------------------------
# Web app: https://open.spotify.com
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then wget --no-verbose --output-document=- https://download.spotify.com/debian/pubkey_C85668DF69375001.gpg | sudo gpg --dearmor --yes --output=/usr/share/keyrings/spotify.gpg; fi
if grep --quiet --regexp=debian /etc/os-release; then echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/spotify.gpg] https://repository.spotify.com stable non-free' | sudo tee /etc/apt/sources.list.d/spotify.list 1> /dev/null; fi
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get update; fi
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get install --assume-yes spotify-client; fi
if grep --quiet --regexp=rhel   /etc/os-release; then echo 'The spotify app is available as a web app.'; fi

# REMOVE spotify *
# -----------------------------------------------------------------------------
# Music and podcasts.
# -----------------------------------------------------------------------------
# Web app: https://open.spotify.com
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get remove --assume-yes spotify-client; fi
if grep --quiet --regexp=debian /etc/os-release; then sudo rm  --force --verbose /usr/share/keyrings/spotify.gpg /etc/apt/sources.list.d/spotify.list /etc/apt/sources.list.d/spotify.sources; fi
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get update; fi

# INSTALL ssh pc01 pc06 pc07 #gpg
# -----------------------------------------------------------------------------
# Secure SHell.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get install --assume-yes ssh; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     install --assumeyes  openssh; fi
sudo sed --in-place --expression='s/PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
# -----------------------------------------------------------------------------
# Check for remote root access.
# -----------------------------------------------------------------------------
grep 'PermitRootLogin no' /etc/ssh/sshd_config
sudo systemctl restart ssh.service

# REMOVE ssh pc01 pc06 pc07 #gpg
# -----------------------------------------------------------------------------
# Secure SHell.
# -----------------------------------------------------------------------------
sudo sed --in-place --expression='s/PermitRootLogin no/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get remove --assume-yes ssh; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     remove --assumeyes  openssh; fi

# INSTALL sushi #none
# -----------------------------------------------------------------------------
# Quick preview.
# -----------------------------------------------------------------------------
if (grep --regexp=debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get install --assume-yes gnome-sushi; fi
if (grep --regexp=rhel   /etc/os-release && type gnome-session) &> /dev/null; then sudo dnf     install --assumeyes  sushi; fi
# -----------------------------------------------------------------------------
# Usage:
# Select a file, press the space bar, and a preview will appear.
# -----------------------------------------------------------------------------

# REMOVE sushi #none
# -----------------------------------------------------------------------------
# Quick preview.
# -----------------------------------------------------------------------------
if (grep --regexp=debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get remove --assume-yes gnome-sushi; fi
if (grep --regexp=rhel   /etc/os-release && type gnome-session) &> /dev/null; then sudo dnf     remove --assumeyes  sushi; fi

# INSTALL teamviewer *
# -----------------------------------------------------------------------------
# Remote desktop.
# -----------------------------------------------------------------------------
# Web app: https://start.teamviewer.com
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then wget --no-verbose --output-document=/tmp/teamviewer.deb https://download.teamviewer.com/download/linux/teamviewer_amd64.deb; fi
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get install --assume-yes /tmp/teamviewer.deb; fi
if grep --quiet --regexp=debian /etc/os-release; then rm   --verbose /tmp/teamviewer.deb; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf install --assumeyes https://download.teamviewer.com/download/linux/teamviewer.x86_64.rpm; fi

# REMOVE teamviewer *
# -----------------------------------------------------------------------------
# Remote desktop.
# -----------------------------------------------------------------------------
# Web app: https://start.teamviewer.com
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get remove --assume-yes teamviewer; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     remove --assumeyes  teamviewer; fi

# INSTALL tree pc01 pc06 pc07
# -----------------------------------------------------------------------------
# Display directory tree.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get install --assume-yes tree; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     install --assumeyes  tree; fi

# REMOVE tree pc01 pc06 pc07
# -----------------------------------------------------------------------------
# Display directory tree.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get remove --assume-yes tree; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     remove --assumeyes  tree; fi

# INSTALL thunderbird *
# -----------------------------------------------------------------------------
# E-mail, calendar, contacts, and task management.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get install --assume-yes thunderbird thunderbird-l10n-"${LANG:0:2}"; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     install --assumeyes  thunderbird; fi

# REMOVE thunderbird *
# -----------------------------------------------------------------------------
# E-mail, calendar, contacts, and task management.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get remove --assume-yes thunderbird thunderbird-l10n-"${LANG:0:2}"; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     remove --assumeyes  thunderbird; fi

# INSTALL transmission pc01 pc06 pc07
# -----------------------------------------------------------------------------
# BitTorrent client.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get install --assume-yes transmission; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     install --assumeyes  transmission; fi

# REMOVE transmission pc01 pc06 pc07
# -----------------------------------------------------------------------------
# BitTorrent client.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get remove --assume-yes transmission; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     remove --assumeyes  transmission; fi

# INSTALL ufw pc01 pc06 pc07
# -----------------------------------------------------------------------------
# Uncomplicated FireWall.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get install --assume-yes gufw; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     install --assumeyes  gufw; fi
sudo ufw allow ssh
sudo ufw enable

# REMOVE ufw pc01 pc06 pc07
# -----------------------------------------------------------------------------
# Uncomplicated FireWall.
# -----------------------------------------------------------------------------
sudo ufw disable
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get remove --assume-yes gufw; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     remove --assumeyes  gufw; fi

# INSTALL usbutils pc06 pc07
# -----------------------------------------------------------------------------
# USB utilities.
# -----------------------------------------------------------------------------
# This package contains the lsusb utility.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get install --assume-yes usbutils; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     install --assumeyes  usbutils; fi

# REMOVE usbutils pc06 pc07
# -----------------------------------------------------------------------------
# USB utilities.
# -----------------------------------------------------------------------------
# This package contains the lsusb utility.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get remove --assume-yes usbutils; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     remove --assumeyes  usbutils; fi

# INSTALL user-greeter *
# -----------------------------------------------------------------------------
# Enable user greeter.
# -----------------------------------------------------------------------------
if [[ -f /etc/lightdm/lightdm.conf ]]; then sudo sed --in-place --expression='s/.*greeter-hide-users=.*$/greeter-hide-users=false/' /etc/lightdm/lightdm.conf; fi
REBOOT=true

# REMOVE user-greeter *
# -----------------------------------------------------------------------------
# Disable user greeter.
# -----------------------------------------------------------------------------
if [[ -f /etc/lightdm/lightdm.conf ]]; then sudo sed --in-place --expression='s/.*greeter-hide-users=.*$/greeter-hide-users=true/' /etc/lightdm/lightdm.conf; fi
REBOOT=true

# INSTALL user-guest pc01 pc06 pc07
# -----------------------------------------------------------------------------
# Add guest user.
# -----------------------------------------------------------------------------
if ! id "$(TEXTDOMAIN=kz gettext 'guest')" &> /dev/null; then sudo useradd --create-home --shell /usr/bin/bash --comment "$(TEXTDOMAIN=kz gettext 'Guest_user')" "$(TEXTDOMAIN=kz gettext 'guest')"; fi
if   id "$(TEXTDOMAIN=kz gettext 'guest')" &> /dev/null; then sudo passwd  --delete "$(TEXTDOMAIN=kz gettext 'guest')"; fi

# REMOVE user-guest pc01 pc06 pc07
# -----------------------------------------------------------------------------
# Delete guest user.
# -----------------------------------------------------------------------------
if id "$(TEXTDOMAIN=kz gettext 'guest')" &> /dev/null; then sudo userdel --remove "$(TEXTDOMAIN=kz gettext 'guest')"; fi

# INSTALL virtualbox #gpg
# -----------------------------------------------------------------------------
# Virtualization.
# -----------------------------------------------------------------------------
# VirtualBox Guest user Additions ISO are in '/usr/share/virtualbox/'.
# If the installation hangs or VBox does not work, check the virtualization
# settings in the BIOS/UEFI.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then echo 'virtualbox-ext-pack virtualbox-ext-pack/license select true' | sudo debconf-set-selections; fi
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get install --assume-yes virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     install --assumeyes  VirtualBox; fi

# REMOVE virtualbox #gpg
# -----------------------------------------------------------------------------
# Virtualization.
# -----------------------------------------------------------------------------
# VirtualBox Guest user Additions ISO are in '/usr/share/virtualbox/'.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get remove --assume-yes virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     remove --assumeyes  VirtualBox; fi

# INSTALL vlc *
# -----------------------------------------------------------------------------
# Multimedia player.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get install --assume-yes vlc; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     install --assumeyes  vlc; fi
# -----------------------------------------------------------------------------
# Ffmpeg - multimedia support.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get install --assume-yes ffmpeg*; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     install --assumeyes  ffmpeg*; fi

# REMOVE vlc *
# -----------------------------------------------------------------------------
# Multimedia player.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get remove --assume-yes vlc; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     remove --assumeyes  vlc; fi
# -----------------------------------------------------------------------------
# Ffmpeg - multimedia support.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get remove --assume-yes ffmpeg*; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     remove --assumeyes  ffmpeg*; fi

# INSTALL vscode pc06 pc07
# -----------------------------------------------------------------------------
# Editor.
# -----------------------------------------------------------------------------
# Web app: https://vscode.dev
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then echo "code code/add-microsoft-repo boolean true" | sudo debconf-set-selections; fi
if grep --quiet --regexp=debian /etc/os-release; then wget --no-verbose --output-document=- https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor --yes --output=/usr/share/keyrings/microsoft.gpg; fi
if grep --quiet --regexp=debian /etc/os-release; then echo -e 'Types: deb\nURIs: https://packages.microsoft.com/repos/code\nSuites: stable\nComponents: main\nArchitectures: amd64,arm64,armhf\nSigned-By: /usr/share/keyrings/microsoft.gpg' |sudo tee /etc/apt/sources.list.d/vscode.sources 1> /dev/null; fi
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get install --assume-yes apt-transport-https; fi
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get update; fi
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get install --assume-yes code; fi
if grep --quiet --regexp=debian /etc/os-release; then sudo update-alternatives --set editor /usr/bin/code; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc; fi
if grep --quiet --regexp=rhel   /etc/os-release; then echo -e '[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc' | sudo tee /etc/yum.repos.d/vscode.repo 1> /dev/null; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf install --assumeyes code; fi

# REMOVE vscode pc06 pc07
# -----------------------------------------------------------------------------
# Editor.
# -----------------------------------------------------------------------------
# Web app: https://vscode.dev
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo update-alternatives --remove editor /usr/bin/code; fi
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get remove --assume-yes code; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     remove --assumeyes  code; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo rm      --force --verbose /etc/yum.repos.d/vscode.repo; fi

# INSTALL webmin pc07
# -----------------------------------------------------------------------------
# Web console.
# -----------------------------------------------------------------------------
# Web app: https://localhost:10000
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then wget --no-verbose --output-document=/tmp/setup-repos.sh https://raw.githubusercontent.com/webmin/webmin/master/setup-repos.sh; fi
if grep --quiet --regexp=debian /etc/os-release; then sudo sh /tmp/setup-repos.sh --force; fi
if grep --quiet --regexp=debian /etc/os-release; then sudo rm  --force --verbose /tmp/setup-repos.sh; fi
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get install --assume-yes webmin; fi
if grep --quiet --regexp=rhel   /etc/os-release; then wget --no-verbose --output-document=/tmp/setup-repos.sh https://raw.githubusercontent.com/webmin/webmin/master/setup-repos.sh; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo sh /tmp/setup-repos.sh --force; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo rm  --force --verbose /tmp/setup-repos.sh; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf install --assumeyes webmin; fi

# REMOVE webmin pc07
# -----------------------------------------------------------------------------
# Web console.
# -----------------------------------------------------------------------------
# Web app: https://localhost:10000
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get remove --assume-yes webmin; fi
if grep --quiet --regexp=debian /etc/os-release; then sudo rm  --force --verbose /usr/share/keyrings/*webmin*.gpg /etc/apt/sources.list.d/webmin*.list /etc/apt/sources.list.d/webmin*.sources; fi
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get update; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf remove --assumeyes webmin; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo rm  --force --verbose /etc/yum.repos.d/webmin.repo; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf update; fi

# INSTALL wine #none
# -----------------------------------------------------------------------------
# Run Windows applications.
# -----------------------------------------------------------------------------
if (grep --regexp=debian /etc/os-release && type gnome-session) &> /dev/null; then sudo dpkg --add-architecture i386; fi
if (grep --regexp=debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get install --assume-yes wine winetricks playonlinux; fi
if (grep --regexp=rhel   /etc/os-release && type gnome-session) &> /dev/null; then sudo dnf install --assumeyes wine playonlinux; fi

# REMOVE wine #none
# -----------------------------------------------------------------------------
# Run Windows applications.
# -----------------------------------------------------------------------------
if (grep --regexp=debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get remove --assume-yes wine winetricks playonlinux; fi
if (grep --regexp=debian /etc/os-release && type gnome-session) &> /dev/null; then sudo dpkg --remove-architecture i386; fi
if (grep --regexp=rhel   /etc/os-release && type gnome-session) &> /dev/null; then sudo dnf remove --assumeyes wine playonlinux; fi

# INSTALL youtube-dl #gpg
# -----------------------------------------------------------------------------
# Download videos.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get install --assume-yes youtubedl-gui; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     install --assumeyes  youtube-dl; fi

# REMOVE youtube-dl #gpg
# -----------------------------------------------------------------------------
# Download videos.
# -----------------------------------------------------------------------------
if grep --quiet --regexp=debian /etc/os-release; then sudo apt-get remove --assume-yes youtubedl-gui; fi
if grep --quiet --regexp=rhel   /etc/os-release; then sudo dnf     remove --assumeyes  youtube-dl; fi
