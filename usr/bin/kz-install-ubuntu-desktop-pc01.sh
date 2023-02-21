# shellcheck shell=bash
###############################################################################
# Installatiebestand voor Ubuntu desktop op pc01.
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

#1-bluetooth (externe bluetooth-adapter)
echo 'SUBSYSTEM=="usb", ATTRS{idVendor}=="413c", ATTRS{idProduct}=="8187", ATTR{authorized}="0"' | sudo tee /etc/udev/rules.d/81-bluetooth-hci.rules
#2 sudo rm --force /etc/udev/rules.d/81-bluetooth-hci.rules

#1-gast (gastgebruiker toevoegen)
sudo useradd --create-home --shell /bin/bash --comment 'Gast' gast || true
sudo passwd --delete gast
#2 sudo userdel --remove gast

#1 gnome-gmail (Gmail als e-mailtoepassing in GNOME)
sudo apt-get install --yes gnome-gmail
#2 sudo apt-get remove --yes gnome-gmail

#1 ssh (veilige shell-client en server)
sudo apt-get install --yes ssh
sudo sed --in-place --expression='s/PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
## Check op remote root-toegang.
grep --quiet --regexp='PermitRootLogin no' /etc/ssh/sshd_config
sudo systemctl restart ssh.service
#2 sudo sed --in-place --expression='s/PermitRootLogin no/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config
#2 sudo apt-get remove --yes ssh

#1 ufw (firewall)
sudo apt-get install --yes gufw
sudo ufw allow ssh
sudo ufw enable
#2 sudo ufw disable

#1 zoom (samenwerken)
sudo snap install zoom-client
#2 sudo snap remove zoom-client