# shellcheck shell=bash
###############################################################################
# Installatiebestand voor Debian 11 LTS desktop op pc07.                      #
#                                                                             #
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.                         #
###############################################################################

#1-deact-eth0 (activeren eth0 uit start-up halen)
## ifup -a --read-environement:
## Cannot find device "eth0"
## [FAILED] Raise network interfaces
sudo sed --in-place --expression='s/^auto eth0$/#auto eth0/' /etc/network/interfaces.d/setup
sudo sed --in-place --expression='s/^iface eth0 net dhcp$/#iface eth0 net dhcp/' /etc/network/interfaces.d/setup
#2 Om te verwijderen Terminalvenster starten en uitvoeren:
#2    sudo sed --in-place --expression='s/^#auto eth0$/auto eth0/' /etc/network/interfaces.d/setup
#2    sudo sed --in-place --expression='s/^#iface eth0 net dhcp$/iface eth0 net dhcp/' /etc/network/interfaces.d/setup

#1 spice-vdagent (klembord delen tussen gastheer en gast)
sudo apt-get install --yes spice-vdagent
#2 Om te verwijderen Terminalvenster starten en uitvoeren:
#2    sudo apt remove spice-vdagent

#1 git (versiebeheersysteem)
sudo apt-get install --yes aspell-nl git
#2 Om te verwijderen Terminalvenster starten en uitvoeren:
#2    sudo apt remove git

#1 kvm (virtualisatie)
## Images staan in /var/lib/libvirt/images/.
## Dpkg::Options i.v.m. interactie a.g.v. restore /etc/libvirt configuratiebestanden.
sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes --option Dpkg::Options::="--force-confdef" --option Dpkg::Options::="--force-confold" bridge-utils cpu-checker libvirt-clients libvirt-daemon-system qemu-kvm qemu-system virtinst virt-manager
sudo adduser "${SUDO_USER:-$USER}" libvirt
sudo adduser "${SUDO_USER:-$USER}" libvirt-qemu
#2 Om te verwijderen Terminalvenster starten en uitvoeren:
#2    sudo apt remove bridge-utils cpu-checker libvirt-clients libvirt-daemon-system qemu-kvm qemu-system virtinst virt-manager
#2    sudo delgroup libvirtd-dnsmasq
#2    sudo deluser ${SUDO_USER:-$USER} libvirtd
#2    sudo deluser ${SUDO_USER:-$USER} libvirtd-qemu
#2    sudo delgroup libvirtd

#1 locate (bestanden snel zoeken op naam)
sudo apt-get install --yes mlocate
#2 Om te verwijderen Terminalvenster starten en uitvoeren:
#2    sudo apt remove mlocate

#1 python (programmeertaal)
sudo apt-get install --yes idle pycodestyle python3-pycodestyle python3-autopep8 python3-pip
sudo ln --force --relative --symbolic /usr/bin/pip3 /usr/bin/pip
sudo ln --force --relative --symbolic /usr/bin/python3 /usr/bin/python
#2 Om te verwijderen Terminalvenster starten en uitvoeren:
#2    sudo apt remove idle pycodestyle python3-pycodestyle python3-autopep8 python3-pip
#2    sudo rm /usr/bin/pip /usr/bin/python

#1 signal (privéberichtenapp)
printf '%s\n' 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal.gpg] https://updates.signal.org/desktop/apt xenial main' | sudo tee /etc/apt/sources.list.d/signal.list
wget --no-verbose --output-document=- https://updates.signal.org/desktop/apt/keys.asc | sudo gpg --dearmor --yes --output=/usr/share/keyrings/signal.gpg
sudo apt-get update
sudo apt-get install --yes signal-desktop
sudo apt-key del 57F6FB06
sudo rm --force /etc/apt/trusted.gpg.d/signal*
#2 Om te verwijderen Terminalvenster starten en uitvoeren:
#2    sudo apt remove signal-desktop
#2    sudo rm /etc/apt/sources.list.d/signal.list* /usr/share/keyrings/signal.asc*
#2    sudo apt update

#1 vscode (editor)
sudo snap install --classic code
#2 Om te verwijderen Terminalvenster starten en uitvoeren:
#2    sudo snap remove code

#1 webmin (browsergebaseerd beheer)
printf '%s\n' 'deb [signed-by=/usr/share/keyrings/webmin.gpg] http://download.webmin.com/download/repository sarge contrib' | sudo tee /etc/apt/sources.list.d/webmin.list
wget --no-verbose --output-document=- http://www.webmin.com/jcameron-key.asc | sudo gpg --dearmor --yes --output=/usr/share/keyrings/webmin.gpg
sudo apt-get update
sudo apt-get install --yes webmin
sudo apt-key del 11F63C51
sudo rm --force /etc/apt/trusted.gpg.d/webmin*
#2 Om te verwijderen Terminalvenster starten en uitvoeren:
#2    sudo apt remove --yes webmin
#2    sudo rm /etc/apt/sources.list.d/webmin.list* /usr/share/keyrings/webmin*
#2    sudo apt update
