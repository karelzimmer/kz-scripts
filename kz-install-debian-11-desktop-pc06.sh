# shellcheck shell=bash
###############################################################################
# Installatiebestand voor Debian 11 LTS desktop op pc07.                      #
#                                                                             #
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.                         #
###############################################################################

#1 git (versiebeheersysteem)
sudo apt-get install --yes aspell-nl git
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove --yes git

#1 kvm (virtualisatie)
## Images staan in /var/lib/libvirt/images/.
## Dpkg::Options i.v.m. interactie a.g.v. restore /etc/libvirt configuratiebestanden.
sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes --option Dpkg::Options::="--force-confdef" --option Dpkg::Options::="--force-confold" bridge-utils cpu-checker libvirt-clients libvirt-daemon-system qemu-kvm qemu-system virtinst virt-manager
sudo adduser "${SUDO_USER:-$USER}" libvirt
sudo adduser "${SUDO_USER:-$USER}" libvirt-qemu
#2 Deel klembord voor kopiëren en plakken tussen gastheer en gast.
#2 1. Start een gast.
#2 2. Start Terminalvenster en voer uit:
#2    sudo apt install spice-vdagent
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove --yes bridge-utils cpu-checker libvirt-clients libvirt-daemon-system qemu-kvm qemu-system virtinst virt-manager
#3    sudo delgroup libvirtd-dnsmasq
#3    sudo deluser ${SUDO_USER:-$USER} libvirtd
#3    sudo deluser ${SUDO_USER:-$USER} libvirtd-qemu
#3    sudo delgroup libvirtd

#1 locate (bestanden snel zoeken op naam)
sudo apt-get install --yes mlocate
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove --yes mlocate

#1 meld (visuele diff en merge tool)
sudo apt-get install --yes meld
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove --yes meld

#1 python (programmeertaal)
sudo apt-get install --yes idle pycodestyle python3-pycodestyle python3-autopep8 python3-pip
sudo ln --force --relative --symbolic /usr/bin/pip3 /usr/bin/pip
sudo ln --force --relative --symbolic /usr/bin/python3 /usr/bin/python
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove --yes idle pycodestyle python3-pycodestyle python3-autopep8 python3-pip
#3    sudo rm --force /usr/bin/pip /usr/bin/python

#1 signal (privéberichtenapp)
wget --no-verbose --output-document=- 'https://updates.signal.org/desktop/apt/keys.asc' | sudo apt-key add -
printf '%s\n' "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | sudo tee /etc/apt/sources.list.d/signal-xenial.list
sudo apt-get update
sudo apt-get install --yes signal-desktop
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove --yes signal-desktop
#3    sudo rm /etc/apt/sources.list.d/signal-xenial.list
#3    sudo apt-get update

#1 vscode (Visual Studio Code editor)
sudo snap install --classic code
#3 Start Terminalvenster en voer uit:
#3    sudo snap remove code
