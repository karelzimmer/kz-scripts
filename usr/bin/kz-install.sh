# shellcheck shell=bash
###############################################################################
# SPDX-FileComment: Install file for use with kz-install script
#
# SPDX-FileCopyrightText: Karel Zimmer <info@karelzimmer.nl>
# SPDX-License-Identifier: CC0-1.0
###############################################################################
# [info] For the format of the records in this file run: man kz install
# [info] To manually run a command, first run: source kz_common.sh

# First install app disabled-apport, then app update-system.
# The rest of the apps are in alphabetical order of app name.

# Install disabled-apport on *
# Disable Ubuntu's automatic crash report generation.
if $UBUNTU; then sudo systemctl stop apport.service; fi
if $UBUNTU; then sudo systemctl disable apport.service; fi
if $UBUNTU; then sudo sed --in-place --expression='s/enabled=1/enabled=0/' /etc/default/apport; fi
if $UBUNTU; then sudo rm --force --verbose /var/crash/*; fi

# Remove disabled-apport from *
# Enable Ubuntu's automatic crash report generation.
if $UBUNTU; then sudo sed --in-place --expression='s/enabled=0/enabled=1/' /etc/default/apport; fi
if $UBUNTU; then sudo systemctl enable --now apport.service; fi

# Install update-system on *
sudo kz-update

# Remove update-system from *
echo 'App update-system cannot be removed.'

# Install 7zip on *
if $APT_SYSTEM; then sudo apt-get install --assume-yes p7zip-full; fi
if $RPM_SYSTEM; then sudo dnf install --assumeyes p7zip; fi

# Remove 7zip from *
if $APT_SYSTEM; then sudo apt-get remove --assume-yes p7zip-full; fi
if $RPM_SYSTEM; then sudo dnf remove --assumeyes p7zip; fi

# Install ansible on pc06 pc07
if $APT_SYSTEM; then sudo apt-get install --assume-yes ansible; fi
if $RPM_SYSTEM; then sudo dnf install --assumeyes ansible; fi

# Remove ansible from pc06 pc07
if $APT_SYSTEM; then sudo apt-get remove --assume-yes ansible; fi
if $RPM_SYSTEM; then sudo dnf remove --assumeyes ansible; fi

# Install anydesk on pc06 pc07
# Remote Wayland display server is not supported.
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then wget --output-document=- https://keys.anydesk.com/repos/DEB-GPG-KEY | sudo gpg --dearmor --yes --output=/usr/share/keyrings/anydesk.gpg; fi
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/anydesk.gpg] http://deb.anydesk.com/ all main' | sudo tee /etc/apt/sources.list.d/anydesk.list; fi
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get update; fi
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get install --assume-yes anydesk; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then echo -e '[anydesk]\nname=AnyDesk RHEL - stable\nbaseurl=http://rpm.anydesk.com/rhel/x86_64/\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://keys.anydesk.com/repos/RPM_SYSTEM-GPG-KEY' | sudo tee /etc/yum.repos.d/AnyDesk-RHEL.repo; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then sudo dnf install --assumeyes anydesk; fi
# Web app: https://my.anydesk.com/v2

# Remove anydesk from pc06 pc07
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get remove --assume-yes anydesk; fi
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo rm --force --verbose /etc/apt/sources.list.d/anydesk.list* /usr/share/keyrings/anydesk.gpg*; fi
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get update; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then sudo dnf remove --assumeyes anydesk; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then sudo rm --force --verbose /etc/yum.repos.d/AnyDesk-RHEL.repo*; fi

# Install apt on -none
if $APT_SYSTEM; then sudo apt-get install --assume-yes apt; fi
if $RPM_SYSTEM; then sudo dnf install --assumeyes apt; fi

# Remove apt from -none
if $APT_SYSTEM; then echo 'App apt cannot be removed from an APT system.'; fi
if $RPM_SYSTEM; then sudo dnf remove --assumeyes apt; fi

# Install backintime on -none
# Back In Time is a simple backup tool for Linux.
# The backup is done by taking snapshots of a specified set of folders.
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get install --assume-yes backintime-qt; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then sudo dnf install --assumeyes backintime-qt; fi

# Remove backintime on -none
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get remove --assume-yes backintime-qt; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then sudo dnf remove --assumeyes backintime-qt; fi

# Install bleachbit on pc-van-hugo
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get install --assume-yes bleachbit; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then sudo dnf install --assumeyes bleachbit; fi

# Remove bleachbit from pc-van-hugo
if $APT_SYSTEM; then sudo apt-get remove --assume-yes bleachbit; fi
if $RPM_SYSTEM; then sudo dnf remove --assumeyes bleachbit; fi

# Install calibre on pc06 pc-van-hugo
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get install --assume-yes calibre; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then sudo --validate && wget --output-document=- https://download.calibre-ebook.com/linux-installer.sh | sudo sh; fi

# Remove calibre from pc06 pc-van-hugo
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get remove --assume-yes calibre; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then sudo calibre-uninstall; fi

# Install change-grub-timeout on *
sudo sed --in-place --expression='s/GRUB_TIMEOUT=5/GRUB_TIMEOUT=1/' /etc/default/grub
sudo sed --in-place --expression='s/GRUB_TIMEOUT=10/GRUB_TIMEOUT=1/' /etc/default/grub
if $APT_SYSTEM; then sudo update-grub; fi
if $RPM_SYSTEM; then sudo grub2-mkconfig -o /boot/grub2/grub.cfg; fi

# Remove change-grub-timeout from *
sudo sed --in-place --expression='s/GRUB_TIMEOUT=1/GRUB_TIMEOUT=5/' /etc/default/grub
if $APT_SYSTEM; then sudo update-grub; fi
if $RPM_SYSTEM; then sudo grub2-mkconfig -o /boot/grub2/grub.cfg; fi

# Install cockpit on pc06
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get install --assume-yes cockpit cockpit-pcp; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then sudo dnf install --assumeyes cockpit cockpit-pcp; fi
# Web app: https://localhost:9090

# Remove cockpit from pc06
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get remove --assume-yes cockpit; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then sudo dnf remove --assumeyes cockpit; fi

# Install cups on *
if $APT_SYSTEM; then sudo apt-get install --assume-yes cups; fi
if $RPM_SYSTEM; then sudo dnf install --assumeyes cups; fi

# Remove cups from *
if $APT_SYSTEM; then sudo apt-get remove --assume-yes cups; fi
if $RPM_SYSTEM; then sudo dnf remove --assumeyes cups; fi

# Install cups-backend-canon on pc-van-emily
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get install --assume-yes cups-backend-bjnp; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then echo 'App cups-backend-canon is not available on an RPM system.'; fi

# Remove cups-backend-canon from pc-van-emily
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get remove --assume-yes cups-backend-bjnp; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then echo 'App cups-backend-canon is not available on an RPM system.'; fi

# Install dash-to-dock on *
# Reboot required!
if $DESKTOP_ENVIRONMENT && $DEBIAN; then sudo apt-get install --assume-yes gnome-shell-extension-dashtodock gnome-shell-extension-no-overview; fi
if $DESKTOP_ENVIRONMENT && $ROCKY; then sudo dnf install --assumeyes gnome-shell-extension-dash-to-dock; fi

# Remove dash-to-dock from *
# Reboot required!
if $DESKTOP_ENVIRONMENT && $DEBIAN; then sudo apt-get remove --assume-yes gnome-shell-extension-dashtodock; fi
if $DESKTOP_ENVIRONMENT && $ROCKY; then sudo dnf remove --assumeyes gnome-shell-extension-dash-to-dock; fi

# Install disabled-aer on pc06
# Disable kernel config parameter PCIEAER (Peripheral Component Interconnect Express Advanced Error Reporting).
# To prevent the log gets flooded with 'AER: Corrected errors received'. Usually needed for HP hardware.
sudo sed --in-place --expression='s/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash pci=noaer"/' /etc/default/grub
if $APT_SYSTEM; then sudo update-grub; fi
if $RPM_SYSTEM; then sudo grub2-mkconfig -o /boot/grub2/grub.cfg; fi
# Check for kernel config parameter pci=noaer.
grep --quiet --regexp='pci=noaer' /etc/default/grub

# Remove disabled-aer from pc06
# Enable kernel config parameter PCIEAER.
sudo sed --in-place --expression='s/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash pci=noaer"/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash pci=noaer"/' /etc/default/grub
if $APT_SYSTEM; then sudo update-grub; fi
if $RPM_SYSTEM; then sudo grub2-mkconfig -o /boot/grub2/grub.cfg; fi
# Check for kernel config parameter pci=noaer.
! grep --quiet --regexp='pci=noaer' /etc/default/grub

# Install disabled-fwupd on -none
# Disable the Firmware update daemon.
sudo systemctl stop fwupd.service
sudo systemctl disable fwupd.service
sudo systemctl mask fwupd.service

# Remove disabled-fwupd from -none
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
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get install --assume-yes libimage-exiftool-perl; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then sudo dnf install --assumeyes perl-Image-ExifTool; fi

# Remove exiftool from pc06 pc07
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get remove --assume-yes libimage-exiftool-perl; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then sudo dnf remove --assumeyes perl-Image-ExifTool; fi

# Install fakeroot on pc06 pc07
if $APT_SYSTEM; then sudo apt-get install --assume-yes fakeroot; fi
if $RPM_SYSTEM; then sudo dnf install --assumeyes fakeroot; fi

# Remove fakeroot from pc06 pc07
if $APT_SYSTEM; then sudo apt-get remove --assume-yes fakeroot; fi
if $RPM_SYSTEM; then sudo dnf remove --assumeyes fakeroot; fi

# Install fdupes on -none
if $APT_SYSTEM; then sudo apt-get install --assume-yes fdupes; fi
if $RPM_SYSTEM; then sudo dnf install --assumeyes fdupes; fi
# Usage:
# $ fdupes -r /path/to/folder   # Report recursively from /path/to/folder
# $ fdupes -rd /path/to/folder  # Delete, interactively, from /path/to/folder
# $ fdupes -rdN /path/to/folder # Delete, from /path/to/folder, keep first dup

# Remove fdupes from -none
if $APT_SYSTEM; then sudo apt-get remove --assume-yes fdupes; fi
if $RPM_SYSTEM; then sudo dnf remove --assumeyes fdupes; fi

# Install force-x11 on -none
# Force the use of X11 because Wayland is not (yet) supported by remote desktop app AnyDesk.
# Force means no choice @ user login for X11 or Wayland!
# Reboot required!
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo sed --in-place --expression='s/^#WaylandEnable=false/WaylandEnable=false/' /etc/gdm3/custom.conf; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then sudo sed --in-place --expression='s/^#WaylandEnable=false/WaylandEnable=false/' /etc/gdm/custom.conf; fi
# To check, after reboot (!), execute: echo $XDG_SESSION_TYPE (should output 'x11')

# Remove force-x11 from -none
# Enable choice @ user login for X11 or Wayland.
# Reboot required!
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo sed --in-place --expression='s/^WaylandEnable=false/#WaylandEnable=false/' /etc/gdm3/custom.conf; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then sudo sed --in-place --expression='s/^WaylandEnable=false/#WaylandEnable=false/' /etc/gdm/custom.conf; fi
# To check, after reboot (!), execute: echo $XDG_SESSION_TYPE (should output 'wayland')

# Install gdebi on *
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get install --assume-yes gdebi; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then echo 'App gdebi is not available on an RPM system.'; fi

# Remove gdebi from *
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get remove --assume-yes gdebi; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then echo 'App gdebi is not available on an RPM system.'; fi

# Install gettext on pc06 pc07
if $APT_SYSTEM; then sudo apt-get install --assume-yes gettext; fi
if $RPM_SYSTEM; then sudo dnf install --assumeyes gettext; fi

# Remove gettext from pc06 pc07
if $APT_SYSTEM; then sudo apt-get remove --assume-yes gettext; fi
if $RPM_SYSTEM; then sudo dnf remove --assumeyes gettext; fi

# Install gimp on pc-van-hugo pc06
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get install --assume-yes gimp gimp-help-en gimp-help-nl; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then sudo dnf install --assumeyes gimp; fi

# Remove gimp from pc-van-hugo pc06
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get remove --assume-yes gimp gimp-help-en gimp-help-nl; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then sudo dnf remove --assumeyes gimp; fi

# Install git on pc06 pc07
if $APT_SYSTEM; then sudo apt-get install --assume-yes git; fi
if $RPM_SYSTEM; then sudo sudo dnf install --assumeyes git; fi

# Remove git from pc06 pc07
if $APT_SYSTEM; then sudo apt-get remove --assume-yes git; fi
if $RPM_SYSTEM; then sudo sudo dnf remove --assumeyes git; fi

# Install gnome-gmail on pc01 pc06 pc07
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get install --assume-yes gnome-gmail; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then echo 'App gnome-gmail is not available on an RPM system.'; fi

# Remove gnome-gmail from pc01 pc06 pc07
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get remove --assume-yes gnome-gmail; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then echo 'App gnome-gmail is not available on an RPM system.'; fi

# Install gnome-tweaks on pc01 pc06 pc07
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get install --assume-yes gnome-tweaks; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then sudo dnf install --assumeyes gnome-tweaks; fi

# Remove gnome-tweaks from pc01 pc06 pc07
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get remove --assume-yes gnome-tweaks; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then sudo dnf remove --assumeyes gnome-tweaks; fi

# Install google-chrome on *
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then wget --output-document=- 'https://dl.google.com/linux/linux_signing_key.pub' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/google-chrome.gpg; fi
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] https://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list; fi
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get update; fi
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get install --assume-yes google-chrome-stable; fi
# Add the source list again because the installation overwrote the newly added source list.
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] https://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list; fi
# The apt-key added during installation is no longer needed.
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo rm --force --verbose /etc/apt/trusted.gpg.d/google-chrome.gpg; fi
# Import GPG Key.
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then sudo rpm --import https://dl.google.com/linux/linux_signing_key.pub; fi
# Install Google Chrome.
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then sudo dnf install --assumeyes https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm; fi

# Remove google-chrome from *
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get remove --assume-yes google-chrome-stable chrome-gnome-shell; fi
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo rm --force --verbose /etc/apt/sources.list.d/google-chrome.list* /usr/share/keyrings/google-chrome.gpg* /etc/apt/trusted.gpg.d/google-chrome.gpg; fi
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get update; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then sudo dnf remove --assumeyes https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then sudo rpm --erase gpg-pubkey-7fac5991-* gpg-pubkey-d38b4796-*; fi

# Install google-earth on -none
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then wget --output-document=- 'https://dl.google.com/linux/linux_signing_key.pub' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/google-earth.gpg; fi
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-earth.gpg] https://dl.google.com/linux/earth/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-earth-pro.list; fi
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get update; fi
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get install --assume-yes google-earth-pro-stable; fi
# Add the source list again because the installation overwrote the newly added source list.
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-earth.gpg] https://dl.google.com/linux/earth/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-earth-pro.list; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then echo -e '[google-earth]\nname=Google Earth - stable\nbaseurl=https://dl.google.com/linux/earth/rpm/stable/x86_64/\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://dl.google.com/linux/linux_signing_key.pub' | sudo tee /etc/yum.repos.d/google-earh.repo; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then sudo dnf install --assumeyes google-earth-pro-stable; fi

# Remove google-earth from -none
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get remove --assume-yes google-earth-pro-stable; fi
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo rm --force --verbose /etc/apt/sources.list.d/google-earth-pro.list* /usr/share/keyrings/google-earth.gpg*; fi
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get update; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then sudo dnf remove --assumeyes google-earth-pro-stable; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then sudo rm --force --verbose /etc/yum.repos.d/google-earth.repo*; fi

# Install handbrake on pc-van-emily
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get install --assume-yes handbrake; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then echo 'App handbrake is not available on an RPM system.'; fi

# Remove handbrake from pc-van-emily
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get remove --assume-yes handbrake; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then echo 'App handbrake is not available on an RPM system.'; fi

# Install htop on pc06 pc07
if $APT_SYSTEM; then sudo apt-get install --assume-yes htop; fi
if $RPM_SYSTEM; then sudo dnf install --assumeyes htop; fi

# Remove htop from pc06 pc07
if $APT_SYSTEM; then sudo apt-get remove --assume-yes htop; fi
if $RPM_SYSTEM; then sudo dnf remove --assumeyes htop; fi

# Install jq on pc06 pc07
if $APT_SYSTEM; then sudo apt-get install --assume-yes jq; fi
if $RPM_SYSTEM; then sudo dnf install --assumeyes jq; fi

# Remove jq from pc06 pc07
if $APT_SYSTEM; then sudo apt-get remove --assume-yes jq; fi
if $RPM_SYSTEM; then sudo dnf remove --assumeyes jq; fi

# Install krita on pc06
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get install --assume-yes krita; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then echo 'App krita is not available on an RPM system.'; fi

# Remove krita from pc06
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get remove --assume-yes krita; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then echo 'App krita is not available on an RPM system.'; fi

# Install kvm on pc06 pc07
# Reboot required!
# Dpkg::Options to prevent interaction while restoring /etc/libvirt configuration files.
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes --option Dpkg::Options::="--force-confdef" --option Dpkg::Options::="--force-confold" bridge-utils cpu-checker libvirt-clients libvirt-daemon-system qemu-kvm qemu-system virtinst virt-manager; fi
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo usermod --append --groups libvirt,libvirt-qemu karel; fi
# Prevent "Error starting domain: Requested operation is not valid: network 'default' is not active".
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo virsh --connect=qemu:///system net-autostart default; fi
# Check network 'default' with: sudo virsh --connect=qemu:///system net-info default (should output 'Autostart: yes')
# Images are in: /var/lib/libvirt/images/
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then sudo dnf groupinstall "Virtualization Host"; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then sudo systemctl enable --now libvirtd; fi
# Prevent "Error starting domain: Requested operation is not valid: network 'default' is not active".
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then sudo virsh --connect=qemu:///system net-autostart default; fi
# Check network 'default' with: sudo virsh --connect=qemu:///system net-info default (should output 'Autostart: yes')
# Images are in: /var/lib/libvirt/images/

# Remove kvm from pc06 pc07
# Reboot required!
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo virsh --connect=qemu:///system net-autostart default --disable; fi
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get remove --assume-yes bridge-utils cpu-checker libvirt-clients libvirt-daemon-system qemu-kvm qemu-system virtinst virt-manager; fi
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo delgroup libvirtd-dnsmasq; fi
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo deluser karel libvirtd; fi
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo deluser karel libvirtd-qemu; fi
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo delgroup libvirtd; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then sudo systemctl disable --now libvirtd; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then sudo dnf groupremove "Virtualization Host"; fi

# Install lftp on pc06 pc07
if $APT_SYSTEM; then sudo apt-get install --assume-yes lftp; fi
if $RPM_SYSTEM; then sudo dnf install --assumeyes lftp; fi

# Remove lftp from pc06 pc07
if $APT_SYSTEM; then sudo apt-get remove --assume-yes lftp; fi
if $RPM_SYSTEM; then sudo dnf remove --assumeyes lftp; fi

# Install libreoffice on *
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get install --assume-yes aspell-en aspell-nl libreoffice libreoffice-l10n-nl; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then sudo dnf install --assumeyes libreoffice; fi

# Remove libreoffice from *
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get remove --assume-yes aspell-en aspell-nl libreoffice libreoffice-l10n-nl; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then sudo dnf remove --assumeyes libreoffice; fi

# Install locate on pc06 pc07
if $APT_SYSTEM; then sudo apt-get install --assume-yes locate; fi
if $RPM_SYSTEM; then sudo dnf install --assumeyes mlocate; fi
sudo updatedb

# Remove locate from pc06 pc07
if $APT_SYSTEM; then sudo apt-get remove --assume-yes locate; fi
if $RPM_SYSTEM; then sudo dnf remove --assumeyes mlocate; fi

# Install log-access-for-user on pc07
if [[ $HOSTNAME = 'pc07' ]]; then sudo usermod --append --groups adm,systemd-journal karel; fi

# Remove log-access-for-user from pc07
if [[ $HOSTNAME = 'pc07' ]]; then sudo deluser karel adm; fi
if [[ $HOSTNAME = 'pc07' ]]; then sudo deluser karel systemd-journal; fi

# Install mypy on pc06 pc07
if $APT_SYSTEM; then sudo apt-get install --assume-yes mypy; fi
if $RPM_SYSTEM; then sudo dnf install --assumeyes python3-mypy; fi

# Remove mypy from pc06 pc07
if $APT_SYSTEM; then sudo apt-get remove --assume-yes mypy; fi
if $RPM_SYSTEM; then sudo dnf remove --assumeyes python3-mypy; fi

# Install nautilus-admin on pc06 pc07
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get install --assume-yes nautilus-admin; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then echo 'App nautilus-admin is not available on an RPM system.'; fi

# Remove nautilus-admin from pc06 pc07
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get remove --assume-yes nautilus-admin; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then echo 'App nautilus-admin is not available on an RPM system.'; fi

# Install nmap on pc06 pc07
if $APT_SYSTEM; then sudo apt-get install --assume-yes nmap; fi
if $RPM_SYSTEM; then sudo dnf install --assumeyes nmap; fi

# Remove nmap from pc06 pc07
if $APT_SYSTEM; then sudo apt-get remove --assume-yes nmap; fi
if $RPM_SYSTEM; then sudo dnf remove --assumeyes nmap; fi

# Install python on pc06 pc07
if $APT_SYSTEM; then sudo apt-get install --assume-yes pycodestyle python3-pycodestyle python3-autopep8 python3-pip python-is-python3; fi
if $APT_SYSTEM; then sudo ln --force --relative --symbolic /usr/bin/pycodestyle /usr/bin/pep8; fi
if $APT_SYSTEM; then sudo ln --force --relative --symbolic /usr/bin/pip3 /usr/bin/pip; fi
if $RPM_SYSTEM; then sudo dnf install --assumeyes python3 python3-pycodestyle python3-pip; fi

# Remove python from pc06 pc07
if $APT_SYSTEM; then sudo apt-get remove --assume-yes pycodestyle python3-pycodestyle python3-autopep8 python3-pip python-is-python3; fi
if $APT_SYSTEM; then sudo rm --force --verbose /usr/bin/pep8 /usr/bin/pip; fi
if $RPM_SYSTEM; then sudo dnf remove --assumeyes python3 python3-pycodestyle python3-pip; fi

# Install repair-ntfs on -none
if $APT_SYSTEM; then sudo apt-get install --assume-yes ntfs-3g; fi
if $RPM_SYSTEM; then sudo dnf install --assumeyes ntfs-3g ntfsprogs; fi
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

# Remove repair-ntfs from -none
if $APT_SYSTEM; then sudo apt-get remove --assume-yes ntfs-3g; fi
if $RPM_SYSTEM; then sudo dnf remove --assumeyes ntfs-3g ntfsprogs; fi

# Install rpm on pc06 pc07
if $APT_SYSTEM; then sudo apt-get install --assume-yes rpm; fi
if $RPM_SYSTEM; then sudo dnf install --assumeyes rpm; fi

# Remove rpm from pc06 pc07
if $APT_SYSTEM; then sudo apt-get remove --assume-yes rpm; fi
if $RPM_SYSTEM; then echo 'App rpm cannot be removed from an RPM system.'; fi

# Install shellcheck on pc06 pc07
if $APT_SYSTEM; then sudo apt-get install --assume-yes shellcheck; fi
if $RPM_SYSTEM; then sudo dnf install --assumeyes shellcheck; fi

# Remove shellcheck from pc06 pc07
if $APT_SYSTEM; then sudo apt-get remove --assume-yes shellcheck; fi
if $RPM_SYSTEM; then sudo dnf remove --assumeyes shellcheck; fi

# Install sound-juicer on pc-van-emily
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get install --assume-yes sound-juicer; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then echo 'App sound-juicer is not available on an RPM system.'; fi

# Remove sound-juicer from pc-van-emily
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get remove --assume-yes sound-juicer; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then echo 'App sound-juicer is not available on an RPM system.'; fi

# Install spice-vdagent on *
if $APT_SYSTEM; then sudo apt-get install --assume-yes spice-vdagent; fi
if $RPM_SYSTEM; then sudo dnf install --assumeyes spice-vdagent; fi

# Remove spice-vdagent from *
if $APT_SYSTEM; then sudo apt-get remove --assume-yes spice-vdagent; fi
if $RPM_SYSTEM; then sudo dnf remove --assumeyes spice-vdagent; fi

# Install ssh on pc01 pc06 pc07
if $APT_SYSTEM; then sudo apt-get install --assume-yes ssh; fi
if $RPM_SYSTEM; then sudo dnf install --assumeyes openssh; fi
sudo sed --in-place --expression='s/PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
if [[ 'pc01 pc06 pc07' =~ $HOSTNAME ]]; then sudo sed --in-place --expression='/^192.168.1./d' /etc/hosts; fi
if [[ 'pc01 pc06 pc07' =~ $HOSTNAME ]]; then sudo sed --in-place --expression='2a192.168.1.100 pc01' /etc/hosts; fi
if [[ 'pc01 pc06 pc07' =~ $HOSTNAME ]]; then sudo sed --in-place --expression='3a192.168.1.2   pc06' /etc/hosts; fi
if [[ 'pc01 pc06 pc07' =~ $HOSTNAME ]]; then sudo sed --in-place --expression='4a192.168.1.219 pc07' /etc/hosts; fi
# Check for remote root access.
grep --quiet --regexp='PermitRootLogin no' /etc/ssh/sshd_config
sudo systemctl restart ssh.service

# Remove ssh from pc01 pc06 pc07
if [[ 'pc01 pc06 pc07' =~ $HOSTNAME ]]; then sudo sed --in-place --expression='/^192.168.1./d' /etc/hosts; fi
sudo sed --in-place --expression='s/PermitRootLogin no/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config
if $APT_SYSTEM; then sudo apt-get remove --assume-yes ssh; fi
if $RPM_SYSTEM; then sudo dnf remove --assumeyes openssh; fi

# Install sushi on pc06
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get install --assume-yes gnome-sushi; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then sudo dnf install --assumeyes sushi; fi
# Usage:
# Select a file, press the space bar, and a preview will appear.

# Remove sushi from pc06
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get remove --assume-yes gnome-sushi; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then sudo dnf remove --assumeyes sushi; fi

# Install tab-completion on *
if $APT_SYSTEM; then sudo apt-get install --assume-yes bash-completion; fi
if $RPM_SYSTEM; then sudo dnf install --assumeyes bash-completion; fi

# Remove tab-completion from *
if $APT_SYSTEM; then sudo apt-get remove --assume-yes bash-completion; fi
if $RPM_SYSTEM; then sudo dnf remove --assumeyes bash-completion; fi

# Install teamviewer on *
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then wget --output-document=- 'https://download.teamviewer.com/download/linux/signature/TeamViewer2017.asc' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/teamviewer.gpg; fi
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then echo 'deb [signed-by=/usr/share/keyrings/teamviewer.gpg] https://linux.teamviewer.com/deb stable main' | sudo tee /etc/apt/sources.list.d/teamviewer.list; fi
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get update; fi
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes teamviewer; fi
# The apt-key added during installation is no longer needed.
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-key del 0C1289C0 DEB49217; fi
# EPEL: Extra Packages for Enterprise Linux
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then sudo dnf install --assumeyes epel-release; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then sudo dnf install --assumeyes https://teamviewer.com/download/linux/teamviewer.x86_64.rpm; fi
# Web app: https://web.teamviewer.com

# Remove teamviewer from *
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get remove --assume-yes teamviewer; fi
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo rm --force --verbose /etc/apt/sources.list.d/teamviewer.list* /usr/share/keyrings/teamviewer*.gpg*; fi
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-key del 0C1289C0 DEB49217; fi
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get update; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then sudo dnf remove --assumeyes teamviewer; fi

# Install thunderbird on *
if $DESKTOP_ENVIRONMENT && $DEBIAN; then sudo apt-get install --assume-yes thunderbird thunderbird-l10n-nl; fi
if $DESKTOP_ENVIRONMENT && $UBUNTU; then sudo apt-get install --assume-yes thunderbird thunderbird-locale-nl; fi
if $DESKTOP_ENVIRONMENT && $ROCKY; then sudo dnf install --assumeyes thunderbird; fi

# Remove thunderbird from *
if $DESKTOP_ENVIRONMENT && $DEBIAN; then sudo apt-get remove --assume-yes thunderbird-l10n-nl; fi
if $DESKTOP_ENVIRONMENT && $UBUNTU; then sudo apt-get remove --assume-yes thunderbird-locale-nl; fi
if $DESKTOP_ENVIRONMENT && $ROCKY; then sudo dnf remove --assumeyes thunderbird; fi

# Install tree on pc06 pc07
if $APT_SYSTEM; then sudo apt-get install --assume-yes tree; fi
if $RPM_SYSTEM; then sudo dnf install --assumeyes tree; fi

# Remove tree from pc06 pc07
if $APT_SYSTEM; then sudo apt-get remove --assume-yes tree; fi
if $RPM_SYSTEM; then sudo dnf remove --assumeyes tree; fi

# Install ufw on pc01 pc06 pc07
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get install --assume-yes gufw; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then sudo dnf install --assumeyes gufw; fi
if $DESKTOP_ENVIRONMENT; then sudo ufw allow ssh; fi
if $DESKTOP_ENVIRONMENT; then sudo ufw enable; fi

# Remove ufw from pc01 pc06 pc07
sudo ufw disable
if $APT_SYSTEM; then sudo apt-get remove --assume-yes gufw; fi
if $RPM_SYSTEM; then sudo dnf remove --assumeyes gufw; fi

# Install usbutils on pc07
# This package contains the lsusb utility.
if $APT_SYSTEM; then sudo apt-get install --assume-yes usbutils; fi
if $RPM_SYSTEM; then sudo dnf install --assumeyes usbutils; fi

# Remove usbutils from pc07
# This package contains the lsusb utility.
if $APT_SYSTEM; then sudo apt-get remove --assume-yes usbutils; fi
if $RPM_SYSTEM; then sudo dnf remove --assumeyes usbutils; fi

# Install user-guest on -none
sudo useradd --create-home --shell /usr/bin/bash --comment "$(gettext 'Guest user')" "$(gettext 'guest')" || true
sudo passwd --delete "$(gettext 'guest')"

# Remove user-guest from -none
sudo userdel --remove "$(gettext 'guest')"

# Install user-karel on pc01
if [[ $HOSTNAME = 'pc01' ]]; then sudo useradd --create-home --shell /usr/bin/bash --comment 'Karel Zimmer' karel || true; fi
if [[ $HOSTNAME = 'pc01' ]]; then sudo usermod --append --groups adm,cdrom,sudo,dip,plugdev,lpadmin karel; fi
if [[ $HOSTNAME = 'pc01' ]]; then sudo passwd --delete --expire karel; fi

# Remove user-karel from pc01
if [[ $HOSTNAME = 'pc01' ]]; then sudo userdel --remove karel; fi

# Install user-toos on Laptop
if [[ $HOSTNAME = 'Laptop' ]]; then sudo useradd --create-home --shell /usr/bin/bash --comment 'Toos Barendse' toos || true; fi
if [[ $HOSTNAME = 'Laptop' ]]; then sudo usermod --append --groups adm,cdrom,sudo,dip,plugdev,lpadmin toos; fi
if [[ $HOSTNAME = 'Laptop' ]]; then sudo passwd --delete --expire toos; fi

# Remove user-toos from Laptop
if [[ $HOSTNAME = 'Laptop' ]]; then sudo userdel --remove toos; fi

# Install virtualbox on pc-van-hugo
# If the installation hangs or VBox does not work, check the virtualization settings in the BIOS/UEFI.
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then echo 'virtualbox-ext-pack virtualbox-ext-pack/license select true' | sudo debconf-set-selections; fi
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get install --assume-yes virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso; fi
# VirtualBox Guest user Additions ISO are in: /usr/share/virtualbox/
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then sudo dnf install --assumeyes VirtualBox; fi

# Remove virtualbox from pc-van-hugo
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get remove --assume-yes virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then sudo dnf remove --assumeyes VirtualBox; fi

# Install vlc on *
if $DESKTOP_ENVIRONMENT && $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get install --assume-yes vlc; fi
# EPEL: Extra Packages for Enterprise Linux
if $DESKTOP_ENVIRONMENT && $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then sudo dnf install --assumeyes epel-release rpmfusion-free-release; fi
if $DESKTOP_ENVIRONMENT && $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then sudo dnf install --assumeyes vlc; fi

# Remove vlc from *
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get remove --assume-yes vlc; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then sudo dnf remove --assumeyes vlc; fi

# Install vscode on pc01 pc06 pc07
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get install --assume-yes apt-transport-https; fi
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then wget --output-document=- 'https://packages.microsoft.com/keys/microsoft.asc' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/packages.microsoft.gpg; fi
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list; fi
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get update; fi
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get install --assume-yes code; fi
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo update-alternatives --set editor /usr/bin/code; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then echo -e '[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc' | sudo tee /etc/yum.repos.d/vscode.repo; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then sudo dnf install --assumeyes code; fi

# Remove vscode from pc01 pc06 pc07
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo update-alternatives --remove editor /usr/bin/code; fi
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get remove --assume-yes code; fi
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo rm --force --verbose /etc/apt/sources.list.d/vscode.list* /usr/share/keyrings/packages.microsoft*; fi
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get update; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then sudo dnf remove --assumeyes code; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then sudo rm --force --verbose /etc/yum.repos.d/vscode.repo*; fi

# Install webmin on pc07
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then wget --output-document=- 'https://www.webmin.com/jcameron-key.asc' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/webmin.gpg; fi
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then echo 'deb [signed-by=/usr/share/keyrings/webmin.gpg] https://download.webmin.com/download/repository sarge contrib' | sudo tee /etc/apt/sources.list.d/webmin.list; fi
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get update; fi
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get install --assume-yes webmin; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then wget --output-document=/tmp/setup-repos.sh https://raw.githubusercontent.com/webmin/webmin/master/setup-repos.sh; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then yes | sudo bash /tmp/setup-repos.sh; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then sudo rm --force --verbose /tmp/setup-repos.sh; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then sudo dnf install --assumeyes webmin; fi
# Web app: https://localhost:10000

# Remove webmin from pc07
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get remove --assume-yes webmin; fi
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo rm --force --verbose /etc/apt/sources.list.d/webmin.list* /usr/share/keyrings/webmin*; fi
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get update; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then dnf remove --assumeyes webmin; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then sudo rm --force --verbose /etc/yum.repos.d/webmin.repo*; fi

# Install wine on -none
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo dpkg --add-architecture i386; fi
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get install --assume-yes wine winetricks playonlinux; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then sudo dnf install --assumeyes wine playonlinux; fi

# Remove wine from -none
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get remove --assume-yes wine winetricks playonlinux; fi
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo dpkg --remove-architecture i386; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then sudo dnf remove --assumeyes wine playonlinux; fi

# Install youtube-dl on pc-van-emily pc-van-hugo
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get install --assume-yes youtubedl-gui; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then sudo dnf install --assumeyes youtube-dl; fi

# Remove youtube-dl from pc-van-emily pc-van-hugo
if $DESKTOP_ENVIRONMENT && $APT_SYSTEM; then sudo apt-get remove --assume-yes youtubedl-gui; fi
if $DESKTOP_ENVIRONMENT && $RPM_SYSTEM; then sudo dnf remove --assumeyes youtube-dl; fi
