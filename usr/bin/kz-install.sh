# shellcheck shell=bash
# #############################################################################
# SPDX-FileComment: Install file for use with kz-install script
#
# SPDX-FileCopyrightText: Karel Zimmer <info@karelzimmer.nl>
# SPDX-License-Identifier: CC0-1.0
# #############################################################################

# =============================================================================
# Use "man kz install.sh" to learn more about the format of this file.
# =============================================================================

# install add-components on *
# -----------------------------------------------------------------------------
# Add contrib and non-free components to the package sources for Debian.
# -----------------------------------------------------------------------------
if grep Debian /etc/os-release && [[ -e /etc/apt/sources.list   ]]; then sudo sed --in-place 's/main non-free-firmware/contrib main non-free non-free-firmware/' /etc/apt/sources.list; fi
if grep Debian /etc/os-release && [[ -e /etc/apt/debian.sources ]]; then sudo sed --in-place 's/main non-free-firmware/contrib main non-free non-free-firmware/' /etc/apt/debian.sources; fi
if grep Debian /etc/os-release; then sudo apt-get update; fi

# remove add-components from *
# -----------------------------------------------------------------------------
# Remove contrib and non-free components to the package sources for Debian.
# -----------------------------------------------------------------------------
if grep Debian /etc/os-release && [[ -e /etc/apt/sources.list   ]]; then sudo sed --in-place 's/contrib main non-free non-free-firmware/main non-free-firmware/' /etc/apt/sources.list; fi
if grep Debian /etc/os-release && [[ -e /etc/apt/debian.sources ]]; then sudo sed --in-place 's/contrib main non-free non-free-firmware/main non-free-firmware/' /etc/apt/debian.sources; fi
if grep Debian /etc/os-release; then sudo apt-get update; fi

# install ansible on pc06 pc07
# -----------------------------------------------------------------------------
# Configuration management, deployment, and task execution.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release; then sudo apt-get install --assume-yes ansible; fi
if grep rhel   /etc/os-release; then sudo dnf     install --assumeyes  ansible; fi

# remove ansible from pc06 pc07
# -----------------------------------------------------------------------------
# Configuration management, deployment, and task execution.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release; then sudo apt-get purge --assume-yes ansible; fi
if grep rhel   /etc/os-release; then sudo dnf     remove --assumeyes ansible; fi

# install backintime on #none
# -----------------------------------------------------------------------------
# Backups/snapshots.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo apt-get install --assume-yes backintime-qt; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo dnf     install --assumeyes  backintime-qt; fi

# remove backintime from #none
# -----------------------------------------------------------------------------
# Backups/snapshots.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo apt-get purge --assume-yes backintime-qt; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo dnf     remove --assumeyes backintime-qt; fi

# install bleachbit on #none
# -----------------------------------------------------------------------------
# Delete files.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo apt-get install --assume-yes bleachbit; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo dnf     install --assumeyes  bleachbit; fi

# remove bleachbit from #none
# -----------------------------------------------------------------------------
# Delete files.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo apt-get purge --assume-yes bleachbit; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo dnf     remove --assumeyes bleachbit; fi

# install broadcom-sta-dkms on pc01
# -----------------------------------------------------------------------------
# Enable wifi adapter.
# Reboot required!
# -----------------------------------------------------------------------------
if grep debian /etc/os-release; then sudo apt-get install --assume-yes linux-headers-generic; fi
if grep debian /etc/os-release; then sudo apt-get install --assume-yes broadcom-sta-dkms; fi
if grep rhel   /etc/os-release; then echo 'The broadcom-sta-dkms app is not available.'; fi

# remove broadcom-sta-dkms from pc01
# -----------------------------------------------------------------------------
# Disable wifi adapter.
# Reboot required!
# -----------------------------------------------------------------------------
if grep debian /etc/os-release; then sudo apt-get purge --assume-yes broadcom-sta-dkms; fi
if grep rhel   /etc/os-release; then echo 'The broadcom-sta-dkms app is not available.'; fi

# install calibre on pc06
# -----------------------------------------------------------------------------
# E-book manager.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo apt-get install --assume-yes calibre; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo --validate && wget --no-verbose --output-document=- https://download.calibre-ebook.com/linux-installer.sh | sudo sh; fi

# remove calibre from pc06
# -----------------------------------------------------------------------------
# E-book manager.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo apt-get purge --assume-yes calibre; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo calibre-uninstall; fi

# install cockpit on pc06
# -----------------------------------------------------------------------------
# Web console.
# Web app: https://localhost:9090
# -----------------------------------------------------------------------------
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo apt-get install --assume-yes cockpit cockpit-pcp; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo dnf     install --assumeyes  cockpit cockpit-pcp; fi

# remove cockpit from pc06
# -----------------------------------------------------------------------------
# Web console.
# Web app: https://localhost:9090
# -----------------------------------------------------------------------------
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo apt-get purge --assume-yes cockpit; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo dnf     remove --assumeyes cockpit; fi

# install cups on #none
# -----------------------------------------------------------------------------
# Common Unix Printing System.
# Web app: http://localhost:631
# -----------------------------------------------------------------------------
if grep debian /etc/os-release; then sudo apt-get install --assume-yes cups; fi
if grep rhel   /etc/os-release; then sudo dnf     install --assumeyes  cups; fi

# remove cups from #none
# -----------------------------------------------------------------------------
# Common Unix Printing System.
# Web app: http://localhost:631
# -----------------------------------------------------------------------------
if grep debian /etc/os-release; then sudo apt-get purge --assume-yes cups; fi
if grep rhel   /etc/os-release; then sudo dnf     remove --assumeyes cups; fi

# install cups-backend-bjnp on #none
# -----------------------------------------------------------------------------
# Printer backend.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo apt-get install --assume-yes cups-backend-bjnp; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then echo 'The cups-backend-bjnp app is not available.'; fi

# remove cups-backend-bjnp from #none
# -----------------------------------------------------------------------------
# Printer backend.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo apt-get purge --assume-yes cups-backend-bjnp; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then echo 'The cups-backend-bjnp app is not available.'; fi

# install dash-to-dock on *
# -----------------------------------------------------------------------------
# Desktop dock like Ubuntu's dash.
# Reboot required!
# -----------------------------------------------------------------------------
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]] && ! apt-cache show gnome-shell-extension-ubuntu-dock ; then sudo apt-get install --assume-yes gnome-shell-extension-dashtodock; fi
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]] &&   apt-cache show gnome-shell-extension-no-overview ; then sudo apt-get install --assume-yes gnome-shell-extension-no-overview; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]] &&   dnf       list gnome-shell-extension-dash-to-dock; then sudo dnf     install --assumeyes  gnome-shell-extension-dash-to-dock; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]] &&   dnf       list gnome-shell-extension-no-overview ; then sudo dnf     install --assumeyes  gnome-shell-extension-no-overview; fi

# remove dash-to-dock from *
# -----------------------------------------------------------------------------
# Desktop dock like Ubuntu's dash.
# Reboot required!
# -----------------------------------------------------------------------------
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]] && ! apt-cache show gnome-shell-extension-ubuntu-dock ; then sudo apt-get purge --assume-yes gnome-shell-extension-dashtodock; fi
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]] &&   apt-cache show gnome-shell-extension-no-overview ; then sudo apt-get purge --assume-yes gnome-shell-extension-no-overview; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]] &&   dnf       list gnome-shell-extension-dash-to-dock; then sudo dnf     remove --assumeyes gnome-shell-extension-dash-to-dock; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]] &&   dnf       list gnome-shell-extension-no-overview ; then sudo dnf     remove --assumeyes gnome-shell-extension-no-overview; fi

# install disabled-aer on pc06
# -----------------------------------------------------------------------------
# Disable kernel config parameter PCIEAER (Peripheral Component Interconnect
# Express Advanced Error Reporting) to prevent the log gets flooded with
# 'AER: Corrected errors received'. App disabled-aer is usually needed for HP hardware.
# -----------------------------------------------------------------------------
if ! grep 'pci=noaer' /etc/default/grub; then sudo sed --in-place 's/quiet/quiet pci=noaer/' /etc/default/grub; fi
if   grep debian /etc/os-release; then sudo update-grub; fi
if   grep rhel   /etc/os-release; then sudo grub2-mkconfig -o /boot/grub2/grub.cfg; fi
# -----------------------------------------------------------------------------
# Check for kernel config parameter pci=noaer.
# -----------------------------------------------------------------------------
grep 'pci=noaer' /etc/default/grub

# remove disabled-aer from pc06
# -----------------------------------------------------------------------------
# Enable kernel config parameter PCIEAER.
# Disable kernel config parameter PCIEAER (Peripheral Component Interconnect
# Express Advanced Error Reporting) to "allow" the log gets flooded with
# 'AER: Corrected errors received'. App disabled-aer is usually needed for HP hardware.
# -----------------------------------------------------------------------------
if grep 'pci=noaer' /etc/default/grub; then sudo sed --in-place 's/quiet pci=noaer/quiet/' /etc/default/grub; fi
if grep debian /etc/os-release; then sudo update-grub; fi
if grep rhel   /etc/os-release; then sudo grub2-mkconfig -o /boot/grub2/grub.cfg; fi
# -----------------------------------------------------------------------------
# Check for kernel config parameter pci=noaer.
# -----------------------------------------------------------------------------
! grep 'pci=noaer' /etc/default/grub

# install disabled-apport on #none
# -----------------------------------------------------------------------------
# Disable automatic crash report generation for Ubuntu.
# -----------------------------------------------------------------------------
if grep Ubuntu /etc/os-release; then sudo systemctl stop apport.service; fi
if grep Ubuntu /etc/os-release; then sudo systemctl disable apport.service; fi
if grep Ubuntu /etc/os-release; then sudo sed --in-place 's/enabled=1/enabled=0/' /etc/default/apport; fi
if grep Ubuntu /etc/os-release; then sudo rm  --force --verbose /var/crash/*; fi

# remove disabled-apport from #none
# -----------------------------------------------------------------------------
# Enable automatic crash report generation for Ubuntu.
# -----------------------------------------------------------------------------
if grep Ubuntu /etc/os-release; then sudo sed --in-place 's/enabled=0/enabled=1/' /etc/default/apport; fi
if grep Ubuntu /etc/os-release; then sudo systemctl enable --now apport.service; fi

# install disabled-fwupd on #none
# -----------------------------------------------------------------------------
# Disable FirmWare UPdate Daemon.
# -----------------------------------------------------------------------------
sudo systemctl stop fwupd.service
sudo systemctl disable fwupd.service
sudo systemctl mask fwupd.service

# remove disabled-fwupd from #none
# -----------------------------------------------------------------------------
# Disable FirmWare UPdate Daemon.
# -----------------------------------------------------------------------------
sudo systemctl unmask fwupd.service
sudo systemctl enable fwupd.service
sudo systemctl start fwupd.service

# install disabled-lidswitch on #none
# -----------------------------------------------------------------------------
# Do nothing when the laptop lid is closed.
# -----------------------------------------------------------------------------
sudo sed --in-place '/^HandleLidSwitch=/d' /etc/systemd/logind.conf
echo 'HandleLidSwitch=ignore' | sudo tee --append /etc/systemd/logind.conf

# remove disabled-lidswitch from #none
# -----------------------------------------------------------------------------
# Restore the default action when the laptop lid is closed.
# -----------------------------------------------------------------------------
sudo sed --in-place '/^HandleLidSwitch=/d' /etc/systemd/logind.conf

# install dual-monitor on pc06
# -----------------------------------------------------------------------------
# Preserve dual monitor settings.
# -----------------------------------------------------------------------------
if [[ -f $HOME/.config/monitors.xml ]]; then sudo cp --preserve --verbose "$HOME/.config/monitors.xml" ~gdm/.config/monitors.xml; fi
if [[ -f  ~gdm/.config/monitors.xml ]]; then sudo chown --verbose gdm:gdm ~gdm/.config/monitors.xml; fi

# remove dual-monitor from pc06
# -----------------------------------------------------------------------------
# Remove dual monitor settings.
# -----------------------------------------------------------------------------
sudo rm --force --verbose ~gdm/.config/monitors.xml

# install exiftool on pc06 pc07
# -----------------------------------------------------------------------------
# Read and write meta information.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo apt-get install --assume-yes libimage-exiftool-perl; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo dnf     install --assumeyes  perl-Image-ExifTool; fi

# remove exiftool from pc06 pc07
# -----------------------------------------------------------------------------
# Read and write meta information.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo apt-get purge --assume-yes libimage-exiftool-perl; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo dnf     remove --assumeyes perl-Image-ExifTool; fi

# install fakeroot on pc06 pc07
# -----------------------------------------------------------------------------
# Simulate superuser privileges.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release; then sudo apt-get install --assume-yes fakeroot; fi
if grep rhel   /etc/os-release; then sudo dnf     install --assumeyes  fakeroot; fi

# remove fakeroot from pc06 pc07
# -----------------------------------------------------------------------------
# Simulate superuser privileges.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release; then sudo apt-get purge --assume-yes fakeroot; fi
if grep rhel   /etc/os-release; then sudo dnf     remove --assumeyes fakeroot; fi

# install fdupes on #none
# -----------------------------------------------------------------------------
# Find duplicate files.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release; then sudo apt-get install --assume-yes fdupes; fi
if grep rhel   /etc/os-release; then sudo dnf     install --assumeyes  fdupes; fi
# -----------------------------------------------------------------------------
# Usage:
# $ fdupes -r /path/to/folder   # Report recursively from /path/to/folder
# $ fdupes -rd /path/to/folder  # Delete, interactively, from /path/to/folder
# $ fdupes -rdN /path/to/folder # Delete, from /path/to/folder, keep first dup
# -----------------------------------------------------------------------------

# remove fdupes from #none
# -----------------------------------------------------------------------------
# Find duplicate files.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release; then sudo apt-get purge --assume-yes fdupes; fi
if grep rhel   /etc/os-release; then sudo dnf     remove --assumeyes fdupes; fi

# install force-x11 on #none
# -----------------------------------------------------------------------------
# Disable choice on user login screen for Xorg/X11 or Wayland, and force X11.
# Force means no choice on user login screen for Xorg/X11 or Wayland!
# Reboot required!
# -----------------------------------------------------------------------------
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo sed --in-place 's/^#WaylandEnable=false/WaylandEnable=false/' /etc/gdm3/custom.conf; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo sed --in-place 's/^#WaylandEnable=false/WaylandEnable=false/' /etc/gdm/custom.conf; fi
# -----------------------------------------------------------------------------
# To check, after reboot!, execute "echo $XDG_SESSION_TYPE", should output
# 'x11'.
# -----------------------------------------------------------------------------

# remove force-x11 from #none
# -----------------------------------------------------------------------------
# Enable choice on user login screen for Xorg/X11 or Wayland.
# Force means no choice on user login screen for Xorg/X11 or Wayland!
# Reboot required!
# -----------------------------------------------------------------------------
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo sed --in-place 's/^WaylandEnable=false/#WaylandEnable=false/' /etc/gdm3/custom.conf; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo sed --in-place 's/^WaylandEnable=false/#WaylandEnable=false/' /etc/gdm/custom.conf; fi
# -----------------------------------------------------------------------------
# To check, after reboot!, execute "echo $XDG_SESSION_TYPE", should output
# 'wayland'.
# -----------------------------------------------------------------------------

# install gdebi on #none
# -----------------------------------------------------------------------------
# View and install deb files.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo apt-get install --assume-yes gdebi; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then echo 'The gdebi app is not available.'; fi

# remove gdebi from #none
# -----------------------------------------------------------------------------
# View and install deb files.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo apt-get purge --assume-yes gdebi; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then echo 'The gdebi app is not available.'; fi

# install gettext on pc06 pc07
# -----------------------------------------------------------------------------
# GNU Internationalization.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release; then sudo apt-get install --assume-yes gettext; fi
if grep rhel   /etc/os-release; then sudo dnf     install --assumeyes  gettext; fi

# remove gettext from pc06 pc07
# -----------------------------------------------------------------------------
# GNU Internationalization.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release; then sudo apt-get purge --assume-yes gettext; fi
if grep rhel   /etc/os-release; then sudo dnf     remove --assumeyes gettext; fi

# install gimp on pc06
# -----------------------------------------------------------------------------
# GNU Image Manipulation Program.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo apt-get install --assume-yes gimp gimp-help-en gimp-help-nl; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo dnf     install --assumeyes  gimp; fi

# remove gimp from pc06
# -----------------------------------------------------------------------------
# GNU Image Manipulation Program.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo apt-get purge --assume-yes gimp gimp-help-en gimp-help-nl; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo dnf     remove --assumeyes gimp; fi

# install git on pc06 pc07
# -----------------------------------------------------------------------------
# Distributed revision control system.
# Web app: https://github.com
# -----------------------------------------------------------------------------
if grep debian /etc/os-release; then sudo apt-get install --assume-yes git; fi
if grep rhel   /etc/os-release; then sudo sudo dnf     install --assumeyes  git; fi

# remove git from pc06 pc07
# -----------------------------------------------------------------------------
# Distributed revision control system.
# Web app: https://github.com
# -----------------------------------------------------------------------------
if grep debian /etc/os-release; then sudo apt-get purge --assume-yes git; fi
if grep rhel   /etc/os-release; then sudo sudo dnf     remove --assumeyes git; fi

# install google-chrome on *
# -----------------------------------------------------------------------------
# Web browser.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then wget --no-verbose --output-document=/tmp/google-chrome.deb https://dl.google.com/dl/linux/direct/google-chrome-stable_current_amd64.deb; fi
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo apt-get install --assume-yes /tmp/google-chrome.deb; fi
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then rm --verbose /tmp/google-chrome.deb; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo rpm --import https://dl.google.com/linux/linux_signing_key.pub; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo dnf     install --assumeyes  https://dl.google.com/dl/linux/direct/google-chrome-stable_current_x86_64.rpm; fi

# remove google-chrome from *
# -----------------------------------------------------------------------------
# Web browser.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo apt-get purge --assume-yes google-chrome-stable; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo dnf     remove --assumeyes google-chrome-stable; fi

# install google-earth on #none
# -----------------------------------------------------------------------------
# Explore the planet.
# Web app: https://earth.google.com
# -----------------------------------------------------------------------------
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then wget --no-verbose --output-document=/tmp/google-earth.deb https://dl.google.com/dl/linux/direct/google-earth-pro-stable_current_amd64.deb; fi
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo apt-get install --assume-yes /tmp/google-earth.deb; fi
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then rm --verbose /tmp/google-earth.deb; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo rpm --import https://dl.google.com/linux/linux_signing_key.pub; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo dnf     install --assumeyes  https://dl.google.com/dl/linux/direct/google-earth-pro-stable-current.x86_64.rpm; fi

# remove google-earth from #none
# -----------------------------------------------------------------------------
# Explore the planet.
# Web app: https://earth.google.com
# -----------------------------------------------------------------------------
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo apt-get purge --assume-yes google-earth-pro-stable; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo dnf     remove --assumeyes google-earth-pro-stable; fi

# install groff on pc06 pc07
# -----------------------------------------------------------------------------
# Compose manual pages with GNU roff.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release; then sudo apt-get install --assume-yes groff; fi
if grep rhel   /etc/os-release; then sudo dnf     install --assumeyes  groff; fi

# remove groff from pc06 pc07
# -----------------------------------------------------------------------------
# Compose manual pages with GNU roff.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release; then sudo apt-get purge --assume-yes groff; fi
if grep rhel   /etc/os-release; then sudo dnf     remove --assumeyes groff; fi

# install handbrake on #none
# -----------------------------------------------------------------------------
# Video-dvd ripper and transcoder.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo apt-get install --assume-yes handbrake; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then echo 'The handbrake app is not available.'; fi

# remove handbrake from #none
# -----------------------------------------------------------------------------
# Video-dvd ripper and transcoder.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo apt-get purge --assume-yes handbrake; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then echo 'The handbrake app is not available.'; fi

# install htop on pc06 pc07
# -----------------------------------------------------------------------------
# Process viewer.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release; then sudo apt-get install --assume-yes htop; fi
if grep rhel   /etc/os-release; then sudo dnf     install --assumeyes  htop; fi

# remove htop from pc06 pc07
# -----------------------------------------------------------------------------
# Process viewer.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release; then sudo apt-get purge --assume-yes htop; fi
if grep rhel   /etc/os-release; then sudo dnf     remove --assumeyes htop; fi

# install imagination on pc06 pc07
# -----------------------------------------------------------------------------
# Slideshow maker.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo apt-get install --assume-yes imagination; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then echo 'The imagination app is not available.'; fi

# remove imagination from pc06 pc07
# -----------------------------------------------------------------------------
# Slideshow maker.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo apt-get purge --assume-yes imagination; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then echo 'The imagination app is not available.'; fi

# install jq on pc06 pc07
# -----------------------------------------------------------------------------
# JSON processor.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release; then sudo apt-get install --assume-yes jq; fi
if grep rhel   /etc/os-release; then sudo dnf     install --assumeyes  jq; fi

# remove jq from pc06 pc07
# -----------------------------------------------------------------------------
# JSON processor.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release; then sudo apt-get purge --assume-yes jq; fi
if grep rhel   /etc/os-release; then sudo dnf     remove --assumeyes jq; fi

# install krita on pc06
# -----------------------------------------------------------------------------
# Image manipulation.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo apt-get install --assume-yes krita; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then echo 'The krita app is not available.'; fi

# remove krita from pc06
# -----------------------------------------------------------------------------
# Image manipulation.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo apt-get purge --assume-yes krita; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then echo 'The krita app is not available.'; fi

# install kvm on pc06 pc07
# -----------------------------------------------------------------------------
# Kernel-based Virtual Machine.
# Images are in: /var/lib/libvirt/images/
# Reboot required!
# Dpkg::Options to prevent interaction while restoring /etc/libvirt
# configuration files.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes --option Dpkg::Options::="--force-confdef" --option Dpkg::Options::="--force-confold" bridge-utils cpu-checker libvirt-clients libvirt-daemon-system qemu-kvm qemu-system virtinst virt-manager; fi
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo usermod --append --groups libvirt,libvirt-qemu "${SUDO_USER:-$USER}"; fi
# -----------------------------------------------------------------------------
# Prevent "Error starting domain: Requested operation is not valid: network
# 'default' is not active".
# -----------------------------------------------------------------------------
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo virsh --connect=qemu:///system net-autostart default; fi
# -----------------------------------------------------------------------------
# Check network 'default' with
# "sudo virsh --connect=qemu:///system net-info default", should output
# 'Autostart: yes'.
# -----------------------------------------------------------------------------
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo dnf groupinstall "Virtualization Host"; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo systemctl enable --now libvirtd; fi
# -----------------------------------------------------------------------------
# Prevent "Error starting domain: Requested operation is not valid: network
# 'default' is not active".
# -----------------------------------------------------------------------------
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo virsh --connect=qemu:///system net-autostart default; fi
# -----------------------------------------------------------------------------
# Check network 'default' with
# "sudo virsh --connect=qemu:///system net-info default", should output
# 'Autostart: yes'.
# -----------------------------------------------------------------------------

# remove kvm from pc06 pc07
# -----------------------------------------------------------------------------
# Kernel-based Virtual Machine.
# Images are in: /var/lib/libvirt/images/
# Reboot required!
# -----------------------------------------------------------------------------
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo virsh --connect=qemu:///system net-autostart default --disable; fi
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo apt-get purge --assume-yes bridge-utils cpu-checker libvirt-clients libvirt-daemon-system qemu-kvm qemu-system virtinst virt-manager; fi
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo gpasswd --delete "${SUDO_USER:-$USER}" libvirt; fi
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo gpasswd --delete "${SUDO_USER:-$USER}" libvirt-qemu; fi
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo groupdel libvirt; fi
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo groupdel libvirt-qemu; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo systemctl disable --now libvirtd; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo dnf groupremove "Virtualization Host"; fi

# install lftp on pc06 pc07
# -----------------------------------------------------------------------------
# FTP/HTTP/BitTorrent client.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release; then sudo apt-get install --assume-yes lftp; fi
if grep rhel   /etc/os-release; then sudo dnf     install --assumeyes  lftp; fi

# remove lftp from pc06 pc07
# -----------------------------------------------------------------------------
# FTP/HTTP/BitTorrent client.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release; then sudo apt-get purge --assume-yes lftp; fi
if grep rhel   /etc/os-release; then sudo dnf     remove --assumeyes lftp; fi

# install libreoffice on *
# -----------------------------------------------------------------------------
# Office suite.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo apt-get install --assume-yes libreoffice; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]] &&   dnf list libreoffice; then sudo dnf     install --assumeyes  libreoffice; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]] && ! dnf list libreoffice; then sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]] && ! dnf list libreoffice; then sudo flatpak install --assumeyes  app/org.libreoffice.LibreOffice; fi

# remove libreoffice from *
# -----------------------------------------------------------------------------
# Office suite.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo apt-get purge --assume-yes libreoffice; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]] &&   dnf list libreoffice; then sudo dnf     remove --assumeyes libreoffice; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]] && ! dnf list libreoffice; then sudo flatpak uninstall --assumeyes  app/org.libreoffice.LibreOffice; fi

# install locate on pc06 pc07
# -----------------------------------------------------------------------------
# Find files.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release; then sudo apt-get install --assume-yes locate; fi
if grep rhel   /etc/os-release; then sudo dnf     install --assumeyes  mlocate; fi
sudo updatedb

# remove locate from pc06 pc07
# -----------------------------------------------------------------------------
# Find files.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release; then sudo apt-get purge --assume-yes locate; fi
if grep rhel   /etc/os-release; then sudo dnf     remove --assumeyes mlocate; fi

# install log-access on pc06 pc07
# -----------------------------------------------------------------------------
# Log access.
# -----------------------------------------------------------------------------
sudo usermod --append --groups adm,systemd-journal "${SUDO_USER:-$USER}"

# remove log-access from pc06 pc07
# -----------------------------------------------------------------------------
# Log access.
# -----------------------------------------------------------------------------
sudo gpasswd --delete "${SUDO_USER:-$USER}" adm
sudo gpasswd --delete "${SUDO_USER:-$USER}" systemd-journal

# install mypy on pc06 pc07
# -----------------------------------------------------------------------------
# Python static typing.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release; then sudo apt-get install --assume-yes mypy; fi
if grep rhel   /etc/os-release; then sudo dnf     install --assumeyes  python3-mypy; fi

# remove mypy from pc06 pc07
# -----------------------------------------------------------------------------
# Python static typing.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release; then sudo apt-get purge --assume-yes mypy; fi
if grep rhel   /etc/os-release; then sudo dnf     remove --assumeyes python3-mypy; fi

# install nautilus-admin on pc06 pc07
# -----------------------------------------------------------------------------
# Administrative operations.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo apt-get install --assume-yes nautilus-admin; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then echo 'The nautilus-admin app is not available.'; fi

# remove nautilus-admin from pc06 pc07
# -----------------------------------------------------------------------------
# Administrative operations.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo apt-get purge --assume-yes nautilus-admin; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then echo 'The nautilus-admin app is not available.'; fi

# install nmap on pc06 pc07
# -----------------------------------------------------------------------------
# Network MAPper.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release; then sudo apt-get install --assume-yes nmap; fi
if grep rhel   /etc/os-release; then sudo dnf     install --assumeyes  nmap; fi

# remove nmap from pc06 pc07
# -----------------------------------------------------------------------------
# Network MAPper.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release; then sudo apt-get purge --assume-yes nmap; fi
if grep rhel   /etc/os-release; then sudo dnf     remove --assumeyes nmap; fi

# install ntfs on #none
# -----------------------------------------------------------------------------
# NTFS support.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release; then sudo apt-get install --assume-yes ntfs-3g; fi
if grep rhel   /etc/os-release; then sudo dnf     install --assumeyes  ntfs-3g ntfsprogs; fi
# -----------------------------------------------------------------------------
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
# -----------------------------------------------------------------------------

# remove ntfs from #none
# -----------------------------------------------------------------------------
# NTFS support.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release; then sudo apt-get purge --assume-yes ntfs-3g; fi
if grep rhel   /etc/os-release; then sudo dnf     remove --assumeyes ntfs-3g ntfsprogs; fi

# install poedit on pc06 pc07
# -----------------------------------------------------------------------------
# Gettext catalogs editor.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release; then sudo apt-get install --assume-yes poedit; fi
if grep rhel   /etc/os-release; then sudo dnf     install --assumeyes  poedit; fi

# remove poedit from pc06 pc07
# -----------------------------------------------------------------------------
# Gettext catalogs editor.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release; then sudo apt-get purge --assume-yes poedit; fi
if grep rhel   /etc/os-release; then sudo dnf     remove --assumeyes poedit; fi

# install python on pc06 pc07
# -----------------------------------------------------------------------------
# Programming language.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release; then sudo apt-get install --assume-yes pycodestyle python3-pycodestyle python3-autopep8 python3-pip python-is-python3; fi
if grep debian /etc/os-release; then sudo ln --force --relative --symbolic /usr/bin/pycodestyle /usr/bin/pep8; fi
if grep debian /etc/os-release; then sudo ln --force --relative --symbolic /usr/bin/pip3 /usr/bin/pip; fi
if grep rhel   /etc/os-release; then sudo dnf     install --assumeyes  python3 python3-pycodestyle python3-pip; fi

# remove python from pc06 pc07
# -----------------------------------------------------------------------------
# Programming language.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release; then sudo apt-get purge --assume-yes pycodestyle python3-pycodestyle python3-autopep8 python3-pip python-is-python3; fi
if grep debian /etc/os-release; then sudo rm --force --verbose /usr/bin/pep8 /usr/bin/pip; fi
if grep rhel   /etc/os-release; then sudo dnf     remove --assumeyes python3 python3-pycodestyle python3-pip; fi

# install rpm on pc06 pc07
# -----------------------------------------------------------------------------
# Package manager.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release; then sudo apt-get install --assume-yes rpm; fi
if grep rhel   /etc/os-release; then sudo dnf     install --assumeyes  rpm; fi

# remove rpm from pc06 pc07
# -----------------------------------------------------------------------------
# Package manager for RPM.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release; then sudo apt-get purge --assume-yes rpm; fi
if grep rhel   /etc/os-release; then echo 'The rpm app cannot be removed.'; fi

# install simplescreenrecorder on #none
# -----------------------------------------------------------------------------
# Screen recorder.
# Requires the use of Xorg/X11.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo apt-get install --assume-yes simplescreenrecorder; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then echo 'The simplescreenrecorder app is not available.'; fi

# remove simplescreenrecorder from #none
# -----------------------------------------------------------------------------
# Screen recorder.
# Required the use of Xorg/X11. Enable Wayland again?
# -----------------------------------------------------------------------------
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo apt-get purge --assume-yes simplescreenrecorder; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then echo 'The simplescreenrecorder app is not available.'; fi

# install skip-grub-menu on *
# -----------------------------------------------------------------------------
# Skip GRUB menu.
# -----------------------------------------------------------------------------
sudo sed --in-place 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/' /etc/default/grub
if grep debian /etc/os-release; then sudo update-grub; fi
if grep rhel   /etc/os-release; then grub2-mkconfig -o /boot/grub2/grub.cfg; fi

# remove skip-grub-menu from *
# -----------------------------------------------------------------------------
# Skip GRUB menu.
# -----------------------------------------------------------------------------
sudo sed --in-place 's/GRUB_TIMEOUT=0/GRUB_TIMEOUT=5/' /etc/default/grub
if grep debian /etc/os-release; then sudo update-grub; fi
if grep rhel   /etc/os-release; then grub2-mkconfig -o /boot/grub2/grub.cfg; fi

# install shellcheck on pc06 pc07
# -----------------------------------------------------------------------------
# Shell script linter.
# Web app: https://www.shellcheck.net
# -----------------------------------------------------------------------------
if grep debian /etc/os-release; then sudo apt-get install --assume-yes shellcheck; fi
if grep rhel   /etc/os-release; then sudo dnf     install --assumeyes  shellcheck; fi

# remove shellcheck from pc06 pc07
# -----------------------------------------------------------------------------
# Shell script linter.
# Web app: https://www.shellcheck.net
# -----------------------------------------------------------------------------
if grep debian /etc/os-release; then sudo apt-get purge --assume-yes shellcheck; fi
if grep rhel   /etc/os-release; then sudo dnf     remove --assumeyes shellcheck; fi

# install sound-juicer on #none
# -----------------------------------------------------------------------------
# Audio-cd ripper and player.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo apt-get install --assume-yes sound-juicer; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then echo 'The sound-juicer app is not available.'; fi

# remove sound-juicer from #none
# -----------------------------------------------------------------------------
# Audio-cd ripper and player.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo apt-get purge --assume-yes sound-juicer; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then echo 'The sound-juicer app is not available.'; fi

# install spice-vdagent on #none
# -----------------------------------------------------------------------------
# Spice (Simple Protocol for Independent Computing Environments) agent for virtualized guest systems.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release; then sudo apt-get install --assume-yes spice-vdagent; fi
if grep rhel   /etc/os-release; then sudo dnf     install --assumeyes  spice-vdagent; fi

# remove spice-vdagent from #none
# -----------------------------------------------------------------------------
# Spice (Simple Protocol for Independent Computing Environments) agent for virtualized guest systems.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release; then sudo apt-get purge --assume-yes spice-vdagent; fi
if grep rhel   /etc/os-release; then sudo dnf     remove --assumeyes spice-vdagent; fi

# install spotify on pc01 pc02 pc06 pc07
# -----------------------------------------------------------------------------
# Music and podcasts.
# Web app: https://open.spotify.com
# -----------------------------------------------------------------------------
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then wget --no-verbose --output-document=- https://download.spotify.com/debian/pubkey_C85668DF69375001.gpg | sudo gpg --dearmor --yes --output=/usr/share/keyrings/spotify.gpg; fi
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/spotify.gpg] https://repository.spotify.com stable non-free' | sudo tee /etc/apt/sources.list.d/spotify.list; fi
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo apt-get update; fi
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo apt-get install --assume-yes spotify-client; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then echo 'The spotify app is available as a web app.'; fi

# remove spotify from pc01 pc02 pc06 pc07
# -----------------------------------------------------------------------------
# Music and podcasts.
# Web app: https://open.spotify.com
# -----------------------------------------------------------------------------
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo apt-get purge --assume-yes spotify-client; fi
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo rm --force --verbose /usr/share/keyrings/spotify.gpg /etc/apt/sources.list.d/spotify.list /etc/apt/sources.list.d/spotify.sources; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then echo 'The spotify web app cannot be removed.'; fi

# install ssh on pc01 pc06 pc07
# -----------------------------------------------------------------------------
# Secure SHell.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release; then sudo apt-get install --assume-yes ssh; fi
if grep rhel   /etc/os-release; then sudo dnf     install --assumeyes  openssh; fi
sudo sed --in-place 's/PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
# -----------------------------------------------------------------------------
# Check for remote root access.
# -----------------------------------------------------------------------------
grep 'PermitRootLogin no' /etc/ssh/sshd_config
sudo systemctl restart ssh.service

# remove ssh from pc01 pc06 pc07
# -----------------------------------------------------------------------------
# Secure SHell.
# -----------------------------------------------------------------------------
sudo sed --in-place 's/PermitRootLogin no/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config
if grep debian /etc/os-release; then sudo apt-get purge --assume-yes ssh; fi
if grep rhel   /etc/os-release; then sudo dnf     remove --assumeyes openssh; fi

# install tab-completion on pc01 pc06 pc07
# -----------------------------------------------------------------------------
# Bash completion.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release; then sudo apt-get install --assume-yes bash-completion; fi
if grep rhel   /etc/os-release; then sudo dnf     install --assumeyes  bash-completion; fi

# remove tab-completion from pc01 pc06 pc07
# -----------------------------------------------------------------------------
# Bash completion.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release; then sudo apt-get purge --assume-yes bash-completion; fi
if grep rhel   /etc/os-release; then sudo dnf     remove --assumeyes bash-completion; fi

# install teamviewer on *
# -----------------------------------------------------------------------------
# Remote desktop.
# Web app: https://web.teamviewer.com
# -----------------------------------------------------------------------------
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then wget --no-verbose --output-document=/tmp/teamviewer.deb https://download.teamviewer.com/download/linux/teamviewer_amd64.deb; fi
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo apt-get install --assume-yes /tmp/teamviewer.deb; fi
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then rm --verbose /tmp/teamviewer.deb; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo dnf     install --assumeyes  https://download.teamviewer.com/download/linux/teamviewer.x86_64.rpm; fi

# remove teamviewer from *
# -----------------------------------------------------------------------------
# Remote desktop.
# Web app: https://web.teamviewer.com
# -----------------------------------------------------------------------------
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo apt-get purge --assume-yes teamviewer; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo dnf     remove --assumeyes teamviewer; fi

# install thunderbird on *
# -----------------------------------------------------------------------------
# E-mail and news.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo apt-get install --assume-yes thunderbird; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo dnf     install --assumeyes  thunderbird; fi

# remove thunderbird from *
# -----------------------------------------------------------------------------
# E-mail and news.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo apt-get purge --assume-yes thunderbird; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo dnf     remove --assumeyes thunderbird; fi

# install transmission on pc01 pc06 pc07
# -----------------------------------------------------------------------------
# BitTorrent client.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo apt-get install --assume-yes transmission; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo dnf     install --assumeyes  transmission; fi

# remove transmission from pc01 pc06 pc07
# -----------------------------------------------------------------------------
# BitTorrent client.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release; then sudo apt-get purge --assume-yes transmission; fi
if grep rhel   /etc/os-release; then sudo dnf     remove --assumeyes transmission; fi

# install tree on pc06 pc07
# -----------------------------------------------------------------------------
# Display directory tree.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release; then sudo apt-get install --assume-yes tree; fi
if grep rhel   /etc/os-release; then sudo dnf     install --assumeyes  tree; fi

# remove tree from pc06 pc07
# -----------------------------------------------------------------------------
# Display directory tree.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release; then sudo apt-get purge --assume-yes tree; fi
if grep rhel   /etc/os-release; then sudo dnf     remove --assumeyes tree; fi

# install ufw on pc01 pc06 pc07
# -----------------------------------------------------------------------------
# Uncomplicated FireWall.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo apt-get install --assume-yes gufw; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo dnf     install --assumeyes  gufw; fi
sudo ufw allow ssh
sudo ufw enable

# remove ufw from pc01 pc06 pc07
# -----------------------------------------------------------------------------
# Uncomplicated FireWall.
# -----------------------------------------------------------------------------
sudo ufw disable
if grep debian /etc/os-release; then sudo apt-get purge --assume-yes gufw; fi
if grep rhel   /etc/os-release; then sudo dnf     remove --assumeyes gufw; fi

# install usbutils on pc06 pc07
# -----------------------------------------------------------------------------
# USB utilities.
# This package contains the lsusb utility.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release; then sudo apt-get install --assume-yes usbutils; fi
if grep rhel   /etc/os-release; then sudo dnf     install --assumeyes  usbutils; fi

# remove usbutils from pc06 pc07
# -----------------------------------------------------------------------------
# USB utilities.
# This package contains the lsusb utility.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release; then sudo apt-get purge --assume-yes usbutils; fi
if grep rhel   /etc/os-release; then sudo dnf     remove --assumeyes usbutils; fi

# install user-guest on pc01 pc06 pc07
# -----------------------------------------------------------------------------
# Add guest user.
# -----------------------------------------------------------------------------
if ! id "$(gettext --domain=kz 'guest')"; then sudo useradd --create-home --shell /usr/bin/bash --comment "$(gettext --domain=kz 'Guest user')" "$(gettext --domain=kz 'guest')"; fi
if   id "$(gettext --domain=kz 'guest')"; then sudo passwd --delete "$(gettext --domain=kz 'guest')"; fi

# remove user-guest from pc01 pc06 pc07
# -----------------------------------------------------------------------------
# Delete guest user.
# -----------------------------------------------------------------------------
if id "$(gettext --domain=kz 'guest')"; then sudo userdel --remove "$(gettext --domain=kz 'guest')"; fi

# install virtualbox on #none
# -----------------------------------------------------------------------------
# Virtualization.
# VirtualBox Guest user Additions ISO are in '/usr/share/virtualbox/'.
# If the installation hangs or VBox does not work, check the virtualization
# settings in the BIOS/UEFI.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then echo 'virtualbox-ext-pack virtualbox-ext-pack/license select true' | sudo debconf-set-selections; fi
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo apt-get install --assume-yes virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo dnf     install --assumeyes  VirtualBox; fi

# remove virtualbox from #none
# -----------------------------------------------------------------------------
# Virtualization.
# VirtualBox Guest user Additions ISO are in '/usr/share/virtualbox/'.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo apt-get purge --assume-yes virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo dnf     remove --assumeyes VirtualBox; fi

# install vlc on *
# -----------------------------------------------------------------------------
# Multimedia player.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo apt-get install --assume-yes vlc; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo dnf     install --assumeyes  vlc; fi

# remove vlc from *
# -----------------------------------------------------------------------------
# Multimedia player.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo apt-get purge --assume-yes vlc; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo dnf     remove --assumeyes vlc; fi

# install vscode on pc01 pc06 pc07
# -----------------------------------------------------------------------------
# Editor.
# Web app: https://vscode.dev
# -----------------------------------------------------------------------------
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then echo "code code/add-microsoft-repo boolean true" | sudo debconf-set-selections; fi
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then wget --no-verbose --output-document=- https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor --yes --output=/usr/share/keyrings/microsoft.gpg; fi
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then echo -e "Types: deb\nURIs: https://packages.microsoft.com/repos/code\nSuites: stable\nComponents: main\nArchitectures: amd64,arm64,armhf\nSigned-By: /usr/share/keyrings/microsoft.gpg" |sudo tee /etc/apt/sources.list.d/vscode.sources; fi
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo apt-get install --assume-yes apt-transport-https; fi
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo apt-get update; fi
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo apt-get install --assume-yes code; fi
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo update-alternatives --set editor /usr/bin/code; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then echo -e '[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc' | sudo tee /etc/yum.repos.d/vscode.repo; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo dnf     install --assumeyes  code; fi

# remove vscode from pc01 pc06 pc07
# -----------------------------------------------------------------------------
# Editor.
# Web app: https://vscode.dev
# -----------------------------------------------------------------------------
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo update-alternatives --remove editor /usr/bin/code; fi
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo apt-get purge --assume-yes code; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo dnf     remove --assumeyes code; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo rm --force --verbose /etc/yum.repos.d/vscode.repo; fi

# install webmin on pc07
# -----------------------------------------------------------------------------
# Web console.
# Web app: https://localhost:10000
# -----------------------------------------------------------------------------
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then wget --output-document=/tmp/setup-repos.sh https://raw.githubusercontent.com/webmin/webmin/master/setup-repos.sh; fi
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo sh /tmp/setup-repos.sh --force; fi
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo rm --force --verbose /tmp/setup-repos.sh; fi
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo apt-get install --assume-yes webmin; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then wget --output-document=/tmp/setup-repos.sh https://raw.githubusercontent.com/webmin/webmin/master/setup-repos.sh; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo sh /tmp/setup-repos.sh --force; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo rm --force --verbose /tmp/setup-repos.sh; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo dnf     install --assumeyes  webmin; fi

# remove webmin from pc07
# -----------------------------------------------------------------------------
# Web console.
# Web app: https://localhost:10000
# -----------------------------------------------------------------------------
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo apt-get purge --assume-yes webmin; fi
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo rm --force --verbose /usr/share/keyrings/*webmin*.gpg /etc/apt/sources.list.d/webmin*.list /etc/apt/sources.list.d/webmin*.sources; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo dnf     remove --assumeyes webmin; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo rm --force --verbose /etc/yum.repos.d/webmin.repo; fi

# install wine on #none
# -----------------------------------------------------------------------------
# Run Windows applications.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo dpkg --add-architecture i386; fi
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo apt-get install --assume-yes wine winetricks playonlinux; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo dnf     install --assumeyes  wine playonlinux; fi

# remove wine from #none
# -----------------------------------------------------------------------------
# Run Windows applications.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo apt-get purge --assume-yes wine winetricks playonlinux; fi
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo dpkg --remove-architecture i386; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo dnf     remove --assumeyes wine playonlinux; fi

# install youtube-dl on #none
# -----------------------------------------------------------------------------
# Download videos.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo apt-get install --assume-yes youtubedl-gui; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo dnf     install --assumeyes  youtube-dl; fi

# remove youtube-dl from #none
# -----------------------------------------------------------------------------
# Download videos.
# -----------------------------------------------------------------------------
if grep debian /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo apt-get purge --assume-yes youtubedl-gui; fi
if grep rhel   /etc/os-release && [[ -n ${DISPLAY-} ]]; then sudo dnf     remove --assumeyes youtube-dl; fi
