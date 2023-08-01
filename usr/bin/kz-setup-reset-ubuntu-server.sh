# shellcheck shell=bash
###############################################################################
# Standard reset file for Ubuntu server.
#
# This script file is used by script kz-setup.
# Use 'man kz setup' for more information.
#
# Written by Karel Zimmer <info@karelzimmer.nl>, CC0 1.0 Universal
# <https://creativecommons.org/publicdomain/zero/1.0>, 2023.
###############################################################################

#  APP terminal
# USER *
sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc
