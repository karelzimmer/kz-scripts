# This module provides global variables and functions.
#
# shellcheck shell=bash source=/dev/null disable=SC2155,SC2034
###############################################################################
# SPDX-FileComment: Common module for kz Bourne-Again shell scripts
#
# SPDX-FileCopyrightText: Karel Zimmer <info@karelzimmer.nl>
# SPDX-License-Identifier: CC0-1.0
###############################################################################


###############################################################################
# Imports/exports
###############################################################################

export TEXTDOMAIN=kz
export TEXTDOMAINDIR=/usr/share/locale
source /usr/bin/gettext.sh


###############################################################################
# Variables
###############################################################################

declare MODULE_NAME='kz_common.sh'
declare MODULE_DESC=$(gettext 'Common module for shell scripts')

# On a server, $0 is reported as '-bash' (login shell), so remove '-'.
declare PROGRAM_PATH=$(dirname "$(realpath "${0/^-/}")")

declare OK=0
declare ERROR=1

declare NORMAL='\033[0m'
declare BOLD='\033[1m'

declare RED='\033[1;31m'
declare GREEN='\033[1;32m'

declare USAGE
declare OPTIONS_USAGE="[-h|--help] [-m|--manual] [-u|--usage] [-v|--version]"

declare HELP
declare OPTIONS_HELP="$(gettext '  -h, --help     show this help text')
$(gettext '  -m, --manual   show manual page')
$(gettext '  -u, --usage    show a short usage summary')
$(gettext '  -v, --version  show program version')"

declare OPTIONS_SHORT='hmuv'
declare OPTIONS_LONG='help,manual,usage,version'

# Determine whether a desktop environment is available.
if [[ -n $(
    type {{cinnamon,gnome,lxqt,mate,xfce4}-session,ksmserver} 2> /dev/null
    ) ]]
then
    declare DESKTOP_ENVIRONMENT=true
else
    declare DESKTOP_ENVIRONMENT=false
fi

declare ERREXIT=true
declare KZ_DEB_LOCAL_FILE=''
declare OPTION_GUI=false
declare TEXT=''
declare TITLE=''


###############################################################################
# Functions
###############################################################################

# This function checks whether the script is started as user root and restarts
# the script as user root if not.
function become_root {
    local -i PKEXEC_RC=0
    local    PROGRAM_EXEC=$PROGRAM_PATH/$PROGRAM_NAME

    become_root_check || exit $OK

    if [[ $UID -ne 0 ]]
    then
        if $OPTION_GUI
        then
            export DISPLAY
            xhost +si:localuser:root |& $LOGCMD
            TEXT="Restart (pkexec $PROGRAM_EXEC ${COMMANDLINE_ARGS[*]})..."
            logmsg "$TEXT"
            # Because $PROGRAM_EXEC will be started again, do not trap twice.
            trap - ERR EXIT SIGHUP SIGINT SIGPIPE SIGTERM
            pkexec "$PROGRAM_EXEC" "${COMMANDLINE_ARGS[@]}" || PKEXEC_RC=$?
            exit $PKEXEC_RC
        else
            TEXT="Restart (exec sudo $PROGRAM_EXEC ${COMMANDLINE_ARGS[*]})..."
            logmsg "$TEXT"
            exec sudo "$PROGRAM_EXEC" "${COMMANDLINE_ARGS[@]}"
        fi
    fi
}


# This function checks if the user is allowed to become root and returns 0 if
# so, otherwise returns 1 with descriptive message.
function become_root_check {
    if [[ $UID -eq 0 ]]
    then
        return $OK
    elif groups "$USER" | grep --quiet --regexp='sudo'
    then
        return $OK
    else
        TEXT=$(gettext 'Already performed by the administrator.')
        infomsg "$TEXT"
        return $ERROR
    fi
}


# This function checks to see if the computer is running on battery power and
# prompts the user to continue if so.
function check_on_ac_power {
    local -i ON_BATTERY=0

    on_ac_power &> /dev/null || ON_BATTERY=$?
    # Value on_battery:
    #   0 (true)  System is on mains power
    #   1 (false) System is not on mains power
    # 255 (false) Power status could not be determined (e.g. on VM)

    if [[ ON_BATTERY -eq 1 ]]
    then
        TEXT=$(gettext "The computer now uses only the battery for power.

It is recommended to connect the computer to the wall socket.")
        infomsg "$TEXT"
        $OPTION_GUI || wait_for_enter
    fi
}


# This function checks for another running package manager and waits for the
# next check if so.
function check_package_manager {
    local -i CHECK_WAIT=10

    while sudo  fuser                           \
                --silent                        \
                /var/cache/debconf/config.dat   \
                /var/{lib/{dpkg,apt/lists},cache/apt/archives}/lock*
    do
        TEXT=$(gettext 'Wait for another package manager to finish')
        if $OPTION_GUI
        then
            logmsg "$TEXT..."
            # Inform the user in 'zenity --progress' why there is a wait.
            printf '%s\n' "#$TEXT"
        else
            infomsg "$TEXT..."
        fi
        sleep $CHECK_WAIT
    done
}


# This function returns an error message.
function errormsg {
    if $OPTION_GUI
    then
        TITLE=$(eval_gettext "\$PROGRAM_DESC error message (\$DISPLAY_NAME)")
        zenity  --error                 \
                --width     600         \
                --height    100         \
                --title     "$TITLE"    \
                --text      "$*"        2> >($LOGCMD) || true
    else
        printf "${RED}%b${NORMAL}\n" "$*" >&2
    fi
}


# This function returns an informational message.
function infomsg {
    if $OPTION_GUI
    then
        TITLE=$(eval_gettext "\$PROGRAM_DESC information (\$DISPLAY_NAME)")
        zenity  --info                  \
                --width     600         \
                --height    100         \
                --title     "$TITLE"    \
                --text      "$*"        2> >($LOGCMD) || true
    else
        printf '%b\n' "$*"
    fi
}


# This function performs initial actions such as set traps (script-hardening).
function init_script {
    # Script-hardening.
    set -o errexit
    set -o errtrace
    set -o nounset
    set -o pipefail

    declare  -g LOGCMD="systemd-cat --identifier=$PROGRAM_NAME"
    declare -ag COMMANDLINE_ARGS=("$@")

    trap 'term err     $LINENO ${FUNCNAME:--} "$BASH_COMMAND" $?' ERR
    trap 'term exit    $LINENO ${FUNCNAME:--} "$BASH_COMMAND" $?' EXIT
    trap 'term sighup  $LINENO ${FUNCNAME:--} "$BASH_COMMAND" $?' SIGHUP
    trap 'term sigint  $LINENO ${FUNCNAME:--} "$BASH_COMMAND" $?' SIGINT
    trap 'term sigpipe $LINENO ${FUNCNAME:--} "$BASH_COMMAND" $?' SIGPIPE
    trap 'term sigterm $LINENO ${FUNCNAME:--} "$BASH_COMMAND" $?' SIGTERM

    TEXT="==== START logs for script $PROGRAM_NAME ====
Started ($PROGRAM_PATH/$PROGRAM_NAME $* as $USER)."
    logmsg "$TEXT"
}


# This function records a message to the log.
function logmsg {
    printf '%b\n' "$*" |& $LOGCMD
}


# This function handles the common options.
function process_options {
    while true
    do
        case $1 in
            -h | --help )
                process_option_help
                exit $OK
                ;;
            -m | --manual )
                process_option_manual
                exit $OK
                ;;
            -u | --usage )
                process_option_usage
                exit $OK
                ;;
            -v | --version )
                process_option_version
                exit $OK
                ;;
            -- )
                break
                ;;
            * )
                shift
                ;;
        esac
    done
}


# This function shows the available help.
function process_option_help {
    local YELP_MAN_URL=''

    if $DESKTOP_ENVIRONMENT
    then
        YELP_MAN_URL="$(gettext ', or see the ')"
        YELP_MAN_URL+="\033]8;;man:$PROGRAM_NAME(1)\033\\$DISPLAY_NAME(1) "
        YELP_MAN_URL+="$(gettext 'man page')\033]8;;\033\\"
    fi
    TEXT="$(eval_gettext "Type '\$DISPLAY_NAME --manual' or 'man \$DISPLAY_NAM\
E'\$YELP_MAN_URL for more information.")"
    printf '%b\n\n%b\n' "$HELP" "$TEXT"
}


# This function displays the manual page.
function process_option_manual {
    yelp man:"$PROGRAM_NAME" &> /dev/null || man --pager=cat "$PROGRAM_NAME"
}


# This function shows the available options.
function process_option_usage {
    TEXT="$(eval_gettext "Type '\$DISPLAY_NAME --help' for more information.")"
    printf '%b\n\n%b\n' "$USAGE" "$TEXT"
}


# This function displays version, author, and license information.
function process_option_version {
    local BUILD_ID=''

    if [[ -e /etc/kz-build.id ]]
    then
        BUILD_ID=$(cat /etc/kz-build.id)
    else
        TEXT=$(gettext 'Build ID cannot be determined.')
        logmsg "$TEXT"
        BUILD_ID=$TEXT
    fi

    TEXT="$(eval_gettext "kz version 4.2.1 (built \$BUILD_ID).")

$(gettext 'Written by Karel Zimmer <info@karelzimmer.nl>.')
$(gettext "License CC0 1.0 <https://creativecommons.org/publicdomain/zero/1.0>\
.")"
    infomsg "$TEXT"
}


# This function controls the termination.
function term {
    local    SIGNAL=${1:-unknown}
    local -i LINENO=${2:-unknown}
    local    FUNCTION=${3:-unknown}
    local    COMMAND=${4:-unknown}
    local -i RC=${5:-$ERROR}
    local    RC_DESC=''
    local -i RC_DESC_SIGNALNO=0
    local    STATUS=$RC/error

    case $RC in
        0 )
            RC_DESC='successful termination'
            STATUS=$RC/OK
            ;;
        1 )
            RC_DESC='terminated with error'
            ;;
        6[4-9] | 7[0-8] )                   # 64--78
            RC_DESC="open file '/usr/include/sysexits.h' and look for '$RC'"
            ;;
        100 )
            RC_DESC='apt/dpkg exited with error'
            ;;
        126 )
            RC_DESC='command cannot execute'
            ;;
        127 )
            RC_DESC='command not found'
            ;;
        128 )
            RC_DESC='invalid argument to exit'
            ;;
        129 )                               # SIGHUP (128 + 1)
            RC_DESC='hangup'
            ;;
        130 )                               # SIGINT (128 + 2)
            RC_DESC='terminated by control-c'
            ;;
        13[1-9] | 140 )                     # 131 (128 + 3)--140 (128 + 12)
            RC_DESC_SIGNALNO=$((RC - 128))
            RC_DESC="typ 'trap -l' and look for $RC_DESC_SIGNALNO"
            ;;
        141 )                               # SIGPIPE (128 + 13)
            RC_DESC='broken pipe: write to pipe with no readers'
            ;;
        142 )                               # SIGALRM (128 + 14)
            RC_DESC='timer signal from alarm'
            ;;
        143 )                               # SIGTERM (128 + 15)
            RC_DESC='termination signal'
            ;;
        14[4-9] | 1[5-8][0-9] | 19[0-2])    # 144 (128 + 16)--192 (128 + 64)
            RC_DESC_SIGNALNO=$((RC - 128))
            RC_DESC="typ 'trap -l' and look for $RC_DESC_SIGNALNO"
            ;;
        255 )
            RC_DESC='exit status out of range'
            ;;
        * )
            RC_DESC='unknown error'
            ;;
    esac
    TEXT="Signal: $SIGNAL, line: $LINENO, function: $FUNCTION, command: "
    TEXT+="$COMMAND, code: $RC ($RC_DESC)."
    logmsg "$TEXT"

    case $SIGNAL in
        err )
            if $ERREXIT
            then
                TEXT=$(eval_gettext "Program \$PROGRAM_NAME encountered an err\
or.")
                errormsg "$TEXT"
                exit "$RC"
            fi
            ;;
        exit )
            logmsg "Delete kz deb files ($MODULE_NAME)..."
            rm  --force                 \
                --verbose               \
                deb                     \
                deb.{1..99}             \
                "$KZ_DEB_LOCAL_FILE"    |& $LOGCMD
            TEXT="Ended (code=exited, status=$STATUS).
==== END logs for script $PROGRAM_NAME ===="
            logmsg "$TEXT"
            trap - ERR EXIT SIGHUP SIGINT SIGPIPE SIGTERM
            exit "$RC"
            ;;
        * )
            TEXT=$(eval_gettext "Program \$PROGRAM_NAME has been interrupted.")
            errormsg "$TEXT"
            exit "$RC"
            ;;
    esac
}


# This function waits for the user to press Enter.
function wait_for_enter {
    local PROMPT="$(gettext 'Press the Enter key to continue [Enter]: ')"

    logmsg "$PROMPT"
    printf '\n'
    read -rp "$PROMPT" < /dev/tty
    printf '\n'
}
