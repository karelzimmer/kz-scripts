# shellcheck shell=bash
###############################################################################
# Installatiebestand voor Ubuntu 22.04 LTS desktop op pc01.
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

#1-bluetooth (externe bluetooth-adapter)
echo 'SUBSYSTEM=="usb", ATTRS{idVendor}=="413c", ATTRS{idProduct}=="8187", ATTR{authorized}="0"' | sudo tee /etc/udev/rules.d/81-bluetooth-hci.rules
#2 sudo rm /etc/udev/rules.d/81-bluetooth-hci.rules

#1 exiftool (metadata lezen en schrijven)
sudo apt-get install --yes libimage-exiftool-perl
#2 sudo apt-get remove --yes libimage-exiftool-perl

#1 git (versiebeheersysteem)
sudo apt-get install --yes git
#2 sudo apt-get remove --yes git

#1 gnome-gmail (Gmail als e-mailtoepassing in GNOME)
sudo apt-get install --yes gnome-gmail
#2 sudo apt-get remove --yes gnome-gmail

#1 pinfo (gebruiksvriendelijke viewer voor Info-documenten)
sudo apt-get install --yes pinfo
#2 sudo apt-get remove --yes pinfo

#1 python (programmeertaal)
sudo apt-get install --yes pycodestyle python3-pycodestyle python3-autopep8 python3-pip python-is-python3
sudo ln --force --relative --symbolic /usr/bin/pycodestyle /usr/bin/pep8
sudo ln --force --relative --symbolic /usr/bin/pip3 /usr/bin/pip
#2 sudo apt-get remove --yes pycodestyle python3-pycodestyle python3-autopep8 python3-pip python-is-python3
#2 sudo rm /usr/bin/pip

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

#1 vscode (editor)
sudo snap install --classic code
#2 sudo snap remove code
