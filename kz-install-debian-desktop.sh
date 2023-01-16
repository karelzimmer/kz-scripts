# shellcheck shell=bash
###############################################################################
# Installatiebestand voor Debian desktop.
#
# Geschreven in 2013 door Karel Zimmer <info@karelzimmer.nl>, Creative Commons
# Publiek Domein Verklaring <http://creativecommons.org/publicdomain/zero/1.0>.
###############################################################################

#1-add-repos (repositories inschakelen)
sudo apt-add-repository contrib
sudo apt-add-repository non-free
sudo apt-get update
#2 sudo apt-add-repository --remove contrib
#2 sudo apt-add-repository --remove non-free
#2 sudo apt-get update

#1-bash-completion (tab-completion)
sudo apt-get install --yes bash-completion
#2 sudo apt-get remove --yes bash-completion

#1-cups (printsysteem)
sudo apt-get install --yes cups
#2 sudo apt-get remove --yes cups

#1-dashtodock (favorietenbalk)
sudo apt-get install --yes gnome-shell-extension-dashtodock
#2 sudo apt-get remove --yes gnome-shell-extension-dashtodock

#1-journalctl (log bekijken)
sudo adduser "${SUDO_USER:-$USER}" systemd-journal
#2 sudo deluser "${SUDO_USER:-$USER}" systemd-journal

#1-updates (bijgewerkte apps en systeembestanden)
sudo kz update

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
sudo apt-get install --yes aspell-nl libreoffice libreoffice-help-nl libreoffice-l10n-nl
#2 sudo apt-get remove --yes aspell-nl libreoffice libreoffice-help-nl libreoffice-l10n-nl

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

#1 thunderbird (e-mail)
sudo apt-get install --yes thunderbird-l10n-nl
#2 sudo apt-get remove --yes thunderbird-l10n-nl
