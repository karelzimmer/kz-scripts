# shellcheck shell=bash
###############################################################################
# SPDX-FileComment: Set up file for Debian server
#
# SPDX-FileCopyrightText: Karel Zimmer <info@karelzimmer.nl>
# SPDX-License-Identifier: CC0-1.0
###############################################################################

# Setup lynis -nouser
git clone https://github.com/CISOfy/lynis /home/"$USER"/lynis || true
# Usage:
# $ cd ~/lynis
# $ [sudo] ./lynis audit system

# Reset lynis -nouser
rm --force --verbose --recursive --verbose /home/"$USER"/lynis


# Setup terminal *
# Turn on aliases.
sed --in-place --expression='s/#alias/alias/g' "$HOME"/.bashrc
# Enable search forward in history (with Ctrl-S).
sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc
echo 'stty -ixon  # Enable fwd search history (i-search)' >> "$HOME"/.bashrc

# Reset terminal *
sed --in-place --expression='s/alias/#alias/g' "$HOME"/.bashrc
sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc
