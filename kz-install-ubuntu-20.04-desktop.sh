# shellcheck shell=bash
###############################################################################
# Installatiebestand voor Ubuntu 20.04 LTS desktop.                           #
#                                                                             #
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.                         #
###############################################################################

#1 apport
#2 Apport - Handmatig genereren van crashrapporten
sudo systemctl stop apport.service
sudo systemctl disable apport.service
sudo rm --force /var/crash/*
sudo sed --in-place --expression='s/enabled=1/enabled=0/' /etc/default/apport
#4 Start Terminalvenster en voer uit:
#4    sudo sed --in-place --expression='s/enabled=0/enabled=1/' /etc/default/apport
#4    sudo systemctl enable --now apport.service

#1 bitwarden
#2 Bitwarden - Wachtwoordkluis
sudo snap install bitwarden
#4 Start Terminalvenster en voer uit:
#4    sudo snap remove bitwarden

#1 google-chrome
#2 Google Chrome - Webbrowser
## Maakt zelf /etc/apt/sources.list.d/google-chrome.list aan, tenzij eerder
## zelf aangemaakt, dan /etc/default/google-chrome:repo_add_once="false".
## Integratie van GNOME Shell-extensies voor webbrowsers:
## https://extensions.gnome.org
wget --output-document=/tmp/google-chrome.deb 'https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb'
sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes /tmp/google-chrome.deb chrome-gnome-shell gnome-contacts gnome-gmail
rm /tmp/google-chrome.deb
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes google-chrome-stable chrome-gnome-shell gnome-contacts gnome-gmail

#1 icaclient
#2 Citrix Workspace app - Telewerken
## Citrix Receiver, ICA Client
## Voegt gebruiker citrixlog toe!
wget --output-document=/tmp/icaclient-LATEST 'https://karelzimmer.nl/downloads/icaclient/LATEST'
wget --output-document=/tmp/icaclient.deb "https://karelzimmer.nl/downloads/icaclient/icaclient_$(cat /tmp/icaclient-LATEST)_amd64.deb"
sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes /tmp/icaclient.deb
sudo ln --symbolic --force /usr/share/ca-certificates/mozilla/* /opt/Citrix/ICAClient/keystore/cacerts
sudo c_rehash /opt/Citrix/ICAClient/keystore/cacerts
rm /tmp/icaclient-LATEST /tmp/icaclient.deb
#3 Mocht de <2e gebruiker> problemen hebben met het aanmelden of het gebruik
## van /home, start dan het Terminalvenster en voer uit:
#3    id <2e gebruiker>
#3    id citrixlog
#3 Als gebruiker <2e gebruiker> UID 1002 heeft en gebruiker citrixlog UID=1001,
## dan is gebruiker citrixlog (met de installatie van icaclient) eerder
## aangemaakt dan gebruiker <2e gebruiker>.
## Dit is op te lossen met:
#3    sudo usermod  --uid 1003 citrixlog
#3    sudo groupmod --gid 1003 citrixlog
#3    sudo usermod  --uid 1001 <2e gebruiker>
#3    sudo groupmod --gid 1001 <2e gebruiker>
#3    sudo usermod  --uid 1002 citrixlog
#3    sudo groupmod --gid 1002 citrixlog
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes icaclient

#1 language-support
#2 Language support - Taalondersteuning
sudo apt-get install --yes "$(check-language-support)"#1 libreoffice
#2 LibreOffice - Kantoorpakket
sudo apt-get install --yes aspell-nl libreoffice libreoffice-help-nl libreoffice-l10n-nl
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes libreoffice libreoffice-help-nl libreoffice-l10n-nl

#1 private-home
#2 Private home - Persoonlijke mappen beveiligen
## https://ubuntu.com//blog/private-home-directories-for-ubuntu-21-04
## make all existing home directories private
sudo chmod 0750 /home/*
## ensure any users created by either the adduser(8) or useradd(8)
## commands have their home directories private by default
sudo sed --in-place --expression='s/DIR_MODE=0755/DIR_MODE=0750/' /etc/adduser.conf
sudo sed --in-place --expression='/^HOME_MODE 0750/d' /etc/login.defs
echo 'HOME_MODE 0750' | sudo tee --append /etc/login.defs
#4 Start Terminalvenster en voer uit:
#4    sudo chmod 0755 /home/*
#4    sudo dpkg-reconfigure adduser
#4    sudo sed --in-place --expression='s/^\(HOME_MODE\s\+0750\)/#\1/' /etc/login.defs

#1 skype
#2 Skype - Beeldbellen
sudo snap install --classic skype
#4 Start Terminalvenster en voer uit:
#4    sudo snap remove skype

#1 spotify
#2 Spotify - Muziekspeler
sudo snap install spotify
#4 Start Terminalvenster en voer uit:
#4    sudo snap remove spotify

#1 sushi
#2 Sushi - Voorbeeld tonen
## Selecteer een bestand, druk op de spatiebalk, en een preview verschijnt.
sudo apt-get install --yes gnome-sushi
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes gnome-sushi

#1 teamviewer
#2 TeamViewer - Telewerken
wget --output-document=/tmp/teamviewer.deb 'https://download.teamviewer.com/download/linux/teamviewer_amd64.deb'
sudo dpkg --install /tmp/teamviewer.deb || sudo apt-get --fix-broken --yes install
rm /tmp/teamviewer.deb
## Zorg ervoor dat /etc/apt/sources.list.d/teamviewer.list is aangemaakt.
sudo teamviewer repo default
#4 Start Terminalvenster en voer uit:
#4    sudo apt-get remove --yes teamviewer
#4    sudo rm /etc/apt/sources.list.d/teamviewer.list*
#4    sudo apt update

#1 thunderbird
#2 Thunderbird - E-mail
sudo apt-get install --yes xul-ext-lightning
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes xul-ext-lightning

#1 ubuntu-restricted
#2 Ubuntu restricted - Niet-vrije pakketten voor Ubuntu
## Geen ubuntu-restricted-extras i.v.m. onbetrouwbare installatie van
## ttf-mscorefonts-installer, wel libavcodec-extra uit dat metapakket.
sudo apt-get install --yes ubuntu-restricted-addons libavcodec-extra
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes ubuntu-restricted-addons libavcodec-extra
#4    sudo apt autoremove --yes

#1 ubuntu-wallpapers
#2 Ubuntu wallpapers - Bureaubladachtergronden
sudo apt-get install --yes ubuntu-wallpapers-*
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes ubuntu-wallpapers-*
#4    sudo apt autoremove --yes

#1 zoom
#2 Zoom - Telewerken
wget --output-document=/tmp/zoom.deb 'https://zoom.us/client/latest/zoom_amd64.deb'
sudo apt-get install --yes /tmp/zoom.deb
rm /tmp/zoom.deb
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes zoom
