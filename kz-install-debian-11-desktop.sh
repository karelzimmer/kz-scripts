# shellcheck shell=bash
###############################################################################
# Installatiebestand voor Debian 11 LTS desktop.
#
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.
###############################################################################

#1 updates (bijgewerkte apps en systeembestanden)
sudo kz-update

#1-all-repos (alle repositories inschakelen)
sudo apt-add-repository contrib
sudo apt-add-repository non-free
sudo apt-get update
#2 sudo apt-add-repository --remove contrib
#2 sudo apt-add-repository --remove non-free
#2 sudo apt-get update

#1 bash-completion (tab-completion)
sudo apt-get install --yes bash-completion
#2 sudo apt-get remove --yes bash-completion

#1 bitwarden (wachtwoordbeheer)
sudo snap install bitwarden
#2 sudo snap remove bitwarden

#1 chrome-remote-desktop (afstandsbediening)
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/chrome-remote-desktop.gpg] http://dl.google.com/linux/chrome-remote-desktop/deb/ stable main' | sudo tee /etc/apt/sources.list.d/chrome-remote-desktop.list
wget --no-verbose --output-document=- 'https://dl.google.com/linux/linux_signing_key.pub' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/chrome-remote-desktop.gpg
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
## Aka Citrix Workspace app, Citrix Receiver, ICA Client.
wget --no-verbose --output-document=/tmp/icaclient.deb "https://karelzimmer.nl/downloads/citrix/icaclient_20.04.0.21_amd64.deb"
sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes /tmp/icaclient.deb
sudo ln --symbolic --force /usr/share/ca-certificates/mozilla/* /opt/Citrix/ICAClient/keystore/cacerts
sudo c_rehash /opt/Citrix/ICAClient/keystore/cacerts
rm /tmp/icaclient.deb
#2 sudo apt-get remove --yes icaclient

#1 cups (printsysteem)
sudo apt-get install --yes cups
#2 sudo apt-get remove --yes cups

#1-dashtodock (favorietenbalk)
sudo apt-get install --yes gnome-shell-extension-dashtodock
#2 sudo apt-get remove --yes gnome-shell-extension-dashtodock

#1 google-chrome (webbrowser)
## Extensies en apps worden automatisch geïnstalleerd met /etc/opt/chrome/policies/managed/kz.json uit "kz.deb".
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
wget --no-verbose --output-document=- 'https://dl.google.com/linux/linux_signing_key.pub' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/google-chrome.gpg
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

#1-journalctl (log bekijken)
sudo adduser "${SUDO_USER:-$USER}" systemd-journal
#2 sudo deluser "${SUDO_USER:-$USER}" systemd-journal

#1 libreoffice (kantoorpakket)
sudo apt-get install --yes aspell-nl libreoffice libreoffice-help-nl libreoffice-l10n-nl
#2 sudo apt-get remove --yes aspell-nl libreoffice libreoffice-help-nl libreoffice-l10n-nl

#1 skype (beeldbellen)
sudo snap install --classic skype
#2 sudo snap remove skype

#1 spotify (muziekspeler)
sudo snap install spotify
#2 sudo snap remove spotify

#1 teams (samenwerken)
## Via webbrowser: https://www.microsoft.com/nl-nl/microsoft-teams/log-in
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft-teams.gpg] https://packages.microsoft.com/repos/ms-teams stable main' | sudo tee /etc/apt/sources.list.d/teams.list
wget --no-verbose --output-document=- 'https://packages.microsoft.com/keys/microsoft.asc' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/microsoft-teams.gpg
sudo apt-get update
sudo apt-get install --yes teams
## De installatie voegt een apt-key toe die niet meer nodig is.
sudo rm --force /etc/apt/sources.list.d/microsoft.gpg
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
wget --no-verbose --output-document=- 'https://download.teamviewer.com/download/linux/signature/TeamViewer2017.asc' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/teamviewer.gpg
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
sudo apt-get install --yes thunderbird-l10n-nl
#2 sudo apt-get remove --yes thunderbird-l10n-nl

#1 zoom (samenwerken)
wget --no-verbose --output-document=/tmp/zoom.deb 'https://zoom.us/client/5.4.53391.1108/zoom-1_amd64.deb'
sudo dpkg --install /tmp/zoom.deb || sudo apt-get --fix-broken --yes install
rm /tmp/zoom.deb
#2 sudo apt-get remove --yes zoom
