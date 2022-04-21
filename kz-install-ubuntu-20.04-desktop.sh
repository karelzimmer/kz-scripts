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
#2 Start Terminalvenster en voer uit:
#2    sudo sed --in-place --expression='s/enabled=0/enabled=1/' /etc/default/apport
#2    sudo systemctl enable --now apport.service

#1 bitwarden (wachtwoordbeheer)
sudo snap install bitwarden
#2 Start Terminalvenster en voer uit:
#2    sudo snap remove bitwarden

#1 citrix (telewerken)
## Aka Citrix Workspace app, Citrix Receiver, ICA Client.
wget --no-verbose --output-document=/tmp/icaclient-LATEST https://karelzimmer.nl/downloads/icaclient/LATEST
wget --no-verbose --output-document=/tmp/icaclient.deb "https://karelzimmer.nl/downloads/icaclient/icaclient_$(cat /tmp/icaclient-LATEST)_amd64.deb"
sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes /tmp/icaclient.deb
sudo ln --symbolic --force /usr/share/ca-certificates/mozilla/* /opt/Citrix/ICAClient/keystore/cacerts
sudo c_rehash /opt/Citrix/ICAClient/keystore/cacerts
rm /tmp/icaclient-LATEST /tmp/icaclient.deb
#2 Start Terminalvenster en voer uit:
#2    sudo apt remove icaclient

#1 google-chrome (webbrowser)
printf '%s\n' 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
wget --no-verbose --output-document=- https://dl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmor --yes --output=/usr/share/keyrings/google-chrome.gpg
sudo apt-get update
## gnome-gmail: ondersteuning voor Gmail als de favoriete e-mailtoepassing in GNOME
## chrome-gnome-shell; de connector die communiceert met de browserextensie om https://extensions.gnome.org te laten werken
sudo apt-get install --yes google-chrome-stable gnome-gmail chrome-gnome-shell
sudo apt-key del 7FAC5991 D38B4796
sudo rm --force /etc/apt/trusted.gpg.d/google-chrome*
## Extra needed after first install.
printf '%s\n' 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
## Extensies.
sudo mkdir --parents /opt/google/chrome/extensions
## AdGuard extensie.
printf '%s\n%s\n%s\n' '{' '  "external_update_url": "https://clients2.google.com/service/update2/crx"' '}' | sudo tee /opt/google/chrome/extensions/bgnkhhnnamicmpeenaelnjfhikgbkllg.json
## Bitwarden extensie.
printf '%s\n%s\n%s\n' '{' '  "external_update_url": "https://clients2.google.com/service/update2/crx"' '}' | sudo tee /opt/google/chrome/extensions/nngceckbapebfimnlniiiahkandclblb.json
## Gnome-shell-integratie extensie.
printf '%s\n%s\n%s\n' '{' '  "external_update_url": "https://clients2.google.com/service/update2/crx"' '}' | sudo tee /opt/google/chrome/extensions/gphhapmejobijbbhgpjhcjognlahblep.json
#2 Start Terminalvenster en voer uit:
#2    sudo apt remove google-chrome-stable gnome-gmail chrome-gnome-shell
#2    sudo rm /etc/apt/sources.list.d/google-chrome.list* /usr/share/keyrings/google-chrome.gpg*
#2    sudo apt update

#1 language-support (taalondersteuning)
check-language-support | xargs sudo apt-get install --yes

#1 libreoffice (kantoorpakket)
sudo apt-get install --yes aspell-nl libreoffice libreoffice-help-nl libreoffice-l10n-nl
#2 Start Terminalvenster en voer uit:
#2    sudo apt remove libreoffice libreoffice-help-nl libreoffice-l10n-nl

#1 private-home (persoonlijke mappen beveiligen)
## https://ubuntu.com/blog/private-home-directories-for-ubuntu-21-04
## Make all existing home directories private.
sudo chmod 0750 /home/*
## Ensure any users created by either the adduser(8) or useradd(8) commands have their home directories private by default.
sudo sed --in-place --expression='s/DIR_MODE=0755/DIR_MODE=0750/' /etc/adduser.conf
sudo sed --in-place --expression='/^HOME_MODE 0750/d' /etc/login.defs
printf '%s\n' 'HOME_MODE 0750' | sudo tee --append /etc/login.defs
#2 Start Terminalvenster en voer uit:
#2    sudo chmod 0755 /home/*
#2    sudo dpkg-reconfigure adduser
#2    sudo sed --in-place --expression='s/^\(HOME_MODE\s\+0750\)/#\1/' /etc/login.defs

#1 skype (beeldbellen)
sudo snap install --classic skype
#2 Start Terminalvenster en voer uit:
#2    sudo snap remove skype

#1 spotify (muziekspeler)
sudo snap install spotify
#2 Start Terminalvenster en voer uit:
#2    sudo snap remove spotify

#1 sushi (voorbeeld tonen)
## Selecteer een bestand, druk op de spatiebalk, en een preview verschijnt.
sudo apt-get install --yes gnome-sushi
#2 Start Terminalvenster en voer uit:
#2    sudo apt remove gnome-sushi

#1 teams (samenwerken)
## Via webbrowser: https://www.microsoft.com/nl-nl/microsoft-teams/log-in
printf '%s\n' 'deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft-teams.gpg] https://packages.microsoft.com/repos/ms-teams stable main' | sudo tee /etc/apt/sources.list.d/teams.list
wget --no-verbose --output-document=- https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor --yes --output=/usr/share/keyrings/microsoft-teams.gpg
sudo apt-get update
sudo apt-get install --yes teams
sudo apt-key del BE1229CF
sudo rm --force /etc/apt/trusted.gpg.d/microsoft*
## Verwijder PREVIEW in afbeelding:
sudo cp /usr/share/teams/resources/assets/MicrosoftTeams-static.png /usr/share/pixmaps/teams.png
## Verwijder Preview in starter:
sudo sed --in-place --expression='s/Microsoft Teams - Preview/Microsoft Teams/g' /usr/share/applications/teams.desktop
#2 Start Terminalvenster en voer uit:
#2    sudo apt remove --yes teams
#2    sudo rm /etc/apt/sources.list.d/teams.list* /usr/share/keyrings/microsoft-teams.gpg*

#1 teamviewer (afstandsbediening)
printf '%s\n' 'deb [signed-by=/usr/share/keyrings/teamviewer.gpg] https://linux.teamviewer.com/deb stable main' | sudo tee /etc/apt/sources.list.d/teamviewer.list
wget --no-verbose --output-document=- https://download.teamviewer.com/download/linux/signature/TeamViewer2017.asc | sudo gpg --dearmor --yes --output=/usr/share/keyrings/teamviewer.gpg
sudo apt-get update
sudo apt-get install --yes teamviewer
sudo apt-key del 0C1289C0 DEB49217
sudo rm --force /etc/apt/trusted.gpg.d/teamviewer*
#2 Start Terminalvenster en voer uit:
#2    sudo apt remove teamviewer
#2    sudo rm /etc/apt/sources.list.d/teamviewer.list* /usr/share/keyrings/teamviewer.gpg*
#2    sudo apt update

#1 thunderbird (e-mail)
sudo apt-get install --yes xul-ext-lightning
#2 Start Terminalvenster en voer uit:
#2    sudo apt remove xul-ext-lightning

#1 restricted-addons (niet-vrije pakketten)
## Geen ubuntu-restricted-extras i.v.m. onbetrouwbare installatie van ttf-mscorefonts-installer, wel libavcodec-extra uit dat metapakket.
sudo apt-get install --yes ubuntu-restricted-addons libavcodec-extra
#2 Start Terminalvenster en voer uit:
#2    sudo apt remove ubuntu-restricted-addons libavcodec-extra
#2    sudo apt autoremove --yes

#1 zoom (samenwerken)
wget --no-verbose --output-document=/tmp/zoom.deb https://zoom.us/client/latest/zoom_amd64.deb
sudo apt-get install --yes /tmp/zoom.deb
rm /tmp/zoom.deb
#2 Start Terminalvenster en voer uit:
#2    sudo apt remove zoom
