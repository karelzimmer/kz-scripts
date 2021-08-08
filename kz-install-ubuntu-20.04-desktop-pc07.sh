# shellcheck shell=bash
###############################################################################
# Installatiebestand voor Ubuntu20.04 LST desktop op pc07.
#
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.
# Auteursrecht (c) 2020-2021 Karel Zimmer.
# GNU Algemene Publieke Licentie <https://www.gnu.org/licenses/gpl.html>.
#
# ReleaseNumber: 03.00.00
# DateOfRelease: 2021-08-08
###############################################################################

#1
#2 Gastgebruiker installeren
if [[ $HOSTNAME = pc07 ]] && ! id gast; then sudo useradd --create-home --shell /bin/bash --comment 'Gast' gast; fi
if [[ $HOSTNAME = pc07 ]] && id gast; then sudo chmod 0750 /home/gast; fi
if [[ $HOSTNAME = pc07 ]] && id gast; then sudo passwd --delete gast; fi
#4 Start Terminalvenster en voer uit:
#4    sudo userdel --remove gast


#1
#2 TLP installeren
## Nodig voor ThinkPads.
if [[ $HOSTNAME = pc07 ]]; then sudo apt-get install --yes tp-smapi-dkms acpi-call-dkms; fi
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes tlp tp-smapi-dkms acpi-call-dkms


#1 bluefish
#2 Bluefish installeren
sudo apt-get install --yes bluefish
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes bluefish


#1 exiftool
#2 ExifTool installeren
sudo apt-get install --yes libimage-exiftool-perl
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes libimage-exiftool-perl


#1 gedit
#2 Gedit installeren
sudo apt-get install --yes gedit-plugins
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes gedit-plugins


#1 git
#2 Git installeren
sudo apt-get install --yes git git-gui qgit
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes git git-gui qgit


#1 kvm
#2 KVM installeren
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
#4    sudo deluser ${SUDO_USER:-$USER} libvirtd
#4    sudo delgroup libvirtd


#1 locate
#2 Locate installeren
sudo apt-get install --yes mlocate
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes mlocate


#1 meld
#2 Meld installeren
sudo apt-get install --yes meld
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes meld


#1 python
#2 Python installeren
sudo apt-get install --yes idle pep8 python3-autopep8 python3-pip python-is-python3
sudo ln --force --relative --symbolic /usr/bin/pip3 /usr/bin/pip
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes idle python3-pip pep8 python-is-python3
#4    sudo rm --force /usr/bin/pip


#1 signal
#2 Signal installeren
wget --output-document=- 'https://updates.signal.org/desktop/apt/keys.asc' | sudo apt-key add -
echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | sudo tee /etc/apt/sources.list.d/signal-xenial.list
sudo apt-get update
sudo apt-get install --yes signal-desktop
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes signal-desktop
#4    sudo rm /etc/apt/sources.list.d/signal-xenial.list
#4    sudo apt-get update


#1 tree
#2 Tree installeren
sudo apt-get install --yes tree
#4 Start Terminalvenster en voer uit:
#4    sudo apt remove --yes tree


#1 vscode
#2 Visual Studio Code installeren
sudo snap install --classic code
#4 Start Terminalvenster en voer uit:
#4    sudo snap remove code


# EOF
