#!/usr/bin/env bash

export TEXTDOMAIN='kz'
export TEXTDOMAINDIR='/usr/share/locale'
source /usr/bin/gettext.sh

# whiptail    --title "Menu example"                                      \
#             --menu "Choose an option"                                   \
#             25 78 16                                                    \
#             "<-- Back"      "Return to the main menu."                  \
#             "Add User"      "Add a user to the system."                 \
#             "Modify User"   "Modify an existing user."                  \
#             "List Users"    "List all users on the system."             \
#             "Add Group"     "Add a user group to the system."           \
#             "Modify Group"  "Modify a group and its list of members."   \
#             "List Groups"   "List all groups on the system."

# Uitlijnen wekt niet ivmveratle
readonly -a  MENU1_ACTIONS=(
            [1]="$(gettext 'Prepare installation')"
                "$(gettext 'Perform installation')"
                "$(gettext 'Finish installation') "
                "$(gettext 'Set up user')         "
                "$(gettext 'Command menu')        "
                "$(gettext 'Exit')                "
            )
readonly -a  MENU1_DESCS=(
            [1]="$(gettext 'Checklist chapter 1')"
                "$(gettext 'Checklist chapter 2')"
                "$(gettext 'Checklist chapter 3')"
                "$(gettext 'Checklist chapter 4')"
                "$(gettext 'Show command menu')"
                "$(gettext 'Exit menu')"
            )
title=$(gettext 'Installation menu')
text=$(gettext 'Select a choice:')
# --menu <text> <height> <width> <listheight> [tag item] ...
REPLY=$(
    whiptail    --title "$title"                            \
                --menu  "$text"                             \
                25 60 10                                    \
                1 "${MENU1_ACTIONS[1]} ${MENU1_DESCS[1]}"   \
                2 "${MENU1_ACTIONS[2]} ${MENU1_DESCS[2]}"   \
                3 "${MENU1_ACTIONS[3]} ${MENU1_DESCS[3]}"   \
                4 "${MENU1_ACTIONS[4]} ${MENU1_DESCS[4]}"   \
                5 "${MENU1_ACTIONS[5]} ${MENU1_DESCS[5]}"   \
                2>&1 >/dev/tty 
    )
echo "You selected: $REPLY"