# shellcheck shell=bash
###############################################################################
# Setup file for Ubuntu desktop on pc01 for monique.
#
# Written by Karel Zimmer <info@karelzimmer.nl>, CC0 1.0 Universal
# <https://creativecommons.org/publicdomain/zero/1.0>, 2013-2023.
###############################################################################

#1-gnome
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 32
#2 gsettings reset org.gnome.shell.extensions.dash-to-dock dash-max-icon-size

#1 zoom
kz-gset --addfavaft=kz-zoom
#2 kz-gset --delfav=kz-zoom

