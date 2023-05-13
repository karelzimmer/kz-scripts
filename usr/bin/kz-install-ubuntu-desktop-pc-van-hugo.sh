# shellcheck shell=bash
###############################################################################
# Install file for Ubuntu desktop on pc-van-hugo.
#
# Written by Karel Zimmer <info@karelzimmer.nl>, CC0 1.0 Universal
# <https://creativecommons.org/publicdomain/zero/1.0>, 2013-2023.
###############################################################################

#1 bleachbit
sudo apt-get install --yes bleachbit
#2 sudo apt-get remove --yes bleachbit

#1 calibre
sudo apt-get install --yes calibre
#2 sudo apt-get remove --yes calibre

#1 clamav
sudo apt-get install --yes clamtk-gnome
#2 sudo apt-get remove --yes clamtk-gnome

#1 gimp
sudo apt-get install --yes gimp gimp-help-en gimp-help-nl
#2 sudo apt-get remove --yes gimp gimp-help-en gimp-help-nl

#1-lidswitch
## Ignore closing laptop lid
sudo sed --in-place --expression='/^HandleLidSwitch=/d' /etc/systemd/logind.conf
echo 'HandleLidSwitch=ignore' | sudo tee --append /etc/systemd/logind.conf
#2 sudo sed --in-place --expression='/^HandleLidSwitch=/d' /etc/systemd/logind.conf

#1 virtualbox
## If installation hangs, the computer has UEFI Secure Boot, see the log:
## ----------------------------------------------------------------------------
## Configuring Secure Boot
## -----------------------
##
## Your system has UEFI Secure Boot enabled.
##
## UEFI Secure Boot requires additional configuration to work with third-party
## drivers.
##
## The system will assist you in configuring UEFI Secure Boot. To permit the
## use of third-party drivers, a new Machine-Owner Key MOK has been generated.
## This key now needs to be enrolled in your system's firmware.
##
## To ensure that this change is being made by you as an authorized user, and
## not by an attacker, you must choose a password now and then confirm the
## change after reboot using the same password, in both the "Enroll MOK" and
## "Change Secure Boot state" menus that will be presented to you when this
## system reboots.
##
## If you proceed but do not confirm the password upon reboot, Ubuntu will
## still be able to boot on your system but any hardware that requires
## third-party drivers to work correctly may not be usable.
## ----------------------------------------------------------------------------
## Steps to take:
## 1. Reboot.
## 2. Run kz update, who does a repair, among other things.
## 3. Provide a Secure Boot password and remember it.
## 4. Reboot.
## 5. Enroll MOK and provide the Secure Boot password from step 3.
##
## With an AMD processor, AMD-V will be enabled, but Intel often requires VT-x
## be enabled in the UEFI BIOS screen !
echo 'virtualbox-ext-pack virtualbox-ext-pack/license select true' | sudo debconf-set-selections
## VirtualBox Guest Additions ISO are in /usr/share/virtualbox/
sudo apt-get install --yes virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso
#2 sudo apt-get remove --yes virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso

#1 youtube-downloader
sudo apt-get install --yes youtubedl-gui
#2 sudo apt-get remove --yes youtubedl-gui
