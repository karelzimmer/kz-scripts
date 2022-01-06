# shellcheck shell=bash
###############################################################################
# Installatiebestand voor Ubuntu 20.04 LTS desktop op pc06.                   #
#                                                                             #
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.                         #
###############################################################################

#1 calibre
#2 Calibre - E-boekmanager
sudo apt-get install --yes calibre
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes calibre

#1 gast
#2 Gast - Gastgebruiker
sudo useradd --create-home --shell /bin/bash --comment 'Gast' gast || true
sudo chmod 0750 /home/gast
sudo passwd --delete gast
#4 Start Terminalvenster en voer uit:
#4    sudo userdel --remove gast

#1 git
#2 Git - Versiebeheersysteem
sudo apt-get install --yes aspell-nl git gitg
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes git gitg

#1 kvm
#2 KVM - Virtualisatie
## Images staan in /var/lib/libvirt/images/.
## Dpkg::Options i.v.m. interactie a.g.v. restore /etc/libvirt configuratiebestanden.
sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes --option Dpkg::Options::="--force-confdef" --option Dpkg::Options::="--force-confold" cpu-checker qemu-kvm bridge-utils virt-manager
#3 Deel klembord voor kopiëren en plakken tussen gastheer en gast.
#3 1. Start een gast.
#3 2. Start Terminalvenster en voer uit:
#3    sudo apt install spice-vdagent
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes cpu-checker qemu-kvm bridge-utils virt-manager
#4    sudo delgroup libvirtd-dnsmasq
#4    sudo deluser ${SUDO_USER:-${SUDO_USER:-$USER}} libvirtd
#4    sudo delgroup libvirtd

#1 lftp
#2 Lftp - FTP-programma
sudo apt-get install --yes lftp
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes lftp

#1 locate
#2 Locate  - Bestanden snel zoeken op naam
sudo apt-get install --yes mlocate
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes mlocate

#1 meld
#2 Meld - Visuele diff en merge tool
sudo apt-get install --yes meld
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes meld

#1 pinta
#2 Pinta - Tekenprogramma
sudo apt-get install --yes pinta
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes pinta

#1 python
#2 Python - Programmeertaal
sudo apt-get install --yes pycodestyle python3-pycodestyle python3-autopep8 python3-pip python-is-python3
sudo ln --force --relative --symbolic /usr/bin/pycodestyle /usr/bin/pep8
sudo ln --force --relative --symbolic /usr/bin/pip3 /usr/bin/pip
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes pycodestyle python3-pycodestyle python3-autopep8 python3-pip python-is-python3
#4    sudo rm --force /usr/bin/pip

#1 signal
#2 Signal - Privéberichtenapp
wget --output-document=- 'https://updates.signal.org/desktop/apt/keys.asc' | sudo apt-key add -
echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | sudo tee /etc/apt/sources.list.d/signal-xenial.list
sudo apt-get update
sudo apt-get install --yes signal-desktop
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes signal-desktop
#4    sudo rm /etc/apt/sources.list.d/signal-xenial.list
#4    sudo apt-get update

#1 tree
#2 Tree - Mappenboom weergeven
sudo apt-get install --yes tree
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes tree

#1 vscode
#2 Visual Studio Code - Editor
sudo snap install --classic code
#4 Start Terminalvenster en voer uit:
#4    sudo snap remove code
