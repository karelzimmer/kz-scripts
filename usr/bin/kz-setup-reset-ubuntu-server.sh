# shellcheck shell=bash
###############################################################################
# Standard reset file for Ubuntu server.
#
# Written by Karel Zimmer <info@karelzimmer.nl>, CC0 1.0 Universal
# <https://creativecommons.org/publicdomain/zero/1.0>, 2023.
###############################################################################

# APP terminal *
sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc
