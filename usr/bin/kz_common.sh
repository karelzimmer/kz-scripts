# shellcheck shell=bash source=/dev/null
###############################################################################
# SPDX-FileComment: Common module for kz Bourne-Again shell scripts
#
# SPDX-FileCopyrightText: Karel Zimmer <info@karelzimmer.nl>
# SPDX-License-Identifier: CC0-1.0
###############################################################################


###############################################################################
# Imports
###############################################################################

export TEXTDOMAIN=kz
export TEXTDOMAINDIR=/usr/share/locale
source /usr/bin/gettext.sh


###############################################################################
# Constants
###############################################################################

readonly MODULE_NAME='kz_common.sh'
MODULE_DESC=$(gettext 'Common module for shell scripts')
# shellcheck disable=SC2034
readonly MODULE_DESC

# shellcheck disable=SC2034
readonly OPTIONS_USAGE='[-h|--help] [-m|--manual] [-u|--usage] [-v|--version]'

OPTIONS_HELP="$(gettext '  -h, --help     show this help text')
$(gettext '  -m, --manual   show manual page')
$(gettext '  -u, --usage    show a short usage summary')
$(gettext '  -v, --version  show program version')"
# shellcheck disable=SC2034
readonly OPTIONS_HELP

# shellcheck disable=SC2034
readonly OPTIONS_SHORT='hmuv'
# shellcheck disable=SC2034
readonly OPTIONS_LONG='help,manual,usage,version'

readonly OK=0
readonly ERR=1

# List NORMAL last here so that -x doesn't bork the display.
# shellcheck disable=SC2034
readonly BOLD='\033[1m'
readonly RED='\033[1;31m'
readonly NORMAL='\033[0m'

if ! type systemctl &> /dev/null; then
    rm --force getkz getkz.{1..99}
    printf '%s\n' "$(gettext 'fatal: no systemd available')" >&2
    exit $ERR
fi

if ! [[ -f /etc/os-release ]]; then
    rm --force getkz getkz.{1..99}
    printf '%s\n' "$(gettext 'fatal: no os release available')" >&2
    exit $ERR
fi


###############################################################################
# Functions
###############################################################################

# This function checks whether the script is started as user root and restarts
# the script as user root if not.
function become_root() {
    local PROGRAM_ID=${PROGRAM_NAME/kz /kz-}
    # pkexec needs fully qualified path to the program to be executed.
    local PKEXEC_PROGRAM=/usr/bin/$PROGRAM_ID
    local TEXT=''
    local -i RC=$OK

    become_root_check || exit $OK

    if [[ $UID -ne 0 ]]; then
        export DISPLAY
        if $OPTION_GUI; then
            xhost +si:localuser:root |& $LOGCMD
            TEXT="Restart (pkexec $PKEXEC_PROGRAM ${COMMANDLINE_ARGS[*]})..."
            logmsg "$TEXT"
            # Because $PKEXEC_PROGRAM will be started again, do not trap twice.
            trap - ERR EXIT SIGHUP SIGINT SIGPIPE SIGTERM
            pkexec "$PKEXEC_PROGRAM" "${COMMANDLINE_ARGS[@]}" || RC=$?
            exit $RC
        else
            TEXT="Restart (exec sudo $PROGRAM_ID ${COMMANDLINE_ARGS[*]})..."
            logmsg "$TEXT"
            exec sudo "$PROGRAM_ID" "${COMMANDLINE_ARGS[@]}"
        fi
    fi
}


# This function checks if the user is allowed to become root and returns 0 if
# so, otherwise returns 1 with descriptive message.
function become_root_check() {
    local TEXT=''

    if [[ $UID -eq 0 ]]; then
        return $OK
    elif groups "$USER" | grep --quiet --regexp='sudo' --regexp='wheel'; then
        return $OK
    else
        TEXT=$(gettext 'Already performed by the administrator.')
        infomsg "$TEXT"
        return $ERR
    fi
}


# This function checks for another running package manager and waits for the
# next check if so.
function check_package_manager() {
    local TEXT=''
    local -i CHECK_WAIT=10

    if grep --quiet rhel /etc/os-release; then
        return $OK
    fi

    while sudo  fuser                           \
                --silent                        \
                /var/cache/debconf/config.dat   \
                /var/{lib/{dpkg,apt/lists},cache/apt/archives}/lock*; do
        TEXT=$(gettext 'Wait for another package manager to finish')
        if $OPTION_GUI; then
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
function errmsg() {
    local TITLE=''

    if $OPTION_GUI; then
        TITLE="$PROGRAM_DESC $(gettext 'error message') ($PROGRAM_NAME)"
        zenity  --error                 \
                --width     600         \
                --height    100         \
                --title     "$TITLE"    \
                --text      "$*"        2> /dev/null || true
    else
        printf "${RED}%b${NORMAL}\n" "$*" >&2
    fi
}


# This function returns an informational message.
function infomsg() {
    local TITLE=''

    if $OPTION_GUI; then
        TITLE="$PROGRAM_DESC $(gettext 'information') ($PROGRAM_NAME)"
        zenity  --info                  \
                --width     600         \
                --height    100         \
                --title     "$TITLE"    \
                --text      "$*"        2> /dev/null || true
    else
        printf '%b\n' "$*"
    fi
}


# This function performs initial actions such as set traps (script-hardening).
function init() {
    local PROGRAM_ID=${PROGRAM_NAME/kz /kz-}
    local TEXT="==== START logs for script $PROGRAM_ID ====
Started ($PROGRAM_ID $* as $USER)."
    local -g  ERREXIT=true
    local -g  LOGCMD="systemd-cat --identifier=$PROGRAM_ID"
    local -g  OPTION_GUI=false
    local -g  KZ_PID_FILE=''
    local -g  RC=$OK
    local -ga COMMANDLINE_ARGS=("$@")

    # Script-hardening.
    set -o errexit
    set -o errtrace
    set -o nounset
    set -o pipefail

    trap 'term_sig err     $LINENO ${FUNCNAME:--} "$BASH_COMMAND" $?' ERR
    trap 'term_sig exit    $LINENO ${FUNCNAME:--} "$BASH_COMMAND" $?' EXIT
    trap 'term_sig sighup  $LINENO ${FUNCNAME:--} "$BASH_COMMAND" $?' SIGHUP
    trap 'term_sig sigint  $LINENO ${FUNCNAME:--} "$BASH_COMMAND" $?' SIGINT
    trap 'term_sig sigpipe $LINENO ${FUNCNAME:--} "$BASH_COMMAND" $?' SIGPIPE
    trap 'term_sig sigterm $LINENO ${FUNCNAME:--} "$BASH_COMMAND" $?' SIGTERM

    logmsg "$TEXT"
}


# This function records a message to the log.
function logmsg() {
    printf '%b\n' "$*" |& $LOGCMD
}


# This function handles the common options and arguments.
function process_options() {
    while true; do
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
function process_option_help() {
    local PROGRAM_ID=${PROGRAM_NAME/kz /kz-}
    local TEXT=''
    local YELP_MAN_URL=''

    if [[ ${DISPLAY-} ]]; then
        YELP_MAN_URL="$(gettext ', or see the ')"
        YELP_MAN_URL+="\033]8;;man:$PROGRAM_ID\033\\$PROGRAM_ID "
        YELP_MAN_URL+="$(gettext 'man page')\033]8;;\033\\"
    fi

    TEXT="$(eval_gettext "Type '\$PROGRAM_NAME --manual' or 'man \
\$PROGRAM_NAME'\$YELP_MAN_URL for more information.")"
    infomsg "$HELP

$TEXT"
}


# This function displays the manual page.
function process_option_manual() {
    local PROGRAM_ID=${PROGRAM_NAME/kz /kz-}

    if [[ ${DISPLAY-} ]]; then
        yelp man:"$PROGRAM_ID" 2> /dev/null
    else
        man --pager=cat "$PROGRAM_NAME"
    fi
}


# This function shows the available options.
function process_option_usage() {
    local TEXT=''

    TEXT="$(eval_gettext "Type '\$PROGRAM_NAME --help' for more information.")"
    infomsg "$USAGE

$TEXT"
}


# This function displays version, author, and license information.
function process_option_version() {
    local BUILD_ID='' # ISO 8601 YYYY-MM-DDTHH:MM:SS
    local TEXT=''

    if [[ -f /usr/share/doc/kz/build.id ]]; then
        BUILD_ID=$(cat /usr/share/doc/kz/build.id)
    else
        TEXT=$(gettext 'Build ID cannot be determined.')
        logmsg "$TEXT"
        # shellcheck disable=SC2034
        BUILD_ID=$TEXT
    fi

    TEXT="$(eval_gettext "kz version 4.2.1 (built \$BUILD_ID).")

$(gettext 'Written by Karel Zimmer <info@karelzimmer.nl>.')
$(gettext "License CC0 1.0 \
<https://creativecommons.org/publicdomain/zero/1.0>.")"
    infomsg "$TEXT"
}


# This function controls the termination.
function term_sig() {
    local SIGNAL=$1
    local -i LINENO=$2
    local FUNCTION=$3
    local COMMAND=$4
    local -i RC=$5

    local PROGRAM_ID=${PROGRAM_NAME/kz /kz-}
    local RC_DESC=''
    local STATUS=$RC/error
    local TEXT=''
    local -i RC_DESC_SIGNALNO=0

    rm --force "$KZ_PID_FILE"
    if [[ $PROGRAM_ID = 'kz-get' ]]; then
        logmsg "Delete getkz files ($MODULE_NAME)..."
        rm --force getkz getkz.{1..99}
        logmsg "Deleted getkz files ($MODULE_NAME)."
    fi

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
            if grep --quiet debian /etc/os-release; then
                RC_DESC='apt/dpkg exited with error'
            elif grep --quiet rhel /etc/os-release; then
                RC_DESC='there are updates available'
            else
                RC_DESC="previous errors/it didn't work"
            fi
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
            RC_DESC_SIGNALNO=$(( RC - 128 ))
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
            RC_DESC_SIGNALNO=$(( RC - 128 ))
            RC_DESC="typ 'trap -l' and look for $RC_DESC_SIGNALNO"
            ;;
        200 )
            # Red Hat or Red Hat-based system.
            RC_DESC='There was a problem with acquiring or releasing of locks.'
            ;;
        255 )
            RC_DESC='exit status out of range'
            ;;
        * )
            RC_DESC='unknown error'
            ;;
    esac

    TEXT="Signal: $SIGNAL, line: $LINENO, function: $FUNCTION, command: \
$COMMAND, code: $RC ($RC_DESC)."
    logmsg "$TEXT"

    case $SIGNAL in
        err )
            if $ERREXIT; then
                TEXT="
$(eval_gettext "Program \$PROGRAM_ID encountered an error.")"
                errmsg "$TEXT"
            fi
            exit "$RC"
            ;;
        exit )
            TEXT="Ended (code=exited, status=$STATUS).
==== END logs for script $PROGRAM_NAME ===="
            logmsg "$TEXT"
            trap - ERR EXIT SIGHUP SIGINT SIGPIPE SIGTERM
            exit "$RC"
            ;;
        * )
            TEXT="
$(eval_gettext "Program \$PROGRAM_ID has been interrupted.")"
            errmsg "$TEXT"
            exit "$RC"
            ;;
    esac
}


# This function waits for the user to press Enter.
function wait_for_enter() {
    local PROMPT=''

    PROMPT="$(gettext 'Press the Enter key to continue [Enter]: ')"
    logmsg "$PROMPT"
    printf '\n'
    read -rp "$PROMPT" < /dev/tty
    printf '\n'
}
