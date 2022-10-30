# shellcheck shell=bash
###############################################################################
# Installatiebestand voor Ubuntu desktop op pc-van-hugo.
#
# Geschreven in 2022 door Karel Zimmer <info@karelzimmer.nl>, Creative Commons
# Publiek Domein Verklaring <http://creativecommons.org/publicdomain/zero/1.0>.
###############################################################################

#1 bleachbit (overbodige bestanden verwijderen)
sudo apt-get install --yes bleachbit
#2 sudo apt-get remove --yes bleachbit

#1 calibre (e-boekmanager)
sudo apt-get install --yes calibre
#2 sudo apt-get remove --yes calibre

#1 clamav (antivirus)
sudo apt-get install --yes clamtk-gnome
#2 sudo apt-get remove --yes clamtk-gnome

#1 gimp (beeldmanipulatieprogramma)
sudo apt-get install --yes gimp gimp-help-en gimp-help-nl
#2 sudo apt-get remove --yes gimp gimp-help-en gimp-help-nl

#1-lidswitch (negeer sluiten laptopdesksel)
sudo sed --in-place --expression='/^HandleLidSwitch=/d' /etc/systemd/logind.conf
echo 'HandleLidSwitch=ignore' | sudo tee --append /etc/systemd/logind.conf
#2 sudo sed --in-place --expression='/^HandleLidSwitch=/d' /etc/systemd/logind.conf

#1 telegram (privéberichtenapp)
sudo snap install telegram-desktop
#2 sudo snap remove telegram-desktop

#1 virtualbox (virtualisatie, check Secure Boot)

## Als installatie hangt, heeft de computer UEFI Secure Boot, zie de log:
## --------------------------------------------------------------------------------
## Configuring Secure Boot
## -----------------------
##
## Your system has UEFI Secure Boot enabled.
##
## UEFI Secure Boot requires additional configuration to work with third-party
## drivers.
##
## The system will assist you in configuring UEFI Secure Boot. To permit the use of
## third-party drivers, a new Machine-Owner Key (MOK) has been generated. This key
## now needs to be enrolled in your system's firmware.
##
## To ensure that this change is being made by you as an authorized user, and not
## by an attacker, you must choose a password now and then confirm the change after
## reboot using the same password, in both the "Enroll MOK" and "Change Secure Boot
## state" menus that will be presented to you when this system reboots.
##
## If you proceed but do not confirm the password upon reboot, Ubuntu will still be
## able to boot on your system but any hardware that requires third-party drivers
## to work correctly may not be usable.
## --------------------------------------------------------------------------------
## Te nemen stappen:
## 1. Reboot.
## 2. Voer kz-update uit (die doet o.a. een repair).
## 3. Geef een Secure Boot-wachtwoord en onthoud deze.
## 4. Reboot.
## 5. Enroll MOK en geef het Secure Boot-wachtwoord op uit stap 3.

## Images staan in ~/VirtualBox VMs/.
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/oracle_vbox_2016.gpg] https://download.virtualbox.org/virtualbox/debian $(lsb_release --codename --short) contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list
wget --no-verbose --output-document=- 'https://www.virtualbox.org/download/oracle_vbox_2016.asc' | sudo gpg --dearmor --yes --output=/usr/share/keyrings/oracle_vbox_2016.gpg
sudo apt-get update
wget --no-verbose --output-document=/tmp/virtualbox-LATEST.TXT 'http://download.virtualbox.org/virtualbox/LATEST.TXT'
## VirtualBox Guest Additions ISO staat in /usr/share/virtualbox/.
sudo apt-get install --yes virtualbox-"$(cut --delimiter='.' --fields='1-2' < /tmp/virtualbox-LATEST.TXT)"
## Downloadbestand moet zo heten, anders mslukt de installatie.
wget --no-verbose --output-document=/tmp/Oracle_VM_VirtualBox_Extension_Pack "http://download.virtualbox.org/virtualbox/$(cat /tmp/virtualbox-LATEST.TXT)/Oracle_VM_VirtualBox_Extension_Pack-$(cat /tmp/virtualbox-LATEST.TXT).vbox-extpack"
echo 'y' | sudo VBoxManage extpack install --replace /tmp/Oracle_VM_VirtualBox_Extension_Pack
sudo adduser "${SUDO_USER:-$USER}" vboxusers
sudo rm /tmp/Oracle_VM_VirtualBox_Extension_Pack /tmp/virtualbox-LATEST.TXT
#2 sudo deluser "${SUDO_USER:-$USER}" vboxusers
#2 sudo delgroup vboxusers
#2 sudo apt-get remove --yes virtualbox-*
#2 sudo rm --force /etc/apt/sources.list.d/virtualbox.list* /usr/share/keyrings/oracle_vbox_2016*
#2 sudo apt-get update

#1 whatsapp (privéberichtenapp)
sudo snap install whatsie
#2 sudo snap remove whatsie

#1 youtube-downloader (download videos)
sudo apt-get install --yes youtubedl-gui
#2 sudo apt-get remove --yes youtubedl-gui
