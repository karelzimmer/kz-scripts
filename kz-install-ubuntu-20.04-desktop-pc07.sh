# shellcheck shell=bash
###############################################################################
# Installatiebestand voor Ubuntu20.04 LST desktop op pc07.                    #
#                                                                             #
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.                         #
###############################################################################

#1 git (vVersiebeheersysteem)
sudo apt-get install --yes git git-gui qgit
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove --yes git git-gui qgit

#1 kvm (virtualisatie)
## Images staan in /var/lib/libvirt/images/.
## Dpkg::Options i.v.m. interactie a.g.v. restore /etc/libvirt configuratiebestanden.
sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes --option Dpkg::Options::="--force-confdef" --option Dpkg::Options::="--force-confold" cpu-checker qemu-kvm bridge-utils virt-manager
#2 Deel klembord voor kopiëren en plakken tussen gastheer en gast.
#2 1. Start een gast.
#2 2. Start Terminalvenster en voer uit:
#2    sudo apt install spice-vdagent
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove --yes cpu-checker qemu-kvm bridge-utils virt-manager
#3    sudo delgroup libvirtd-dnsmasq
#3    sudo deluser ${SUDO_USER:-$USER} libvirtd
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
sudo apt-get install --yes idle python3-pycodestyle python3-autopep8 python3-pip python-is-python3
sudo ln --force --relative --symbolic /usr/bin/pip3 /usr/bin/pip
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove --yes idle python3-pycodestyle python3-autopep8 python3-pip python-is-python3
#3    sudo rm --force /usr/bin/pip

#1 signal (privéberichtenapp)
wget --no-verbose --output-document=- 'https://updates.signal.org/desktop/apt/keys.asc' | sudo apt-key add -
printf '%s\n' "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | sudo tee /etc/apt/sources.list.d/signal-xenial.list
sudo apt-get update
sudo apt-get install --yes signal-desktop
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove --yes signal-desktop
#3    sudo rm /etc/apt/sources.list.d/signal-xenial.list
#3    sudo apt-get update

#1 tlp (accubesparing)
sudo apt-get install --yes tlp
## Nodig voor ThinkPads.
sudo apt-get install --yes tp-smapi-dkms acpi-call-dkms
#2 Check status:
#2 ~~~~~~~~~~~~~
#2 Start Terminalvenster en voer uit:
#2    sudo tlp-stat --battery
#2
#2 Mogelijk extra te (ThinkPads/zie uitvoer tlp-stat):
#2    sudo apt-get install --yes tp-smapi-dkms acpi-call-dkms
#3 Start Terminalvenster en voer uit:
#3    sudo apt remove --yes tlp tp-smapi-dkms acpi-call-dkms

#1 vscode (Visual Studio Code editor)
sudo snap install --classic code
#3 Start Terminalvenster en voer uit:
#3    sudo snap remove code
