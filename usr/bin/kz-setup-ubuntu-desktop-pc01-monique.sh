# shellcheck shell=bash
###############################################################################
# Setup file for Ubuntu desktop on pc01 for monique.
#
# Written in 2013 by Karel Zimmer <info@karelzimmer.nl>, Creative Commons
# Public Domain Dedication <https://creativecommons.org/publicdomain/zero/1.0>.
###############################################################################

#1-gnome
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 32
#2 gsettings reset org.gnome.shell.extensions.dash-to-dock dash-max-icon-size

#1 zoom
kz-gset --addfavaft=kz-zoom
#2 kz-gset --delfav=kz-zoom

