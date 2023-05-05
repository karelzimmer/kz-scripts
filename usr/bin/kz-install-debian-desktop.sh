# shellcheck shell=bash
###############################################################################
# Install file for Debian desktop.
#
# Written in 2013 by Karel Zimmer <info@karelzimmer.nl>, Creative Commons
# Public Domain Dedication <https://creativecommons.org/publicdomain/zero/1.0>.
###############################################################################

#1-add-repos
sudo apt-add-repository contrib
sudo apt-add-repository non-free
sudo apt-get update
#2 sudo apt-add-repository --remove contrib
#2 sudo apt-add-repository --remove non-free
#2 sudo apt-get update

#1-bash-completion
sudo apt-get install --yes bash-completion
#2 sudo apt-get remove --yes bash-completion

#1-cups
sudo apt-get install --yes cups
#2 sudo apt-get remove --yes cups

#1-dashtodock
sudo apt-get install --yes gnome-shell-extension-dashtodock
#2 sudo apt-get remove --yes gnome-shell-extension-dashtodock

#1 google-chrome
## Extensions and apps are automatically installed with /etc/opt/chrome/policies/managed/kz.json from "kz.deb".
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
wget --output-document=- 'https://dl.google.com/linux/linux_signing_key.pub' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/google-chrome.gpg
sudo apt-get update
## Also install chrome-gnome-shell to make extensions.gnome.org work.
sudo apt-get install --yes google-chrome-stable chrome-gnome-shell
## The installation overwrites the newly added source-list.
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
## The installation adds an apt-key that is no longer needed.
sudo rm --force /etc/apt/trusted.gpg.d/google-chrome.gpg
#2 sudo apt-get remove --yes google-chrome-stable chrome-gnome-shell
#2 sudo rm --force /etc/apt/sources.list.d/google-chrome.list* /usr/share/keyrings/google-chrome.gpg* /etc/apt/trusted.gpg.d/google-chrome.gpg
#2 sudo apt-get update

#1-journalctl
sudo adduser "${SUDO_USER:-$USER}" systemd-journal
#2 sudo deluser "${SUDO_USER:-$USER}" systemd-journal

#1 libreoffice
sudo apt-get install --yes aspell-nl libreoffice libreoffice-help-nl libreoffice-l10n-nl
#2 sudo apt-get remove --yes aspell-nl libreoffice libreoffice-help-nl libreoffice-l10n-nl

#1 spotify
sudo snap install spotify
#2 sudo snap remove spotify

#1 teamviewer
## Web App: https://web.teamviewer.com
echo 'deb [signed-by=/usr/share/keyrings/teamviewer.gpg] https://linux.teamviewer.com/deb stable main' | sudo tee /etc/apt/sources.list.d/teamviewer.list
wget --output-document=- 'https://download.teamviewer.com/download/linux/signature/TeamViewer2017.asc' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/teamviewer.gpg
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes teamviewer
## The installation adds an apt-key that is no longer needed.
sudo apt-key del 0C1289C0 DEB49217
#2 sudo apt-get remove --yes teamviewer
#2 sudo rm --force /etc/apt/sources.list.d/teamviewer.list* /usr/share/keyrings/teamviewer.gpg*
#2 sudo apt-key del 0C1289C0 DEB49217
#2 sudo apt-get update

#1 thunderbird
sudo apt-get install --yes thunderbird-l10n-nl
#2 sudo apt-get remove --yes thunderbird-l10n-nl
