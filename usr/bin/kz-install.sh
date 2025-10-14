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
if grep --quiet Debian /etc/os-release && [[ -e /etc/apt/sources.list ]]; then sudo sed --in-place 's/main non-free-firmware/contrib main non-free non-free-firmware/' /etc/apt/sources.list; fi
if grep --quiet Debian /etc/os-release && [[ -e /etc/apt/debian.sources ]]; then sudo sed --in-place 's/main non-free-firmware/contrib main non-free non-free-firmware/' /etc/apt/debian.sources; fi
if grep --quiet debian /etc/os-release; then sudo apt-get update; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf check-update || true; fi

# REMOVE components from *
# -----------------------------------------------------------------------------
# Remove Debian components package sources & update package lists for all.
# -----------------------------------------------------------------------------
if grep --quiet Debian /etc/os-release && [[ -e /etc/apt/sources.list ]]; then sudo sed --in-place 's/contrib main non-free non-free-firmware/main non-free-firmware/' /etc/apt/sources.list; fi
if grep --quiet Debian /etc/os-release && [[ -e /etc/apt/debian.sources ]]; then sudo sed --in-place 's/contrib main non-free non-free-firmware/main non-free-firmware/' /etc/apt/debian.sources; fi
if grep --quiet debian /etc/os-release; then sudo apt-get update; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf check-update || true; fi

# INSTALL bleachbit #gpg
# -----------------------------------------------------------------------------
# Delete files.
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get install --assume-yes bleachbit; fi
if (grep rhel   /etc/os-release && type gnome-session) &> /dev/null; then sudo dnf install --assumeyes bleachbit; fi

# REMOVE bleachbit #gpg
# -----------------------------------------------------------------------------
# Delete files.
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get remove --assume-yes bleachbit; fi
if (grep rhel   /etc/os-release && type gnome-session) &> /dev/null; then sudo dnf remove --assumeyes bleachbit; fi

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
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get install --assume-yes calibre; fi
if (grep rhel   /etc/os-release && type gnome-session) &> /dev/null; then sudo --validate && wget --no-verbose --output-document=- https://download.calibre-ebook.com/linux-installer.sh | sudo sh; fi

# REMOVE calibre pc06
# -----------------------------------------------------------------------------
# E-book manager.
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get remove --assume-yes calibre; fi
if (grep rhel   /etc/os-release && type gnome-session) &> /dev/null; then sudo calibre-uninstall; fi

# INSTALL cockpit pc06
# -----------------------------------------------------------------------------
# Web console.
# -----------------------------------------------------------------------------
# Web app: https://localhost:9090
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get install --assume-yes cockpit cockpit-pcp; fi
if (grep rhel   /etc/os-release && type gnome-session) &> /dev/null; then sudo dnf install --assumeyes cockpit cockpit-pcp; fi

# REMOVE cockpit pc06
# -----------------------------------------------------------------------------
# Web console.
# -----------------------------------------------------------------------------
# Web app: https://localhost:9090
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get remove --assume-yes cockpit; fi
if (grep rhel   /etc/os-release && type gnome-session) &> /dev/null; then sudo dnf remove --assumeyes cockpit; fi

# INSTALL cups-backend-bjnp #gpg
# -----------------------------------------------------------------------------
# Printer backend.
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get install --assume-yes cups-backend-bjnp; fi

# REMOVE cups-backend-bjnp #gpg
# -----------------------------------------------------------------------------
# Printer backend.
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get remove --assume-yes cups-backend-bjnp; fi

# INSTALL desktop *
# -----------------------------------------------------------------------------
# Dash-to-dock - desktop dock like Ubuntu's dash.
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && type gnome-session && ! apt-cache show gnome-shell-extension-ubuntu-dock ) &> /dev/null; then sudo apt-get install --assume-yes gnome-shell-extension-dashtodock; fi
if (grep debian /etc/os-release && type gnome-session && apt-cache show gnome-shell-extension-no-overview ) &> /dev/null; then sudo apt-get install --assume-yes gnome-shell-extension-no-overview; fi
if (grep rhel   /etc/os-release && type gnome-session && dnf list gnome-shell-extension-dash-to-dock) &> /dev/null; then sudo dnf install --assumeyes gnome-shell-extension-dash-to-dock; fi
if (grep rhel   /etc/os-release && type gnome-session && dnf list gnome-shell-extension-no-overview ) &> /dev/null; then sudo dnf install --assumeyes gnome-shell-extension-no-overview; fi
# -----------------------------------------------------------------------------
# Nautilus-admin - administrative operations.
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get install --assume-yes nautilus-admin; fi
# -----------------------------------------------------------------------------
# Ffmpeg - multimedia support.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes ffmpeg*; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes ffmpeg*; fi
# -----------------------------------------------------------------------------
# Gnome Tweaks - adjust advanced settings.
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get install --assume-yes gnome-tweaks; fi
if (grep rhel   /etc/os-release && type gnome-session) &> /dev/null; then sudo dnf install --assumeyes gnome-tweaks; fi
# -----------------------------------------------------------------------------
# Xfce4-goodies - enhancements for the Xfce Desktop Environment.
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && type xfce4-session) &> /dev/null; then sudo apt-get install --assume-yes xfce4-goodies; fi
if (grep rhel   /etc/os-release && type xfce4-session) &> /dev/null; then sudo dnf install --assumeyes xfce4-goodies; fi
if type xfce4-session &> /dev/null; then sudo sed --in-place '/^greeter-hide-users=false/d' /etc/lightdm/lightdm.conf; fi
if type xfce4-session &> /dev/null; then sudo sed --in-place '/^greeter-show-manual-login=false/d' /etc/lightdm/lightdm.conf; fi
if type xfce4-session &> /dev/null; then sudo sed --in-place '/^user-session=karel/d' /etc/lightdm/lightdm.conf; fi
if type xfce4-session &> /dev/null; then sudo sed --in-place '4agreeter-hide-users=false' /etc/lightdm/lightdm.conf; fi
if type xfce4-session &> /dev/null; then sudo sed --in-place '5agreeter-show-manual-login=false' /etc/lightdm/lightdm.conf; fi
if type xfce4-session &> /dev/null; then sudo sed --in-place '6auser-session=karel' /etc/lightdm/lightdm.conf; fi
# -----------------------------------------------------------------------------
# Spice-vdagent - enhancements for virtualized guest systems.
# -----------------------------------------------------------------------------
# Spice (Simple Protocol for Independent Computing Environments) agent for
# virtualized guest systems.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes spice-vdagent; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes spice-vdagent; fi
# -----------------------------------------------------------------------------
# Sushi - quick preview.
# -----------------------------------------------------------------------------
# Usage:
# Select a file, press the space bar, and a preview will appear.
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get install --assume-yes gnome-sushi; fi
if (grep rhel   /etc/os-release && type gnome-session) &> /dev/null; then sudo dnf install --assumeyes sushi; fi
# -----------------------------------------------------------------------------
# Update-grub - skip GRUB menu.
# -----------------------------------------------------------------------------
sudo sed --in-place --regexp-extended "s/^.?GRUB_TIMEOUT=.*$/GRUB_TIMEOUT=0/" /etc/default/grub
if grep --quiet debian /etc/os-release; then sudo update-grub; fi
if grep --quiet rhel   /etc/os-release; then sudo grub2-mkconfig -o /boot/grub2/grub.cfg; fi
REBOOT=true

# REMOVE desktop from *
# -----------------------------------------------------------------------------
# Dash-to-dock - desktop dock like Ubuntu's dash.
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && type gnome-session && ! apt-cache show gnome-shell-extension-ubuntu-dock ) &> /dev/null; then sudo apt-get remove --assume-yes gnome-shell-extension-dashtodock; fi
if (grep debian /etc/os-release && type gnome-session && apt-cache show gnome-shell-extension-no-overview ) &> /dev/null; then sudo apt-get remove --assume-yes gnome-shell-extension-no-overview; fi
if (grep rhel   /etc/os-release && type gnome-session && dnf list gnome-shell-extension-dash-to-dock) &> /dev/null; then sudo dnf remove --assumeyes gnome-shell-extension-dash-to-dock; fi
if (grep rhel   /etc/os-release && type gnome-session && dnf list gnome-shell-extension-no-overview ) &> /dev/null; then sudo dnf remove --assumeyes gnome-shell-extension-no-overview; fi
# -----------------------------------------------------------------------------
# Nautilus-admin - administrative operations.
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get remove --assume-yes nautilus-admin; fi
# -----------------------------------------------------------------------------
# Ffmpeg - multimedia support.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes ffmpeg*; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes ffmpeg*; fi
# -----------------------------------------------------------------------------
# Gnome Tweaks - adjust advanced settings.
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get install --assume-yes gnome-tweaks; fi
if (grep rhel   /etc/os-release && type gnome-session) &> /dev/null; then sudo dnf install --assumeyes gnome-tweaks; fi
# -----------------------------------------------------------------------------
# Xfce4-goodies - enhancements for the Xfce Desktop Environment.
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && type xfce4-session) &> /dev/null; then sudo apt-get remove --assume-yes xfce4-goodies; fi
if (grep rhel   /etc/os-release && type xfce4-session) &> /dev/null; then sudo dnf remove --assumeyes xfce4-goodies; fi
if type xfce4-session &> /dev/null; then sudo sed --in-place '/^greeter-hide-users=false/d' /etc/lightdm/lightdm.conf; fi
if type xfce4-session &> /dev/null; then sudo sed --in-place '/^greeter-show-manual-login=false/d' /etc/lightdm/lightdm.conf; fi
if type xfce4-session &> /dev/null; then sudo sed --in-place '/^user-session=karel/d' /etc/lightdm/lightdm.conf; fi
# -----------------------------------------------------------------------------
# Spice-vdagent - enhancements for virtualized guest systems.
# -----------------------------------------------------------------------------
# Spice (Simple Protocol for Independent Computing Environments) agent for
# virtualized guest systems.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes spice-vdagent; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes spice-vdagent; fi
# -----------------------------------------------------------------------------
# Sushi - quick preview.
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get remove --assume-yes gnome-sushi; fi
if (grep rhel   /etc/os-release && type gnome-session) &> /dev/null; then sudo dnf remove --assumeyes sushi; fi
# -----------------------------------------------------------------------------
# Update-grub - show GRUB menu.
# -----------------------------------------------------------------------------
sudo sed --in-place --regexp-extended "s/^.?GRUB_TIMEOUT=.*$/GRUB_TIMEOUT=5/" /etc/default/grub
if grep --quiet debian /etc/os-release; then sudo update-grub; fi
if grep --quiet rhel   /etc/os-release; then sudo grub2-mkconfig -o /boot/grub2/grub.cfg; fi
REBOOT=true

# INSTALL development pc06 pc07
# -----------------------------------------------------------------------------
# Ansible - configuration management, deployment, and task execution.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes ansible; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes ansible; fi
# -----------------------------------------------------------------------------
# Fakeroot - simulate superuser privileges.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes fakeroot; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes fakeroot; fi
# -----------------------------------------------------------------------------
# Gettext - GNU Internationalization.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes gettext; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes gettext; fi
# -----------------------------------------------------------------------------
# Git - distributed revision control system.
# -----------------------------------------------------------------------------
# Web app: https://github.com
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes git; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes git; fi
# -----------------------------------------------------------------------------
# Groff - compose manual pages with GNU roff.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes groff; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes groff; fi
# -----------------------------------------------------------------------------
# Htop - process viewer.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes htop; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes htop; fi
# -----------------------------------------------------------------------------
# Jq - JSON processor.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes jq; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes jq; fi
# -----------------------------------------------------------------------------
# Lftp - FTP/HTTP/BitTorrent client.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes lftp; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes lftp; fi
# -----------------------------------------------------------------------------
# Nmap - Network MAPper.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes nmap; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes nmap; fi
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
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes poedit; fi
# -----------------------------------------------------------------------------
# RPM - package manager.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes rpm; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes rpm; fi
# -----------------------------------------------------------------------------
# Shellcheck - shell script linter.
# -----------------------------------------------------------------------------
# Web app: https://www.shellcheck.net
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes shellcheck; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes shellcheck; fi
# -----------------------------------------------------------------------------
# Vscode - editor.
# -----------------------------------------------------------------------------
# Web app: https://vscode.dev
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then echo "code code/add-microsoft-repo boolean true" | sudo debconf-set-selections; fi
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then wget --no-verbose --output-document=- https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor --yes --output=/usr/share/keyrings/microsoft.gpg; fi
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then echo -e 'Types: deb\nURIs: https://packages.microsoft.com/repos/code\nSuites: stable\nComponents: main\nArchitectures: amd64,arm64,armhf\nSigned-By: /usr/share/keyrings/microsoft.gpg' |sudo tee /etc/apt/sources.list.d/vscode.sources 1> /dev/null; fi
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get install --assume-yes apt-transport-https; fi
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get update; fi
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get install --assume-yes code; fi
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo update-alternatives --set editor /usr/bin/code; fi
if (grep rhel   /etc/os-release && type gnome-session) &> /dev/null; then sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc; fi
if (grep rhel   /etc/os-release && type gnome-session) &> /dev/null; then echo -e '[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc' | sudo tee /etc/yum.repos.d/vscode.repo 1> /dev/null; fi
if (grep rhel   /etc/os-release && type gnome-session) &> /dev/null; then sudo dnf install --assumeyes code; fi

# REMOVE development pc06 pc07
# -----------------------------------------------------------------------------
# Ansible - configuration management, deployment, and task execution.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes ansible; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes ansible; fi
# -----------------------------------------------------------------------------
# Fakeroot - simulate superuser privileges.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes fakeroot; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes fakeroot; fi
# -----------------------------------------------------------------------------
# Gettext - GNU Internationalization.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes gettext; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes gettext; fi
# -----------------------------------------------------------------------------
# Git - distributed revision control system.
# -----------------------------------------------------------------------------
# Web app: https://github.com
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes git; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes git; fi
# -----------------------------------------------------------------------------
# Groff - compose manual pages with GNU roff.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes groff; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes groff; fi
# -----------------------------------------------------------------------------
# Htop - process viewer.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes htop; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes htop; fi
# -----------------------------------------------------------------------------
# Jq - JSON processor.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes jq; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes jq; fi
# -----------------------------------------------------------------------------
# Lftp - FTP/HTTP/BitTorrent client.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes lftp; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes lftp; fi
# -----------------------------------------------------------------------------
# Nmap - Network MAPper.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes nmap; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes nmap; fi
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
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes poedit; fi
# -----------------------------------------------------------------------------
# RPM - package manager for RPM.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes rpm; fi
# -----------------------------------------------------------------------------
# Shellcheck - shell script linter.
# -----------------------------------------------------------------------------
# Web app: https://www.shellcheck.net
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes shellcheck; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes shellcheck; fi
# -----------------------------------------------------------------------------
# Vscode - editor.
# -----------------------------------------------------------------------------
# Web app: https://vscode.dev
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo update-alternatives --remove editor /usr/bin/code; fi
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get remove --assume-yes code; fi
if (grep rhel   /etc/os-release && type gnome-session) &> /dev/null; then sudo dnf remove --assumeyes code; fi
if (grep rhel   /etc/os-release && type gnome-session) &> /dev/null; then sudo rm --force --verbose /etc/yum.repos.d/vscode.repo; fi

# INSTALL disabled-aer pc06
# -----------------------------------------------------------------------------
# Disable Advanced Error Reporting.
# -----------------------------------------------------------------------------
# Disable kernel config parameter PCIEAER (Peripheral Component Interconnect
# Express Advanced Error Reporting) prevents the log gets flooded with
# 'AER: Corrected errors received'. This is usually needed for HP hardware.
# -----------------------------------------------------------------------------
if ! grep --quiet 'pci=noaer' /etc/default/grub; then sudo sed --in-place 's/quiet/quiet pci=noaer/' /etc/default/grub; fi
if grep --quiet debian /etc/os-release; then sudo update-grub; fi
if grep --quiet rhel   /etc/os-release; then sudo grub2-mkconfig -o /boot/grub2/grub.cfg; fi
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

# INSTALL disabled-lidswitch #gpg
# -----------------------------------------------------------------------------
# Do nothing when the laptop lid is closed.
# -----------------------------------------------------------------------------
sudo sed --in-place '/^HandleLidSwitch=/d' /etc/systemd/logind.conf
echo 'HandleLidSwitch=ignore' | sudo tee --append /etc/systemd/logind.conf 1> /dev/null

# REMOVE disabled-lidswitch #gpg
# -----------------------------------------------------------------------------
# Restore the default action when the laptop lid is closed.
# -----------------------------------------------------------------------------
sudo sed --in-place '/^HandleLidSwitch=/d' /etc/systemd/logind.conf

# INSTALL exiftool pc06 pc07
# -----------------------------------------------------------------------------
# Read and write meta information.
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get install --assume-yes libimage-exiftool-perl; fi
if (grep rhel   /etc/os-release && type gnome-session) &> /dev/null; then sudo dnf install --assumeyes perl-Image-ExifTool; fi

# REMOVE exiftool pc06 pc07
# -----------------------------------------------------------------------------
# Read and write meta information.
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get remove --assume-yes libimage-exiftool-perl; fi
if (grep rhel   /etc/os-release && type gnome-session) &> /dev/null; then sudo dnf remove --assumeyes perl-Image-ExifTool; fi

# INSTALL gimp pc06
# -----------------------------------------------------------------------------
# GNU Image Manipulation Program.
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get install --assume-yes gimp gimp-help-en gimp-help-nl; fi
if (grep rhel   /etc/os-release && type gnome-session) &> /dev/null; then sudo dnf install --assumeyes gimp; fi

# REMOVE gimp pc06
# -----------------------------------------------------------------------------
# GNU Image Manipulation Program.
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get remove --assume-yes gimp gimp-help-en gimp-help-nl; fi
if (grep rhel   /etc/os-release && type gnome-session) &> /dev/null; then sudo dnf remove --assumeyes gimp; fi

# INSTALL google-chrome *
# -----------------------------------------------------------------------------
# Web browser.
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then wget --no-verbose --output-document=/tmp/google-chrome.deb https://dl.google.com/dl/linux/direct/google-chrome-stable_current_amd64.deb; fi
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get install --assume-yes /tmp/google-chrome.deb; fi
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then rm --verbose /tmp/google-chrome.deb; fi
if (grep rhel   /etc/os-release && type gnome-session) &> /dev/null; then sudo rpm --import https://dl.google.com/linux/linux_signing_key.pub; fi
if (grep rhel   /etc/os-release && type gnome-session) &> /dev/null; then sudo dnf install --assumeyes https://dl.google.com/dl/linux/direct/google-chrome-stable_current_x86_64.rpm; fi

# REMOVE google-chrome from *
# -----------------------------------------------------------------------------
# Web browser.
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get remove --assume-yes google-chrome-stable; fi
if (grep rhel   /etc/os-release && type gnome-session) &> /dev/null; then sudo dnf remove --assumeyes google-chrome-stable; fi

# INSTALL google-earth pc04
# -----------------------------------------------------------------------------
# Explore the planet.
# -----------------------------------------------------------------------------
# Web app: https://earth.google.com
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then wget --no-verbose --output-document=/tmp/google-earth.deb https://dl.google.com/dl/linux/direct/google-earth-pro-stable_current_amd64.deb; fi
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get install --assume-yes /tmp/google-earth.deb; fi
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then rm --verbose /tmp/google-earth.deb; fi
if (grep rhel   /etc/os-release && type gnome-session) &> /dev/null; then sudo rpm --import https://dl.google.com/linux/linux_signing_key.pub; fi
if (grep rhel   /etc/os-release && type gnome-session) &> /dev/null; then sudo dnf install --assumeyes https://dl.google.com/dl/linux/direct/google-earth-pro-stable-current.x86_64.rpm; fi

# REMOVE google-earth pc04
# -----------------------------------------------------------------------------
# Explore the planet.
# -----------------------------------------------------------------------------
# Web app: https://earth.google.com
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get remove --assume-yes google-earth-pro-stable; fi
if (grep rhel   /etc/os-release && type gnome-session) &> /dev/null; then sudo dnf remove --assumeyes google-earth-pro-stable; fi

# INSTALL handbrake #gpg
# -----------------------------------------------------------------------------
# Video-dvd ripper and transcoder.
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get install --assume-yes handbrake; fi

# REMOVE handbrake #gpg
# -----------------------------------------------------------------------------
# Video-dvd ripper and transcoder.
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get remove --assume-yes handbrake; fi

# INSTALL imagination pc06 pc07
# -----------------------------------------------------------------------------
# Slideshow maker.
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get install --assume-yes imagination; fi

# REMOVE imagination pc06 pc07
# -----------------------------------------------------------------------------
# Slideshow maker.
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get remove --assume-yes imagination; fi

# INSTALL krita pc06
# -----------------------------------------------------------------------------
# Image manipulation.
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get install --assume-yes krita; fi

# REMOVE krita pc06
# -----------------------------------------------------------------------------
# Image manipulation.
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get remove --assume-yes krita; fi

# INSTALL kvm pc06 pc07
# -----------------------------------------------------------------------------
# Virtualization.
# -----------------------------------------------------------------------------
# Kernel-based Virtual Machine.
# Images are in: /var/lib/libvirt/images/
# Dpkg::Options to prevent interaction while restoring /etc/libvirt
# configuration files.
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes --option Dpkg::Options::="--force-confdef" --option Dpkg::Options::="--force-confold" bridge-utils cpu-checker libvirt-clients libvirt-daemon-system qemu-kvm qemu-system virtinst virt-manager; fi
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo usermod --append --groups kvm,libvirt,libvirt-qemu "${SUDO_USER:-$USER}"; fi
# -----------------------------------------------------------------------------
# Prevent "Error starting domain: Requested operation is not valid: network
# 'default' is not active".
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo virsh --connect=qemu:///system net-autostart default; fi
# -----------------------------------------------------------------------------
# Check network 'default' with
# "sudo virsh --connect=qemu:///system net-info default", should output
# 'Autostart: yes'.
# -----------------------------------------------------------------------------
if (grep rhel   /etc/os-release && type gnome-session) &> /dev/null; then sudo dnf groupinstall "Virtualization Host"; fi
if (grep rhel   /etc/os-release && type gnome-session) &> /dev/null; then sudo systemctl enable --now libvirtd; fi
# -----------------------------------------------------------------------------
# Prevent "Error starting domain: Requested operation is not valid: network
# 'default' is not active".
# -----------------------------------------------------------------------------
if (grep rhel   /etc/os-release && type gnome-session) &> /dev/null; then sudo virsh --connect=qemu:///system net-autostart default; fi
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
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo virsh --connect=qemu:///system net-autostart default --disable; fi
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get remove --assume-yes bridge-utils cpu-checker libvirt-clients libvirt-daemon-system qemu-kvm qemu-system virtinst virt-manager; fi
if (grep rhel   /etc/os-release && type gnome-session) &> /dev/null; then sudo systemctl disable --now libvirtd; fi
if (grep rhel   /etc/os-release && type gnome-session) &> /dev/null; then sudo dnf groupremove "Virtualization Host"; fi
REBOOT=true

# INSTALL libreoffice *
# -----------------------------------------------------------------------------
# Office suite.
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get install --assume-yes libreoffice; fi
if (grep rhel   /etc/os-release && type gnome-session && dnf list libreoffice) &> /dev/null; then sudo dnf install --assumeyes libreoffice; fi
if (grep rhel   /etc/os-release && type gnome-session && ! dnf list libreoffice) &> /dev/null; then sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo; fi
if (grep rhel   /etc/os-release && type gnome-session && ! dnf list libreoffice) &> /dev/null; then sudo flatpak install --assumeyes app/org.libreoffice.LibreOffice; fi

# REMOVE libreoffice from *
# -----------------------------------------------------------------------------
# Office suite.
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get remove --assume-yes libreoffice; fi
if (grep rhel   /etc/os-release && type gnome-session && dnf list libreoffice) &> /dev/null; then sudo dnf remove --assumeyes libreoffice; fi
if (grep rhel   /etc/os-release && type gnome-session && ! dnf list libreoffice) &> /dev/null; then sudo flatpak uninstall --assumeyes app/org.libreoffice.LibreOffice; fi

# INSTALL locate pc06 pc07
# -----------------------------------------------------------------------------
# Find files.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes locate; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes mlocate; fi
sudo updatedb

# REMOVE locate pc06 pc07
# -----------------------------------------------------------------------------
# Find files.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes locate; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes mlocate; fi

# INSTALL primary-monitor pc06
# -----------------------------------------------------------------------------
# Set the default GDM login monitor in a multi-monitor setup.
# -----------------------------------------------------------------------------
# Saved in: /home/karel/.config/monitors.xml
# -----------------------------------------------------------------------------
if id gdm &> /dev/null && [[ -f /home/karel/.config/monitors.xml ]]; then sudo cp --preserve --verbose /home/karel/.config/monitors.xml ~gdm/.config/monitors.xml; fi
if id gdm &> /dev/null && [[ -f ~gdm/.config/monitors.xml ]]; then sudo chown --verbose gdm:gdm ~gdm/.config/monitors.xml; fi
if id Debian-gdm &> /dev/null && [[ -f /home/karel/.config/monitors.xml ]]; then sudo cp --preserve --verbose /home/karel/.config/monitors.xml ~Debian-gdm/.config/monitors.xml; fi
if id Debian-gdm &> /dev/null && [[ -f ~Debian-gdm/.config/monitors.xml ]]; then sudo chown --verbose Debian-gdm:Debian-gdm ~Debian-gdm/.config/monitors.xml; fi
REBOOT=true

# REMOVE primary-monitor pc06
# -----------------------------------------------------------------------------
# Reset the default GDM login monitor in a multi-monitor setup.
# -----------------------------------------------------------------------------
# Saved in: /home/karel/.config/monitors.xml
# -----------------------------------------------------------------------------
sudo rm --force --verbose ~gdm/.config/monitors.xml ~Debian-gdm/.config/monitors.xml
REBOOT=true

# INSTALL sound-juicer on #gp
# -----------------------------------------------------------------------------
# Audio-cd ripper and player.
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get install --assume-yes sound-juicer; fi

# REMOVE sound-juicer #gpg
# -----------------------------------------------------------------------------
# Audio-cd ripper and player.
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get remove --assume-yes sound-juicer; fi

# INSTALL spotify pc01 pc02 pc06 pc07
# -----------------------------------------------------------------------------
# Music and podcasts.
# -----------------------------------------------------------------------------
# Web app: https://open.spotify.com
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then wget --no-verbose --output-document=- https://download.spotify.com/debian/pubkey_C85668DF69375001.gpg | sudo gpg --dearmor --yes --output=/usr/share/keyrings/spotify.gpg; fi
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/spotify.gpg] https://repository.spotify.com stable non-free' | sudo tee /etc/apt/sources.list.d/spotify.list 1> /dev/null; fi
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get update; fi
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get install --assume-yes spotify-client; fi
if (grep rhel   /etc/os-release && type gnome-session) &> /dev/null; then echo 'The spotify app is available as a web app.'; fi

# REMOVE spotify pc01 pc02 pc06 pc07
# -----------------------------------------------------------------------------
# Music and podcasts.
# -----------------------------------------------------------------------------
# Web app: https://open.spotify.com
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get remove --assume-yes spotify-client; fi
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo rm --force --verbose /usr/share/keyrings/spotify.gpg /etc/apt/sources.list.d/spotify.list /etc/apt/sources.list.d/spotify.sources; fi

# INSTALL ssh pc01 pc06 pc07
# -----------------------------------------------------------------------------
# Secure SHell.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes ssh; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes openssh; fi
sudo sed --in-place 's/PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
# -----------------------------------------------------------------------------
# Check for remote root access.
# -----------------------------------------------------------------------------
grep 'PermitRootLogin no' /etc/ssh/sshd_config
sudo systemctl restart ssh.service
# -----------------------------------------------------------------------------
# Configure static table lookup for hostnames and IP addresses.
# -----------------------------------------------------------------------------
if [[ 'pc01 pc06 pc07' =~ $HOSTNAME ]]; then sudo sed --in-place '/^192.168.1./d' /etc/hosts; fi
if [[ 'pc01 pc06 pc07' =~ $HOSTNAME ]]; then sudo sed --in-place '2a192.168.1.100 pc01' /etc/hosts; fi
if [[ 'pc01 pc06 pc07' =~ $HOSTNAME ]]; then sudo sed --in-place '3a192.168.1.2 pc06' /etc/hosts; fi
if [[ 'pc01 pc06 pc07' =~ $HOSTNAME ]]; then sudo sed --in-place '4a192.168.1.219 pc07' /etc/hosts; fi

# REMOVE ssh pc01 pc06 pc07
# -----------------------------------------------------------------------------
# Secure SHell.
# -----------------------------------------------------------------------------
sudo sed --in-place 's/PermitRootLogin no/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes ssh; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes openssh; fi
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
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then wget --no-verbose --output-document=/tmp/teamviewer.deb https://download.teamviewer.com/download/linux/teamviewer_amd64.deb; fi
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get install --assume-yes /tmp/teamviewer.deb; fi
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then rm --verbose /tmp/teamviewer.deb; fi
if (grep rhel   /etc/os-release && type gnome-session) &> /dev/null; then sudo dnf install --assumeyes https://download.teamviewer.com/download/linux/teamviewer.x86_64.rpm; fi

# REMOVE teamviewer from *
# -----------------------------------------------------------------------------
# Remote desktop.
# -----------------------------------------------------------------------------
# Web app: https://web.teamviewer.com
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get remove --assume-yes teamviewer; fi
if (grep rhel   /etc/os-release && type gnome-session) &> /dev/null; then sudo dnf remove --assumeyes teamviewer; fi

# INSTALL terminal pc01 pc06 pc07
# -----------------------------------------------------------------------------
# Bash completion.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes bash-completion; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes bash-completion; fi
# -----------------------------------------------------------------------------
# View and install deb files.
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get install --assume-yes gdebi; fi
# -----------------------------------------------------------------------------
# Display directory tree.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes tree; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes tree; fi

# REMOVE terminal pc01 pc06 pc07
# -----------------------------------------------------------------------------
# Bash completion.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes bash-completion; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes bash-completion; fi
# -----------------------------------------------------------------------------
# View and install deb files.
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get remove --assume-yes gdebi; fi
# -----------------------------------------------------------------------------
# Display directory tree.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes tree; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes tree; fi

# INSTALL transmission pc01 pc06 pc07
# -----------------------------------------------------------------------------
# BitTorrent client.
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get install --assume-yes transmission; fi
if (grep rhel   /etc/os-release && type gnome-session) &> /dev/null; then sudo dnf install --assumeyes transmission; fi

# REMOVE transmission pc01 pc06 pc07
# -----------------------------------------------------------------------------
# BitTorrent client.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes transmission; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes transmission; fi

# INSTALL ufw pc01 pc06 pc07
# -----------------------------------------------------------------------------
# Uncomplicated FireWall.
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get install --assume-yes gufw; fi
if (grep rhel   /etc/os-release && type gnome-session) &> /dev/null; then sudo dnf install --assumeyes gufw; fi
sudo ufw allow ssh
sudo ufw enable

# REMOVE ufw pc01 pc06 pc07
# -----------------------------------------------------------------------------
# Uncomplicated FireWall.
# -----------------------------------------------------------------------------
sudo ufw disable
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes gufw; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes gufw; fi

# INSTALL usbutils pc06 pc07
# -----------------------------------------------------------------------------
# USB utilities.
# This package contains the lsusb utility.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get install --assume-yes usbutils; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf install --assumeyes usbutils; fi

# REMOVE usbutils pc06 pc07
# -----------------------------------------------------------------------------
# USB utilities.
# This package contains the lsusb utility.
# -----------------------------------------------------------------------------
if grep --quiet debian /etc/os-release; then sudo apt-get remove --assume-yes usbutils; fi
if grep --quiet rhel   /etc/os-release; then sudo dnf remove --assumeyes usbutils; fi

# INSTALL user-guest pc01 pc06 pc07
# -----------------------------------------------------------------------------
# Add guest user.
# -----------------------------------------------------------------------------
if ! id "$(gettext --domain=kz 'guest')" &> /dev/null; then sudo useradd --create-home --shell /usr/bin/bash --comment "$(gettext --domain=kz 'Guest_user')" "$(gettext --domain=kz 'guest')"; fi
if id "$(gettext --domain=kz 'guest')" &> /dev/null; then sudo passwd --delete "$(gettext --domain=kz 'guest')"; fi

# REMOVE user-guest pc01 pc06 pc07
# -----------------------------------------------------------------------------
# Delete guest user.
# -----------------------------------------------------------------------------
if id "$(gettext --domain=kz 'guest')" &> /dev/null; then sudo userdel --remove "$(gettext --domain=kz 'guest')"; fi

# INSTALL virtualbox #gpg
# -----------------------------------------------------------------------------
# Virtualization.
# -----------------------------------------------------------------------------
# VirtualBox Guest user Additions ISO are in '/usr/share/virtualbox/'.
# If the installation hangs or VBox does not work, check the virtualization
# settings in the BIOS/UEFI.
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then echo 'virtualbox-ext-pack virtualbox-ext-pack/license select true' | sudo debconf-set-selections; fi
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get install --assume-yes virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso; fi
if (grep rhel   /etc/os-release && type gnome-session) &> /dev/null; then sudo dnf install --assumeyes VirtualBox; fi

# REMOVE virtualbox #gpg
# -----------------------------------------------------------------------------
# Virtualization.
# -----------------------------------------------------------------------------
# VirtualBox Guest user Additions ISO are in '/usr/share/virtualbox/'.
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get remove --assume-yes virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso; fi
if (grep rhel   /etc/os-release && type gnome-session) &> /dev/null; then sudo dnf remove --assumeyes VirtualBox; fi

# INSTALL vlc *
# -----------------------------------------------------------------------------
# Multimedia player.
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get install --assume-yes vlc; fi
if (grep rhel   /etc/os-release && type gnome-session) &> /dev/null; then sudo dnf install --assumeyes vlc; fi

# REMOVE vlc from *
# -----------------------------------------------------------------------------
# Multimedia player.
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get remove --assume-yes vlc; fi
if (grep rhel   /etc/os-release && type gnome-session) &> /dev/null; then sudo dnf remove --assumeyes vlc; fi

# INSTALL webmin pc07
# -----------------------------------------------------------------------------
# Web console.
# -----------------------------------------------------------------------------
# Web app: https://localhost:10000
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then wget --no-verbose --output-document=/tmp/setup-repos.sh https://raw.githubusercontent.com/webmin/webmin/master/setup-repos.sh; fi
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo sh /tmp/setup-repos.sh --force; fi
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo rm --force --verbose /tmp/setup-repos.sh; fi
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get install --assume-yes webmin; fi
if (grep rhel   /etc/os-release && type gnome-session) &> /dev/null; then wget --no-verbose --output-document=/tmp/setup-repos.sh https://raw.githubusercontent.com/webmin/webmin/master/setup-repos.sh; fi
if (grep rhel   /etc/os-release && type gnome-session) &> /dev/null; then sudo sh /tmp/setup-repos.sh --force; fi
if (grep rhel   /etc/os-release && type gnome-session) &> /dev/null; then sudo rm --force --verbose /tmp/setup-repos.sh; fi
if (grep rhel   /etc/os-release && type gnome-session) &> /dev/null; then sudo dnf install --assumeyes webmin; fi

# REMOVE webmin pc07
# -----------------------------------------------------------------------------
# Web console.
# -----------------------------------------------------------------------------
# Web app: https://localhost:10000
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get remove --assume-yes webmin; fi
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo rm --force --verbose /usr/share/keyrings/*webmin*.gpg /etc/apt/sources.list.d/webmin*.list /etc/apt/sources.list.d/webmin*.sources; fi
if (grep rhel   /etc/os-release && type gnome-session) &> /dev/null; then sudo dnf remove --assumeyes webmin; fi
if (grep rhel   /etc/os-release && type gnome-session) &> /dev/null; then sudo rm --force --verbose /etc/yum.repos.d/webmin.repo; fi

# INSTALL youtube-dl #gpg
# -----------------------------------------------------------------------------
# Download videos.
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get install --assume-yes youtubedl-gui; fi
if (grep rhel   /etc/os-release && type gnome-session) &> /dev/null; then sudo dnf install --assumeyes youtube-dl; fi

# REMOVE youtube-dl #gpg
# -----------------------------------------------------------------------------
# Download videos.
# -----------------------------------------------------------------------------
if (grep debian /etc/os-release && type gnome-session) &> /dev/null; then sudo apt-get remove --assume-yes youtubedl-gui; fi
if (grep rhel   /etc/os-release && type gnome-session) &> /dev/null; then sudo dnf remove --assumeyes youtube-dl; fi
