# shellcheck shell=bash
###############################################################################
# Installatiebestand voor Debian 11 LST desktop op pc07.
#
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.
###############################################################################
# RELEASE_YEAR=2021

# VERSION_NUMBER=01.01.01
# VERSION_DATE=2021-09-17


#1
#2 Intel Wireless WiFi Link Firmware (wifi-adapter) installeren
## Als NIET uitgevoerd TIJDENS installatie.
:
#sudo sed --in-place --expression='s/main$/main contrib non-free/g' /etc/apt/sources.list
#sudo apt-get update
#sudo apt-get install firmware-iwlwifi
#sudo modprobe --remove iwlwifi
#sudo modprobe iwlwifi
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes firmware-iwlwifi
#4    sudo sed --in-place --expression='s/main contrib non-free$/main/g' /etc/apt/sources.list
#4    sudo apt-get update
#4    sudo modprobe --remove iwlwifi
#4    sudo modprobe iwlwifi


#1
#2 Activeren eth0 uit start-up (netwerk-adapter) halen
## Anders [FAILED] Raise network interfaces
sudo sed --in-place --expression='s/^auto eth0$/#auto eth0/' /etc/network/interfaces.d/setup
sudo sed --in-place --expression='s/^iface eth0 net dhcp$/#iface eth0 net dhcp/' /etc/network/interfaces.d/setup
#4 Start Terminalvenster en voer uit:
#4    sudo sed --in-place --expression='s/^#auto eth0$/auto eth0/' /etc/network/interfaces.d/setup
#4    sudo sed --in-place --expression='s/^#iface eth0 net dhcp$/iface eth0 net dhcp/' /etc/network/interfaces.d/setup


#1 bluefish
#2 Bluefish (editor) installeren
sudo apt-get install --yes bluefish
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes bluefish


#1 exiftool
#2 ExifTool (multimedia-metadata) installeren
sudo apt-get install --yes libimage-exiftool-perl
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes libimage-exiftool-perl


#1 gast
#2 Gastgebruiker (gast) installeren
sudo useradd --create-home --shell /bin/bash --comment 'Gast' gast || true
sudo chmod 0750 /home/gast
sudo passwd --delete gast
#4 Start Terminalvenster en voer uit:
#4    sudo userdel --remove gast


#1 gedit
#2 Gedit (editor) installeren
sudo apt-get install --yes gedit-plugins
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes gedit-plugins


#1 git
#2 Git (versiebeheersysteem) installeren
sudo apt-get install --yes aspell-nl git gitg
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes git gitg


#1 kvm
#2 KVM (virtualisatie) installeren
## Images staan in /var/lib/libvirt/images/.
## Dpkg::Options i.v.m. interactie a.g.v. restore /etc/libvirt configuratiebestanden.
sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes --option Dpkg::Options::="--force-confdef" --option Dpkg::Options::="--force-confold" bridge-utils cpu-checker libvirt-clients libvirt-daemon-system qemu-kvm qemu-system virtinst virt-manager
sudo adduser "${SUDO_USER:-$USER}" libvirt
sudo adduser "${SUDO_USER:-$USER}" libvirt-qemu
#3 Deel klembord voor kopiëren en plakken tussen gastheer en gast.
#3 1. Start een gast.
#3 2. Start Terminalvenster en voer uit:
#3    sudo apt install spice-vdagent
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes bridge-utils cpu-checker libvirt-clients libvirt-daemon-system qemu-kvm qemu-system virtinst virt-manager
#4    sudo delgroup libvirtd-dnsmasq
#4    sudo deluser ${SUDO_USER:-$USER} libvirtd
#4    sudo deluser ${SUDO_USER:-$USER} libvirtd-qemu
#4    sudo delgroup libvirtd


#1 locate
#2 Locate (bestanden snel zoeken op naam) installeren
sudo apt-get install --yes mlocate
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes mlocate


#1 meld
#2 Meld (visuele diff en merge tool) installeren
sudo apt-get install --yes meld
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes meld


#1 python
#2 Python (programmeertaal) installeren
sudo apt-get install --yes idle pycodestyle python3-pycodestyle python3-autopep8 python3-pip
sudo ln --force --relative --symbolic /usr/bin/pip3 /usr/bin/pip
sudo ln --force --relative --symbolic /usr/bin/python3 /usr/bin/python
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes idle pycodestyle python3-pycodestyle python3-autopep8 python3-pip
#4    sudo rm --force /usr/bin/pip /usr/bin/python


#1 signal
#2 Signal (privéberichtenapp) installeren
wget --output-document=- 'https://updates.signal.org/desktop/apt/keys.asc' | sudo apt-key add -
echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | sudo tee /etc/apt/sources.list.d/signal-xenial.list
sudo apt-get update
sudo apt-get install --yes signal-desktop
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes signal-desktop
#4    sudo rm /etc/apt/sources.list.d/signal-xenial.list
#4    sudo apt-get update


#1 tlp
#2 TLP (accubesparing) installeren
sudo apt-get install --yes tlp
## Nodig voor ThinkPads.
sudo apt-get install --yes tp-smapi-dkms acpi-call-dkms
#3 Check status:
#3 ~~~~~~~~~~~~~
#3 Start Terminalvenster en voer uit:
#3    sudo tlp-stat --battery
#3
#3 Mogelijk extra te installeren (ThinkPads/zie uitvoer tlp-stat):
#3    sudo apt-get install --yes tp-smapi-dkms acpi-call-dkms
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes tlp tp-smapi-dkms acpi-call-dkms


#1 tree
#2 Tree (mappenboom weergeven) installeren
sudo apt-get install --yes tree
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes tree


#1 vscode
#2 Visual Studio Code (editor) installeren
sudo snap install --classic code
#4 Start Terminalvenster en voer uit:
#4    sudo snap remove code


# EOF
