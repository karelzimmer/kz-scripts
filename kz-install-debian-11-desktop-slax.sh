# shellcheck shell=bash
###############################################################################
# Installatiebestand voor Debian 11 LTS desktop op slax.
#
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.
###############################################################################

#1 updates (bijgewerkte apps en systeembestanden)
sudo kz-update

#1 git (versiebeheersysteem)
sudo apt-get install --yes aspell-nl git
#2 sudo apt-get remove --yes git

#1 lsb-release (rapportagehulpprogramma voor Linux Standard Base)
sudo apt-get install --yes lsb-release
#2 sudo apt-get remove --yes lsb-release

#1 sudo (supergebruikersrechten)
sudo apt-get install --yes sudo
#2 sudo apt-get remove --yes sudo

#1 vim (vi improved)
sudo apt-get install --yes vim
#2 sudo apt-get remove --yes vim
