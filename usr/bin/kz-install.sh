# shellcheck shell=bash disable=SC2034
# #############################################################################
# SPDX-FileComment: Install file for use with kz-install script
#
# SPDX-FileCopyrightText: Karel Zimmer <info@karelzimmer.nl>
# SPDX-License-Identifier: CC0-1.0
# #############################################################################

# =============================================================================
# Use "man kz install.sh" to learn more about the format of this file.
# =============================================================================

# INSTALL components *
# -----------------------------------------------------------------------------
# Add Debian components to package sources & update package lists for all.
# -----------------------------------------------------------------------------
if grep --quiet Debian /etc/os-release && [[ -e /etc/apt/sources.list   ]]; then sudo sed --in-place 's/main non-free-firmware/contrib main non-free non-free-firmware/' /etc/apt/sources.list; fi
if grep --quiet Debian /etc/os-release && [[ -e /etc/apt/debian.sources ]]; then sudo sed --in-place 's/main non-free-firmware/contrib main non-free non-free-firmware/' /etc/apt/debian.sources; fi
if grep --quiet debian /etc/os-release; then sudo apt-get update; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     check-update || true; fi

# REMOVE components *
# -----------------------------------------------------------------------------
# Remove Debian components package sources & update package lists for all.
# -----------------------------------------------------------------------------
if grep --quiet Debian /etc/os-release && [[ -e /etc/apt/sources.list   ]]; then sudo sed --in-place 's/contrib main non-free non-free-firmware/main non-free-firmware/' /etc/apt/sources.list; fi
if grep --quiet Debian /etc/os-release && [[ -e /etc/apt/debian.sources ]]; then sudo sed --in-place 's/contrib main non-free non-free-firmware/main non-free-firmware/' /etc/apt/debian.sources; fi
if grep --quiet debian /etc/os-release; then sudo apt-get update; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     check-update || true; fi

# INSTALL backintime #none
# -----------------------------------------------------------------------------
# Backups/snapshots.
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get install --assume-yes backintime-qt; fi
if (grep rhel   /etc/os-release && type gnome-session) &> /dev/null; then sudo dnf     install --assumeyes  backintime-qt; fi

# REMOVE backintime #none
# -----------------------------------------------------------------------------
# Backups/snapshots.
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get remove --assume-yes backintime-qt; fi
if (grep rhel   /etc/os-release && type gnome-session) &> /dev/null; then sudo dnf     remove --assumeyes  backintime-qt; fi

# INSTALL bleachbit #none #gpg
# -----------------------------------------------------------------------------
# Delete files.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes bleachbit; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     install --assumeyes  bleachbit; fi

# REMOVE bleachbit #none #gpg
# -----------------------------------------------------------------------------
# Delete files.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes bleachbit; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     remove --assumeyes  bleachbit; fi

# INSTALL broadcom-sta-dkms pc01
# -----------------------------------------------------------------------------
# Enable wifi adapter.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes linux-headers-generic; fi
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes broadcom-sta-dkms; fi
REBOOT=true

# REMOVE broadcom-sta-dkms pc01
# -----------------------------------------------------------------------------
# Disable wifi adapter.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes broadcom-sta-dkms; fi
REBOOT=true

# INSTALL calibre pc06
# -----------------------------------------------------------------------------
# E-book manager.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes calibre; fi
if grep --quiet rhel   /etc/os-release; then sudo --validate && wget --no-verbose --output-document=- https://download.calibre-ebook.com/linux-installer.sh | sudo sh; fi

# REMOVE calibre pc06
# -----------------------------------------------------------------------------
# E-book manager.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes calibre; fi
if grep --quiet rhel   /etc/os-release; then sudo calibre-uninstall; fi

# INSTALL cockpit pc06
# -----------------------------------------------------------------------------
# Web console.
# -----------------------------------------------------------------------------
# Web app: https://localhost:9090
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes cockpit cockpit-pcp; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     install --assumeyes  cockpit cockpit-pcp; fi

# REMOVE cockpit pc06
# -----------------------------------------------------------------------------
# Web console.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes cockpit; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     remove --assumeyes  cockpit; fi

# INSTALL cups #none
# -----------------------------------------------------------------------------
# Common Unix Printing System.
# -----------------------------------------------------------------------------
# Web app: http://localhost:631
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes cups; fi
if grep --quiet rhel /etc/os-release  ; then sudo dnf     install --assumeyes  cups; fi

# REMOVE cups #none
# -----------------------------------------------------------------------------
# Common Unix Printing System.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes cups; fi
if grep --quiet rhel /etc/os-release  ; then sudo dnf     remove --assumeyes  cups; fi

# INSTALL cups-backend-bjnp #none #gpg
# -----------------------------------------------------------------------------
# Printer backend.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes cups-backend-bjnp; fi

# REMOVE cups-backend-bjnp #none #gpg
# -----------------------------------------------------------------------------
# Printer backend.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes cups-backend-bjnp; fi

# INSTALL desktop *
# -----------------------------------------------------------------------------
# Cinnamon - desktop environment.
# -----------------------------------------------------------------------------
if (type cinnamon-session && grep debian /etc/os-release) &> /dev/null && [[ -f /etc/lightdm/lightdm.conf ]]; then sudo sed --in-place 's/greeter-hide-users=true/greeter-hide-users=false/' /etc/lightdm/lightdm.conf; fi
# -----------------------------------------------------------------------------
# GNOME Dash-to-dock - desktop dock like Ubuntu's dash.
# -----------------------------------------------------------------------------
if (type gnome-session && grep debian /etc/os-release && ! apt-cache show gnome-shell-extension-ubuntu-dock) &> /dev/null; then sudo apt-get install --assume-yes gnome-shell-extension-dashtodock; fi
if (type gnome-session && grep debian /etc/os-release &&   apt-cache show gnome-shell-extension-no-overview) &> /dev/null; then sudo apt-get install --assume-yes gnome-shell-extension-no-overview; fi
if (type gnome-session && grep rhel   /etc/os-release &&   dnf list  gnome-shell-extension-dash-to-dock)     &> /dev/null; then sudo dnf     install --assumeyes  gnome-shell-extension-dash-to-dock; fi
if (type gnome-session && grep rhel   /etc/os-release &&   dnf list  gnome-shell-extension-no-overview )     &> /dev/null; then sudo dnf     install --assumeyes  gnome-shell-extension-no-overview; fi
# -----------------------------------------------------------------------------
# GNOME Gdebi - view and install deb files.
# -----------------------------------------------------------------------------
if (type gnome-session && grep debian /etc/os-release) &> /dev/null; then sudo apt-get install --assume-yes gdebi; fi
# -----------------------------------------------------------------------------
# GNOME Nautilus-admin - administrative operations.
# -----------------------------------------------------------------------------
if (type gnome-session && grep debian /etc/os-release) &> /dev/null; then sudo apt-get install --assume-yes nautilus-admin; fi
# -----------------------------------------------------------------------------
# GNOME Sushi - quick preview.
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get install --assume-yes gnome-sushi; fi
if (grep rhel   /etc/os-release && type gnome-session) &> /dev/null; then sudo dnf     install --assumeyes  sushi; fi
# -----------------------------------------------------------------------------
# Usage:
# Select a file, press the space bar, and a preview will appear.
# -----------------------------------------------------------------------------
# GNOME Tweaks - adjust advanced settings.
# -----------------------------------------------------------------------------
if (type gnome-session && grep debian /etc/os-release) &> /dev/null; then sudo apt-get install --assume-yes gnome-tweaks; fi
if (type gnome-session && grep rhel   /etc/os-release) &> /dev/null; then sudo dnf     install --assumeyes  gnome-tweaks; fi
# -----------------------------------------------------------------------------
# Mint Codecs - enhancements for the Linux Mint Cinnamon Desktop Environment.
# -----------------------------------------------------------------------------
if (grep linuxmint /etc/os-release && type cinnamon-session) &> /dev/null; then sudo apt-get install --assume-yes mint-meta-codecs; fi
# -----------------------------------------------------------------------------
# Xfce4 Goodies - enhancements for the Xfce Desktop Environment.
# -----------------------------------------------------------------------------
if (type xfce4-session && grep debian /etc/os-release) &> /dev/null; then sudo apt-get install --assume-yes xfce4-goodies; fi
if (type xfce4-session && grep rhel   /etc/os-release) &> /dev/null; then sudo dnf     install --assumeyes  xfce4-goodies; fi
if type xfce4-session &> /dev/null; then sudo sed --in-place '/^greeter-hide-users=false/d'         /etc/lightdm/lightdm.conf; fi
if type xfce4-session &> /dev/null; then sudo sed --in-place '/^greeter-show-manual-login=false/d'  /etc/lightdm/lightdm.conf; fi
if type xfce4-session &> /dev/null; then sudo sed --in-place "/^user-session=${SUDO_USER:-$USER}/d" /etc/lightdm/lightdm.conf; fi
if type xfce4-session &> /dev/null; then sudo sed --in-place '4agreeter-hide-users=false'           /etc/lightdm/lightdm.conf; fi
if type xfce4-session &> /dev/null; then sudo sed --in-place '5agreeter-show-manual-login=false'    /etc/lightdm/lightdm.conf; fi
if type xfce4-session &> /dev/null; then sudo sed --in-place "6auser-session=${SUDO_USER:-$USER}"   /etc/lightdm/lightdm.conf; fi
REBOOT=true

# REMOVE desktop *
# -----------------------------------------------------------------------------
# Cinnamon - desktop environment.
# -----------------------------------------------------------------------------
if (type cinnamon-session && grep debian /etc/os-release) &> /dev/null && [[ -f /etc/lightdm/lightdm.conf ]]; then sudo sed --in-place 's/greeter-hide-users=false/greeter-hide-users=true/' /etc/lightdm/lightdm.conf; fi
# -----------------------------------------------------------------------------
# GNOME Dash-to-dock - desktop dock like Ubuntu's dash.
# -----------------------------------------------------------------------------
if (type gnome-session && grep debian /etc/os-release && ! apt-cache show gnome-shell-extension-ubuntu-dock) &> /dev/null; then sudo apt-get remove --assume-yes gnome-shell-extension-dashtodock; fi
if (type gnome-session && grep debian /etc/os-release &&   apt-cache show gnome-shell-extension-no-overview) &> /dev/null; then sudo apt-get remove --assume-yes gnome-shell-extension-no-overview; fi
if (type gnome-session && grep rhel   /etc/os-release &&   dnf list  gnome-shell-extension-dash-to-dock)     &> /dev/null; then sudo dnf     remove --assumeyes  gnome-shell-extension-dash-to-dock; fi
if (type gnome-session && grep rhel   /etc/os-release &&   dnf list  gnome-shell-extension-no-overview)      &> /dev/null; then sudo dnf     remove --assumeyes  gnome-shell-extension-no-overview; fi
# -----------------------------------------------------------------------------
# GNOME Gdebi - view and install deb files.
# -----------------------------------------------------------------------------
if (type gnome-session && grep debian /etc/os-release) &> /dev/null; then sudo apt-get remove --assume-yes gdebi; fi
# -----------------------------------------------------------------------------
# GNOME Nautilus-admin - administrative operations.
# -----------------------------------------------------------------------------
if (type gnome-session && grep debian /etc/os-release) &> /dev/null; then sudo apt-get remove --assume-yes nautilus-admin; fi
# -----------------------------------------------------------------------------
# GNOME Sushi - quick preview.
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get remove --assume-yes gnome-sushi; fi
if (grep rhel   /etc/os-release && type gnome-session) &> /dev/null; then sudo dnf     remove --assumeyes  sushi; fi
# -----------------------------------------------------------------------------
# GNOME Tweaks - adjust advanced settings.
# -----------------------------------------------------------------------------
if (type gnome-session && grep debian /etc/os-release) &> /dev/null; then sudo apt-get install --assume-yes gnome-tweaks; fi
if (type gnome-session && grep rhel   /etc/os-release) &> /dev/null; then sudo dnf     install --assumeyes  gnome-tweaks; fi
# -----------------------------------------------------------------------------
# Mint Codecs - enhancements for the Linux Mint Cinnamon Desktop Environment.
# -----------------------------------------------------------------------------
if (grep linuxmint /etc/os-release && type cinnamon-session) &> /dev/null; then sudo apt-get remove --assume-yes mint-meta-codecs; fi
# -----------------------------------------------------------------------------
# Xfce4 Goodies - enhancements for the Xfce Desktop Environment.
# -----------------------------------------------------------------------------
if (type xfce4-session && grep debian /etc/os-release) &> /dev/null; then sudo apt-get remove --assume-yes xfce4-goodies; fi
if (type xfce4-session && grep rhel   /etc/os-release) &> /dev/null; then sudo dnf     remove --assumeyes  xfce4-goodies; fi
if type xfce4-session &> /dev/null; then sudo sed --in-place '/^greeter-hide-users=false/d'         /etc/lightdm/lightdm.conf; fi
if type xfce4-session &> /dev/null; then sudo sed --in-place '/^greeter-show-manual-login=false/d'  /etc/lightdm/lightdm.conf; fi
if type xfce4-session &> /dev/null; then sudo sed --in-place "/^user-session=${SUDO_USER:-$USER}/d" /etc/lightdm/lightdm.conf; fi
REBOOT=true

# INSTALL development pc06 pc07
# -----------------------------------------------------------------------------
# Ansible - configuration management, deployment, and task execution.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes ansible; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     install --assumeyes  ansible; fi
# -----------------------------------------------------------------------------
# Fakeroot - simulate superuser privileges.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes fakeroot; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     install --assumeyes  fakeroot; fi
# -----------------------------------------------------------------------------
# Gettext - GNU Internationalization.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes gettext; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     install --assumeyes  gettext; fi
# -----------------------------------------------------------------------------
# Git - distributed revision control system.
# -----------------------------------------------------------------------------
# Web app: https://github.com
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes git; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     install --assumeyes  git; fi
# -----------------------------------------------------------------------------
# Groff - compose manual pages with GNU roff.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes groff; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     install --assumeyes  groff; fi
# -----------------------------------------------------------------------------
# Jq - JSON processor.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes jq; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     install --assumeyes  jq; fi
# -----------------------------------------------------------------------------
# Lftp - FTP/HTTP/BitTorrent client.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes lftp; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     install --assumeyes  lftp; fi
# -----------------------------------------------------------------------------
# Nmap - Network MAPper.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes nmap; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     install --assumeyes  nmap; fi
# -----------------------------------------------------------------------------
# Python - programming language.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes python3 mypy python3-pycodestyle python3-autopep8 python3-pip python-is-python3; fi
if grep --quiet debian /etc/os-release; then sudo ln --force --relative --symbolic /usr/bin/pycodestyle /usr/bin/pep8; fi
if grep --quiet debian /etc/os-release; then sudo ln --force --relative --symbolic /usr/bin/pip3 /usr/bin/pip; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes python3 python3-mypy python3-pycodestyle python3-pip; fi
# -----------------------------------------------------------------------------
# Poedit - gettext catalogs editor.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes poedit; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     install --assumeyes  poedit; fi
# -----------------------------------------------------------------------------
# RPM - package manager.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes rpm; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     install --assumeyes  rpm; fi
# -----------------------------------------------------------------------------
# Shellcheck - shell script linter.
# -----------------------------------------------------------------------------
# Web app: https://www.shellcheck.net
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes shellcheck; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     install --assumeyes  shellcheck; fi
# -----------------------------------------------------------------------------
# Spice-vdagent - enhancements for virtualized guest systems.
# -----------------------------------------------------------------------------
# Spice (Simple Protocol for Independent Computing Environments) agent for
# virtualized guest systems.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes spice-vdagent; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     install --assumeyes  spice-vdagent; fi
# -----------------------------------------------------------------------------
# Usbutils - USB utilities.
# -----------------------------------------------------------------------------
# This package contains the lsusb utility.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes usbutils; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     install --assumeyes  usbutils; fi

# REMOVE development pc06 pc07
# -----------------------------------------------------------------------------
# Ansible - configuration management, deployment, and task execution.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes ansible; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     remove --assumeyes  ansible; fi
# -----------------------------------------------------------------------------
# Fakeroot - simulate superuser privileges.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes fakeroot; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     remove --assumeyes  fakeroot; fi
# -----------------------------------------------------------------------------
# Gettext - GNU Internationalization.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes gettext; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     remove --assumeyes  gettext; fi
# -----------------------------------------------------------------------------
# Git - distributed revision control system.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes git; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     remove --assumeyes  git; fi
# -----------------------------------------------------------------------------
# Groff - compose manual pages with GNU roff.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes groff; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     remove --assumeyes  groff; fi
# -----------------------------------------------------------------------------
# Jq - JSON processor.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes jq; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     remove --assumeyes  jq; fi
# -----------------------------------------------------------------------------
# Lftp - FTP/HTTP/BitTorrent client.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes lftp; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     remove --assumeyes  lftp; fi
# -----------------------------------------------------------------------------
# Nmap - Network MAPper.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes nmap; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     remove --assumeyes  nmap; fi
# -----------------------------------------------------------------------------
# Python - programming language.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes python mypy python3-pycodestyle python3-autopep8 python3-pip python-is-python3; fi
if grep --quiet debian /etc/os-release; then sudo rm --force --verbose /usr/bin/pep8 /usr/bin/pip; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes python3 python3-mypy python3-pycodestyle python3-pip; fi
# -----------------------------------------------------------------------------
# Poedit - Gettext catalogs editor.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes poedit; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     remove --assumeyes  poedit; fi
# -----------------------------------------------------------------------------
# RPM - package manager for RPM.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes rpm; fi
# -----------------------------------------------------------------------------
# Shellcheck - shell script linter.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes shellcheck; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     remove --assumeyes  shellcheck; fi
# -----------------------------------------------------------------------------
# Spice-vdagent - enhancements for virtualized guest systems.
# -----------------------------------------------------------------------------
# Spice (Simple Protocol for Independent Computing Environments) agent for
# virtualized guest systems.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes spice-vdagent; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     remove --assumeyes  spice-vdagent; fi
# -----------------------------------------------------------------------------
# Usbutils - USB utilities.
# -----------------------------------------------------------------------------
# This package contains the lsusb utility.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes usbutils; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     remove --assumeyes  usbutils; fi

# INSTALL disabled-aer pc06
# -----------------------------------------------------------------------------
# Disable Advanced Error Reporting.
# -----------------------------------------------------------------------------
# Disable kernel config parameter PCIEAER (Peripheral Component Interconnect
# Express Advanced Error Reporting) prevents the log gets flooded with
# 'AER: Corrected errors received'. This is usually needed for HP hardware.
# -----------------------------------------------------------------------------
if ! grep --quiet 'pci=noaer' /etc/default/grub; then sudo sed --in-place 's/quiet/quiet pci=noaer/' /etc/default/grub; fi
if   grep --quiet debian /etc/os-release; then sudo update-grub; fi
if   grep --quiet rhel   /etc/os-release; then sudo grub2-mkconfig -o /boot/grub2/grub.cfg; fi
# -----------------------------------------------------------------------------
# Check for kernel config parameter pci=noaer.
# -----------------------------------------------------------------------------
grep --quiet 'pci=noaer' /etc/default/grub
REBOOT=true

# REMOVE disabled-aer pc06
# -----------------------------------------------------------------------------
# Enable Advanced Error Reporting.
# -----------------------------------------------------------------------------
# Enable kernel config parameter PCIEAER (Peripheral Component Interconnect
# Express Advanced Error Reporting) to "allow" the log gets flooded with
# 'AER: Corrected errors received'. This is usually needed for HP hardware.
# -----------------------------------------------------------------------------
if grep --quiet 'pci=noaer' /etc/default/grub; then sudo sed --in-place 's/quiet pci=noaer/quiet/' /etc/default/grub; fi
if grep --quiet debian /etc/os-release; then sudo update-grub; fi
if grep --quiet rhel   /etc/os-release; then sudo grub2-mkconfig -o /boot/grub2/grub.cfg; fi
# -----------------------------------------------------------------------------
# Check for kernel config parameter pci=noaer.
# -----------------------------------------------------------------------------
! grep --quiet 'pci=noaer' /etc/default/grub
REBOOT=true

# INSTALL disabled-apport #none
# -----------------------------------------------------------------------------
# Disable automatic crash report generation for Ubuntu.
# -----------------------------------------------------------------------------
if grep --quiet Ubuntu /etc/os-release; then sudo systemctl stop    apport.service; fi
if grep --quiet Ubuntu /etc/os-release; then sudo systemctl disable apport.service; fi
if grep --quiet Ubuntu /etc/os-release; then sudo sed --in-place 's/enabled=1/enabled=0/' /etc/default/apport; fi
if grep --quiet Ubuntu /etc/os-release; then sudo rm --force --verbose /var/crash/*; fi

# REMOVE disabled-apport #none
# -----------------------------------------------------------------------------
# Enable automatic crash report generation for Ubuntu.
# -----------------------------------------------------------------------------
if grep --quiet Ubuntu /etc/os-release; then sudo sed --in-place 's/enabled=0/enabled=1/' /etc/default/apport; fi
if grep --quiet Ubuntu /etc/os-release; then sudo systemctl enable --now apport.service; fi

# INSTALL disabled-fwupd #none
# -----------------------------------------------------------------------------
# Disable FirmWare UPdate Daemon.
# -----------------------------------------------------------------------------
sudo systemctl stop    fwupd.service
sudo systemctl disable fwupd.service
sudo systemctl mask    fwupd.service

# REMOVE disabled-fwupd #none
# -----------------------------------------------------------------------------
# Enable FirmWare UPdate Daemon.
# -----------------------------------------------------------------------------
sudo systemctl unmask fwupd.service
sudo systemctl enable fwupd.service
sudo systemctl start  fwupd.service

# INSTALL disabled-lidswitch #none #gpg
# -----------------------------------------------------------------------------
# Do nothing when the laptop lid is closed.
# -----------------------------------------------------------------------------
sudo sed --in-place '/^HandleLidSwitch=/d' /etc/systemd/logind.conf
echo 'HandleLidSwitch=ignore' | sudo tee --append /etc/systemd/logind.conf 1> /dev/null

# REMOVE disabled-lidswitch #none #gpg
# -----------------------------------------------------------------------------
# Restore the default action when the laptop lid is closed.
# -----------------------------------------------------------------------------
sudo sed --in-place '/^HandleLidSwitch=/d' /etc/systemd/logind.conf

# INSTALL evolution #none
# -----------------------------------------------------------------------------
# E-mail, calendar, contacts, and task management.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get install    --assume-yes    evolution; fi
if grep --quiet rhel   /etc/os-release; then sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo; fi
if grep --quiet rhel   /etc/os-release; then sudo flatpak install    --assumeyes     flathub org.gnome.Evolution; fi

# REMOVE evolution #none
# -----------------------------------------------------------------------------
# E-mail, calendar, contacts, and task management.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get remove    --assume-yes evolution; fi
if grep --quiet rhel   /etc/os-release; then sudo flatpak uninstall --assumeyes flathub org.gnome.Evolution; fi

# INSTALL exiftool pc06 pc07
# -----------------------------------------------------------------------------
# Read and write meta information.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes libimage-exiftool-perl; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     install --assumeyes  perl-Image-ExifTool; fi

# REMOVE exiftool pc06 pc07
# -----------------------------------------------------------------------------
# Read and write meta information.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes libimage-exiftool-perl; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     remove --assumeyes  perl-Image-ExifTool; fi

# INSTALL fdupes #none
# -----------------------------------------------------------------------------
# Find duplicate files.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes fdupes; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     install --assumeyes  fdupes; fi
# -----------------------------------------------------------------------------
# Usage:
# $ fdupes -r /path/to/folder # Report recursively from /path/to/folder
# $ fdupes -rd /path/to/folder # Delete, interactively, from /path/to/folder
# $ fdupes -rdN /path/to/folder # Delete, from /path/to/folder, keep first dup
# -----------------------------------------------------------------------------

# REMOVE fdupes #none
# -----------------------------------------------------------------------------
# Find duplicate files.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes fdupes; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     remove --assumeyes  fdupes; fi

# INSTALL force-x11 #none
# -----------------------------------------------------------------------------
# Disable choice on user login screen for Xorg/X11 or Wayland, and force X11.
# -----------------------------------------------------------------------------
# Force means no choice on user login screen for Xorg/X11 or Wayland!
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo sed --in-place 's/^#WaylandEnable=false/WaylandEnable=false/' /etc/gdm3/custom.conf; fi
if (grep rhel   /etc/os-release && type gnome-session) &> /dev/null; then sudo sed --in-place 's/^#WaylandEnable=false/WaylandEnable=false/' /etc/gdm/custom.conf; fi
REBOOT=true
# -----------------------------------------------------------------------------
# To check, after reboot!, execute "echo $XDG_SESSION_TYPE", should output
# 'x11'.
# -----------------------------------------------------------------------------

# REMOVE force-x11 #none
# -----------------------------------------------------------------------------
# Enable choice on user login screen for Xorg/X11 or Wayland.
# -----------------------------------------------------------------------------
# Force means no choice on user login screen for Xorg/X11 or Wayland!
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo sed --in-place 's/^WaylandEnable=false/#WaylandEnable=false/' /etc/gdm3/custom.conf; fi
if (grep rhel   /etc/os-release && type gnome-session) &> /dev/null; then sudo sed --in-place 's/^WaylandEnable=false/#WaylandEnable=false/' /etc/gdm/custom.conf; fi
REBOOT=true
# -----------------------------------------------------------------------------
# To check, after reboot!, execute "echo $XDG_SESSION_TYPE", should output
# 'wayland'.
# -----------------------------------------------------------------------------

# INSTALL gimp pc06
# -----------------------------------------------------------------------------
# GNU Image Manipulation Program.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes gimp gimp-help-en gimp-help-nl; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     install --assumeyes  gimp; fi

# REMOVE gimp pc06
# -----------------------------------------------------------------------------
# GNU Image Manipulation Program.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes gimp gimp-help-en gimp-help-nl; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     remove --assumeyes  gimp; fi

# INSTALL google-chrome *
# -----------------------------------------------------------------------------
# Web browser.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then wget --no-verbose --output-document=/tmp/google-chrome.deb https://dl.google.com/dl/linux/direct/google-chrome-stable_current_amd64.deb; fi
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes /tmp/google-chrome.deb; fi
if grep --quiet debian /etc/os-release; then rm --verbose /tmp/google-chrome.deb; fi
if grep --quiet rhel   /etc/os-release; then sudo rpm --import https://dl.google.com/linux/linux_signing_key.pub; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes https://dl.google.com/dl/linux/direct/google-chrome-stable_current_x86_64.rpm; fi

# REMOVE google-chrome *
# -----------------------------------------------------------------------------
# Web browser.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes google-chrome-stable; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     remove --assumeyes  google-chrome-stable; fi

# INSTALL google-earth pc04
# -----------------------------------------------------------------------------
# Explore the planet.
# -----------------------------------------------------------------------------
# Web app: https://earth.google.com
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then wget --no-verbose --output-document=/tmp/google-earth.deb https://dl.google.com/dl/linux/direct/google-earth-pro-stable_current_amd64.deb; fi
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes /tmp/google-earth.deb; fi
if grep --quiet debian /etc/os-release; then rm --verbose /tmp/google-earth.deb; fi
if grep --quiet rhel   /etc/os-release; then sudo rpm --import https://dl.google.com/linux/linux_signing_key.pub; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes https://dl.google.com/dl/linux/direct/google-earth-pro-stable-current.x86_64.rpm; fi

# REMOVE google-earth pc04
# -----------------------------------------------------------------------------
# Explore the planet.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes google-earth-pro-stable; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     remove --assumeyes  google-earth-pro-stable; fi

# INSTALL handbrake #none #gpg
# -----------------------------------------------------------------------------
# Video-dvd ripper and transcoder.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes handbrake; fi

# REMOVE handbrake #none #gpg
# -----------------------------------------------------------------------------
# Video-dvd ripper and transcoder.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes handbrake; fi

# INSTALL imagination pc06 pc07
# -----------------------------------------------------------------------------
# Slideshow maker.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes imagination; fi

# REMOVE imagination pc06 pc07
# -----------------------------------------------------------------------------
# Slideshow maker.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes imagination; fi

# INSTALL krita pc06
# -----------------------------------------------------------------------------
# Image manipulation.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes krita; fi

# REMOVE krita pc06
# -----------------------------------------------------------------------------
# Image manipulation.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes krita; fi

# INSTALL kvm pc06 pc07
# -----------------------------------------------------------------------------
# Virtualization.
# -----------------------------------------------------------------------------
# Kernel-based Virtual Machine.
# Images are in: /var/lib/libvirt/images/
# Dpkg::Options to prevent interaction while restoring /etc/libvirt
# configuration files.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes --option Dpkg::Options::="--force-confdef" --option Dpkg::Options::="--force-confold" bridge-utils cpu-checker libvirt-clients libvirt-daemon-system qemu-kvm qemu-system virtinst virt-manager; fi
if grep --quiet debian /etc/os-release; then sudo usermod --append --groups kvm,libvirt,libvirt-qemu "${SUDO_USER:-$USER}"; fi
# -----------------------------------------------------------------------------
# Prevent "Error starting domain: Requested operation is not valid: network
# 'default' is not active".
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo virsh --connect=qemu:///system net-autostart default; fi
# -----------------------------------------------------------------------------
# Check network 'default' with
# "sudo virsh --connect=qemu:///system net-info default", should output
# 'Autostart: yes'.
# -----------------------------------------------------------------------------
if grep --quiet rhel   /etc/os-release; then sudo dnf groupinstall "Virtualization Host"; fi
if grep --quiet rhel   /etc/os-release; then sudo systemctl enable --now libvirtd; fi
# -----------------------------------------------------------------------------
# Prevent "Error starting domain: Requested operation is not valid: network
# 'default' is not active".
# -----------------------------------------------------------------------------
if grep --quiet rhel   /etc/os-release; then sudo virsh --connect=qemu:///system net-autostart default; fi
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
if grep --quiet debian /etc/os-release; then sudo virsh --connect=qemu:///system net-autostart default --disable; fi
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes bridge-utils cpu-checker libvirt-clients libvirt-daemon-system qemu-kvm qemu-system virtinst virt-manager; fi
if grep --quiet rhel   /etc/os-release; then sudo systemctl disable --now libvirtd; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf groupremove "Virtualization Host"; fi
REBOOT=true

# INSTALL libreoffice *
# -----------------------------------------------------------------------------
# Office suite.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get install    --assume-yes    libreoffice; fi
if grep --quiet rhel   /etc/os-release; then sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo; fi
if grep --quiet rhel   /etc/os-release; then sudo flatpak install    --assumeyes     app/org.libreoffice.LibreOffice; fi

# REMOVE libreoffice *
# -----------------------------------------------------------------------------
# Office suite.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get remove    --assume-yes libreoffice; fi
if grep --quiet rhel   /etc/os-release; then sudo flatpak uninstall --assumeyes  app/org.libreoffice.LibreOffice; fi

# INSTALL locate pc06 pc07
# -----------------------------------------------------------------------------
# Find files.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes locate; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     install --assumeyes  mlocate; fi
sudo updatedb

# REMOVE locate pc06 pc07
# -----------------------------------------------------------------------------
# Find files.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes locate; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     remove --assumeyes  mlocate; fi

# INSTALL microsoft-edge #none
# -----------------------------------------------------------------------------
# Web browser.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then wget --no-verbose --output-document=- https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor --yes --output=/usr/share/keyrings/microsoft.gpg; fi
if grep --quiet debian /etc/os-release; then echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/edge stable main" | sudo tee /etc/apt/sources.list.d/microsoft-edge.list 1> /dev/null; fi
if grep --quiet debian /etc/os-release; then sudo apt-get update; fi
if grep --quiet debian /etc/os-release; then sudo apt-get install    --assume-yes    microsoft-edge-stable; fi
if grep --quiet rhel   /etc/os-release; then sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo; fi
if grep --quiet rhel   /etc/os-release; then sudo flatpak install    --assumeyes     flathub com.microsoft.Edge; fi

# REMOVE microsoft-edge #none
# -----------------------------------------------------------------------------
# Web browser.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get remove    --assume-yes microsoft-edge-stable; fi
if grep --quiet debian /etc/os-release; then sudo rm --force --verbose /etc/apt/sources.list.d/microsoft-edge.list; fi
if grep --quiet debian /etc/os-release; then sudo apt-get update; fi
if grep --quiet rhel   /etc/os-release; then sudo flatpak uninstall --assumeyes  flathub com.microsoft.Edge; fi

# INSTALL microsoft-vscode pc06 pc07
# -----------------------------------------------------------------------------
# Editor.
# -----------------------------------------------------------------------------
# Web app: https://vscode.dev
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then echo "code code/add-microsoft-repo boolean true" | sudo debconf-set-selections; fi
if grep --quiet debian /etc/os-release; then wget --no-verbose --output-document=- https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor --yes --output=/usr/share/keyrings/microsoft.gpg; fi
if grep --quiet debian /etc/os-release; then echo -e 'Types: deb\nURIs: https://packages.microsoft.com/repos/code\nSuites: stable\nComponents: main\nArchitectures: amd64,arm64,armhf\nSigned-By: /usr/share/keyrings/microsoft.gpg' |sudo tee /etc/apt/sources.list.d/microsoft-vscode.sources 1> /dev/null; fi
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes apt-transport-https; fi
if grep --quiet debian /etc/os-release; then sudo apt-get update; fi
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes code; fi
if grep --quiet debian /etc/os-release; then sudo update-alternatives --set editor /usr/bin/code; fi
if grep --quiet rhel   /etc/os-release; then sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc; fi
if grep --quiet rhel   /etc/os-release; then echo -e '[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc' | sudo tee /etc/yum.repos.d/vscode.repo 1> /dev/null; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes code; fi

# REMOVE microsoft-vscode pc06 pc07
# -----------------------------------------------------------------------------
# Editor.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo update-alternatives --remove editor /usr/bin/code; fi
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes code; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     remove --assumeyes  code; fi
if grep --quiet rhel   /etc/os-release; then sudo rm --force --verbose /etc/yum.repos.d/vscode.repo; fi

# INSTALL ntfs #none
# -----------------------------------------------------------------------------
# NTFS support.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes ntfs-3g; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     install --assumeyes  ntfs-3g ntfsprogs; fi
# -----------------------------------------------------------------------------
# Usage:
# $ findmnt (or lsblk)
# TARGET SOURCE FSTYPE OPTIONS
# /media/... /dev/sda1 ntfs3 rw,nosuid,nodev,relatime,uid=...
# $ lsblk
# NAME MAJ:MIN RM SIZE RO TYPE MOUNTPOINTS
# sda 8:0 0 931,5G 0 disk
# +-sda1 8:1 0 931,5G 0 part /media/...
# $ sudo ntfsfix /dev/sdba1 # Fix an NTFS partition
# $ sudo -b ntfsfix /dev/sdba1 # Clear the bad sector list
# $ sudo -d ntfsfix /dev/sdba1 # Clear the volume dirty flag
# -----------------------------------------------------------------------------

# REMOVE ntfs #none
# -----------------------------------------------------------------------------
# NTFS support.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes ntfs-3g; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     remove --assumeyes  ntfs-3g ntfsprogs; fi

# INSTALL primary-monitor pc06
# -----------------------------------------------------------------------------
# Set the default GDM login monitor in a multi-monitor setup.
# -----------------------------------------------------------------------------
# Saved in: /home/${SUDO_USER:-$USER}/.config/monitors.xml
# -----------------------------------------------------------------------------
if id gdm &> /dev/null && [[ -f /home/"${SUDO_USER:-$USER}"/.config/monitors.xml ]]; then sudo cp --preserve --verbose /home/"${SUDO_USER:-$USER}"/.config/monitors.xml ~gdm/.config/monitors.xml; fi
if id gdm &> /dev/null && [[ -f ~gdm/.config/monitors.xml ]]; then sudo chown --verbose gdm:gdm ~gdm/.config/monitors.xml; fi
if id Debian-gdm &> /dev/null && [[ -f /home/"${SUDO_USER:-$USER}"/.config/monitors.xml ]]; then sudo cp --preserve --verbose /home/"${SUDO_USER:-$USER}"/.config/monitors.xml ~Debian-gdm/.config/monitors.xml; fi
if id Debian-gdm &> /dev/null && [[ -f ~Debian-gdm/.config/monitors.xml ]]; then sudo chown --verbose Debian-gdm:Debian-gdm ~Debian-gdm/.config/monitors.xml; fi
REBOOT=true

# REMOVE primary-monitor pc06
# -----------------------------------------------------------------------------
# Reset the default GDM login monitor in a multi-monitor setup.
# -----------------------------------------------------------------------------
# Saved in: /home/${SUDO_USER:-$USER}/.config/monitors.xml
# -----------------------------------------------------------------------------
sudo rm --force --verbose ~gdm/.config/monitors.xml ~Debian-gdm/.config/monitors.xml
REBOOT=true

# INSTALL simplescreenrecorder #none
# -----------------------------------------------------------------------------
# Screen recorder.
# -----------------------------------------------------------------------------
# Requires the use of Xorg/X11.
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get install --assume-yes simplescreenrecorder; fi

# REMOVE simplescreenrecorder #none
# -----------------------------------------------------------------------------
# Screen recorder.
# -----------------------------------------------------------------------------
# Required the use of Xorg/X11. Enable Wayland again?
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get remove --assume-yes simplescreenrecorder; fi

# INSTALL sound-juicer #gp
# -----------------------------------------------------------------------------
# Audio-cd ripper and player.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes sound-juicer; fi

# REMOVE sound-juicer #none #gpg
# -----------------------------------------------------------------------------
# Audio-cd ripper and player.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes sound-juicer; fi

# INSTALL spotify pc01 pc02 pc06 pc07
# -----------------------------------------------------------------------------
# Music and podcasts.
# -----------------------------------------------------------------------------
# Web app: https://open.spotify.com
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then wget --no-verbose --output-document=- https://download.spotify.com/debian/pubkey_C85668DF69375001.gpg | sudo gpg --dearmor --yes --output=/usr/share/keyrings/spotify.gpg; fi
if grep --quiet debian /etc/os-release; then echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/spotify.gpg] https://repository.spotify.com stable non-free' | sudo tee /etc/apt/sources.list.d/spotify.list 1> /dev/null; fi
if grep --quiet debian /etc/os-release; then sudo apt-get update; fi
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes spotify-client; fi
if grep --quiet rhel   /etc/os-release; then echo 'The spotify app is available as a web app.'; fi

# REMOVE spotify pc01 pc02 pc06 pc07
# -----------------------------------------------------------------------------
# Music and podcasts.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes spotify-client; fi
if grep --quiet debian /etc/os-release; then sudo rm --force --verbose /usr/share/keyrings/spotify.gpg /etc/apt/sources.list.d/spotify.list /etc/apt/sources.list.d/spotify.sources; fi
if grep --quiet debian /etc/os-release; then sudo apt-get update; fi

# INSTALL ssh pc01 pc06 pc07
# -----------------------------------------------------------------------------
# Secure SHell.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes ssh; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     install --assumeyes  openssh; fi
sudo sed --in-place 's/PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
# -----------------------------------------------------------------------------
# Check for remote root access.
# -----------------------------------------------------------------------------
grep 'PermitRootLogin no' /etc/ssh/sshd_config
sudo systemctl restart ssh.service
# -----------------------------------------------------------------------------
# Configure static table lookup for hostnames and IP addresses.
# -----------------------------------------------------------------------------
if [[ 'pc01 pc06 pc07' =~ $HOSTNAME ]]; then sudo sed --in-place '/^192.168.1./d'       /etc/hosts; fi
if [[ 'pc01 pc06 pc07' =~ $HOSTNAME ]]; then sudo sed --in-place '2a192.168.1.100 pc01' /etc/hosts; fi
if [[ 'pc01 pc06 pc07' =~ $HOSTNAME ]]; then sudo sed --in-place '3a192.168.1.2 pc06'   /etc/hosts; fi
if [[ 'pc01 pc06 pc07' =~ $HOSTNAME ]]; then sudo sed --in-place '4a192.168.1.219 pc07' /etc/hosts; fi

# REMOVE ssh pc01 pc06 pc07
# -----------------------------------------------------------------------------
# Secure SHell.
# -----------------------------------------------------------------------------
sudo sed --in-place 's/PermitRootLogin no/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes ssh; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     remove --assumeyes  openssh; fi
# -----------------------------------------------------------------------------
# Configure static table lookup for hostnames and IP addresses.
# -----------------------------------------------------------------------------
if [[ 'pc01 pc06 pc07' =~ $HOSTNAME ]]; then sudo sed --in-place '/^192.168.1./d' /etc/hosts; fi

# INSTALL teamviewer *
# -----------------------------------------------------------------------------
# Remote desktop.
# -----------------------------------------------------------------------------
# Web app: https://web.teamviewer.com
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then wget --no-verbose --output-document=/tmp/teamviewer.deb https://download.teamviewer.com/download/linux/teamviewer_amd64.deb; fi
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes /tmp/teamviewer.deb; fi
if grep --quiet debian /etc/os-release; then rm --verbose /tmp/teamviewer.deb; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes https://download.teamviewer.com/download/linux/teamviewer.x86_64.rpm; fi

# REMOVE teamviewer *
# -----------------------------------------------------------------------------
# Remote desktop.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes teamviewer; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     remove --assumeyes  teamviewer; fi

# INSTALL terminal pc01 pc06 pc07
# -----------------------------------------------------------------------------
# Bash completion - tab-completion.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes bash-completion; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     install --assumeyes  bash-completion; fi
# -----------------------------------------------------------------------------
# Htop - process viewer.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes htop; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     install --assumeyes  htop; fi
# -----------------------------------------------------------------------------
# Tree - display directory tree.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes tree; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     install --assumeyes  tree; fi
# -----------------------------------------------------------------------------
# Usermod - log access.
# -----------------------------------------------------------------------------
sudo usermod --append --groups adm,systemd-journal "${SUDO_USER:-$USER}"

# REMOVE terminal pc01 pc06 pc07
# -----------------------------------------------------------------------------
# Bash completion - tab-completion.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes bash-completion; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     remove --assumeyes  bash-completion; fi
# -----------------------------------------------------------------------------
# Htop - process viewer.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes htop; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     remove --assumeyes  htop; fi
# -----------------------------------------------------------------------------
# Tree - display directory tree.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes tree; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     remove --assumeyes  tree; fi
# -----------------------------------------------------------------------------
# Usermod - log access.
# -----------------------------------------------------------------------------
sudo gpasswd --delete "${SUDO_USER:-$USER}" adm
sudo gpasswd --delete "${SUDO_USER:-$USER}" systemd-journal

# INSTALL thunderbird *
# -----------------------------------------------------------------------------
# E-mail, calendar, contacts, and task management.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes thunderbird thunderbird-l10n-nl; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     install --assumeyes  thunderbird; fi

# REMOVE thunderbird *
# -----------------------------------------------------------------------------
# E-mail, calendar, contacts, and task management.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes thunderbird thunderbird-l10n-nl; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     remove --assumeyes  thunderbird; fi

# INSTALL transmission pc01 pc06 pc07
# -----------------------------------------------------------------------------
# BitTorrent client.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes transmission; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     install --assumeyes  transmission; fi

# REMOVE transmission pc01 pc06 pc07
# -----------------------------------------------------------------------------
# BitTorrent client.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes transmission; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     remove --assumeyes  transmission; fi

# INSTALL ufw pc01 pc06 pc07
# -----------------------------------------------------------------------------
# Uncomplicated FireWall.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes gufw; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     install --assumeyes  gufw; fi
sudo ufw allow ssh
sudo ufw enable

# REMOVE ufw pc01 pc06 pc07
# -----------------------------------------------------------------------------
# Uncomplicated FireWall.
# -----------------------------------------------------------------------------
sudo ufw disable
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes gufw; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     remove --assumeyes  gufw; fi

# INSTALL update-grub *
# -----------------------------------------------------------------------------
# Skip GRUB menu.
# -----------------------------------------------------------------------------
sudo sed --in-place --regexp-extended "s/^.?GRUB_TIMEOUT=.*$/GRUB_TIMEOUT=0/" /etc/default/grub
if grep --quiet debian /etc/os-release; then sudo update-grub; fi
if grep --quiet rhel   /etc/os-release; then sudo grub2-mkconfig -o /boot/grub2/grub.cfg; fi
REBOOT=true

# REMOVE update-grub *
# -----------------------------------------------------------------------------
# Show GRUB menu.
# -----------------------------------------------------------------------------
sudo sed --in-place --regexp-extended "s/^.?GRUB_TIMEOUT=.*$/GRUB_TIMEOUT=5/" /etc/default/grub
if grep --quiet debian /etc/os-release; then sudo update-grub; fi
if grep --quiet rhel   /etc/os-release; then sudo grub2-mkconfig -o /boot/grub2/grub.cfg; fi
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

# INSTALL virtualbox #none #gpg
# -----------------------------------------------------------------------------
# Virtualization.
# -----------------------------------------------------------------------------
# VirtualBox Guest user Additions ISO are in '/usr/share/virtualbox/'.
# If the installation hangs or VBox does not work, check the virtualization
# settings in the BIOS/UEFI.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then echo 'virtualbox-ext-pack virtualbox-ext-pack/license select true' | sudo debconf-set-selections; fi
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     install --assumeyes  VirtualBox; fi

# REMOVE virtualbox #none #gpg
# -----------------------------------------------------------------------------
# Virtualization.
# -----------------------------------------------------------------------------
# VirtualBox Guest user Additions ISO are in '/usr/share/virtualbox/'.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     remove --assumeyes  VirtualBox; fi

# INSTALL vlc *
# -----------------------------------------------------------------------------
# Multimedia player.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes vlc; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     install --assumeyes  vlc; fi
# -----------------------------------------------------------------------------
# Ffmpeg - multimedia support.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes ffmpeg*; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     install --assumeyes  ffmpeg*; fi

# REMOVE vlc *
# -----------------------------------------------------------------------------
# Multimedia player.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes vlc; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     remove --assumeyes  vlc; fi
# -----------------------------------------------------------------------------
# Ffmpeg - multimedia support.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes ffmpeg*; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     remove --assumeyes  ffmpeg*; fi

# INSTALL webmin pc07
# -----------------------------------------------------------------------------
# Web console.
# -----------------------------------------------------------------------------
# Web app: https://localhost:10000
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then wget --no-verbose --output-document=/tmp/setup-repos.sh https://raw.githubusercontent.com/webmin/webmin/master/setup-repos.sh; fi
if grep --quiet debian /etc/os-release; then sudo sh /tmp/setup-repos.sh --force; fi
if grep --quiet debian /etc/os-release; then sudo rm --force --verbose /tmp/setup-repos.sh; fi
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes webmin; fi
if grep --quiet rhel   /etc/os-release; then wget --no-verbose --output-document=/tmp/setup-repos.sh https://raw.githubusercontent.com/webmin/webmin/master/setup-repos.sh; fi
if grep --quiet rhel   /etc/os-release; then sudo sh /tmp/setup-repos.sh --force; fi
if grep --quiet rhel   /etc/os-release; then sudo rm --force --verbose /tmp/setup-repos.sh; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes webmin; fi

# REMOVE webmin pc07
# -----------------------------------------------------------------------------
# Web console.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes webmin; fi
if grep --quiet debian /etc/os-release; then sudo rm --force --verbose /usr/share/keyrings/*webmin*.gpg /etc/apt/sources.list.d/webmin*.list /etc/apt/sources.list.d/webmin*.sources; fi
if grep --quiet debian /etc/os-release; then sudo apt-get update; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes webmin; fi
if grep --quiet rhel   /etc/os-release; then sudo rm --force --verbose /etc/yum.repos.d/webmin.repo; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf update; fi

# INSTALL wine #none
# -----------------------------------------------------------------------------
# Run Windows applications.
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo dpkg --add-architecture i386; fi
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get install --assume-yes wine winetricks playonlinux; fi
if (grep rhel   /etc/os-release && type gnome-session) &> /dev/null; then sudo dnf install --assumeyes wine playonlinux; fi

# REMOVE wine #none
# -----------------------------------------------------------------------------
# Run Windows applications.
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get remove --assume-yes wine winetricks playonlinux; fi
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo dpkg --remove-architecture i386; fi
if (grep rhel   /etc/os-release && type gnome-session) &> /dev/null; then sudo dnf remove --assumeyes wine playonlinux; fi

# INSTALL youtube-dl #none #gpg
# -----------------------------------------------------------------------------
# Download videos.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes youtubedl-gui; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     install --assumeyes  youtube-dl; fi

# REMOVE youtube-dl #none #gpg
# -----------------------------------------------------------------------------
# Download videos.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes youtubedl-gui; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf     remove --assumeyes  youtube-dl; fi
