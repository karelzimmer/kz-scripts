# shellcheck shell=bash
###############################################################################
# Installatiebestand voor Ubuntu 22.04 LTS desktop op pc06.
#
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.
###############################################################################

#1-add-hosts (koppel IP-adressen aan hostnamen)
sudo sed --in-place --expression='/^192.168.1.112/d' /etc/hosts
sudo sed --in-place --expression='/^192.168.1.113/d' /etc/hosts
echo '192.168.1.112 pc06' | sudo tee --append /etc/hosts
echo '192.168.1.113 pc01' | sudo tee --append /etc/hosts
#2 sudo sed --in-place --expression='/^192.168.1.112/d' /etc/hosts
#2 sudo sed --in-place --expression='/^192.168.1.113/d' /etc/hosts

#1-gast (gastgebruiker toevoegen)
sudo useradd --create-home --shell /bin/bash --comment 'Gast' gast || true
sudo passwd --delete gast
#2 sudo userdel --remove gast

#1-gdm (inlogscherm dual-monitor)
sudo cp ~karel/.config/monitors.xml ~gdm/.config/monitors.xml
sudo chown gdm:gdm ~gdm/.config/monitors.xml
#2 sudo rm ~gdm/.config/monitors.xml

#1 ansible (automatiseringsplatform)
sudo apt-get install --yes ansible
#2 sudo apt-get remove --yes ansible

#1 cockpit (browsergebaseerd beheer)
sudo apt-get install --yes cockpit cockpit-pcp
#2 sudo apt-get remove --yes cockpit

#1 gimp (beeldmanipulatieprogramma)
sudo apt-get install --yes gimp gimp-help-en gimp-help-nl
#2 sudo apt-get remove --yes gimp gimp-help-en gimp-help-nl

#1 git (versiebeheersysteem)
sudo apt-get install --yes aspell-nl git
#2 sudo apt-get remove --yes git

#1 gnome-gmail (Gmail als e-mailtoepassing in GNOME)
sudo apt-get install --yes gnome-gmail
#2 sudo apt-get remove --yes gnome-gmail

#1 kvm (virtualisatie)
## Images staan in /var/lib/libvirt/images/.
## Dpkg::Options i.v.m. interactie a.g.v. restore /etc/libvirt configuratiebestanden.
sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes --option Dpkg::Options::="--force-confdef" --option Dpkg::Options::="--force-confold" cpu-checker qemu-kvm bridge-utils virt-manager
#2 sudo apt-get remove --yes cpu-checker qemu-kvm bridge-utils virt-manager
#2 sudo delgroup libvirtd-dnsmasq
#2 sudo deluser ${SUDO_USER:-${SUDO_USER:-$USER}} libvirtd
#2 sudo delgroup libvirtd

#1 locate (bestanden snel zoeken op naam)
sudo apt-get install --yes mlocate
#2 sudo apt-get remove --yes mlocate

#1 pinfo (gebruiksvriendelijke viewer voor Info-documenten)
sudo apt-get install --yes pinfo
#2 sudo apt-get remove --yes pinfo

#1 plex (mediaspeler)
## Snap plex-htpc is de mediaspeler voor de Linux-computer die is aangesloten op het grote scherm.
## Een Home Theater PC (HTPC) is een computer die fungeert als multimediacentrum in huis.
sudo snap install plex-desktop
#2 sudo snap remove plex-desktop

#1 python (programmeertaal)
sudo apt-get install --yes pycodestyle python3-pycodestyle python3-autopep8 python3-pip python-is-python3
sudo ln --force --relative --symbolic /usr/bin/pycodestyle /usr/bin/pep8
sudo ln --force --relative --symbolic /usr/bin/pip3 /usr/bin/pip
#2 sudo apt-get remove --yes pycodestyle python3-pycodestyle python3-autopep8 python3-pip python-is-python3
#2 sudo rm /usr/bin/pip

#1 signal (privéberichtenapp)
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal.gpg] https://updates.signal.org/desktop/apt xenial main' | sudo tee /etc/apt/sources.list.d/signal.list
wget --no-verbose --output-document=- 'https://updates.signal.org/desktop/apt/keys.asc' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/signal.gpg
sudo apt-get update
sudo apt-get install --yes signal-desktop
#2 sudo apt-get remove --yes signal-desktop
#2 sudo rm --force /etc/apt/sources.list.d/signal.list* /usr/share/keyrings/signal.asc*
#2 sudo apt-get update

#1 ssh (veilige shell-client en server)
sudo apt-get install --yes ssh
sudo sed --in-place --expression='s/PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
## Check op remote root-toegang.
grep --quiet --regexp='PermitRootLogin no' /etc/ssh/sshd_config
sudo systemctl restart ssh.service
#2 sudo sed --in-place --expression='s/PermitRootLogin no/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config
#2 sudo apt-get remove --yes ssh

#1 tree (mappenboom)
sudo apt-get install --yes tree
#2 sudo apt-get remove --yes tree

#1 ufw (firewall)
sudo apt-get install --yes gufw
sudo ufw allow ssh
sudo ufw enable
#2 sudo ufw disable

#1 vlc (mediaspeler)
sudo snap install vlc
#2 sudo snap remove vlc

#1 vscode (editor)
sudo snap install --classic code
#2 sudo snap remove code
