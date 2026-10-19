# shellcheck shell=bash disable=SC2034
# #############################################################################
# SPDX-FileComment: Installation file for use with kz install.
#
# SPDX-FileCopyrightText: Karel Zimmer <info@karelzimmer.nl>
# SPDX-License-Identifier: CC0-1.0
# #############################################################################
#
# =============================================================================
# Use "man kz install.sh" and "man kz install.sh.gpg" to learn more about the
# format of this file.
# =============================================================================

#|install|aer-settings|#none|Advanced Error Reporting settings
# -----------------------------------------------------------------------------
# Disable kernel config parameter PCIEAER (Peripheral Component Interconnect
# Express Advanced Error Reporting) prevents the log gets flooded with
# 'AER: Corrected errors received'. This is usually needed for HP hardware.
# -----------------------------------------------------------------------------
if ! grep --quiet --regexp='pci=noaer' /etc/default/grub; then sudo sed --in-place --expression='s/loglevel=3/loglevel=3 pci=noaer/; s/quiet/quiet pci=noaer/' /etc/default/grub; fi
if grep --quiet --regexp='debian' /etc/os-release; then sudo update-grub; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo grub2-mkconfig -o /boot/grub2/grub.cfg; fi
# -----------------------------------------------------------------------------
# Check for available kernel config parameter pci=noaer.
# -----------------------------------------------------------------------------
grep --quiet --regexp='pci=noaer' /etc/default/grub
touch /tmp/kz-install-need-reboot

#|remove|aer-settings|#none|Advanced Error Reporting settings
# -----------------------------------------------------------------------------
# Enable kernel config parameter PCIEAER (Peripheral Component Interconnect
# Express Advanced Error Reporting) to allow 'AER: Corrected errors received'
# messages to appear in the log. This is usually the case for HP hardware.
# -----------------------------------------------------------------------------
if grep --quiet --regexp='pci=noaer' /etc/default/grub; then sudo sed --in-place --expression='s/ pci=noaer//' /etc/default/grub; fi
if grep --quiet --regexp='debian' /etc/os-release; then sudo update-grub; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo grub2-mkconfig -o /boot/grub2/grub.cfg; fi
# -----------------------------------------------------------------------------
# Check for missing kernel config parameter pci=noaer.
# -----------------------------------------------------------------------------
! grep --quiet --regexp='pci=noaer' /etc/default/grub
touch /tmp/kz-install-need-reboot

#|install|angryipscan|pc06 pc07|Network scanner
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes flatpak && sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo && sudo flatpak install --assumeyes org.angryip.ipscan; fi
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf install --assumeyes flatpak && sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo && sudo flatpak install --assumeyes org.angryip.ipscan; fi

#|remove|angryipscan|pc06 pc07|Network scanner
if [[ ${XDG_CURRENT_DESKTOP-} ]]; then sudo flatpak uninstall --assumeyes org.angryip.ipscan; fi

#|install|ansible|pc06 pc07|Configuration management
if grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes ansible; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf install --assumeyes ansible-core; fi

#|remove|ansible|pc06 pc07|Configuration management
if grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get remove --assume-yes ansible; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf remove --assumeyes ansible-core; fi

#|install|apport-settings|#none|Apport settings
if grep --quiet --regexp='Ubuntu' /etc/os-release; then sudo systemctl disable --now apport.service && sudo sed --in-place --expression='s/enabled=.*$/enabled=0/' /etc/default/apport && sudo rm --force --verbose /var/crash/*; fi

#|remove|apport-settings|#none|Apport settings
if grep --quiet --regexp='Ubuntu' /etc/os-release; then sudo sed --in-place --expression='s/enabled=.*$/enabled=1/' /etc/default/apport && systemctl enable --now apport.service; fi

#|install|backintime|#none|Backup & snapshot system
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes backintime-qt; fi
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf install --assumeyes backintime-qt; fi

#|remove|backintime|#none|Backup & snapshot system
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get remove --assume-yes backintime-qt; fi
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf remove --assumeyes backintime-qt; fi

#|install|bash-completion|pc01 pc06 pc07|Bash completion
if grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes bash-completion; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf install --assumeyes bash-completion; fi

#|remove|bash-completion|pc01 pc06 pc07|Bash completion
if grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get remove --assume-yes bash-completion; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf remove --assumeyes bash-completion; fi

#|install|bitwarden|*|Password manager
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes flatpak && sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo && sudo flatpak install --assumeyes com.bitwarden.desktop; fi
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf install --assumeyes flatpak && sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo && sudo flatpak install --assumeyes com.bitwarden.desktop; fi
touch /tmp/kz-install-need-reboot

#|remove|bitwarden|*|Password manager
if [[ ${XDG_CURRENT_DESKTOP-} ]]; then sudo flatpak uninstall --assumeyes com.bitwarden.desktop; fi
touch /tmp/kz-install-need-reboot

#|install|bottles|pc06 pc07|Run Windows software
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes flatpak && sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo && sudo flatpak install --assumeyes com.usebottles.bottles; fi
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf install --assumeyes flatpak && sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo && sudo flatpak install --assumeyes com.usebottles.bottles; fi
touch /tmp/kz-install-need-reboot

#|remove|bottles|pc06 pc07|Run Windows software
if [[ ${XDG_CURRENT_DESKTOP-} ]]; then sudo flatpak uninstall --assumeyes com.usebottles.bottles; fi
touch /tmp/kz-install-need-reboot

#|install|cockpit|pc06|Server management
# -----------------------------------------------------------------------------
# Web app: https://localhost:9090
# -----------------------------------------------------------------------------
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes cockpit cockpit-pcp; fi
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf install --assumeyes cockpit cockpit-pcp; fi

#|remove|cockpit|pc06|Server management
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get remove --assume-yes cockpit; fi
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf remove --assumeyes cockpit; fi

#|install|cups|*|Printing
# -----------------------------------------------------------------------------
# Common UNIX Printing System
# Web app: http://localhost:631
# -----------------------------------------------------------------------------
if grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes cups libcupsimage2; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf install --assumeyes cups; fi

#|remove|cups|*|Printing
if grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get remove --assume-yes cups libcupsimage2; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf remove --assumeyes cups; fi

#|install|desktop-settings|*|Desktop settings
# -----------------------------------------------------------------------------
# Enable LightDM user greeter.
# -----------------------------------------------------------------------------
if [[ -f /etc/lightdm/lightdm.conf ]]; then sudo sed --in-place --expression='s/.*greeter-hide-users=.*$/greeter-hide-users=false/' /etc/lightdm/lightdm.conf; fi
touch /tmp/kz-install-need-reboot

#|remove|desktop-settings|*|Desktop settings
# -----------------------------------------------------------------------------
# Disable LightDM user greeter.
# -----------------------------------------------------------------------------
if [[ -f /etc/lightdm/lightdm.conf ]]; then sudo sed --in-place --expression='s/.*greeter-hide-users=.*$/greeter-hide-users=true/' /etc/lightdm/lightdm.conf; fi
touch /tmp/kz-install-need-reboot

#|install|dos2unix|pc06 pc07|Convert text files
if grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes dos2unix; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf install --assumeyes dos2unix; fi

#|remove|dos2unix|pc06 pc07|Convert text files
if grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get remove --assume-yes dos2unix; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf remove --assumeyes dos2unix; fi

#|install|evolution|pc06 pc07|Email & agenda
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes evolution; fi
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf install --assumeyes evolution; fi

#|remove|evolution|pc06 pc07|Email & agenda
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get remove --assume-yes evolution; fi
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf remove --assumeyes evolution; fi

#|install|exiftool|pc06 pc07|Metadata editor
if grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes libimage-exiftool-perl; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf install --assumeyes perl-Image-ExifTool; fi

#|remove|exiftool|pc06 pc07|Metadata editor
if grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get remove --assume-yes libimage-exiftool-perl; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf remove --assumeyes perl-Image-ExifTool; fi

#|install|fakeroot|pc06 pc07|Simulate superuser privileges
if grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes fakeroot; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf install --assumeyes fakeroot; fi

#|remove|fakeroot|pc06 pc07|Simulate superuser privileges
if grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get remove --assume-yes fakeroot; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf remove --assumeyes fakeroot; fi

#|install|fastfetch|pc06 pc07|System information
if grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes fastfetch; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf install --assumeyes fastfetch; fi

#|remove|fastfetch|pc06 pc07|System information
if grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get remove --assume-yes fastfetch; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf remove --assumeyes fastfetch; fi

#|install|fdupes|#none|Find duplicate files
if grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes fdupes; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf install --assumeyes fdupes; fi
# -----------------------------------------------------------------------------
# Usage:
# $ fdupes -r   /path/to/folder # Report recursively from /path/to/folder
# $ fdupes -rd  /path/to/folder # Delete, interactively, from /path/to/folder
# $ fdupes -rdN /path/to/folder # Delete, from /path/to/folder, keep first dup
# -----------------------------------------------------------------------------

#|remove|fdupes|#none|Find duplicate files
if grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get remove --assume-yes fdupes; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf remove --assumeyes fdupes; fi

#|install|firefox|#none|Browser
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes firefox-esr firefox-esr-l10n-"${LANG:0:2}" || sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes firefox firefox-locale-"${LANG:0:2}"; fi
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf install --assumeyes firefox; fi

#|remove|firefox|#none|Browser
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get remove --assume-yes firefox-esr firefox-esr-l10n-"${LANG:0:2}" || sudo DEBIAN_FRONTEND=noninteractive apt-get remove --assume-yes firefox firefox-locale-"${LANG:0:2}"; fi
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf remove --assumeyes firefox; fi

#|install|firewall|*|Firewall
# -----------------------------------------------------------------------------
# Install [g]ufw & firewall-config.
# -----------------------------------------------------------------------------
if grep --quiet --regexp='debian' /etc/os-release; then if [[ ${XDG_CURRENT_DESKTOP-} ]]; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes gufw; else sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes ufw; fi; sudo ufw enable; fi
if grep --quiet --regexp='rhel' /etc/os-release && [[ ${XDG_CURRENT_DESKTOP-} ]]; then sudo dnf install --assumeyes firewall-config; fi
# -----------------------------------------------------------------------------
# Add firewall rules for GSConnect.
# -----------------------------------------------------------------------------
if type gnome-session &> /dev/null && gnome-extensions list --enabled | grep --quiet --regexp='gsconnect' && systemctl is-enabled --quiet ufw; then sudo ufw allow 1714:1764/udp && sudo ufw allow 1714:1764/tcp && sudo ufw reload; fi
if type gnome-session &> /dev/null && gnome-extensions list --enabled | grep --quiet --regexp='gsconnect' && systemctl is-enabled --quiet firewalld; then sudo firewall-cmd --permanent --add-port=1714-1764/{udp,tcp} && sudo firewall-cmd --reload; fi
# -----------------------------------------------------------------------------
# Add firewall rules for SSH.
# -----------------------------------------------------------------------------
if type ssh &> /dev/null && systemctl is-enabled --quiet ufw; then sudo ufw allow ssh && sudo ufw reload; fi
if type ssh &> /dev/null && systemctl is-enabled --quiet firewalld; then sudo firewall-cmd --permanent --add-service=ssh && sudo firewall-cmd --reload; fi

#|remove|firewall|*|Firewall
# -----------------------------------------------------------------------------
# Remove firewall rules for GSConnect.
# -----------------------------------------------------------------------------
if type gnome-session &> /dev/null && gnome-extensions list --enabled | grep --quiet --regexp='gsconnect' && systemctl is-enabled --quiet ufw; then sudo ufw delete allow 1714:1764/udp && sudo ufw delete allow 1714:1764/tcp; fi
if type gnome-session &> /dev/null && gnome-extensions list --enabled | grep --quiet --regexp='gsconnect' && systemctl is-enabled --quiet firewalld; then sudo firewall-cmd --permanent --remove-port=1714-1764/{udp,tcp}; fi
# -----------------------------------------------------------------------------
# Remove firewall rules for SSH.
# -----------------------------------------------------------------------------
if type ssh &> /dev/null && systemctl is-enabled --quiet ufw; then sudo ufw delete allow ssh && sudo ufw reload; fi
if type ssh &> /dev/null && systemctl is-enabled --quiet firewalld; then sudo firewall-cmd --permanent --remove-service=ssh && sudo firewall-cmd --reload; fi
# -----------------------------------------------------------------------------
# Remove [g]ufw & firewall-config.
# -----------------------------------------------------------------------------
if grep --quiet --regexp='debian' /etc/os-release; then sudo ufw disable && sudo DEBIAN_FRONTEND=noninteractive apt-get remove --assume-yes ufw; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf remove --assumeyes firewall-config; fi

#|install|fwupd-settings|#none|Firmware updates settings
sudo systemctl disable --now fwupd.service && sudo systemctl mask fwupd.service

#|remove|fwupd-settings|#none|Firmware updates settings
sudo systemctl unmask fwupd.service && sudo systemctl enable --now fwupd.service

#|install|gdebi|#none|Install deb files
if grep --quiet --regexp='debian' /etc/os-release && type gnome-session &> /dev/null; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes gdebi; fi
# This app is not available on Red Hat and Red Hat-based systems.

#|remove|gdebi|#none|Install deb files
if grep --quiet --regexp='debian' /etc/os-release && type gnome-session &> /dev/null; then sudo DEBIAN_FRONTEND=noninteractive apt-get remove --assume-yes gdebi; fi
# This app is not available on Red Hat and Red Hat-based systems.

#|install|gettext|pc06 pc07|Internationalization utilities
if grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes gettext; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf install --assumeyes gettext; fi

#|remove|gettext|pc06 pc07|Internationalization utilities
if grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get remove --assume-yes gettext; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf remove --assumeyes gettext; fi

#|install|git|pc06 pc07|Version control system
# -----------------------------------------------------------------------------
# Web app: https://github.com
# -----------------------------------------------------------------------------
if grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes git; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf install --assumeyes git; fi

#|remove|git|pc06 pc07|Version control system
if grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get remove --assume-yes git; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf remove --assumeyes git; fi

#|install|gnome-extensions-cli|pc06 pc07|GNOME extensions command line interface
if grep --quiet --regexp='debian' /etc/os-release && type gnome-session &> /dev/null; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes pipx && sudo pipx install gnome-extensions-cli; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release && type gnome-session &> /dev/null; then sudo dnf install --assumeyes pipx && sudo pipx install gnome-extensions-cli; fi

#|remove|gnome-extensions-cli|pc06 pc07|GNOME extensions command line interface
if grep --quiet --regexp='debian' /etc/os-release && type gnome-session &> /dev/null; then sudo pipx uninstall gnome-extensions-cli; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release && type gnome-session &> /dev/null; then sudo pipx uninstall gnome-extensions-cli; fi

#|install|gnome-shell-extension-caffeine|*|GNOME disable screensaver & suspend
if grep --quiet --regexp='debian' /etc/os-release && type gnome-session &> /dev/null && apt-cache show gnome-shell-extension-caffeine; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes gnome-shell-extension-caffeine; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release && type gnome-session &> /dev/null && dnf list gnome-shell-extension-caffeine; then sudo dnf install --assumeyes gnome-shell-extension-caffeine; fi
touch /tmp/kz-install-need-reboot

#|remove|gnome-shell-extension-caffeine|*|GNOME disable screensaver & suspend
if grep --quiet --regexp='debian' /etc/os-release && type gnome-session &> /dev/null && apt-cache show gnome-shell-extension-caffeine; then sudo DEBIAN_FRONTEND=noninteractive apt-get remove --assume-yes gnome-shell-extension-caffeine; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release && type gnome-session &> /dev/null && dnf list gnome-shell-extension-caffeine; then sudo dnf remove --assumeyes gnome-shell-extension-caffeine; fi
touch /tmp/kz-install-need-reboot

#|install|gnome-shell-extension-dashtodock|*|GNOME dock
if grep --quiet --regexp='debian' /etc/os-release && type gnome-session &> /dev/null && ! apt-cache show gnome-shell-extension-ubuntu-dock; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes gnome-shell-extension-dashtodock; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release && type gnome-session &> /dev/null && dnf list gnome-shell-extension-dash-to-dock; then sudo dnf install --assumeyes gnome-shell-extension-dash-to-dock; fi
touch /tmp/kz-install-need-reboot

#|remove|gnome-shell-extension-dashtodock|*|GNOME dock
if grep --quiet --regexp='debian' /etc/os-release && type gnome-session &> /dev/null && ! apt-cache show gnome-shell-extension-ubuntu-dock; then sudo DEBIAN_FRONTEND=noninteractive apt-get remove --assume-yes gnome-shell-extension-dashtodock; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release && type gnome-session &> /dev/null && dnf list gnome-shell-extension-dash-to-dock; then sudo dnf remove --assumeyes gnome-shell-extension-dash-to-dock; fi
touch /tmp/kz-install-need-reboot

#|install|gnome-shell-extension-gsconnect|pc06 pc07|GNOME connect mobile devices & desktops
# -----------------------------------------------------------------------------
# Install gnome-shell-extension-gsconnect.
# -----------------------------------------------------------------------------
if grep --quiet --regexp='debian' /etc/os-release && type gnome-session &> /dev/null && apt-cache show gnome-shell-extension-gsconnect; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes gnome-shell-extension-gsconnect; fi
# For Red Hat and Red Hat-based systems go to https://extensions.gnome.org/extension/1319/gsconnect/ and enable the extension.
# -----------------------------------------------------------------------------
# Add firewall rules for GSConnect.
# -----------------------------------------------------------------------------
if systemctl is-enabled --quiet ufw; then sudo ufw allow 1714:1764/udp && sudo ufw allow 1714:1764/tcp && sudo ufw reload; fi
if systemctl is-enabled --quiet firewalld; then sudo firewall-cmd --permanent --add-port=1714-1764/{udp,tcp} && sudo firewall-cmd --reload; fi

#|remove|gnome-shell-extension-gsconnect|pc06 pc07|GNOME connect mobile devices & desktops
# -----------------------------------------------------------------------------
# Remove gnome-shell-extension-gsconnect.
# -----------------------------------------------------------------------------
if grep --quiet --regexp='debian' /etc/os-release && type gnome-session &> /dev/null && apt-cache show gnome-shell-extension-gsconnect; then sudo DEBIAN_FRONTEND=noninteractive apt-get remove --assume-yes gnome-shell-extension-gsconnect; fi
# For Red Hat and Red Hat-based systems go to https://extensions.gnome.org/extension/1319/gsconnect/ and disable the extension.
# -----------------------------------------------------------------------------
# Remove firewall rules for GSConnect.
# -----------------------------------------------------------------------------
if systemctl is-enabled --quiet ufw; then sudo ufw delete allow 1714:1764/udp && sudo ufw delete allow 1714:1764/tcp && sudo ufw reload; fi
if systemctl is-enabled --quiet firewalld; then sudo firewall-cmd --permanent --remove-port=1714-1764/{udp,tcp} && sudo firewall-cmd --reload; fi

#|install|gnome-shell-extension-manager|pc06 pc07|GNOME extensions manager
if grep --quiet --regexp='debian' /etc/os-release && type gnome-session &> /dev/null; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes gnome-shell-extension-manager; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release && type gnome-session &> /dev/null; then sudo dnf install --assumeyes gnome-extensions-app; fi

#|remove|gnome-shell-extension-manager|pc06 pc07|GNOME extensions manager
if grep --quiet --regexp='debian' /etc/os-release && type gnome-session &> /dev/null; then sudo DEBIAN_FRONTEND=noninteractive apt-get remove --assume-yes gnome-shell-extension-manager; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release && type gnome-session &> /dev/null; then sudo dnf remove --assumeyes gnome-extensions-app; fi

#|install|gnome-shell-extension-no-annoyance|*|GNOME disable 'Window is ready'
if grep --quiet --regexp='debian' /etc/os-release && type gnome-session &> /dev/null && apt-cache show gnome-shell-extension-no-annoyance; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes gnome-shell-extension-no-annoyance; fi
# For Red Hat and Red Hat-based systems go to https://extensions.gnome.org/extension/6109/noannoyance-fork/ and enable the extension.
touch /tmp/kz-install-need-reboot

#|remove|gnome-shell-extension-no-annoyance|*|GNOME disable 'Window is ready'
if grep --quiet --regexp='debian' /etc/os-release && type gnome-session &> /dev/null && apt-cache show gnome-shell-extension-no-annoyance; then sudo DEBIAN_FRONTEND=noninteractive apt-get remove --assume-yes gnome-shell-extension-no-annoyance; fi
# For Red Hat and Red Hat-based systems go to https://extensions.gnome.org/extension/6109/noannoyance-fork/ and disable the extension.
touch /tmp/kz-install-need-reboot

#|install|gnome-shell-extension-no-overview|*|GNOME no overview at start-up
if grep --quiet --regexp='debian' /etc/os-release && type gnome-session &> /dev/null && apt-cache show gnome-shell-extension-no-overview; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes gnome-shell-extension-no-overview; fi
# For Red Hat and Red Hat-based systems go to https://extensions.gnome.org/extension/4099/no-overview/ and enable the extension.
touch /tmp/kz-install-need-reboot

#|remove|gnome-shell-extension-no-overview|*|GNOME no overview at start-up
if grep --quiet --regexp='debian' /etc/os-release && type gnome-session &> /dev/null && apt-cache show gnome-shell-extension-no-overview; then sudo DEBIAN_FRONTEND=noninteractive apt-get remove --assume-yes gnome-shell-extension-no-overview; fi
# For Red Hat and Red Hat-based systems go to https://extensions.gnome.org/extension/4099/no-overview/ and disable the extension.
touch /tmp/kz-install-need-reboot

#|install|gnome-tweaks|pc06 pc07|GNOME tweaks
if grep --quiet --regexp='debian' /etc/os-release && type gnome-session &> /dev/null; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes gnome-tweaks; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release && type gnome-session &> /dev/null; then sudo dnf install --assumeyes gnome-tweaks; fi

#|remove|gnome-tweaks|pc06 pc07|GNOME tweaks
if grep --quiet --regexp='debian' /etc/os-release && type gnome-session &> /dev/null; then sudo DEBIAN_FRONTEND=noninteractive apt-get remove --assume-yes gnome-tweaks; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release && type gnome-session &> /dev/null; then sudo dnf remove --assumeyes gnome-tweaks; fi

#|install|google-chrome|pc01 pc06 pc07|Browser
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='debian' /etc/os-release; then sudo wget --quiet --output-document=/tmp/google-chrome.deb https://dl.google.com/dl/linux/direct/google-chrome-stable_current_amd64.deb && sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes /tmp/google-chrome.deb && sudo rm --force --verbose /tmp/google-chrome.deb; fi
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo rpm --import https://dl.google.com/linux/linux_signing_key.pub && sudo dnf install --assumeyes https://dl.google.com/dl/linux/direct/google-chrome-stable_current_x86_64.rpm; fi

#|remove|google-chrome|pc01 pc06 pc07|Browser
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get remove --assume-yes google-chrome-stable; fi
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf remove --assumeyes google-chrome-stable; fi

#|install|groff|pc06 pc07|Text-formatting system
if grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes groff; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf install --assumeyes groff; fi

#|remove|groff|pc06 pc07|Text-formatting system
if grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get remove --assume-yes groff; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf remove --assumeyes groff; fi

#|install|htop|pc01 pc06 pc07|Processes viewer
if grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes htop; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf install --assumeyes htop; fi

#|remove|htop|pc01 pc06 pc07|Processes viewer
if grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get remove --assume-yes htop; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf remove --assumeyes htop; fi

#|install|imagination|pc06 pc07|Slide show maker
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes imagination; fi
# This app is not available on Red Hat and Red Hat-based systems.

#|remove|imagination|pc06 pc07|Slide show maker
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get remove --assume-yes imagination; fi
# This app is not available on Red Hat and Red Hat-based systems.

#|install|jq|pc06 pc07|JSON processor
if grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes jq; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf install --assumeyes jq; fi

#|remove|jq|pc06 pc07|JSON processor
if grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get remove --assume-yes jq; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf remove --assumeyes jq; fi

#|install|krita|pc06|Image manipulation
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes krita; fi
# This app is not available on Red Hat and Red Hat-based systems.

#|remove|krita|pc06|Image manipulation
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get remove --assume-yes krita; fi
# This app is not available on Red Hat and Red Hat-based systems.

#|install|kvm|pc06 pc07|Virtualization
# -----------------------------------------------------------------------------
# Kernel-based Virtual Machine
# Images are in: /var/lib/libvirt/images/
# -----------------------------------------------------------------------------
if grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes bridge-utils libvirt-clients libvirt-daemon-system qemu-system virtinst; if [[ ${XDG_CURRENT_DESKTOP-} ]]; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes virt-manager; fi; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf groupinstall "Virtualization Host"; fi
sudo systemctl enable --now libvirtd
# -----------------------------------------------------------------------------
# Prevent "Error starting domain: Requested operation is not valid: network
# 'default' is not active".
# -----------------------------------------------------------------------------
sudo virsh --connect=qemu:///system net-autostart default
# -----------------------------------------------------------------------------
# Check network 'default' with the following command:
# "sudo virsh --connect=qemu:///system net-info default", should output
# 'Autostart: yes'.
# -----------------------------------------------------------------------------
touch /tmp/kz-install-need-reboot

#|remove|kvm|pc06 pc07|Virtualization
if grep --quiet --regexp='debian' /etc/os-release; then sudo virsh --connect=qemu:///system net-autostart default --disable && sudo DEBIAN_FRONTEND=noninteractive apt-get remove --assume-yes bridge-utils libvirt-clients libvirt-daemon-system qemu-system virtinst; if [[ ${XDG_CURRENT_DESKTOP-} ]]; then sudo DEBIAN_FRONTEND=noninteractive apt-get remove --assume-yes virt-manager; fi; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo systemctl disable --now libvirtd && sudo dnf groupremove "Virtualization Host"; fi
touch /tmp/kz-install-need-reboot

#|install|lftp|pc06 pc07|FTP client
if grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes lftp; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf install --assumeyes lftp; fi

#|remove|lftp|pc06 pc07|FTP client
if grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get remove --assume-yes lftp; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf remove --assumeyes lftp; fi

#|install|libreoffice|*|Office suite
# -----------------------------------------------------------------------------
# This install includes:
# - Microsoft TrueType core fonts like Arial, Times New Roman, and Verdana, and
# - MS Word fonts like Calibri, Cambria, and Arial, for better compatibility
# -----------------------------------------------------------------------------
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='debian' /etc/os-release; then echo 'ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true' | sudo debconf-set-selections && sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes fonts-croscore fonts-crosextra-caladea fonts-crosextra-carlito fonts-recommended libreoffice libreoffice-gtk3 ttf-mscorefonts-installer && sudo fc-cache -fv; fi
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf install --assumeyes cabextract flatpak fontconfig google-carlito-fonts google-crosextra-caladea-fonts liberation-fonts xorg-x11-font-utils && sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo && sudo flatpak install --assumeyes flathub app/org.libreoffice.LibreOffice && sudo rpm -i --nodigest https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm && sudo fc-cache -fv; fi

#|remove|libreoffice|*|Office suite
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get remove --assume-yes fonts-croscore fonts-crosextra-caladea fonts-crosextra-carlito fonts-recommended libreoffice libreoffice-gtk3 ttf-mscorefonts-installer && sudo fc-cache -fv; fi
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf remove --assumeyes cabextract flatpak fontconfig google-carlito-fonts google-crosextra-caladea-fonts liberation-fonts xorg-x11-font-utils && sudo flatpak uninstall --assumeyes app/org.libreoffice.LibreOffice && sudo rpm -e --nodigest https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm && sudo fc-cache -fv; fi

#|install|linters|pc06 pc07|Analyse scripts
# -----------------------------------------------------------------------------
# This install includes:
# MyPy              - Optional static typing for Python
# pycodestyle       - Python style guide checker (formerly called pep8)
# python3-autopep8  - Tool that automatically formats Python code to conform to
#                       PEP 8
# Bashate           - Bash script style checker
# Shellcheck        - Lint tool for shell scripts,
#                       Web app: https://www.shellcheck.net
# -----------------------------------------------------------------------------
if grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes mypy pycodestyle python3-autopep8 python3-bashate shellcheck; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf install --assumeyes pycodestyle python3-autopep8 python3-bashate python3-mypy shellcheck; fi

#|remove|linters|pc06 pc07|Analyse scripts
if grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get remove --assume-yes mypy pycodestyle python3-autopep8 python3-bashate shellcheck; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf remove --assumeyes pycodestyle python3-autopep8 python3-bashate python3-mypy shellcheck; fi

#|install|locate|pc06 pc07|Locate files
if grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes locate; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf install --assumeyes mlocate; fi
sudo updatedb

#|remove|locate|pc06 pc07|Locate files
if grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get remove --assume-yes locate; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf remove --assumeyes mlocate; fi

#|install|lshw|pc01 pc06 pc07|Hardware info
if grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes lshw; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf install --assumeyes lshw; fi

#|remove|lshw|pc01 pc06 pc07|Hardware info
if grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get remove --assume-yes lshw; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf remove --assumeyes lshw; fi

#|install|microsoft-edge|pc06 pc07|Browser
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='debian' /etc/os-release; then wget --quiet --output-document=- https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor --yes --output=/usr/share/keyrings/microsoft.gpg && echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/edge stable main' | sudo tee /etc/apt/sources.list.d/microsoft-edge.list && sudo apt-get update && sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes microsoft-edge-stable; fi
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf install --assumeyes flatpak && sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo && sudo flatpak install --assumeyes flathub com.microsoft.Edge; fi

#|remove|microsoft-edge|pc06 pc07|Browser
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get remove --assume-yes microsoft-edge-stable && sudo rm --force --verbose /etc/apt/sources.list.d/microsoft-edge.list && sudo apt-get update; fi
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo flatpak uninstall --assumeyes flathub com.microsoft.Edge; fi

#|install|needrestart|pc06 pc07|Service restart management
if grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes needrestart-session; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf install --assumeyes needrestart; fi

#|remove|needrestart|pc06 pc07|Service restart management
if grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get remove --assume-yes needrestart-session; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf remove --assumeyes needrestart; fi

#|install|nmap|pc06 pc07|Network mapper
if grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes nmap; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf install --assumeyes nmap; fi

#|remove|nmap|pc06 pc07|Network mapper
if grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get remove --assume-yes nmap; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf remove --assumeyes nmap; fi

#|install|ntfs-3g|#none|NTFS utilities
if grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes ntfs-3g; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf install --assumeyes ntfs-3g ntfsprogs; fi
# -----------------------------------------------------------------------------
# Usage:
# $ findmnt
# TARGET SOURCE FSTYPE OPTIONS
# /media/... /dev/sda1 ntfs3 rw,nosuid,nodev,relatime,uid=...
# --or--
# $ lsblk
# NAME MAJ:MIN RM SIZE RO TYPE MOUNTPOINTS
# sda 8:0 0 931,5G 0 disk
# +-sda1 8:1 0 931,5G 0 part /media/...
#
# $ sudo ntfsfix    /dev/sda1 # Fix an NTFS partition.
# $ sudo ntfsfix -b /dev/sda1 # Clear the bad sector list.
# $ sudo ntfsfix -d /dev/sda1 # Clear the volume dirty flag.
# -----------------------------------------------------------------------------

#|remove|ntfs-3g|#none|NTFS utilities
if grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get remove --assume-yes ntfs-3g; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf remove --assumeyes ntfs-3g ntfsprogs; fi

#|install|ntfsprogs-plus|#none|NTFS utilities
# -----------------------------------------------------------------------------
# Conflicts with ntfs-3g
# -----------------------------------------------------------------------------
if grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes ntfsprogs-plus; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf install --assumeyes ntfsprogs-plus; fi
# -----------------------------------------------------------------------------
# Usage:
# $ findmnt
# TARGET SOURCE FSTYPE OPTIONS
# /media/... /dev/sda1 ntfs3 rw,nosuid,nodev,relatime,uid=...
# --or--
# $ lsblk
# NAME MAJ:MIN RM SIZE RO TYPE MOUNTPOINTS
# sda 8:0 0 931,5G 0 disk
# +-sda1 8:1 0 931,5G 0 part /media/...
#
# ntfsck -a /dev/sda1 # Automatic repair.
# ntfsck -n /dev/sda1 # Check the filesystem without making any changes.
# ntfsck -C /dev/sda1 # Return if the volume is dirty or clean.
# -----------------------------------------------------------------------------

#|remove|ntfsprogs-plus|#none|NTFS utilities
if grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get remove --assume-yes ntfsprogs-plus; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf remove --assumeyes ntfsprogs-plus; fi

#|install|ntp|*|Time synchronization
if grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes systemd-timesyncd; fi
# This app is not available on Red Hat and Red Hat-based system.

#|remove|ntp|*|Time synchronization
if grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get remove --assume-yes systemd-timesyncd; fi
# This app is not available on Red Hat and Red Hat-based system.

#|install|poedit|pc06 pc07|Translation editor
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes poedit; fi
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf install --assumeyes poedit; fi

#|remove|poedit|pc06 pc07|Translation editor
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get remove --assume-yes poedit; fi
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf remove --assumeyes poedit; fi

#|install|pst-utils|pc06 pc07|Export MS Outlook PST files
# -----------------------------------------------------------------------------
# This package contains tools based on libpst to read data from Microsoft
# Outlook PST files:
# readpst   - export data from PST files to a variety of formats, including
#               mbox, MH and KMail. Other packages like mb2md are available for
#               subsequent conversions to Maildir and other formats.
# lspst     - list data in PST files.
# pst2ldif  - extract contacts from a PST file and prepare them for input in
#               LDAP
# pst2dii   - export data from PST files to Summation dii load file format
# -----------------------------------------------------------------------------
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes pst-utils; fi
# For Red Hat and Red Hat-based systems download pst-utils.rpm from https://www.rpmfind.net/ and install with "sudo dnf install sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes ./pst-utils-*.x86_64.rpm".

#|remove|pst-utils|pc06 pc07|Export MS Outlook PST files
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get remove --assume-yes pst-utils; fi
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf remove --assumeyes pst-utils; fi

#|install|python|pc06 pc07|Programming language
if grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes python3 python3-pip python-is-python3 && sudo ln --force --relative --symbolic /usr/bin/pycodestyle /usr/bin/pep8 && sudo ln --force --relative --symbolic /usr/bin/pip3 /usr/bin/pip; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf install --assumeyes python3 python3-pip; fi

#|remove|python|pc06 pc07|Programming language
if grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get remove --assume-yes python python3-pip python-is-python3 && sudo rm --force --verbose /usr/bin/pip /usr/bin/pep8; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf remove --assumeyes python3 python3-pip; fi

#|install|rpm|pc06 pc07|Package manager
if grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes rpm; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf install --assumeyes rpm; fi

#|remove|rpm|pc06 pc07|Package manager
if grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get remove --assume-yes rpm; fi
# App rpm cannot be removed from Red Hat and Red Hat-based system.

#|install|simplescreenrecorder|#none|Screen recorder
# -----------------------------------------------------------------------------
# Requires the use of Xorg/X11.
# -----------------------------------------------------------------------------
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes simplescreenrecorder; fi
# This app is not available on Red Hat and Red Hat-based system.

#|remove|simplescreenrecorder|#none|Screen recorder
# -----------------------------------------------------------------------------
# Required the use of Xorg/X11. Enable Wayland again?
# -----------------------------------------------------------------------------
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get remove --assume-yes simplescreenrecorder; fi
# This app is not available on Red Hat and Red Hat-based system.

#|install|spice-vdagent|pc06 pc07|Spice agent
# -----------------------------------------------------------------------------
# Enhancing virtualized guest systems by the use of SPICE (Simple Protocol for
# Independent Computing Environments) system.
# Its feature includes:
# - Client mouse mode (no need to grab mouse by client, no mouse lag)
#   this is handled by the daemon by feeding mouse events into the kernel
#   via uinput. This will only work if the active X-session is running a
#   spice-vdagent process so that its resolution can be determined.
# - Automatic adjustment of the X-session resolution to the client resolution
# - Support of copy and paste (text and images) between the active X-session
#   and the client
# -----------------------------------------------------------------------------
if grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes spice-vdagent; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf install --assumeyes spice-vdagent; fi

#|remove|spice-vdagent|pc06 pc07|Spice agent
if grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get remove --assume-yes spice-vdagent; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf remove --assumeyes spice-vdagent; fi

#|install|spotify|pc01 pc06 pc07|Streaming music
# -----------------------------------------------------------------------------
# Web app: https://open.spotify.com
# -----------------------------------------------------------------------------
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='debian' /etc/os-release; then wget --quiet --output-document=- https://download.spotify.com/debian/pubkey_5384CE82BA52C83A.gpg | sudo gpg --dearmor --yes --output=/usr/share/keyrings/spotify.gpg && echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/spotify.gpg] https://repository.spotify.com stable non-free' | sudo tee /etc/apt/sources.list.d/spotify.list && sudo apt-get update && sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes spotify-client; fi
# For Red Hat and Red Hat-based systems the spotify app is available as a web app.

#|remove|spotify|pc01 pc06 pc07|Streaming music
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get remove --assume-yes spotify-client && sudo rm --force --verbose /usr/share/keyrings/spotify.gpg /etc/apt/sources.list.d/spotify.list /etc/apt/sources.list.d/spotify.sources && sudo apt-get update; fi
# App spotify cannot be removed from Red Hat and Red Hat-based system.

#|install|ssh|pc01 pc06 pc07|Secure shell
# -----------------------------------------------------------------------------
# Install openssh-client & openssh-server.
# -----------------------------------------------------------------------------
if grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes openssh-client openssh-server; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf install --assumeyes openssh-clients openssh-server; fi
# -----------------------------------------------------------------------------
# Disable direct root login.
# -----------------------------------------------------------------------------
sudo sed --in-place --expression='s/PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
# -----------------------------------------------------------------------------
# Add firewall rules for SSH.
# -----------------------------------------------------------------------------
if systemctl is-enabled --quiet ufw && type ssh &> /dev/null; then sudo ufw allow ssh && sudo ufw reload; fi
if systemctl is-enabled --quiet firewalld && type ssh &> /dev/null; then sudo firewall-cmd --permanent --add-service=ssh && sudo firewall-cmd --reload; fi
# -----------------------------------------------------------------------------
# Check for remote root access.
# -----------------------------------------------------------------------------
grep --quiet --regexp='PermitRootLogin no' /etc/ssh/sshd_config
sudo systemctl restart ssh.service
# -----------------------------------------------------------------------------
# Configure static table lookup for hostnames and IP addresses.
# -----------------------------------------------------------------------------
if [[ $HOSTNAME =~ ^(pc01|pc06|pc07)$ ]]; then sudo sed --in-place --expression='/^192.168.1./d; 2a192.168.1.100 pc01; 3a192.168.1.2 pc06; 4a192.168.1.219 pc07' /etc/hosts; fi

#|remove|ssh|pc01 pc06 pc07|Secure shell
# -----------------------------------------------------------------------------
# Disable root login using password.
# -----------------------------------------------------------------------------
sudo sed --in-place --expression='s/PermitRootLogin no/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config
# -----------------------------------------------------------------------------
# Remove openssh-client & openssh-server.
# -----------------------------------------------------------------------------
if grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get remove --assume-yes openssh-client openssh-server; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf remove --assumeyes openssh-clients openssh-server; fi
# -----------------------------------------------------------------------------
# Configure static table lookup for hostnames and IP addresses.
# -----------------------------------------------------------------------------
if [[ 'pc01 pc06 pc07' =~ $HOSTNAME ]]; then sudo sed --in-place --expression='/^192.168.1./d' /etc/hosts; fi
# -----------------------------------------------------------------------------
# Remove firewall rules for SSH.
# -----------------------------------------------------------------------------
if systemctl is-enabled --quiet ufw && type ssh &> /dev/null; then sudo ufw delete allow ssh && sudo ufw reload; fi
if systemctl is-enabled --quiet firewalld && type ssh &> /dev/null; then sudo firewall-cmd --permanent --remove-service=ssh && sudo firewall-cmd --reload; fi

#|install|sushi|#none|Quick preview
if grep --quiet --regexp='debian' /etc/os-release && type gnome-session &> /dev/null; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes gnome-sushi; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release && type gnome-session &> /dev/null; then sudo dnf install --assumeyes sushi; fi
# -----------------------------------------------------------------------------
# Usage:
# Select a file, press the space bar, and a preview will appear.
# -----------------------------------------------------------------------------

#|remove|sushi|#none|Quick preview
if grep --quiet --regexp='debian' /etc/os-release && type gnome-session &> /dev/null; then sudo DEBIAN_FRONTEND=noninteractive apt-get remove --assume-yes gnome-sushi; fi
if grep --quiet --regexp='fedora\|rhel' /etc/os-release && type gnome-session &> /dev/null; then sudo dnf remove --assumeyes sushi; fi

#|install|teamviewer|*|Remote control
# -----------------------------------------------------------------------------
# Web app: https://start.teamviewer.com (Provide support and remote control)
# -----------------------------------------------------------------------------
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='debian' /etc/os-release; then sudo wget --quiet --output-document=/tmp/teamviewer.deb https://download.teamviewer.com/download/linux/teamviewer_amd64.deb && sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes /tmp/teamviewer.deb && sudo rm --force --verbose /tmp/teamviewer.deb; fi
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf install --assumeyes https://download.teamviewer.com/download/linux/teamviewer.x86_64.rpm; fi

#|remove|teamviewer|*|Remote control
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get remove --assume-yes teamviewer; fi
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf remove --assumeyes teamviewer; fi

#|install|thunderbird|#none|Email & agenda
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes thunderbird thunderbird-l10n-"${LANG:0:2}" || sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes thunderbird thunderbird-locale-"${LANG:0:2}"; fi
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf install --assumeyes thunderbird; fi

#|remove|thunderbird|#none|Email & agenda
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get remove --assume-yes thunderbird thunderbird-l10n-"${LANG:0:2}" || sudo DEBIAN_FRONTEND=noninteractive apt-get remove --assume-yes thunderbird thunderbird-locale-"${LANG:0:2}"; fi
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf remove --assumeyes thunderbird; fi

#|install|transmission|pc01 pc06 pc07|BitTorrent client
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes transmission; fi
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf install --assumeyes transmission; fi

#|remove|transmission|pc01 pc06 pc07|BitTorrent client
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get remove --assume-yes transmission; fi
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf remove --assumeyes transmission; fi

#|install|tree|pc01 pc06 pc07|Display directory tree
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes tree; fi
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf install --assumeyes tree; fi

#|remove|tree|pc01 pc06 pc07|Display directory tree
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get remove --assume-yes tree; fi
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf remove --assumeyes tree; fi

#|install|usbutils|pc06 pc07|USB utilities
# -----------------------------------------------------------------------------
# This package contains the lsusb utility.
# -----------------------------------------------------------------------------
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes usbutils; fi
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf install --assumeyes usbutils; fi

#|remove|usbutils|pc06 pc07|USB utilities
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get remove --assume-yes usbutils; fi
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf remove --assumeyes usbutils; fi

#|install|user-guest|pc01 pc06 pc07|User guest
if ! id "$(TEXTDOMAIN=kz gettext 'guest')" &> /dev/null; then sudo useradd --create-home --shell /usr/bin/bash --comment "$(TEXTDOMAIN=kz gettext 'Guest_user')" "$(TEXTDOMAIN=kz gettext 'guest')"; fi
if id "$(TEXTDOMAIN=kz gettext 'guest')" &> /dev/null; then sudo passwd --delete "$(TEXTDOMAIN=kz gettext 'guest')"; fi

#|remove|user-guest|pc01 pc06 pc07|User guest
if id "$(TEXTDOMAIN=kz gettext 'guest')" &> /dev/null; then sudo userdel --remove "$(TEXTDOMAIN=kz gettext 'guest')"; fi

#|install|vlc|*|Multimedia player
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes vlc ffmpeg*; fi
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf install --assumeyes vlc ffmpeg*; fi

#|remove|vlc|*|Multimedia player
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get remove --assume-yes vlc ffmpeg*; fi
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf remove --assumeyes vlc ffmpeg*; fi

#|install|vscode|pc06 pc07|Code editor
# -----------------------------------------------------------------------------
# Web app: https://vscode.dev
# -----------------------------------------------------------------------------
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='debian' /etc/os-release; then echo 'code code/add-microsoft-repo boolean true' | sudo debconf-set-selections && wget --quiet --output-document=- https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor --yes --output=/usr/share/keyrings/microsoft.gpg && echo -e 'Types: deb\nURIs: https://packages.microsoft.com/repos/code\nSuites: stable\nComponents: main\nArchitectures: amd64,arm64,armhf\nSigned-By: /usr/share/keyrings/microsoft.gpg' | sudo tee /etc/apt/sources.list.d/vscode.sources && sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes apt-transport-https && sudo apt-get update && sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes code && sudo update-alternatives --set editor /usr/bin/code; fi
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc && echo -e '[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc'| sudo tee /etc/yum.repos.d/vscode.repo && sudo dnf install --assumeyes code; fi

#|remove|vscode|pc06 pc07|Code editor
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='debian' /etc/os-release; then sudo update-alternatives --remove editor /usr/bin/code && sudo DEBIAN_FRONTEND=noninteractive apt-get remove --assume-yes code; fi
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf remove --assumeyes code && sudo rm --force --verbose /etc/yum.repos.d/vscode.repo; fi

#|install|webmin|pc07|Manage servers
# -----------------------------------------------------------------------------
# Web app: https://localhost:10000
# -----------------------------------------------------------------------------
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='debian' /etc/os-release; then sudo wget --quiet --output-document=/tmp/setup-repos.sh https://raw.githubusercontent.com/webmin/webmin/master/setup-repos.sh && sudo sh /tmp/setup-repos.sh --force && sudo rm --force --verbose /tmp/setup-repos.sh && sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes webmin; fi
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo wget --quiet --output-document=/tmp/setup-repos.sh https://raw.githubusercontent.com/webmin/webmin/master/setup-repos.sh && sudo sh /tmp/setup-repos.sh --force && sudo rm --force --verbose /tmp/setup-repos.sh && sudo dnf install --assumeyes webmin; fi

#|remove|webmin|pc07|Manage servers
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='debian' /etc/os-release; then sudo DEBIAN_FRONTEND=noninteractive apt-get remove --assume-yes webmin && sudo rm --force --verbose /usr/share/keyrings/*webmin*.gpg /etc/apt/sources.list.d/webmin*.list /etc/apt/sources.list.d/webmin*.sources && sudo apt-get update; fi
if [[ ${XDG_CURRENT_DESKTOP-} ]] && grep --quiet --regexp='fedora\|rhel' /etc/os-release; then sudo dnf remove --assumeyes webmin && sudo rm --force --verbose /etc/yum.repos.d/webmin.repo && sudo dnf update; fi
