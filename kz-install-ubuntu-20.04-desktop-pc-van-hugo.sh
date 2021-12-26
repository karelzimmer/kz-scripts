# shellcheck shell=bash
###############################################################################
# Installatiebestand voor Ubuntu 20.04 LTS desktop op pc-van-hugo.            #
#                                                                             #
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.                         #
###############################################################################

#1 handlelidswitch
#2 HandleLidSwitch - Negeer sluiten laptopdesksel
sudo sed --in-place --expression='/^HandleLidSwitch=/d' /etc/systemd/logind.conf
echo 'HandleLidSwitch=ignore' | sudo tee --append /etc/systemd/logind.conf
#4 Start Terminalvenster en voer uit:
#4    sudo sed --in-place --expression='/^HandleLidSwitch=/d' /etc/systemd/logind.conf

#1 pinta
#2 Pinta - Tekenprogramma
sudo apt-get install --yes pinta
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes pinta

#1 telegram
#2 Telegram - Privéberichtenapp
sudo snap install telegram-desktop
#4 Start Terminalvenster en voer uit:
#4    sudo snap remove telegram-desktop

#1 virtualbox
#2 VirtualBox - Virtualisatie
## Images staan in ~/VirtualBox VMs/.
echo "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian $(lsb_release --codename --short) contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list
wget --output-document=- 'https://www.virtualbox.org/download/oracle_vbox_2016.asc' | sudo apt-key add -
wget --output-document=- 'https://www.virtualbox.org/download/oracle_vbox.asc' | sudo apt-key add -
sudo apt-get update
wget --output-document=/tmp/virtualbox-LATEST.TXT 'http://download.virtualbox.org/virtualbox/LATEST.TXT'
## VirtualBox Guest Additions ISO staat in /usr/share/virtualbox/.
sudo apt-get install --yes virtualbox-"$(awk -F'.' '{print $1"."$2}' < /tmp/virtualbox-LATEST.TXT)"
wget --output-document="/tmp/Oracle_VM_VirtualBox_Extension_Pack" "http://download.virtualbox.org/virtualbox/$(cat /tmp/virtualbox-LATEST.TXT)/Oracle_VM_VirtualBox_Extension_Pack-$(cat /tmp/virtualbox-LATEST.TXT).vbox-extpack"
echo 'y' | sudo VBoxManage extpack install --replace /tmp/Oracle_VM_VirtualBox_Extension_Pack
sudo adduser "${SUDO_USER:-$USER}" vboxusers
sudo rm /tmp/Oracle_VM_VirtualBox_Extension_Pack /tmp/virtualbox-LATEST.TXT
#3 Met een AMD-processor zal AMD-V wel aanstaan, maar bij Intel moet vaak VT-x
#3 aangezet worden in het BIOS of UEFI-firmware!
#4 Start Terminalvenster en typ, of kopieer en plak:
#4    sudo apt remove --yes virtualbox-*
#4    sudo rm /etc/apt/sources.list.d/virtualbox.list
#4    sudo apt-get update
#4    sudo deluser "${SUDO_USER:-$USER}" vboxusers
#4    sudo delgroup vboxusers
