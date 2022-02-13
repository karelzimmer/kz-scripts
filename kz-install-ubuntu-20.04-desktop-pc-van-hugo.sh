# shellcheck shell=bash
###############################################################################
# Installatiebestand voor Ubuntu 20.04 LTS desktop op pc-van-hugo.            #
#                                                                             #
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.                         #
###############################################################################

#1 handlelidswitch (negeer sluiten laptopdesksel)
sudo sed --in-place --expression='/^HandleLidSwitch=/d' /etc/systemd/logind.conf
printf '%s\n' 'HandleLidSwitch=ignore' | sudo tee --append /etc/systemd/logind.conf
#3 Start Terminalvenster en voer uit:
#3    sudo sed --in-place --expression='/^HandleLidSwitch=/d' /etc/systemd/logind.conf

#1 pinta (tekenprogramma)
sudo apt-get install --yes pinta
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove --yes pinta

#1 telegram (privéberichtenapp)
sudo snap install telegram-desktop
#3 Start Terminalvenster en voer uit:
#3    sudo snap remove telegram-desktop

#1 virtualbox (virtualisatie)
## Images staan in ~/VirtualBox VMs/.
printf '%s\n' "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian $(lsb_release --codename --short) contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list
wget --no-verbose --output-document=- 'https://www.virtualbox.org/download/oracle_vbox_2016.asc' | sudo apt-key add -
wget --no-verbose --output-document=- 'https://www.virtualbox.org/download/oracle_vbox.asc' | sudo apt-key add -
sudo apt-get update
wget --no-verbose --output-document=/tmp/virtualbox-LATEST.TXT 'http://download.virtualbox.org/virtualbox/LATEST.TXT'
## VirtualBox Guest Additions ISO staat in /usr/share/virtualbox/.
sudo apt-get install --yes virtualbox-"$(awk -F'.' '{print $1"."$2}' < /tmp/virtualbox-LATEST.TXT)"
wget --no-verbose --output-document="/tmp/Oracle_VM_VirtualBox_Extension_Pack" "http://download.virtualbox.org/virtualbox/$(cat /tmp/virtualbox-LATEST.TXT)/Oracle_VM_VirtualBox_Extension_Pack-$(cat /tmp/virtualbox-LATEST.TXT).vbox-extpack"
printf '%s\n' 'y' | sudo VBoxManage extpack install --replace /tmp/Oracle_VM_VirtualBox_Extension_Pack
sudo adduser "${SUDO_USER:-$USER}" vboxusers
sudo rm /tmp/Oracle_VM_VirtualBox_Extension_Pack /tmp/virtualbox-LATEST.TXT
#2 Met een AMD-processor zal AMD-V wel aanstaan, maar bij Intel moet vaak VT-x
#2 aangezet worden in het BIOS of UEFI-firmware!
#3 Start Terminalvenster en typ, of kopieer en plak:
#3    sudo apt remove --yes virtualbox-*
#3    sudo rm /etc/apt/sources.list.d/virtualbox.list
#3    sudo apt-get update
#3    sudo deluser "${SUDO_USER:-$USER}" vboxusers
#3    sudo delgroup vboxusers
