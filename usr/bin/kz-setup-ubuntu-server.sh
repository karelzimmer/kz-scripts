# shellcheck shell=bash
###############################################################################
# SPDX-FileComment: Set up file for Ubuntu server
#
# SPDX-FileCopyrightText: Karel Zimmer <info@karelzimmer.nl>
# SPDX-License-Identifier: CC0-1.0
###############################################################################

# Setup APP lynis USER -nouser
git clone https://github.com/CISOfy/lynis /home/"$USER"/lynis || true
: # Usage:
: # $ cd ~/lynis
: # $ [sudo] ./lynis audit system

# Reset APP lynis USER -nouser
rm --force --verbose --recursive --verbose /home/"$USER"/lynis


# Setup APP terminal USER *
: # Search forward in history (with Ctrl-S).
sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc
echo 'stty -ixon  # Enable fwd search history (i-search)' >> "$HOME"/.bashrc

# Reset APP terminal USER *
sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc
