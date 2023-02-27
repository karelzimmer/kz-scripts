# shellcheck shell=bash
###############################################################################
# Install file for Ubuntu desktop on pc-van-ria-en-toos.
#
# Written in 2023 by Karel Zimmer <info@karelzimmer.nl>, Creative Commons
# Public Domain Dedication <http://creativecommons.org/publicdomain/zero/1.0>.
###############################################################################

#1 citrix
## Teleworking
## Dependency since Ubuntu 22.04.
wget --output-document=/tmp/libidn11.deb 'https://karelzimmer.nl/downloads/citrix/libidn11_1.33-3_amd64.deb'
sudo apt-get install --yes /tmp/libidn11.deb
## Aka Citrix Workspace app, Citrix Receiver, ICA Client.
## This old version because a newer one doesn't work for Toos' work.
wget --output-document=/tmp/icaclient.deb 'https://karelzimmer.nl/downloads/citrix/icaclient_20.04.0.21_amd64.deb'
sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes /tmp/icaclient.deb
sudo ln --symbolic --force /usr/share/ca-certificates/mozilla/* /opt/Citrix/ICAClient/keystore/cacerts
sudo c_rehash /opt/Citrix/ICAClient/keystore/cacerts
rm /tmp/icaclient.deb /tmp/libidn11.deb
#2 sudo apt-get remove --yes icaclient libidn11
