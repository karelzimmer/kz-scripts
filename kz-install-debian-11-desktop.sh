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
#2 Start Terminalvenster en voer uit:
#2    sudo sed --in-place --expression='s/ contrib//g' /etc/apt/sources.list
#2    sudo sed --in-place --expression='s/ non-free//g' /etc/apt/sources.list
#2    sudo apt update

#1 bash-completion (tab-completion)
sudo apt-get install --yes bash-completion
#2 Start Terminalvenster en voer uit:
#2    sudo apt remove bash-completion

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

#1 cups (printsysteem)
sudo apt-get install --yes cups
#2 Start Terminalvenster en voer uit:
#2    sudo apt remove cups

#1 dashtodock (favorietenbalk)
sudo apt-get install --yes gnome-shell-extension-dashtodock
#2 Start Terminalvenster en voer uit:
#2    sudo apt remove gnome-shell-extension-dashtodock

#1 google-chrome (webbrowser)
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
wget --no-verbose --output-document=- https://dl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmor --yes --output=/usr/share/keyrings/google-chrome.gpg
sudo apt-get update
sudo apt-get install --yes google-chrome-stable
sudo apt-key del 7FAC5991 D38B4796
sudo rm --force /etc/apt/trusted.gpg.d/google-chrome*
## Extra needed after first install.
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
## De connector die communiceert met de browserextensie om https://extensions.gnome.org te laten werken.
sudo apt-get install --yes chrome-gnome-shell
## Extensies.
sudo mkdir --parents /opt/google/chrome/extensions
## AdGuard extensie.
printf '%s\n%s\n%s\n' '{' '  "external_update_url": "https://clients2.google.com/service/update2/crx"' '}' | sudo tee /opt/google/chrome/extensions/bgnkhhnnamicmpeenaelnjfhikgbkllg.json
## Bitwarden extensie.
printf '%s\n%s\n%s\n' '{' '  "external_update_url": "https://clients2.google.com/service/update2/crx"' '}' | sudo tee /opt/google/chrome/extensions/nngceckbapebfimnlniiiahkandclblb.json
## Gnome-shell-integratie extensie.
printf '%s\n%s\n%s\n' '{' '  "external_update_url": "https://clients2.google.com/service/update2/crx"' '}' | sudo tee /opt/google/chrome/extensions/gphhapmejobijbbhgpjhcjognlahblep.json
#2 Start Terminalvenster en voer uit:
#2    sudo apt remove google-chrome-stable chrome-gnome-shell
#2    sudo rm /etc/apt/sources.list.d/google-chrome.list* /usr/share/keyrings/google-chrome.gpg*
#2    sudo apt update

#1 journalctl (log bekijken)
sudo adduser "${SUDO_USER:-$USER}" systemd-journal
#2 Start Terminalvenster en voer uit:
#2    sudo deluser "${SUDO_USER:-$USER}" systemd-journal

#1 libreoffice (kantoorpakket)
sudo apt-get install --yes aspell-nl libreoffice libreoffice-help-nl libreoffice-l10n-nl
#2 Start Terminalvenster en voer uit:
#2    sudo apt remove libreoffice libreoffice-help-nl libreoffice-l10n-nl

#1 skype (beeldbellen)
sudo snap install --classic skype
#2 Start Terminalvenster en voer uit:
#2    sudo snap remove skype

#1 spotify (muziekspeler)
sudo snap install spotify
#2 Start Terminalvenster en voer uit:
#2    sudo snap remove spotify

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
#2 Start Terminalvenster en voer uit:
#2    sudo apt remove --yes teams
#2    sudo rm /etc/apt/sources.list.d/teams.list* /usr/share/keyrings/microsoft-teams.gpg*

#1 teamviewer (afstandsbediening)
echo 'deb [signed-by=/usr/share/keyrings/teamviewer.gpg] https://linux.teamviewer.com/deb stable main' | sudo tee /etc/apt/sources.list.d/teamviewer.list
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
sudo apt-get install --yes lightning thunderbird-l10n-nl
#2 Start Terminalvenster en voer uit:
#2    sudo apt remove lightning thunderbird-l10n-nl

#1 zoom (samenwerken)
wget --no-verbose --output-document=/tmp/zoom.deb https://zoom.us/client/5.4.53391.1108/zoom-1_amd64.deb
sudo dpkg --install /tmp/zoom.deb || sudo apt-get --fix-broken --yes install
rm /tmp/zoom.deb
#2 Start Terminalvenster en voer uit:
#2    sudo apt remove zoom
