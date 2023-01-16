# shellcheck shell=bash
###############################################################################
# Installatiebestand voor Ubuntu desktop op pc06.
#
# Geschreven in 2009 door Karel Zimmer <info@karelzimmer.nl>, Creative Commons
# Publiek Domein Verklaring <http://creativecommons.org/publicdomain/zero/1.0>.
###############################################################################

#1-add-hosts (koppel IP-adressen aan hostnamen)
sudo sed --in-place --expression='/^192.168.1.112/d' /etc/hosts
sudo sed --in-place --expression='/^192.168.1.113/d' /etc/hosts
echo '192.168.1.112 pc06' | sudo tee --append /etc/hosts
echo '192.168.1.113 pc01' | sudo tee --append /etc/hosts
#2 sudo sed --in-place --expression='/^192.168.1.112/d' /etc/hosts
#2 sudo sed --in-place --expression='/^192.168.1.113/d' /etc/hosts

#1-brightness (helderheid instellen)
echo '#!/bin/sh' | sudo tee /etc/rc.local
echo 'echo 1900 > /sys/class/backlight/intel_backlight/brightness' | sudo tee --append /etc/rc.local
sudo chmod +x /etc/rc.local
#2 echo '' | sudo tee /etc/rc.local
#2 sudo chmod -x /etc/rc.local

#1-gast (gastgebruiker toevoegen)
sudo useradd --create-home --shell /bin/bash --comment 'Gast' gast || true
sudo passwd --delete gast
#2 sudo userdel --remove gast

#1-gdm (inlogscherm dual-monitor)
if [[ -f ~karel/.config/monitors.xml ]]; then sudo cp ~karel/.config/monitors.xml ~gdm/.config/monitors.xml; fi
if [[ -f ~gdm/.config/monitors.xml ]]; then sudo chown gdm:gdm ~gdm/.config/monitors.xml; fi
#2 sudo rm --force ~gdm/.config/monitors.xml

#1 ansible (automatiseringsplatform)
sudo apt-get install --yes ansible
#2 sudo apt-get remove --yes ansible

#1 cockpit (browsergebaseerd beheer)
sudo apt-get install --yes cockpit cockpit-pcp
#2 sudo apt-get remove --yes cockpit

#1 exiftool (metadata lezen en schrijven)
sudo apt-get install --yes libimage-exiftool-perl
#2 sudo apt-get remove --yes libimage-exiftool-perl

#1 gimp (beeldmanipulatieprogramma)
sudo apt-get install --yes gimp gimp-help-en gimp-help-nl
#2 sudo apt-get remove --yes gimp gimp-help-en gimp-help-nl

#1 gnome-gmail (Gmail als e-mailtoepassing in GNOME)
sudo apt-get install --yes gnome-gmail
#2 sudo apt-get remove --yes gnome-gmail

#1 gnome-tweaks (GNOME afstellingen)
sudo apt-get install --yes gnome-tweaks
#2 sudo apt-get remove --yes gnome-tweaks

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

#1 nautilus-admin (open map/bestand als beheerder)
sudo apt-get install --yes nautilus-admin
#2 sudo apt-get remove --yes nautilus-admin

#1 plex (mediaspeler)
## Snap plex-htpc is de mediaspeler voor de Linux-computer die is aangesloten op het grote scherm.
## Een Home Theater PC (HTPC) is een computer die fungeert als multimediacentrum in huis.
sudo snap install plex-desktop
#2 sudo snap remove plex-desktop

#1 signal (privéberichtenapp)
sudo snap install signal-desktop
#2 sudo snap remove signal-desktop

#1 ssh (veilige shell-client en server)
sudo apt-get install --yes ssh
sudo sed --in-place --expression='s/PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
## Check op remote root-toegang.
grep --quiet --regexp='PermitRootLogin no' /etc/ssh/sshd_config
sudo systemctl restart ssh.service
#2 sudo sed --in-place --expression='s/PermitRootLogin no/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config
#2 sudo apt-get remove --yes ssh

#1 sushi (voorbeeld tonen)
## Selecteer een bestand, druk op de spatiebalk, en een preview verschijnt.
sudo apt-get install --yes gnome-sushi
#2 sudo apt-get remove --yes gnome-sushi

#1 teams (samenwerken)
## Via webbrowser: https://www.microsoft.com/nl-nl/microsoft-teams/log-in
sudo snap install teams
#2 sudo snap remove teams

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
