# shellcheck shell=bash
###############################################################################
# Installatiebestand voor Debian desktop op pc07.
#
# Geschreven in 2019 door Karel Zimmer <info@karelzimmer.nl>, Creative Commons
# Publiek Domein Verklaring <http://creativecommons.org/publicdomain/zero/1.0>.
###############################################################################

#1-deact-eth0 (activeren eth0 uit start-up halen)
## ifup -a --read-environement: Cannot find device "eth0"/ [FAILED] Raise network interfaces
sudo sed --in-place --expression='s/^auto eth0$/#auto eth0/' /etc/network/interfaces.d/setup
sudo sed --in-place --expression='s/^iface eth0 net dhcp$/#iface eth0 net dhcp/' /etc/network/interfaces.d/setup
#2 sudo sed --in-place --expression='s/^#auto eth0$/auto eth0/' /etc/network/interfaces.d/setup
#2 sudo sed --in-place --expression='s/^#iface eth0 net dhcp$/iface eth0 net dhcp/' /etc/network/interfaces.d/setup

#1 adm (gebruiker toevoegen aan groep adm)
sudo adduser "${SUDO_USER:-$USER}" adm
#2 sudo deluser ${SUDO_USER:-$USER} adm

#1 spice-vdagent (klembord delen tussen gastheer en gast)
sudo apt-get install --yes spice-vdagent
#2 sudo apt-get remove --yes spice-vdagent

#1 gnome-gmail (Gmail als e-mailtoepassing in GNOME)
sudo apt-get install --yes gnome-gmail
#2 sudo apt-get remove --yes gnome-gmail

#1 kvm (virtualisatie)
## Images staan in /var/lib/libvirt/images/.
## Dpkg::Options i.v.m. interactie a.g.v. restore /etc/libvirt configuratiebestanden.
sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes --option Dpkg::Options::="--force-confdef" --option Dpkg::Options::="--force-confold" bridge-utils cpu-checker libvirt-clients libvirt-daemon-system qemu-kvm qemu-system virtinst virt-manager
sudo adduser "${SUDO_USER:-$USER}" libvirt
sudo adduser "${SUDO_USER:-$USER}" libvirt-qemu
#2 sudo apt-get remove --yes bridge-utils cpu-checker libvirt-clients libvirt-daemon-system qemu-kvm qemu-system virtinst virt-manager
#2 sudo delgroup libvirtd-dnsmasq
#2 sudo deluser ${SUDO_USER:-$USER} libvirtd
#2 sudo deluser ${SUDO_USER:-$USER} libvirtd-qemu
#2 sudo delgroup libvirtd

#1 locate (bestanden snel zoeken op naam)
sudo apt-get install --yes mlocate
#2 sudo apt-get remove --yes mlocate

#1 pinfo (gebruiksvriendelijke viewer voor Info-documenten)
sudo apt-get install --yes pinfo
#2 sudo apt-get remove --yes pinfo

#1 signal (privéberichtenapp)
sudo snap install signal-desktop
#2 sudo snap remove signal-desktop

#1 webmin (browsergebaseerd beheer)
echo 'deb [signed-by=/usr/share/keyrings/webmin.gpg] http://download.webmin.com/download/repository sarge contrib' | sudo tee /etc/apt/sources.list.d/webmin.list
wget --no-verbose --output-document=- 'http://www.webmin.com/jcameron-key.asc' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/webmin.gpg
sudo apt-get update
sudo apt-get install --yes webmin
#2 sudo apt-get remove --yes webmin
#2 sudo rm --force /etc/apt/sources.list.d/webmin.list* /usr/share/keyrings/webmin*
#2 sudo apt-get update
