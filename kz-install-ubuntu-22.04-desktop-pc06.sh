# shellcheck shell=bash
###############################################################################
# Installatiebestand voor Ubuntu 22.04 LTS desktop op pc06.                   #
#                                                                             #
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.                         #
###############################################################################

#1 cockpit (browsergebaseerd beheer)
sudo apt-get install --yes cockpit cockpit-pcp
#2 sudo apt remove --yes cockpit

#1-gdm (inlogscherm dual-monitor)
sudo cp ~karel/.config/monitors.xml ~gdm/.config/monitors.xml
sudo chown gdm:gdm ~gdm/.config/monitors.xml
#2 sudo rm ~gdm/.config/monitors.xml

#1 git (versiebeheersysteem)
sudo apt-get install --yes aspell-nl git
#2 sudo apt remove --yes git

#1 gnome-gmail (Gmail als de favoriete e-mailtoepassing in GNOME)
sudo apt-get install --yes gnome-gmail
#2 sudo apt remove --yes gnome-gmail

#1 kvm (virtualisatie)
## Images staan in /var/lib/libvirt/images/.
## Dpkg::Options i.v.m. interactie a.g.v. restore /etc/libvirt configuratiebestanden.
sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes --option Dpkg::Options::="--force-confdef" --option Dpkg::Options::="--force-confold" cpu-checker qemu-kvm bridge-utils virt-manager
#2 sudo apt remove --yes cpu-checker qemu-kvm bridge-utils virt-manager
#2 sudo delgroup libvirtd-dnsmasq
#2 sudo deluser ${SUDO_USER:-${SUDO_USER:-$USER}} libvirtd
#2 sudo delgroup libvirtd

#1 locate (bestanden snel zoeken op naam)
sudo apt-get install --yes mlocate
#2 sudo apt remove --yes mlocate

#1 pinta (tekenprogramma)
sudo apt-get install --yes pinta
#2 sudo apt remove --yes pinta

#1 python (programmeertaal)
sudo apt-get install --yes pycodestyle python3-pycodestyle python3-autopep8 python3-pip python-is-python3
sudo ln --force --relative --symbolic /usr/bin/pycodestyle /usr/bin/pep8
sudo ln --force --relative --symbolic /usr/bin/pip3 /usr/bin/pip
#2 sudo apt remove --yes pycodestyle python3-pycodestyle python3-autopep8 python3-pip python-is-python3
#2 sudo rm /usr/bin/pip

#1 signal (privéberichtenapp)
printf '%s\n' 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal.gpg] https://updates.signal.org/desktop/apt xenial main' | sudo tee /etc/apt/sources.list.d/signal.list
wget --no-verbose --output-document=- https://updates.signal.org/desktop/apt/keys.asc | sudo gpg --dearmor --yes --output=/usr/share/keyrings/signal.gpg
sudo apt-get update
sudo apt-get install --yes signal-desktop
sudo apt-key del 57F6FB06
sudo rm --force /etc/apt/trusted.gpg.d/signal*
#2 sudo apt remove --yes signal-desktop
#2 sudo rm /etc/apt/sources.list.d/signal.list* /usr/share/keyrings/signal.asc*
#2 sudo apt update

#1 vscode (editor)
sudo snap install --classic code
#2 sudo snap remove code
