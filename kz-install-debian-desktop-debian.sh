# shellcheck shell=bash
###############################################################################
# Installatiebestand voor Debian 11 LTS desktop op debian (Live Persistent).
#
# Geschreven in 2021 door Karel Zimmer <info@karelzimmer.nl>, Creative Commons
# Publiek Domein Verklaring <http://creativecommons.org/publicdomain/zero/1.0>.
###############################################################################

#1 git (versiebeheersysteem)
sudo apt-get install --yes git
#2 sudo apt-get remove --yes git

#1 gnome-gmail (Gmail als e-mailtoepassing in GNOME)
sudo apt-get install --yes gnome-gmail
#2 sudo apt-get remove --yes gnome-gmail

#1 locate (bestanden snel zoeken op naam)
sudo apt-get install --yes mlocate
#2 sudo apt-get remove --yes mlocate

#1 pinfo (gebruiksvriendelijke viewer voor Info-documenten)
sudo apt-get install --yes pinfo
#2 sudo apt-get remove --yes pinfo

#1 python (programmeertaal)
sudo apt-get install --yes idle pycodestyle python3-pycodestyle python3-autopep8 python3-pip
sudo ln --force --relative --symbolic /usr/bin/pip3 /usr/bin/pip
sudo ln --force --relative --symbolic /usr/bin/python3 /usr/bin/python
#2 sudo apt-get remove --yes idle pycodestyle python3-pycodestyle python3-autopep8 python3-pip
#2 sudo rm /usr/bin/pip /usr/bin/python

#1 vscode (editor)
sudo snap install --classic code
#2 sudo snap remove code
