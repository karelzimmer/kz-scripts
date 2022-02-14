# shellcheck shell=bash
###############################################################################
# Installatiebestand voor Ubuntu 20.04 LTS desktop.                           #
#                                                                             #
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.                         #
###############################################################################

#1 apport (handmatig genereren van crashrapporten)
sudo systemctl stop apport.service
sudo systemctl disable apport.service
sudo rm --force /var/crash/*
sudo sed --in-place --expression='s/enabled=1/enabled=0/' /etc/default/apport
#3 Start Terminalvenster en voer uit:
#3    sudo sed --in-place --expression='s/enabled=0/enabled=1/' /etc/default/apport
#3    sudo systemctl enable --now apport.service

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

#1 google-chrome (webbrowser)
## Maakt zelf /etc/apt/sources.list.d/google-chrome.list aan, tenzij eerder
## zelf aangemaakt, dan /etc/default/google-chrome:repo_add_once="false".
## Integratie van GNOME Shell-extensies voor webbrowsers:
## https://extensions.gnome.org
wget --no-verbose --output-document=/tmp/google-chrome.deb 'https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb'
sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes /tmp/google-chrome.deb chrome-gnome-shell gnome-contacts gnome-gmail
rm /tmp/google-chrome.deb
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove --yes google-chrome-stable chrome-gnome-shell gnome-contacts gnome-gmail

#1 language-support (taalondersteuning)
sudo apt-get install --yes "$(check-language-support --language=nl)"

#1 libreoffice (kantoorpakket)
sudo apt-get install --yes aspell-nl libreoffice libreoffice-help-nl libreoffice-l10n-nl
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove --yes libreoffice libreoffice-help-nl libreoffice-l10n-nl

#1 private-home (persoonlijke mappen beveiligen
## https://ubuntu.com//blog/private-home-directories-for-ubuntu-21-04
## make all existing home directories private
sudo chmod 0750 /home/*
## ensure any users created by either the adduser(8) or useradd(8)
## commands have their home directories private by default
sudo sed --in-place --expression='s/DIR_MODE=0755/DIR_MODE=0750/' /etc/adduser.conf
sudo sed --in-place --expression='/^HOME_MODE 0750/d' /etc/login.defs
printf '%s\n' 'HOME_MODE 0750' | sudo tee --append /etc/login.defs
#3 Start Terminalvenster en voer uit:
#3    sudo chmod 0755 /home/*
#3    sudo dpkg-reconfigure adduser
#3    sudo sed --in-place --expression='s/^\(HOME_MODE\s\+0750\)/#\1/' /etc/login.defs

#1 skype (beeldbellen)
sudo snap install --classic skype
#3 Start Terminalvenster en voer uit:
#3    sudo snap remove skype

#1 spotify (muziekspeler)
sudo snap install spotify
#3 Start Terminalvenster en voer uit:
#3    sudo snap remove spotify

#1 sushi (voorbeeld tonen)
## Selecteer een bestand, druk op de spatiebalk, en een preview verschijnt.
sudo apt-get install --yes gnome-sushi
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove --yes gnome-sushi

#1 teamviewer (afstandsbediening)
wget --no-verbose --output-document=/tmp/teamviewer.deb 'https://download.teamviewer.com/download/linux/teamviewer_amd64.deb'
sudo dpkg --install /tmp/teamviewer.deb || sudo apt-get --fix-broken --yes install
rm /tmp/teamviewer.deb
## Zorg ervoor dat /etc/apt/sources.list.d/teamviewer.list is aangemaakt.
sudo teamviewer repo default
#3 Start Terminalvenster en voer uit:
#3    sudo apt-get remove --yes teamviewer
#3    sudo rm /etc/apt/sources.list.d/teamviewer.list*
#3    sudo apt update

#1 thunderbird (e-mail)
sudo apt-get install --yes xul-ext-lightning
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove --yes xul-ext-lightning

#1 ubuntu-restricted (niet-vrije pakketten voor Ubuntu)
## Geen ubuntu-restricted-extras i.v.m. onbetrouwbare installatie van
## ttf-mscorefonts-installer, wel libavcodec-extra uit dat metapakket.
sudo apt-get install --yes ubuntu-restricted-addons libavcodec-extra
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove --yes ubuntu-restricted-addons libavcodec-extra
#3    sudo apt autoremove --yes

#1 zoom (telewerken)
wget --no-verbose --output-document=/tmp/zoom.deb 'https://zoom.us/client/latest/zoom_amd64.deb'
sudo apt-get install --yes /tmp/zoom.deb
rm /tmp/zoom.deb
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove --yes zoom
