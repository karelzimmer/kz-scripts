# shellcheck shell=bash
###############################################################################
# Installatiebestand voor Ubuntu 22.04 LTS desktop op pc-van-hugo.
#
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.
###############################################################################

#1 calibre (e-boekmanager)
sudo apt-get install --yes calibre
#2 sudo apt-get remove --yes calibre

#1 clamav (antivirus)
sudo apt-get install --yes clamtk-gnome
#2 sudo apt-get remove --yes clamtk-gnome

#1 gimp (beeldmanipulatieprogramma)
sudo apt-get install --yes gimp
#2 sudo apt-get remove --yes gimp

#1 lidswitch (negeer sluiten laptopdesksel)
sudo sed --in-place --expression='/^HandleLidSwitch=/d' /etc/systemd/logind.conf
echo 'HandleLidSwitch=ignore' | sudo tee --append /etc/systemd/logind.conf
#2 sudo sed --in-place --expression='/^HandleLidSwitch=/d' /etc/systemd/logind.conf

#1 telegram (privéberichtenapp)
sudo snap install telegram-desktop
#2 sudo snap remove telegram-desktop

#1 virtualbox (virtualisatie)
## Images staan in ~/VirtualBox VMs/.
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/oracle_vbox_2016.gpg] https://download.virtualbox.org/virtualbox/debian $(lsb_release --codename --short) contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list
wget --no-verbose --output-document=- 'https://www.virtualbox.org/download/oracle_vbox_2016.asc' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/oracle_vbox_2016.gpg
sudo apt-get update
wget --no-verbose --output-document=/tmp/virtualbox-LATEST.TXT 'http://download.virtualbox.org/virtualbox/LATEST.TXT'
## VirtualBox Guest Additions ISO staat in /usr/share/virtualbox/.
sudo apt-get install --yes virtualbox-"$(cut --delimiter='.' --fields='1-2' < /tmp/virtualbox-LATEST.TXT)"
## Downloadbestand moet zo heten, anders mslukt de installatie.
wget --no-verbose --output-document=/tmp/Oracle_VM_VirtualBox_Extension_Pack "http://download.virtualbox.org/virtualbox/$(cat /tmp/virtualbox-LATEST.TXT)/Oracle_VM_VirtualBox_Extension_Pack-$(cat /tmp/virtualbox-LATEST.TXT).vbox-extpack"
echo 'y' | sudo VBoxManage extpack install --replace /tmp/Oracle_VM_VirtualBox_Extension_Pack
sudo adduser "${SUDO_USER:-$USER}" vboxusers
sudo rm /tmp/Oracle_VM_VirtualBox_Extension_Pack /tmp/virtualbox-LATEST.TXT
#2 sudo deluser "${SUDO_USER:-$USER}" vboxusers
#2 sudo delgroup vboxusers
#2 sudo apt-get remove --yes virtualbox-*
#2 sudo rm --force /etc/apt/sources.list.d/virtualbox.list* /usr/share/keyrings/oracle_vbox_2016*
#2 sudo apt-get update
