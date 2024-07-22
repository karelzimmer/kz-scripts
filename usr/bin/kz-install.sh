# shellcheck shell=bash
###############################################################################
# SPDX-FileComment: Install file
#
# SPDX-FileCopyrightText: Karel Zimmer <info@karelzimmer.nl>
# SPDX-License-Identifier: CC0-1.0
###############################################################################
# For the format of the records in this file, see the kz install man page.

# Install disabled-apport on *
#
# Disable the program crash report.
# For Ubuntu.
if [[ $(lsb_release --id --short) = 'Ubuntu' ]]; then sudo systemctl stop apport.service; fi
if [[ $(lsb_release --id --short) = 'Ubuntu' ]]; then sudo systemctl disable apport.service; fi
if [[ $(lsb_release --id --short) = 'Ubuntu' ]]; then sudo rm --force --verbose /var/crash/*; fi
if [[ $(lsb_release --id --short) = 'Ubuntu' ]]; then sudo sed --in-place --expression='s/enabled=1/enabled=0/' /etc/default/apport; fi

# Remove disabled-apport from *
#
# Enable the program crash report.
# For Ubuntu.
if [[ $(lsb_release --id --short) = 'Ubuntu' ]]; then sudo sed --in-place --expression='s/enabled=0/enabled=1/' /etc/default/apport; fi
if [[ $(lsb_release --id --short) = 'Ubuntu' ]]; then sudo systemctl enable --now apport.service; fi

# Install extra-repos on *
#
# For Debian with desktop environment.
if [[ $(lsb_release --id --short) = 'Debian' && -n $(type {{cinnamon,gnome,lxqt,mate,xfce4}-session,ksmserver} 2> /dev/null) ]]; then sudo apt-add-repository contrib; fi
if [[ $(lsb_release --id --short) = 'Debian' && -n $(type {{cinnamon,gnome,lxqt,mate,xfce4}-session,ksmserver} 2> /dev/null) ]]; then sudo apt-add-repository non-free; fi
if [[ $(lsb_release --id --short) = 'Debian' && -n $(type {{cinnamon,gnome,lxqt,mate,xfce4}-session,ksmserver} 2> /dev/null) ]]; then sudo apt-add-repository "deb https://www.deb-multimedia.org $(lsb_release --codename --short) main non-free"; fi
if [[ $(lsb_release --id --short) = 'Debian' && -n $(type {{cinnamon,gnome,lxqt,mate,xfce4}-session,ksmserver} 2> /dev/null) ]]; then wget --output-document=/tmp/deb-multimedia-keyring_2016.8.1_all.deb 'https://www.deb-multimedia.org/pool/main/d/deb-multimedia-keyring/deb-multimedia-keyring_2016.8.1_all.deb'; fi
if [[ $(lsb_release --id --short) = 'Debian' && -n $(type {{cinnamon,gnome,lxqt,mate,xfce4}-session,ksmserver} 2> /dev/null) ]]; then sudo apt-get install --yes /tmp/deb-multimedia-keyring_2016.8.1_all.deb; fi
if [[ $(lsb_release --id --short) = 'Debian' && -n $(type {{cinnamon,gnome,lxqt,mate,xfce4}-session,ksmserver} 2> /dev/null) ]]; then rm /tmp/deb-multimedia-keyring_2016.8.1_all.deb; fi
if [[ $(lsb_release --id --short) = 'Debian' && -n $(type {{cinnamon,gnome,lxqt,mate,xfce4}-session,ksmserver} 2> /dev/null) ]]; then sudo apt-get update; fi

# Remove extra-repos from *
#
# For Debian with desktop environment.
if [[ $(lsb_release --id --short) = 'Debian' && -n $(type {{cinnamon,gnome,lxqt,mate,xfce4}-session,ksmserver} 2> /dev/null) ]]; then sudo apt-add-repository --remove contrib; fi
if [[ $(lsb_release --id --short) = 'Debian' && -n $(type {{cinnamon,gnome,lxqt,mate,xfce4}-session,ksmserver} 2> /dev/null) ]]; then sudo apt-add-repository --remove non-free; fi
if [[ $(lsb_release --id --short) = 'Debian' && -n $(type {{cinnamon,gnome,lxqt,mate,xfce4}-session,ksmserver} 2> /dev/null) ]]; then sudo apt-add-repository --remove "deb https://www.deb-multimedia.org $(lsb_release --codename --short) main non-free"; fi
if [[ $(lsb_release --id --short) = 'Debian' && -n $(type {{cinnamon,gnome,lxqt,mate,xfce4}-session,ksmserver} 2> /dev/null) ]]; then sudo apt-get remove --yes deb-multimedia-keyring; fi
if [[ $(lsb_release --id --short) = 'Debian' && -n $(type {{cinnamon,gnome,lxqt,mate,xfce4}-session,ksmserver} 2> /dev/null) ]]; then sudo apt-get update; fi

# Install update-system on *
#
sudo apt-get update
sudo apt-get dist-upgrade --yes
if type snap &> /dev/null; then sudo snap refresh; fi

# Remove update-system from *
#
# There is no command available to remove update system.

# Install ansible on pc06 pc07
sudo apt-get install --yes ansible

# Remove ansible from pc06 pc07
sudo apt-get remove --yes ansible

# Install anydesk on -nohost
#
# Remote Wayland display server is not supported.
wget --output-document=- 'https://keys.anydesk.com/repos/DEB-GPG-KEY' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/anydesk.gpg
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/anydesk.gpg] http://deb.anydesk.com/ all main' | sudo tee /etc/apt/sources.list.d/anydesk.list > /dev/null
sudo apt-get update
sudo apt-get install --yes anydesk
#
# Web app: https://my.anydesk.com/v2

# Remove anydesk from -nohost
sudo apt-get remove --yes anydesk
sudo rm --force --verbose /etc/apt/sources.list.d/anydesk.list* /usr/share/keyrings/anydesk.gpg*
sudo apt-get update

# Install bash-completion on *
sudo apt-get install --yes bash-completion

# Remove bash-completion from *
sudo apt-get remove --yes bash-completion

# Install bleachbit on pc-van-hugo
sudo apt-get install --yes bleachbit

# Remove bleachbit from pc-van-hugo
sudo apt-get remove --yes bleachbit

# Install calibre on pc06 pc-van-hugo
sudo apt-get install --yes calibre

# Remove calibre from pc06 pc-van-hugo
sudo apt-get remove --yes calibre

# Install change-grub-timeout on *
sudo sed --in-place --expression='s/GRUB_TIMEOUT=5/GRUB_TIMEOUT=1/' /etc/default/grub
sudo sed --in-place --expression='s/GRUB_TIMEOUT=10/GRUB_TIMEOUT=1/' /etc/default/grub
sudo update-grub

# Remove change-grub-timeout from *
sudo sed --in-place --expression='s/GRUB_TIMEOUT=1/GRUB_TIMEOUT=5/' /etc/default/grub
sudo update-grub

# Install clamav on pc-van-hugo
sudo apt-get install --yes clamtk-gnome

# Remove clamav from pc-van-hugo
sudo apt-get remove --yes clamtk-gnome

# Install cockpit on pc06
sudo apt-get install --yes cockpit cockpit-pcp
#
# Web app: https://localhost:9090

# Remove cockpit from pc06
sudo apt-get remove --yes cockpit

# Install cups on *
sudo apt-get install --yes cups

# Remove cups from *
sudo apt-get remove --yes cups

# Install cups-backend-canon on pc-van-emily
sudo apt-get install --yes cups-backend-bjnp

# Remove cups-backend-canon from pc-van-emily
sudo apt-get remove --yes cups-backend-bjnp

# Install dashtodock on *
# For all with GNOME desktop environment.
if type gnome-session &> /dev/null; then sudo apt-get install --yes gnome-shell-extension-dashtodock || true; fi # Not every GNOME desktop environment has this extension available.

# Remove dashtodock from *
# For all with GNOME desktop environment.
if type gnome-session &> /dev/null; then sudo apt-get remove --yes gnome-shell-extension-dashtodock || true; fi # Not every GNOME desktop environment has this extension available.

# Install deja-dup on pc07
sudo apt-get install --yes deja-dup

# Remove deja-dup from pc07
sudo apt-get remove --yes deja-dup

# Install disabled-aer on pc06
#
# Disable kernel config parameter PCIEAER (Peripheral Component Interconnect Express Advanced Error Reporting).
# To prevent the log gets flooded with 'AER: Corrected errors received'. Usually needed for HP hardware.
sudo sed --in-place --expression='s/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash pci=noaer"/' /etc/default/grub
sudo update-grub
#
# Check for kernel config parameter pci=noaer.
grep --quiet --regexp='pci=noaer' /etc/default/grub

# Remove disabled-aer from pc06
#
# Enable kernel config parameter PCIEAER.
sudo sed --in-place --expression='s/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash pci=noaer"/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash pci=noaer"/' /etc/default/grub
sudo update-grub
#
# Check for kernel config parameter pci=noaer.
! grep --quiet --regexp='pci=noaer' /etc/default/grub

# Install disabled-fwupd on -nohost
#
# Disable the Firmware update daemon.
sudo systemctl stop fwupd.service
sudo systemctl disable fwupd.service
sudo systemctl mask fwupd.service

# Remove disabled-fwupd from -nohost
#
# Enable the Firmware update daemon.
sudo systemctl unmask fwupd.service
sudo systemctl enable fwupd.service
sudo systemctl start fwupd.service

# Install disabled-lidswitch on pc-van-hugo
#
# Do nothing when the lid is closed.
sudo sed --in-place --expression='/^HandleLidSwitch=/d' /etc/systemd/logind.conf
echo 'HandleLidSwitch=ignore' | sudo tee --append /etc/systemd/logind.conf > /dev/null

# Remove disabled-lidswitch from pc-van-hugo
#
# Restore the default action when the lid is closed.
sudo sed --in-place --expression='/^HandleLidSwitch=/d' /etc/systemd/logind.conf

# Install dual-monitor on pc06
if [[ -f /home/${SUDO_USER:-$USER}/.config/monitors.xml ]]; then sudo cp --preserve --verbose /home/"${SUDO_USER:-$USER}"/.config/monitors.xml ~gdm/.config/monitors.xml; fi
if [[ -f ~gdm/.config/monitors.xml ]]; then sudo chown --verbose gdm:gdm ~gdm/.config/monitors.xml; fi

# Remove dual-monitor from pc06
sudo rm --force --verbose ~gdm/.config/monitors.xml

# Install exiftool on pc06 pc07
sudo apt-get install --yes libimage-exiftool-perl

# Remove exiftool from pc06 pc07
sudo apt-get remove --yes libimage-exiftool-perl

# Install fakeroot on pc06 pc07
sudo apt-get install --yes fakeroot

# Remove fakeroot from pc06 pc07
sudo apt-get remove --yes fakeroot

# Install fdupes on -nohost
sudo apt-get install --yes fdupes
#
# Usage:
# $ fdupes -r /home               # Report recursively from /home
# $ fdupes -d /path/to/folder     # Delete, interactively, from /path/to/folder
# $ fdupes -d -N /path/to/folder  # Delete, from /path/to/folder

# Remove fdupes from -nohost
sudo apt-get remove --yes fdupes

# Install force-x11 on -nohost
#
# Force the use of X11 because Wayland is not (yet) supported by remote desktop app AnyDesk.
# Force means no choice @ user login for X11 or Wayland!
sudo sed --in-place --expression='s/^#WaylandEnable=false/WaylandEnable=false/' /etc/gdm3/custom.conf
#
# To check, after reboot (!), execute: echo $XDG_SESSION_TYPE (should output 'x11')

# Remove force-x11 from -nohost
#
# Enable choice @ user login for X11 or Wayland.
sudo sed --in-place --expression='s/^WaylandEnable=false/#WaylandEnable=false/' /etc/gdm3/custom.conf
#
# To check, after reboot (!), execute: echo $XDG_SESSION_TYPE (should output 'wayland')

# Install gdebi on *
# For all with desktop environment.
if [[ -n $(type {{cinnamon,gnome,lxqt,mate,xfce4}-session,ksmserver} 2> /dev/null) ]]; then sudo apt-get install --yes gdebi; fi

# Remove gdebi from *
# For all with desktop environment.
if [[ -n $(type {{cinnamon,gnome,lxqt,mate,xfce4}-session,ksmserver} 2> /dev/null) ]]; then sudo apt-get remove --yes gdebi; fi

# Install gettext on pc06 pc07
sudo apt-get install --yes gettext

# Remove gettext from pc06 pc07
sudo apt-get remove --yes gettext

# Install gimp on pc-van-hugo pc06
sudo apt-get install --yes gimp gimp-help-en gimp-help-nl

# Remove gimp from pc-van-hugo pc06
sudo apt-get remove --yes gimp gimp-help-en gimp-help-nl

# Install git on pc06 pc07
sudo apt-get install --yes git

# Remove git from pc06 pc07
sudo apt-get remove --yes git

# Install gnome-gmail on pc01 pc06 pc07
sudo apt-get install --yes gnome-gmail

# Remove gnome-gmail from pc01 pc06 pc07
sudo apt-get remove --yes gnome-gmail

# Install gnome-tweaks on pc01 pc06 pc07
sudo apt-get install --yes gnome-tweaks

# Remove gnome-tweaks from pc01 pc06 pc07
sudo apt-get remove --yes gnome-tweaks

# Install gnome-web on pc06
sudo apt-get install --yes epiphany-browser

# Remove gnome-web from pc06
sudo apt-get remove --yes epiphany-browser

# Install google-chrome on *
# For all with desktop environment.
if [[ -n $(type {{cinnamon,gnome,lxqt,mate,xfce4}-session,ksmserver} 2> /dev/null) ]]; then wget --output-document=- 'https://dl.google.com/linux/linux_signing_key.pub' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/google-chrome.gpg; fi
if [[ -n $(type {{cinnamon,gnome,lxqt,mate,xfce4}-session,ksmserver} 2> /dev/null) ]]; then echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] https://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list > /dev/null; fi
if [[ -n $(type {{cinnamon,gnome,lxqt,mate,xfce4}-session,ksmserver} 2> /dev/null) ]]; then sudo apt-get update; fi
if [[ -n $(type {{cinnamon,gnome,lxqt,mate,xfce4}-session,ksmserver} 2> /dev/null) ]]; then sudo apt-get install --yes google-chrome-stable; fi
#
# Also install chrome-gnome-shell to make extensions.gnome.org work.
# For all with GNOME desktop environment.
if type gnome-session &> /dev/null; then sudo apt-get install --yes chrome-gnome-shell; fi
#
# Add the source list again because the installation overwrote the newly added source list.
# For all with desktop environment.
if [[ -n $(type {{cinnamon,gnome,lxqt,mate,xfce4}-session,ksmserver} 2> /dev/null) ]]; then echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] https://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list > /dev/null; fi
#
# The apt-key added during installation is no longer needed.
# For all with desktop environment.
if [[ -n $(type {{cinnamon,gnome,lxqt,mate,xfce4}-session,ksmserver} 2> /dev/null) ]]; then sudo rm --force --verbose /etc/apt/trusted.gpg.d/google-chrome.gpg; fi

# Remove google-chrome from *
# For all with GNOME desktop environment.
if type gnome-session &> /dev/null; then apt-get remove --yes chrome-gnome-shell; fi
# For all with desktop environment.
if [[ -n $(type {{cinnamon,gnome,lxqt,mate,xfce4}-session,ksmserver} 2> /dev/null) ]]; then sudo apt-get remove --yes google-chrome-stable chrome-gnome-shell; fi
if [[ -n $(type {{cinnamon,gnome,lxqt,mate,xfce4}-session,ksmserver} 2> /dev/null) ]]; then sudo rm --force --verbose /etc/apt/sources.list.d/google-chrome.list* /usr/share/keyrings/google-chrome.gpg* /etc/apt/trusted.gpg.d/google-chrome.gpg; fi
if [[ -n $(type {{cinnamon,gnome,lxqt,mate,xfce4}-session,ksmserver} 2> /dev/null) ]]; then sudo apt-get update; fi

# Install google-earth on -nohost
wget --output-document=- 'https://dl.google.com/linux/linux_signing_key.pub' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/google-earth.gpg
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-earth.gpg] https://dl.google.com/linux/earth/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-earth-pro.list > /dev/null
sudo apt-get update
sudo apt-get install --yes google-earth-pro-stable
#
# Add the source list again because the installation overwrote the newly added source list.
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-earth.gpg] https://dl.google.com/linux/earth/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-earth-pro.list > /dev/null

# Remove google-earth from -nohost
sudo apt-get remove --yes google-earth-pro-stable
sudo rm --force --verbose /etc/apt/sources.list.d/google-earth-pro.list* /usr/share/keyrings/google-earth.gpg*
sudo apt-get update

# Install handbrake on pc-van-emily
sudo apt-get install --yes handbrake

# Remove handbrake from pc-van-emily
sudo apt-get remove --yes handbrake

# Install htop on pc06 pc07
sudo apt-get install --yes htop

# Remove htop from pc06 pc07
sudo apt-get remove --yes htop

# Install jq on pc06 pc07
sudo apt-get install --yes jq

# Remove jq from pc06 pc07
sudo apt-get remove --yes jq

# Install krita on pc06
sudo apt-get install --yes krita

# Remove krita from pc06
sudo apt-get remove --yes krita

# Install kvm on pc06 pc07
#
# Dpkg::Options to prevent interaction while restoring /etc/libvirt configuration files.
sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes --option Dpkg::Options::="--force-confdef" --option Dpkg::Options::="--force-confold" bridge-utils cpu-checker libvirt-clients libvirt-daemon-system qemu-kvm qemu-system virtinst virt-manager
sudo usermod --append --groups libvirt,libvirt-qemu "${SUDO_USER:-$USER}"
#
# Prevent "Error starting domain: Requested operation is not valid: network 'default' is not active".
sudo virsh --connect=qemu:///system net-autostart default
#
# Check network 'default' with: sudo virsh --connect=qemu:///system net-info default (should output 'Autostart: yes')
# Images are in: /var/lib/libvirt/images/

# Remove kvm from pc06 pc07
sudo virsh --connect=qemu:///system net-autostart default --disable
sudo apt-get remove --yes bridge-utils cpu-checker libvirt-clients libvirt-daemon-system qemu-kvm qemu-system virtinst virt-manager
sudo delgroup libvirtd-dnsmasq
sudo deluser "${SUDO_USER:-$USER}" libvirtd
sudo deluser "${SUDO_USER:-$USER}" libvirtd-qemu
sudo delgroup libvirtd

# Install lftp on pc06 pc07
sudo apt-get install --yes lftp

# Remove lftp from pc06 pc07
sudo apt-get remove --yes lftp

# Install libreoffice on *
# For all with desktop environment.
if [[ -n $(type {{cinnamon,gnome,lxqt,mate,xfce4}-session,ksmserver} 2> /dev/null) ]]; then sudo apt-get install --yes aspell-en aspell-nl libreoffice libreoffice-help-nl libreoffice-l10n-nl; fi

# Remove libreoffice from *
# For all with desktop environment.
if [[ -n $(type {{cinnamon,gnome,lxqt,mate,xfce4}-session,ksmserver} 2> /dev/null) ]]; then sudo apt-get remove --yes aspell-en aspell-nl libreoffice libreoffice-help-nl libreoffice-l10n-nl; fi

# Install locate on pc06 pc07
sudo apt-get install --yes locate
sudo updatedb

# Remove locate from pc06 pc07
sudo apt-get remove --yes locate

# Install lshw on pc07
sudo apt-get install --yes lshw

# Remove lshw from pc07
sudo apt-get remove --yes lshw

# Install nautilus-admin on pc06 pc07
sudo apt-get install --yes nautilus-admin

# Remove nautilus-admin from pc06 pc07
sudo apt-get remove --yes nautilus-admin

# Install nmap on pc06 pc07
sudo apt-get install --yes nmap

# Remove nmap from pc06 pc07
sudo apt-get remove --yes nmap

# Install python on pc06 pc07
sudo apt-get install --yes pycodestyle python3-pycodestyle python3-autopep8 python3-pip python-is-python3
sudo ln --force --relative --symbolic /usr/bin/pycodestyle /usr/bin/pep8
sudo ln --force --relative --symbolic /usr/bin/pip3 /usr/bin/pip

# Remove python from pc06 pc07
sudo apt-get remove --yes pycodestyle python3-pycodestyle python3-autopep8 python3-pip python-is-python3
sudo rm --force --verbose /usr/bin/pep8 /usr/bin/pip

# Install repair-ntfs on -nohost
sudo apt-get install --yes ntfs-3g
#
# Usage:
# $ findmnt
# TARGET          SOURCE    FSTYPE OPTIONS
# /media/...      /dev/sdb2 ntfs3  rw,nosuid,nodev,relatime,uid=...
# $ sudo ntfsfix /dev/sdb2

# Remove repair-ntfs from -nohost
sudo apt-get remove --yes ntfs-3g

# Install shellcheck on pc06 pc07
sudo apt-get install --yes shellcheck

# Remove shellcheck from pc06 pc07
sudo apt-get remove --yes shellcheck

# Install signal on pc06 pc07
wget --output-document=- 'https://updates.signal.org/desktop/apt/keys.asc' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/signal-desktop-keyring.gpg
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main'| sudo tee /etc/apt/sources.list.d/signal-xenial.list > /dev/null
sudo apt-get update
sudo apt-get install --yes signal-desktop

# Remove signal from pc06 pc07
sudo apt-get remove --yes signal-desktop
sudo rm --force --verbose /etc/apt/sources.list.d/signal-xenial.list* /usr/share/keyrings/signal-desktop-keyring.gpg*
sudo apt-get update

# Install sound-juicer on pc-van-emily
sudo apt-get install --yes sound-juicer

# Remove sound-juicer from pc-van-emily
sudo apt-get remove --yes sound-juicer

# Install spice-vdagent on *
sudo apt-get install --yes spice-vdagent

# Remove spice-vdagent from *
sudo apt-get remove --yes spice-vdagent

# Install ssh on pc01 pc06 pc07
sudo apt-get install --yes ssh
sudo sed --in-place --expression='s/PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
sudo sed --in-place --expression='/^192.168.1./d' /etc/hosts
sudo sed --in-place --expression='2a192.168.1.100 pc01' /etc/hosts
sudo sed --in-place --expression='3a192.168.1.2   pc06' /etc/hosts
sudo sed --in-place --expression='4a192.168.1.219 pc07' /etc/hosts
#
# Check for remote root access.
grep --quiet --regexp='PermitRootLogin no' /etc/ssh/sshd_config
sudo systemctl restart ssh.service

# Remove ssh from pc01 pc06 pc07
sudo sed --in-place --expression='/^192.168.1./d' /etc/hosts
sudo sed --in-place --expression='s/PermitRootLogin no/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config
sudo apt-get remove --yes ssh

# Install sushi on pc06
sudo apt-get install --yes gnome-sushi
#
# Usage:
# Select a file, press the space bar, and a preview will appear.

# Remove sushi from pc06
sudo apt-get remove --yes gnome-sushi

# Install teamviewer on *
# For all with desktop environment.
if [[ -n $(type {{cinnamon,gnome,lxqt,mate,xfce4}-session,ksmserver} 2> /dev/null) ]]; then wget --output-document=- 'https://download.teamviewer.com/download/linux/signature/TeamViewer2017.asc' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/teamviewer.gpg; fi
if [[ -n $(type {{cinnamon,gnome,lxqt,mate,xfce4}-session,ksmserver} 2> /dev/null) ]]; then echo 'deb [signed-by=/usr/share/keyrings/teamviewer.gpg] https://linux.teamviewer.com/deb stable main' | sudo tee /etc/apt/sources.list.d/teamviewer.list > /dev/null; fi
if [[ -n $(type {{cinnamon,gnome,lxqt,mate,xfce4}-session,ksmserver} 2> /dev/null) ]]; then sudo apt-get update; fi
if [[ -n $(type {{cinnamon,gnome,lxqt,mate,xfce4}-session,ksmserver} 2> /dev/null) ]]; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes teamviewer; fi
#
# The apt-key added during installation is no longer needed.
# For all with desktop environment.
if [[ -n $(type {{cinnamon,gnome,lxqt,mate,xfce4}-session,ksmserver} 2> /dev/null) ]]; then sudo apt-key del 0C1289C0 DEB49217; fi
#
# Web app: https://web.teamviewer.com

# Remove teamviewer from *
# For all with desktop environment.
if [[ -n $(type {{cinnamon,gnome,lxqt,mate,xfce4}-session,ksmserver} 2> /dev/null) ]]; then sudo apt-get remove --yes teamviewer; fi
if [[ -n $(type {{cinnamon,gnome,lxqt,mate,xfce4}-session,ksmserver} 2> /dev/null) ]]; then sudo rm --force --verbose /etc/apt/sources.list.d/teamviewer.list* /usr/share/keyrings/teamviewer*.gpg*; fi
if [[ -n $(type {{cinnamon,gnome,lxqt,mate,xfce4}-session,ksmserver} 2> /dev/null) ]]; then sudo apt-key del 0C1289C0 DEB49217; fi
if [[ -n $(type {{cinnamon,gnome,lxqt,mate,xfce4}-session,ksmserver} 2> /dev/null) ]]; then sudo apt-get update; fi

# Install thunderbird on *
# For all with desktop environment.
if [[ -n $(type {{cinnamon,gnome,lxqt,mate,xfce4}-session,ksmserver} 2> /dev/null) ]]; then sudo apt-get install --yes thunderbird-l10n-nl || true; fi # Debian
if [[ -n $(type {{cinnamon,gnome,lxqt,mate,xfce4}-session,ksmserver} 2> /dev/null) ]]; then sudo apt-get install --yes thunderbird-locale-nl || true; fi # Ubuntu

# Remove thunderbird from *
# For all with desktop environment.
if [[ -n $(type {{cinnamon,gnome,lxqt,mate,xfce4}-session,ksmserver} 2> /dev/null) ]]; then sudo apt-get remove --yes thunderbird-l10n-nl || true; fi # Debian
if [[ -n $(type {{cinnamon,gnome,lxqt,mate,xfce4}-session,ksmserver} 2> /dev/null) ]]; then sudo apt-get remove --yes thunderbird-locale-nl || true; fi # Ubuntu

# Install tree on pc06 pc07
sudo apt-get install --yes tree

# Remove tree from pc06 pc07
sudo apt-get remove --yes tree

# Install ufw on pc01 pc06 pc07
sudo apt-get install --yes gufw
sudo ufw allow ssh
sudo ufw enable

# Remove ufw from pc01 pc06 pc07
sudo ufw disable
sudo apt-get remove --yes gufw

# Install usbutils on pc07
sudo apt-get install --yes usbutils

# Remove usbutils from pc07
sudo apt-get remove --yes usbutils

# Install user-guest on -nohost
sudo useradd --create-home --shell /usr/bin/bash --comment "$(gettext --domain=kz 'Guest user')" "$(gettext --domain=kz 'guest')" || true
sudo passwd --delete "$(gettext --domain=kz 'guest')"

# Remove user-guest from -nohost
sudo userdel --remove "$(gettext --domain=kz 'guest')"

# Install user-karel on pc01
sudo useradd --create-home --shell /usr/bin/bash --comment 'Karel Zimmer' karel || true
sudo usermod --append --groups adm,cdrom,sudo,dip,plugdev,lpadmin karel
sudo passwd --delete --expire karel

# Remove user-karel from pc01
sudo userdel --remove karel

# Install user-log-access on *
sudo usermod --append --groups adm,systemd-journal "${SUDO_USER:-$USER}"

# Remove user-log-access from *
sudo deluser "${SUDO_USER:-$USER}" adm
sudo deluser "${SUDO_USER:-$USER}" systemd-journal

# Install user-toos on Laptop
sudo useradd --create-home --shell /usr/bin/bash --comment 'Toos Barendse' toos || true
sudo usermod --append --groups adm,cdrom,sudo,dip,plugdev,lpadmin toos
sudo passwd --delete --expire toos

# Remove user-toos from Laptop
sudo userdel --remove toos

# Install virtualbox on pc-van-hugo
#
# If the installation hangs or VBox does not work, check the virtualization settings in the BIOS/UEFI.
echo 'virtualbox-ext-pack virtualbox-ext-pack/license select true' | sudo debconf-set-selections
sudo apt-get install --yes virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso
#
# VirtualBox Guest user Additions ISO are in: /usr/share/virtualbox/

# Remove virtualbox from pc-van-hugo
sudo apt-get remove --yes virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso

# Install vlc on *
# For all with desktop environment.
if [[ -n $(type {{cinnamon,gnome,lxqt,mate,xfce4}-session,ksmserver} 2> /dev/null) ]]; then sudo apt-get install --yes vlc; fi

# Remove vlc from *
# For all with desktop environment.
if [[ -n $(type {{cinnamon,gnome,lxqt,mate,xfce4}-session,ksmserver} 2> /dev/null) ]]; then sudo apt-get remove --yes vlc; fi

# Install vscode on pc01 pc06 pc07
wget --output-document=- 'https://packages.microsoft.com/keys/microsoft.asc' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
sudo apt-get update
sudo apt-get install --yes code
sudo update-alternatives --set editor /usr/bin/code

# Remove vscode from pc01 pc06 pc07
sudo update-alternatives --remove editor /usr/bin/code
sudo apt-get remove --yes code
sudo rm --force --verbose /etc/apt/sources.list.d/vscode.list* /usr/share/keyrings/packages.microsoft*
sudo apt-get update

# Install webmin on pc07
wget --output-document=- 'https://www.webmin.com/jcameron-key.asc' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/webmin.gpg
echo 'deb [signed-by=/usr/share/keyrings/webmin.gpg] https://download.webmin.com/download/repository sarge contrib' | sudo tee /etc/apt/sources.list.d/webmin.list > /dev/null
sudo apt-get update
sudo apt-get install --yes webmin
#
# Web app: https://localhost:10000

# Remove webmin from pc07
sudo apt-get remove --yes webmin
sudo rm --force --verbose /etc/apt/sources.list.d/webmin.list* /usr/share/keyrings/webmin*
sudo apt-get update

# Install wine on -nohost
sudo apt-get install --yes wine winetricks playonlinux

# Remove wine from -nohost
sudo apt-get remove --yes wine winetricks playonlinux

# Install youtube-dl on pc-van-emily pc-van-hugo
sudo apt-get install --yes youtubedl-gui

# Remove youtube-dl from pc-van-emily pc-van-hugo
sudo apt-get remove --yes youtubedl-gui

