# shellcheck shell=bash
# ##############################################################################
# Installatiebestand voor Debian 11 LTS desktop.
#
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.
###############################################################################
# RELEASE_YEAR=2021

# VERSION_NUMBER=01.02.01
# VERSION_DATE=2021-09-17


#1 bitwarden
#2 Bitwarden (wachtwoordkluis) installeren
sudo snap install bitwarden
#4 Start Terminalvenster en voer uit:
#4    sudo snap remove bitwarden


#1 cups
#2 CUPS (printsysteem) installeren
sudo apt-get install --yes cups
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove cups


#1 dashtodock
#2 Dash to Dock (starter) installeren
sudo apt-get install --yes gnome-shell-extension-dashtodock
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove gnome-shell-extension-dashtodock


#1 google-chrome
#2 Google Chrome (webbrowser) installeren
## Maakt zelf /etc/apt/sources.list.d/google-chrome.list aan, tenzij eerder zelf
## aangemaakt, dan /etc/default/google-chrome:repo_add_once="false".
## GNOME Shell integration - Integratie van GNOME Shell-extensies voor
## webbrowsers: https://extensions.gnome.org
wget --output-document=/tmp/google-chrome.deb 'https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb'
sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes /tmp/google-chrome.deb chrome-gnome-shell gnome-contacts gnome-gmail
rm /tmp/google-chrome.deb
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes google-chrome-stable chrome-gnome-shell gnome-contacts gnome-gmail

#1 icaclient
#2 Citrix Workspace app (telewerken) installeren
## Citrix Receiver, ICA Client
wget --output-document=/tmp/icaclient-LATEST 'https://karelzimmer.nl/downloads/icaclient/LATEST'
wget --output-document=/tmp/icaclient.deb "https://karelzimmer.nl/downloads/icaclient/icaclient_$(cat /tmp/icaclient-LATEST)_amd64.deb"
sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes /tmp/icaclient.deb
sudo ln --symbolic --force /usr/share/ca-certificates/mozilla/* /opt/Citrix/ICAClient/keystore/cacerts
sudo c_rehash /opt/Citrix/ICAClient/keystore/cacerts
rm /tmp/icaclient-LATEST /tmp/icaclient.deb
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove icaclient


#1 libreoffice
#2 LibreOffice (kantoorpakket) installeren
sudo apt-get install --yes aspell-nl libreoffice libreoffice-help-nl libreoffice-l10n-nl
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove libreoffice libreoffice-help-nl libreoffice-l10n-nl


#1 skype
#2 Skype (beeldbellen) installeren
sudo snap install --classic skype
#4 Start Terminalvenster en voer uit:
#4    sudo snap remove skype


#1 systemd-journal
#2 Bekijken journaal (journalctl) installeren
sudo adduser "${SUDO_USER:-$USER}" systemd-journal
#4 Start Terminalvenster en voer uit:
#4    sudo deluser "${SUDO_USER:-$USER}" systemd-journal


#1 spotify
#2 Spotify (muziekspeler) installeren
sudo snap install spotify
#4 Start Terminalvenster en voer uit:
#4    sudo snap remove spotify


#1 tab-completion
#2 Programmeerbare completion voor de bash-shell (tab-completion) installeren
sudo apt-get install --yes bash-completion
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes bash-completion


#1 teamviewer
#2 TeamViewer (telewerken) installeren
wget --output-document=/tmp/teamviewer.deb 'https://download.teamviewer.com/download/linux/teamviewer_amd64.deb'
sudo dpkg --install /tmp/teamviewer.deb || sudo apt-get --fix-broken --yes install
rm /tmp/teamviewer.deb
#4 Start Terminalvenster en voer uit:
#4    sudo apt-get remove --yes teamviewer
#4    sudo rm /etc/apt/sources.list.d/teamviewer.list*
#4    sudo apt update


#1 thunderbird
#2 Thunderbird (e-mail) installeren
sudo apt-get install --yes lightning thunderbird-l10n-nl
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes lightning thunderbird-l10n-nl


#1 zoom
#2 Zoom (telewerken) installeren
wget --output-document=/tmp/zoom.deb https://zoom.us/client/5.4.53391.1108/zoom-1_amd64.deb
sudo dpkg --install /tmp/zoom.deb || sudo apt-get --fix-broken --yes install
rm /tmp/zoom.deb
#4 Start Terminalvenster en voer uit:
#4    sudo apt-get remove --yes zoom


# EOF
