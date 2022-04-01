# shellcheck shell=bash
###############################################################################
# Installatiebestand voor Ubuntu 20.04 desktop op pc06.                       #
#                                                                             #
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.                         #
###############################################################################

#1 calibre (e-boekmanager)
sudo apt-get install --yes calibre
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove calibre

#1 cockpit (browsergebaseerd beheer)
sudo apt-get install --yes --target-release="$(lsb_release --codename --short)"-backports cockpit cockpit-pcp
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove cockpit

#1 earth (verken de wereld)
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-earth.gpg] http://dl.google.com/linux/earth/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-earth-pro.list
wget --no-verbose --output-document=- https://dl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmor --yes --output=/usr/share/keyrings/google-earth.gpg
sudo apt-get update
sudo apt-get install --yes google-earth-pro-stable
sudo apt-key del 7FAC5991 D38B4796
sudo rm --force /etc/apt/trusted.gpg.d/google-earth*
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove --yes google-earth-pro-stable
#3    sudo rm /etc/apt/sources.list.d/google-earth.list* /usr/share/keyrings/google-earth.gpg*
#3    sudo apt update

#1 gdm (inlogscherm dual-monitor)
sudo cp ~/.config/monitors.xml ~gdm/.config/monitors.xml
sudo chown gdm:gdm ~gdm/.config/monitors.xml
#3 Start Terminalvenster en voer uit:
#3    sudo rm ~gdm/.config/monitors.xml

#1 git (versiebeheersysteem)
sudo apt-get install --yes aspell-nl git
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove git

#1 kvm (virtualisatie)
## Images staan in /var/lib/libvirt/images/.
## Dpkg::Options i.v.m. interactie a.g.v. restore /etc/libvirt configuratiebestanden.
sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes --option Dpkg::Options::="--force-confdef" --option Dpkg::Options::="--force-confold" cpu-checker qemu-kvm bridge-utils virt-manager
#2 Deel klembord voor kopiëren en plakken tussen gastheer en gast.
#2 1. Start een gast.
#2 2. Start Terminalvenster en voer uit:
#2    sudo apt install spice-vdagent
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove cpu-checker qemu-kvm bridge-utils virt-manager
#3    sudo delgroup libvirtd-dnsmasq
#3    sudo deluser ${SUDO_USER:-${SUDO_USER:-$USER}} libvirtd
#3    sudo delgroup libvirtd

#1 lftp (FTP-programma)
sudo apt-get install --yes lftp
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove lftp

#1 locate (bestanden snel zoeken op naam)
sudo apt-get install --yes mlocate
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove mlocate

#1 neofetch (systeeminformatie in het terminalvenster)
sudo apt-get install --yes neofetch
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove neofetch

#1 meld (visuele diff en merge tool)
sudo apt-get install --yes meld
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove meld

#1 pinta (tekenprogramma)
sudo apt-get install --yes pinta
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove pinta

#1 python (programmeertaal)
sudo apt-get install --yes pycodestyle python3-pycodestyle python3-autopep8 python3-pip python-is-python3
sudo ln --force --relative --symbolic /usr/bin/pycodestyle /usr/bin/pep8
sudo ln --force --relative --symbolic /usr/bin/pip3 /usr/bin/pip
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove pycodestyle python3-pycodestyle python3-autopep8 python3-pip python-is-python3
#3    sudo rm /usr/bin/pip

#1 samba (communiceren met andere machines)
sudo apt-get install --yes samba cifs-utils
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove samba cifs-utils

#1 signal (privéberichtenapp)
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal.gpg] https://updates.signal.org/desktop/apt xenial main' | sudo tee /etc/apt/sources.list.d/signal.list
wget --no-verbose --output-document=- https://updates.signal.org/desktop/apt/keys.asc | sudo gpg --dearmor --yes --output=/usr/share/keyrings/signal.gpg
sudo apt-get update
sudo apt-get install --yes signal-desktop
sudo apt-key del 57F6FB06
sudo rm --force /etc/apt/trusted.gpg.d/signal*
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove signal-desktop
#3    sudo rm /etc/apt/sources.list.d/signal.list* /usr/share/keyrings/signal.asc*
#3    sudo apt update

#1 tree (mappenboom weergeven)
sudo apt-get install --yes tree
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove tree

#1 virtualbox (virtualisatie)
## Images staan in ~/VirtualBox VMs/.
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/oracle_vbox_2016.gpg] https://download.virtualbox.org/virtualbox/debian $(lsb_release --codename --short) contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list
wget --no-verbose --output-document=- https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo gpg --dearmor --yes --output=/usr/share/keyrings/oracle_vbox_2016.gpg
sudo apt-get update
wget --no-verbose --output-document=/tmp/virtualbox-LATEST.TXT http://download.virtualbox.org/virtualbox/LATEST.TXT
## VirtualBox Guest Additions ISO staat in /usr/share/virtualbox/.
sudo apt-get install --yes virtualbox-"$(awk -F'.' '{print $1"."$2}' < /tmp/virtualbox-LATEST.TXT)"
## Downloadbestand moet zo heten, anders mslukt de installatie.
wget --no-verbose --output-document=/tmp/Oracle_VM_VirtualBox_Extension_Pack "http://download.virtualbox.org/virtualbox/$(cat /tmp/virtualbox-LATEST.TXT)/Oracle_VM_VirtualBox_Extension_Pack-$(cat /tmp/virtualbox-LATEST.TXT).vbox-extpack"
echo 'y' | sudo VBoxManage extpack install --replace /tmp/Oracle_VM_VirtualBox_Extension_Pack
sudo adduser "${SUDO_USER:-$USER}" vboxusers
sudo rm /tmp/Oracle_VM_VirtualBox_Extension_Pack /tmp/virtualbox-LATEST.TXT
sudo apt-key del 98AB5139 2980AECF
sudo rm --force /etc/apt/trusted.gpg.d/oracle_vbox*
#2 Met een AMD-processor zal AMD-V wel aanstaan, maar bij Intel moet vaak VT-x
#2 aangezet worden in het BIOS of UEFI-firmware!
#3 Start Terminalvenster en typ, of kopieer en plak:
#3    sudo apt remove --yes virtualbox-*
#3    sudo rm /etc/apt/sources.list.d/virtualbox.list* /usr/share/keyrings/oracle_vbox_2016*
#3    sudo apt update
#3    sudo deluser "${SUDO_USER:-$USER}" vboxusers
#3    sudo delgroup vboxusers
#1 vscode (editor)
sudo snap install --classic code
#3 Start Terminalvenster en voer uit:
#3    sudo snap remove code

#1 webmin (browsergebaseerd beheer)
echo 'deb [signed-by=/usr/share/keyrings/webmin.gpg] http://download.webmin.com/download/repository sarge contrib' | sudo tee /etc/apt/sources.list.d/webmin.list
wget --no-verbose --output-document=- http://www.webmin.com/jcameron-key.asc | sudo gpg --dearmor --yes --output=/usr/share/keyrings/webmin.gpg
sudo apt-get update
sudo apt-get install --yes webmin
sudo apt-key del 11F63C51
sudo rm --force /etc/apt/trusted.gpg.d/webmin*
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove --yes webmin
#3    sudo rm /etc/apt/sources.list.d/webmin.list* /usr/share/keyrings/webmin*
#3    sudo apt update
