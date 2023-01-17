# shellcheck shell=bash
###############################################################################
# Instelbestand voor Ubuntu desktop op pc01 voor monique.
#
# Geschreven in 2013 door Karel Zimmer <info@karelzimmer.nl>, Creative Commons
# Publiek Domein Verklaring <http://creativecommons.org/publicdomain/zero/1.0>.
###############################################################################

#1-gnome (bureaubladomgeving) [Ubuntu pc01 monique]
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 32
#2 gsettings reset org.gnome.shell.extensions.dash-to-dock dash-max-icon-size

#1 zoom (samenwerken)
kz-gset --addfavaft=zoom-client_zoom-client
#2 kz-gset --delfav=zoom-client_zoom-client

