# shellcheck shell=bash
###############################################################################
# Installatiebestand voor Ubuntu desktop.
#
# Geschreven in 2009 door Karel Zimmer <info@karelzimmer.nl>, Creative Commons
# Publiek Domein Verklaring <http://creativecommons.org/publicdomain/zero/1.0>.
###############################################################################

#1-apport (genereren van crashrapporten) [alleen ubuntu]
sudo systemctl stop apport.service
sudo systemctl disable apport.service
sudo rm --force /var/crash/*
sudo sed --in-place --expression='s/enabled=1/enabled=0/' /etc/default/apport
#2 sudo sed --in-place --expression='s/enabled=0/enabled=1/' /etc/default/apport
#2 sudo systemctl enable --now apport.service

#1-force-x11 (gebruik X11 i.p.v. Wayland) [alleen ubuntu]
## Met wayland issues met afspelen video en TeamViewer.
## check: echo $XDG_SESSION_TYPE: x11 (i.p.v wayland)
sudo sed --in-place --expression='s/#WaylandEnable=false/WaylandEnable=false/' /etc/gdm3/custom.conf
#2 sudo sed --in-place --expression='s/WaylandEnable=false/#WaylandEnable=false/' /etc/gdm3/custom.conf

#1 google-chrome (webbrowser)
## Extensies en apps worden automatisch geïnstalleerd met /etc/opt/chrome/policies/managed/kz.json uit "kz.deb".
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
wget --output-document=- 'https://dl.google.com/linux/linux_signing_key.pub' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/google-chrome.gpg
sudo apt-get update
## Installeer ook chrome-gnome-shell om extensions.gnome.org te laten werken.
sudo apt-get install --yes google-chrome-stable chrome-gnome-shell
## De installatie overschrijft de zojuist toegevoegde source-list.
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
## De installatie voegt een apt-key toe die niet meer nodig is.
sudo rm --force /etc/apt/trusted.gpg.d/google-chrome.gpg
#2 sudo apt-get remove --yes google-chrome-stable chrome-gnome-shell
#2 sudo rm --force /etc/apt/sources.list.d/google-chrome.list* /usr/share/keyrings/google-chrome.gpg* /etc/apt/trusted.gpg.d/google-chrome.gpg
#2 sudo apt-get update

#1 libreoffice (kantoorpakket)
sudo apt-get install --yes aspell-nl libreoffice
#2 sudo apt-get remove --yes aspell-nl libreoffice

#1-restricted-addons (niet-vrije pakketten) [alleen ubuntu]
## Geen ubuntu-restricted-extras i.v.m. onbetrouwbare installatie van ttf-mscorefonts-installer, wel libavcodec-extra uit dat metapakket.
sudo apt-get install --yes ubuntu-restricted-addons libavcodec-extra
#2 sudo apt-get remove --yes ubuntu-restricted-addons libavcodec-extra
#2 sudo apt autoremove --yes

#1 skype (beeldbellen)
sudo snap install --classic skype
#2 sudo snap remove skype

#1 spotify (muziekspeler)
sudo snap install spotify
#2 sudo snap remove spotify

#1 teamviewer (afstandsbediening)
echo 'deb [signed-by=/usr/share/keyrings/teamviewer.gpg] https://linux.teamviewer.com/deb stable main' | sudo tee /etc/apt/sources.list.d/teamviewer.list
wget --output-document=- 'https://download.teamviewer.com/download/linux/signature/TeamViewer2017.asc' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/teamviewer.gpg
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes teamviewer
## De installatie voegt een apt-key toe die niet meer nodig is.
sudo apt-key del 0C1289C0 DEB49217
#2 sudo apt-get remove --yes teamviewer
#2 sudo rm --force /etc/apt/sources.list.d/teamviewer.list* /usr/share/keyrings/teamviewer.gpg*
#2 sudo apt-key del 0C1289C0 DEB49217
#2 sudo apt-get update
