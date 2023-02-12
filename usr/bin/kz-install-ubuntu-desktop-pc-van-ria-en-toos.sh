# shellcheck shell=bash
###############################################################################
# Installatiebestand voor Ubuntu desktop op pc-van-ria-en-toos.
#
# Geschreven in 2023 door Karel Zimmer <info@karelzimmer.nl>, Creative Commons
# Publiek Domein Verklaring <http://creativecommons.org/publicdomain/zero/1.0>.
###############################################################################

#1 citrix (telewerken)
## Afhankelijkheid sinds Ubuntu 22.04.
wget --output-document=/tmp/libidn11.deb 'https://karelzimmer.nl/downloads/citrix/libidn11_1.33-3_amd64.deb'
sudo apt-get install --yes /tmp/libidn11.deb
## Aka Citrix Workspace app, Citrix Receiver, ICA Client.
## Deze oude versie omdat een nieuwere niet werkt voor Toos haar werk.
wget --output-document=/tmp/icaclient.deb 'https://karelzimmer.nl/downloads/citrix/icaclient_20.04.0.21_amd64.deb'
sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes /tmp/icaclient.deb
sudo ln --symbolic --force /usr/share/ca-certificates/mozilla/* /opt/Citrix/ICAClient/keystore/cacerts
sudo c_rehash /opt/Citrix/ICAClient/keystore/cacerts
rm /tmp/icaclient.deb /tmp/libidn11.deb
#2 sudo apt-get remove --yes icaclient libidn11
