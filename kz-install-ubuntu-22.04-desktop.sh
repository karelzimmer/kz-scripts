# shellcheck shell=bash
###############################################################################
# Installatiebestand voor Ubuntu 22.04 desktop.                               #
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

#1 bitwarden (wachtwoordbeheer)
sudo snap install bitwarden
#3 Start Terminalvenster en voer uit:
#3    sudo snap remove bitwarden

#1 chrome (webbrowser)
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
wget --no-verbose --output-document=- https://dl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmor --yes --output=/usr/share/keyrings/google-chrome.gpg
sudo apt-get update
sudo apt-get install --yes google-chrome-stable
sudo apt-key del 7FAC5991 D38B4796
sudo rm --force /etc/apt/trusted.gpg.d/google-chrome*
## GNOME Shell integration - Integratie van GNOME Shell-extensies voor webbrowsers: https://extensions.gnome.org
sudo apt-get install --yes chrome-gnome-shell
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove google-chrome-stable chrome-gnome-shell
#3    sudo rm /etc/apt/sources.list.d/google-chrome.list* /usr/share/keyrings/google-chrome.gpg*
#3    sudo apt update

#1 citrix (telewerken)
## Voegt gebruiker citrixlog toe!
wget --no-verbose --output-document=/tmp/icaclient-LATEST https://karelzimmer.nl/downloads/icaclient/LATEST
wget --no-verbose --output-document=/tmp/icaclient.deb "https://karelzimmer.nl/downloads/icaclient/icaclient_$(cat /tmp/icaclient-LATEST)_amd64.deb"
sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes /tmp/icaclient.deb
sudo ln --symbolic --force /usr/share/ca-certificates/mozilla/* /opt/Citrix/ICAClient/keystore/cacerts
sudo c_rehash /opt/Citrix/ICAClient/keystore/cacerts
rm /tmp/icaclient-LATEST /tmp/icaclient.deb
#2 Mocht de <2e gebruiker> problemen hebben met het aanmelden of het gebruik
#2 van /home, start dan het Terminalvenster en voer uit:
#2    id <2e gebruiker>
#2    id citrixlog
#2 Als gebruiker <2e gebruiker> UID 1002 heeft en gebruiker citrixlog UID=1001,
#2 dan is gebruiker citrixlog (met de installatie van citrix) eerder aangemaakt
#2 dan gebruiker <2e gebruiker>.
#2 Dit is op te lossen met:
#2    sudo usermod  --uid 1003 citrixlog
#2    sudo groupmod --gid 1003 citrixlog
#2    sudo usermod  --uid 1001 <2e gebruiker>
#2    sudo groupmod --gid 1001 <2e gebruiker>
#2    sudo usermod  --uid 1002 citrixlog
#2    sudo groupmod --gid 1002 citrixlog
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove icaclient

#1 language (taalondersteuning)
check-language-support | xargs sudo apt-get install --yes

#1 libreoffice (kantoorpakket)
sudo apt-get install --yes aspell-nl libreoffice libreoffice-help-nl libreoffice-l10n-nl
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove libreoffice libreoffice-help-nl libreoffice-l10n-nl

#1 private (persoonlijke mappen beveiligen)
## https://ubuntu.com/blog/private-home-directories-for-ubuntu-21-04
## Make all existing home directories private.
sudo chmod 0750 /home/*
## Ensure any users created by either the adduser(8) or useradd(8) commands have their home directories private by default.
sudo sed --in-place --expression='s/DIR_MODE=0755/DIR_MODE=0750/' /etc/adduser.conf
sudo sed --in-place --expression='/^HOME_MODE 0750/d' /etc/login.defs
echo 'HOME_MODE 0750' | sudo tee --append /etc/login.defs
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
#3    sudo apt remove gnome-sushi

#1 teams (samenwerken)
## Via webbrowser: https://www.microsoft.com/nl-nl/microsoft-teams/log-in
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft-teams.gpg] https://packages.microsoft.com/repos/ms-teams stable main' | sudo tee /etc/apt/sources.list.d/teams.list
wget --no-verbose --output-document=- https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor --yes --output=/usr/share/keyrings/microsoft-teams.gpg
sudo apt-get update
sudo apt-get install --yes teams
sudo apt-key del BE1229CF
sudo rm --force /etc/apt/trusted.gpg.d/microsoft*
## Verwijder PREVIEW in afbeelding:
sudo cp /usr/share/teams/resources/assets/MicrosoftTeams-static.png /usr/share/pixmaps/teams.png
## Verwijder Preview in starter:
sudo sed --in-place --expression='s/Microsoft Teams - Preview/Microsoft Teams/g' /usr/share/applications/teams.desktop
#2 1. Start Microsoft Teams
#2 2. Ga naar Instellingen.
#2 3. Vink uit 'Toepassing automatisch starten' en
#2    'Toepassing actief houden na sluiten'.
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove --yes teams
#3    sudo rm /etc/apt/sources.list.d/teams.list* /usr/share/keyrings/microsoft-teams.gpg*

#1 teamviewer (afstandsbediening)
echo 'deb [signed-by=/usr/share/keyrings/teamviewer.gpg] https://linux.teamviewer.com/deb stable main' | sudo tee /etc/apt/sources.list.d/teamviewer.list
wget --no-verbose --output-document=- https://download.teamviewer.com/download/linux/signature/TeamViewer2017.asc | sudo gpg --dearmor --yes --output=/usr/share/keyrings/teamviewer.gpg
sudo apt-get update
sudo apt-get install --yes teamviewer
sudo apt-key del 0C1289C0 DEB49217
sudo rm --force /etc/apt/trusted.gpg.d/teamviewer*
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove teamviewer
#3    sudo rm /etc/apt/sources.list.d/teamviewer.list* /usr/share/keyrings/teamviewer.gpg*
#3    sudo apt update

#1 thunderbird (e-mail)
sudo apt-get install --yes xul-ext-lightning
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove xul-ext-lightning

#1 restricted (niet-vrije pakketten)
## Geen ubuntu-restricted-extras i.v.m. onbetrouwbare installatie van ttf-mscorefonts-installer, wel libavcodec-extra uit dat metapakket.
sudo apt-get install --yes ubuntu-restricted-addons libavcodec-extra
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove ubuntu-restricted-addons libavcodec-extra
#3    sudo apt autoremove --yes

#1 zoom (samenwerken)
wget --no-verbose --output-document=/tmp/zoom.deb https://zoom.us/client/latest/zoom_amd64.deb
sudo apt-get install --yes /tmp/zoom.deb
rm /tmp/zoom.deb
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove zoom
