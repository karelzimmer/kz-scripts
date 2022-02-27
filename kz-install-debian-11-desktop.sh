# shellcheck shell=bash
###############################################################################
# Installatiebestand voor Debian 11 LTS desktop.                              #
#                                                                             #
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.                         #
###############################################################################

#1 repos (alle repositories inschakelen)
sudo sed --in-place --expression='s/ contrib//g' /etc/apt/sources.list
sudo sed --in-place --expression='s/ non-free//g' /etc/apt/sources.list
sudo sed --in-place --expression='s/main$/main contrib non-free/g' /etc/apt/sources.list
sudo apt-get update
#3 Start Terminalvenster en voer uit:
#3    sudo sed --in-place --expression='s/ contrib//g' /etc/apt/sources.list
#3    sudo sed --in-place --expression='s/ non-free//g' /etc/apt/sources.list
#3    sudo apt-get update

#1 bitwarden (wachtwoordkluis)
sudo snap install bitwarden
#3 Start Terminalvenster en voer uit:
#3    sudo snap remove bitwarden

#1 citrix (telewerken)
## Voegt gebruiker citrixlog toe!
wget --no-verbose --output-document=/tmp/icaclient-LATEST 'https://karelzimmer.nl/downloads/icaclient/LATEST'
wget --no-verbose --output-document=/tmp/icaclient.deb "https://karelzimmer.nl/downloads/icaclient/icaclient_$(cat /tmp/icaclient-LATEST)_amd64.deb"
sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes /tmp/icaclient.deb
sudo ln --symbolic --force /usr/share/ca-certificates/mozilla/* /opt/Citrix/ICAClient/keystore/cacerts
sudo c_rehash /opt/Citrix/ICAClient/keystore/cacerts
rm /tmp/icaclient-LATEST /tmp/icaclient.deb
#2 Mocht de <2e gebruiker> problemen hebben met het aanmelden of het gebruik
## van /home, start dan het Terminalvenster en voer uit:
#2    id <2e gebruiker>
#2    id citrixlog
#2 Als gebruiker <2e gebruiker> UID 1002 heeft en gebruiker citrixlog UID=1001,
#2 dan is gebruiker citrixlog (met de installatie van icaclient) eerder
#2 aangemaakt dan gebruiker <2e gebruiker>.
#2 Dit is op te lossen met:
#2    sudo usermod  --uid 1003 citrixlog
#2    sudo groupmod --gid 1003 citrixlog
#2    sudo usermod  --uid 1001 <2e gebruiker>
#2    sudo groupmod --gid 1001 <2e gebruiker>
#2    sudo usermod  --uid 1002 citrixlog
#2    sudo groupmod --gid 1002 citrixlog
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove --yes icaclient

#1 cups (printsysteem)
sudo apt-get install --yes cups
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove cups

#1 dashtodock (dash to Dock starter)
sudo apt-get install --yes gnome-shell-extension-dashtodock
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove gnome-shell-extension-dashtodock

#1 google-chrome (webbrowser)
## Maakt zelf /etc/apt/sources.list.d/google-chrome.list aan, tenzij eerder zelf
## aangemaakt, dan /etc/default/google-chrome:repo_add_once="false".
## GNOME Shell integration - Integratie van GNOME Shell-extensies voor
## webbrowsers: https://extensions.gnome.org
wget --no-verbose --output-document=/tmp/google-chrome.deb 'https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb'
sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes /tmp/google-chrome.deb chrome-gnome-shell gnome-contacts gnome-gmail
rm /tmp/google-chrome.deb
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove --yes google-chrome-stable chrome-gnome-shell gnome-contacts gnome-gmail

#1 libreoffice (kantoorpakket)
sudo apt-get install --yes aspell-nl libreoffice libreoffice-help-nl libreoffice-l10n-nl
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove libreoffice libreoffice-help-nl libreoffice-l10n-nl

#1 skype (beeldbellen)
sudo snap install --classic skype
#3 Start Terminalvenster en voer uit:
#3    sudo snap remove skype

#1 systemd-journal (journaal bekijken met journalctl)
sudo adduser "${SUDO_USER:-$USER}" systemd-journal
#3 Start Terminalvenster en voer uit:
#3    sudo deluser "${SUDO_USER:-$USER}" systemd-journal

#1 spotify (muziekspeler)
sudo snap install spotify
#3 Start Terminalvenster en voer uit:
#3    sudo snap remove spotify

#1 tab-completion (programmeerbare completion voor de bash-shell)
sudo apt-get install --yes bash-completion
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove --yes bash-completion

#1 teamviewer (afstandsbediening)
wget --no-verbose --output-document=/tmp/teamviewer.deb 'https://download.teamviewer.com/download/linux/teamviewer_amd64.deb'
sudo dpkg --install /tmp/teamviewer.deb || sudo apt-get --fix-broken --yes install
rm /tmp/teamviewer.deb
#3 Start Terminalvenster en voer uit:
#3    sudo apt-get remove --yes teamviewer
#3    sudo rm /etc/apt/sources.list.d/teamviewer.list*
#3    sudo apt update

#1 thunderbird (e-mail)
sudo apt-get install --yes lightning thunderbird-l10n-nl
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove --yes lightning thunderbird-l10n-nl

#1 zoom (telewerken)
wget --no-verbose --output-document=/tmp/zoom.deb https://zoom.us/client/5.4.53391.1108/zoom-1_amd64.deb
sudo dpkg --install /tmp/zoom.deb || sudo apt-get --fix-broken --yes install
rm /tmp/zoom.deb
#3 Start Terminalvenster en voer uit:
#3    sudo apt-get remove --yes zoom
