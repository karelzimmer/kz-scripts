#!/usr/bin/env bash
###############################################################################
# SPDX-FileComment: Install helper script for use with kz-install-extra.gpg
#
# SPDX-FileCopyrightText: Karel Zimmer <info@karelzimmer.nl>
# SPDX-License-Identifier: CC0-1.0
###############################################################################

gpg --import  /usr/share/kz/kz-key.gpg      2> /dev/null
gpg --decrypt /usr/bin/kz-install-extra.gpg 2> /dev/null | grep "$HOSTNAME"
