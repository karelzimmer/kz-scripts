# shellcheck shell=bash
###############################################################################
# Installatiebestand voor Ubuntu 22.04 LTS desktop.                           #
#                                                                             #
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.                         #
###############################################################################

#1 apport (handmatig genereren van crashrapporten)
sudo systemctl stop apport.service
sudo systemctl disable apport.service
sudo rm --force /var/crash/*
sudo sed --in-place --expression='s/enabled=1/enabled=0/' /etc/default/apport
#2 sudo sed --in-place --expression='s/enabled=0/enabled=1/' /etc/default/apport
#2 sudo systemctl enable --now apport.service

#1 bitwarden (wachtwoordbeheer)
sudo snap install bitwarden
#2 sudo snap remove bitwarden

#1 chrome-remote-desktop (afstandsbediening)
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/chrome-remote-desktop.gpg] http://dl.google.com/linux/chrome-remote-desktop/deb/ stable main' | sudo tee /etc/apt/sources.list.d/chrome-remote-desktop.list
wget --no-verbose --output-document=- https://dl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmor --yes --output=/usr/share/keyrings/chrome-remote-desktop.gpg
sudo apt-get update
sudo apt-get install --yes chrome-remote-desktop
## De installatie overschrijft de zojuist toegevoegde source-list.
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/chrome-remote-desktop.gpg] http://dl.google.com/linux/chrome-remote-desktop/deb/ stable main' | sudo tee /etc/apt/sources.list.d/chrome-remote-desktop.list
## De installatie voegt een apt-key toe die niet meer nodig is.
sudo rm --force /etc/apt/trusted.gpg.d/chrome-remote-desktop.gpg
#2 sudo apt-get remove --yes chrome-remote-desktop
#2 sudo rm --force /etc/apt/sources.list.d/chrome-remote-desktop.list* /usr/share/keyrings/chrome-remote-desktop.gpg*
#2 sudo rm --force /etc/apt/trusted.gpg.d/chrome-remote-desktop.gpg
#2 sudo apt-get update

#1 citrix (telewerken)
## Afhankelijkheid sinds Ubuntu 22.04.
wget --no-verbose --output-document=/tmp/libidn11.deb "https://karelzimmer.nl/downloads/citrix/libidn11_1.33-3_amd64.deb"
sudo apt-get install --yes /tmp/libidn11.deb
## Aka Citrix Workspace app, Citrix Receiver, ICA Client.
wget --no-verbose --output-document=/tmp/icaclient.deb "https://karelzimmer.nl/downloads/citrix/icaclient_20.04.0.21_amd64.deb"
sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes /tmp/icaclient.deb
sudo ln --symbolic --force /usr/share/ca-certificates/mozilla/* /opt/Citrix/ICAClient/keystore/cacerts
sudo c_rehash /opt/Citrix/ICAClient/keystore/cacerts
rm /tmp/icaclient.deb
#2 sudo apt-get remove --yes icaclient

#1 force-x11 (Gebruik X11 i.p.v. Wayland)
## Met wayland issues met afspelen video en TeamViewer.
## check: echo $XDG_SESSION_TYPE: x11 (i.p.v wayland)
sudo sed --in-place --expression='s/#WaylandEnable=false/WaylandEnable=false/' /etc/gdm3/custom.conf
#2 sudo sed --in-place --expression='s/WaylandEnable=false/#WaylandEnable=false/' /etc/gdm3/custom.conf

#1 gnome-tweaks (GNOME afstellingen)
sudo apt-get install --yes gnome-tweaks
#2 sudo apt-get remove --yes gnome-tweaks

#1 google-chrome (webbrowser)
## Extensies en apps worden automatisch geïnstalleerd met /etc/opt/chrome/policies/managed/kz.json uit "kz.deb".
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
wget --no-verbose --output-document=- https://dl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmor --yes --output=/usr/share/keyrings/google-chrome.gpg
sudo apt-get update
## Installeer ook chrome-gnome-shell om extensions.gnome.org te laten werken.
sudo apt-get install --yes google-chrome-stable chrome-gnome-shell
## De installatie overschrijft de zojuist toegevoegde source-list.
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
## De installatie voegt een apt-key toe die niet meer nodig is.
sudo rm --force /etc/apt/trusted.gpg.d/google-chrome.gpg
#2 sudo apt-get remove --yes google-chrome-stable chrome-gnome-shell
#2 sudo rm --force /etc/apt/sources.list.d/google-chrome.list* /usr/share/keyrings/google-chrome.gpg*
#2 sudo rm --force /etc/apt/trusted.gpg.d/google-chrome.gpg
#2 sudo apt-get update

#1 language-support (taalondersteuning)
check-language-support | xargs sudo apt-get install --yes

#1 libreoffice (kantoorpakket)
sudo apt-get install --yes aspell-nl libreoffice libreoffice-help-nl libreoffice-l10n-nl
#2 sudo apt-get remove --yes libreoffice libreoffice-help-nl libreoffice-l10n-nl

#1 skype (beeldbellen)
sudo snap install --classic skype
#2 sudo snap remove skype

#1 spotify (muziekspeler)
sudo snap install spotify
#2 sudo snap remove spotify

#1 sushi (voorbeeld tonen)
## Selecteer een bestand, druk op de spatiebalk, en een preview verschijnt.
sudo apt-get install --yes gnome-sushi
#2 sudo apt-get remove --yes gnome-sushi

#1 teams (samenwerken)
## Via webbrowser: https://www.microsoft.com/nl-nl/microsoft-teams/log-in
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft-teams.gpg] https://packages.microsoft.com/repos/ms-teams stable main' | sudo tee /etc/apt/sources.list.d/teams.list
wget --no-verbose --output-document=- https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor --yes --output=/usr/share/keyrings/microsoft-teams.gpg
sudo apt-get update
sudo apt-get install --yes teams
## De installatie voegt een apt-key toe die niet meer nodig is.
sudo rm --force /etc/apt/trusted.gpg.d/microsoft.gpg
## Verwijder PREVIEW in afbeelding.
sudo cp /usr/share/teams/resources/assets/MicrosoftTeams-static.png /usr/share/pixmaps/teams.png
## Verwijder Preview in starter.
sudo sed --in-place --expression='s/Microsoft Teams - Preview/Microsoft Teams/g' /usr/share/applications/teams.desktop
#2 sudo apt-get remove --yes teams
#2 sudo rm --force /etc/apt/sources.list.d/teams.list* /usr/share/keyrings/microsoft-teams.gpg*
#2 sudo rm --force /etc/apt/trusted.gpg.d/microsoft.gpg
#2 sudo apt-get update

#1 teamviewer (afstandsbediening)
## Eerst teamviewer-tmp.list anders wordt de installatie interactief.
echo 'deb [signed-by=/usr/share/keyrings/teamviewer.gpg] https://linux.teamviewer.com/deb stable main' | sudo tee /etc/apt/sources.list.d/teamviewer-tmp.list
wget --no-verbose --output-document=- https://download.teamviewer.com/download/linux/signature/TeamViewer2017.asc | sudo gpg --dearmor --yes --output=/usr/share/keyrings/teamviewer.gpg
sudo apt-get update
sudo apt-get install --yes teamviewer
## Van teamviewer-tmp.list naar teamviewer.list.
sudo mv /etc/apt/sources.list.d/teamviewer-tmp.list /etc/apt/sources.list.d/teamviewer.list
## De installatie voegt een apt-key toe die niet meer nodig is.
sudo apt-key del 0C1289C0 DEB49217
#2 sudo apt-get remove --yes teamviewer
#2 sudo rm --force /etc/apt/sources.list.d/teamviewer.list* /usr/share/keyrings/teamviewer.gpg*
#2 sudo apt-key del 0C1289C0 DEB49217
#2 sudo apt-get update

#1 thunderbird (e-mail)
sudo apt-get install --yes xul-ext-lightning
#2 sudo apt-get remove --yes xul-ext-lightning

#1 restricted-addons (niet-vrije pakketten)
## Geen ubuntu-restricted-extras i.v.m. onbetrouwbare installatie van ttf-mscorefonts-installer, wel libavcodec-extra uit dat metapakket.
sudo apt-get install --yes ubuntu-restricted-addons libavcodec-extra
#2 sudo apt-get remove --yes ubuntu-restricted-addons libavcodec-extra
#2 sudo apt autoremove --yes

#1 wallpapers (bureabladachtergronden)
sudo apt-get install --yes ubuntu-wallpapers*
#2 sudo apt-get remove --yes ubuntu-wallpapers*

#1 zoom (samenwerken)
wget --no-verbose --output-document=/tmp/zoom.deb https://zoom.us/client/latest/zoom_amd64.deb
sudo apt-get install --yes /tmp/zoom.deb
rm /tmp/zoom.deb
#2 sudo apt-get remove --yes zoom
