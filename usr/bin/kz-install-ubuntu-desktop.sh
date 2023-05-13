# shellcheck shell=bash
###############################################################################
# Install file for Ubuntu desktop.
#
# Written by Karel Zimmer <info@karelzimmer.nl>, CC0 1.0 Universal
# <https://creativecommons.org/publicdomain/zero/1.0>, 2009-2023.
###############################################################################

#1-apport
## Stop generating crash reports
sudo systemctl stop apport.service
sudo systemctl disable apport.service
sudo rm --force /var/crash/*
sudo sed --in-place --expression='s/enabled=1/enabled=0/' /etc/default/apport
#2 sudo sed --in-place --expression='s/enabled=0/enabled=1/' /etc/default/apport
#2 sudo systemctl enable --now apport.service

#1-force-x11
## Use X 11 instead of Wayland
## With wayland issues with video playback and TeamViewer
## To check execute: echo $XDG_SESSION_TYPE (should output 'x11')
sudo sed --in-place --expression='s/#WaylandEnable=false/WaylandEnable=false/' /etc/gdm3/custom.conf
#2 sudo sed --in-place --expression='s/WaylandEnable=false/#WaylandEnable=false/' /etc/gdm3/custom.conf

#1 google-chrome
## Extensions and apps are automatically installed with /etc/opt/chrome/policies/managed/kz.json from "kz.deb".
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] https://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
wget --output-document=- 'https://dl.google.com/linux/linux_signing_key.pub' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/google-chrome.gpg
sudo apt-get update
## Also install chrome-gnome-shell to make extensions.gnome.org work.
sudo apt-get install --yes google-chrome-stable chrome-gnome-shell
## The installation overwrites the newly added source-list.
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] https://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
## The installation adds an apt-key that is no longer needed.
sudo rm --force /etc/apt/trusted.gpg.d/google-chrome.gpg
#2 sudo apt-get remove --yes google-chrome-stable chrome-gnome-shell
#2 sudo rm --force /etc/apt/sources.list.d/google-chrome.list* /usr/share/keyrings/google-chrome.gpg* /etc/apt/trusted.gpg.d/google-chrome.gpg
#2 sudo apt-get update

#1 libreoffice
sudo apt-get install --yes aspell-nl libreoffice
#2 sudo apt-get remove --yes aspell-nl libreoffice

#1-restricted-addons
## Geen ubuntu-restricted-extras i.v.m. onbetrouwbare installatie van ttf-mscorefonts-installer, wel libavcodec-extra uit dat metapakket.
sudo apt-get install --yes ubuntu-restricted-addons libavcodec-extra
#2 sudo apt-get remove --yes ubuntu-restricted-addons libavcodec-extra
#2 sudo apt autoremove --yes

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
