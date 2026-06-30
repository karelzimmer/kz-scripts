# shellcheck shell=bash disable=SC2034,SC2129
# #############################################################################
# SPDX-FileComment: Settings file for use with kz setup
#
# SPDX-FileCopyrightText: Karel Zimmer <info@karelzimmer.nl>
# SPDX-License-Identifier: CC0-1.0
# #############################################################################

# =============================================================================
# Use "man kz setup.sh" and "man kz setup.sh.gpg" to learn more about the
# format of this file.
# =============================================================================

# SETUP bitwarden
# DESC  A secure and free password manager for all of your devices (*).
# HOST  *
kz-desktop --addaft=com.bitwarden.desktop #1

# RESET bitwarden
kz-desktop --delete=com.bitwarden.desktop #2

# SETUP bitwarden
# DESC  A secure and free password manager for all of your devices (pc06 pc06).
# HOST  pc06 pc07
kz-desktop --addaft=com.bitwarden.desktop #3

# RESET bitwarden
kz-desktop --delete=com.bitwarden.desktop #4

# SETUP bottles
# DESC  Run Windows software.
# HOST  pc06 pc07
kz-desktop --addaft=com.usebottles.bottles

# RESET bottles
kz-desktop --delete=com.usebottles.bottles
