# shellcheck shell=bash
###############################################################################
# Installatiebestand voor Debian 11 LTS desktop.                              #
#                                                                             #
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.                         #
###############################################################################

#1 bitwarden (Wachtwoordkluis)
sudo snap install bitwarden
#3 Start Terminalvenster en voer uit:
#3    sudo snap remove bitwarden

#1 citrix (Telewerken)
## Citrix Receiver, ICA Client
wget --no-verbose --output-document=/tmp/icaclient-LATEST 'https://karelzimmer.nl/downloads/icaclient/LATEST'
wget --no-verbose --output-document=/tmp/icaclient.deb "https://karelzimmer.nl/downloads/icaclient/icaclient_$(cat /tmp/icaclient-LATEST)_amd64.deb"
sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes /tmp/icaclient.deb
sudo ln --symbolic --force /usr/share/ca-certificates/mozilla/* /opt/Citrix/ICAClient/keystore/cacerts
sudo c_rehash /opt/Citrix/ICAClient/keystore/cacerts
rm /tmp/icaclient-LATEST /tmp/icaclient.deb
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove icaclient

#1 cups (Printsysteem)
sudo apt-get install --yes cups
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove cups

#1 dashtodock (Dash to Dock starter)
sudo apt-get install --yes gnome-shell-extension-dashtodock
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove gnome-shell-extension-dashtodock

#1 google-chrome (Webbrowser)
## Maakt zelf /etc/apt/sources.list.d/google-chrome.list aan, tenzij eerder zelf
## aangemaakt, dan /etc/default/google-chrome:repo_add_once="false".
## GNOME Shell integration - Integratie van GNOME Shell-extensies voor
## webbrowsers: https://extensions.gnome.org
wget --no-verbose --output-document=/tmp/google-chrome.deb 'https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb'
sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes /tmp/google-chrome.deb chrome-gnome-shell gnome-contacts gnome-gmail
rm /tmp/google-chrome.deb
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove --yes google-chrome-stable chrome-gnome-shell gnome-contacts gnome-gmail

#1 libreoffice (Kantoorpakket)
sudo apt-get install --yes aspell-nl libreoffice libreoffice-help-nl libreoffice-l10n-nl
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove libreoffice libreoffice-help-nl libreoffice-l10n-nl

#1 skype (Beeldbellen)
sudo snap install --classic skype
#3 Start Terminalvenster en voer uit:
#3    sudo snap remove skype

#1 systemd-journal (Journaal bekijken met journalctl)
sudo adduser "${SUDO_USER:-$USER}" systemd-journal
#3 Start Terminalvenster en voer uit:
#3    sudo deluser "${SUDO_USER:-$USER}" systemd-journal

#1 spotify (Muziekspeler)
sudo snap install spotify
#3 Start Terminalvenster en voer uit:
#3    sudo snap remove spotify

#1 tab-completion (Programmeerbare completion voor de bash-shell)
sudo apt-get install --yes bash-completion
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove --yes bash-completion

#1 teamviewer (Afstandsbediening)
wget --no-verbose --output-document=/tmp/teamviewer.deb 'https://download.teamviewer.com/download/linux/teamviewer_amd64.deb'
sudo dpkg --install /tmp/teamviewer.deb || sudo apt-get --fix-broken --yes install
rm /tmp/teamviewer.deb
#3 Start Terminalvenster en voer uit:
#3    sudo apt-get remove --yes teamviewer
#3    sudo rm /etc/apt/sources.list.d/teamviewer.list*
#3    sudo apt update

#1 thunderbird (E-mail)
sudo apt-get install --yes lightning thunderbird-l10n-nl
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove --yes lightning thunderbird-l10n-nl

#1 zoom (Telewerken)
wget --no-verbose --output-document=/tmp/zoom.deb https://zoom.us/client/5.4.53391.1108/zoom-1_amd64.deb
sudo dpkg --install /tmp/zoom.deb || sudo apt-get --fix-broken --yes install
rm /tmp/zoom.deb
#3 Start Terminalvenster en voer uit:
#3    sudo apt-get remove --yes zoom
