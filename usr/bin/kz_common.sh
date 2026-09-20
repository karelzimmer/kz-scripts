# shellcheck shell=bash source=/dev/null disable=SC2034,SC2154
# #############################################################################
# SPDX-FileComment: Common module for kz Bash scripts.
#
# SPDX-FileCopyrightText: Karel Zimmer <info@karelzimmer.nl>
# SPDX-License-Identifier: CC0-1.0
# #############################################################################


# #############################################################################
# Imports
# #############################################################################

export TEXTDOMAIN='kz'
export TEXTDOMAINDIR='/usr/share/locale'
source /usr/bin/gettext.sh


# #############################################################################
# Constants
# #############################################################################

# List NORMAL last here so that -x doesn't bork the display.
readonly BLUE='\033[1;34m'
readonly GREEN='\033[1;32m'
readonly RED='\033[1;31m'
readonly NORMAL='\033[0m'


# #############################################################################
# Functions
# #############################################################################

# This function returns an error message.
kz.errmsg() {
    kz.logmsg "${RED}$*${NORMAL}"
    if [[ ${UI_MODE-} = 'gui' ]]; then
        # shellcheck disable=SC2154
        zenity  --error                     \
                --no-markup                 \
                --width     600             \
                --height    100             \
                --title     "$PROGRAM_DESC" \
                --text      "$*"            \
                2> /dev/null                || true
    elif [[ ${UI_MODE-} = 'tui' ]]; then
        # This tput locks the cursor position top-left to prevent flickering.
        tput cup 0 0
        # shellcheck disable=SC2153,SC2154
        dialog  --mouse                     \
                --colors                    \
                --backtitle "$PROGRAM_NAME" \
                --title     "$PROGRAM_DESC" \
                --msgbox    "\Zb\Z1$*\Zn"   \
                0 0                         || true
    else
        printf "${RED}%b${NORMAL}\n" "$*" >&2
    fi
}


# This function returns an informational message.
kz.infomsg() {
    kz.logmsg "$*"
    if [[ ${UI_MODE-} = 'gui' ]]; then
        zenity  --info                      \
                --no-markup                 \
                --width     600             \
                --height    100             \
                --title     "$PROGRAM_DESC" \
                --text      "$*"            \
                2> /dev/null                || true
    elif [[ ${UI_MODE-} = 'tui' ]]; then
        # This tput locks the cursor position top-left to prevent flickering.
        tput cup 0 0
        dialog  --mouse                     \
                --backtitle "$PROGRAM_NAME" \
                --title     "$PROGRAM_DESC" \
                --msgbox    "$*"            \
                0 0                         || true
    else
        printf '%b\n' "$*"
    fi
}


# This function performs initial actions.
kz.init() {
    local bold='\033[1m'
    local text=''

    # Check if systemd is available .
    if ! type systemctl &> /dev/null; then
        printf  "${RED}%s${NORMAL}\n"   \
                "$(gettext 'fatal: no systemd available')" >&2
        exit 1
    fi

    # Check if os release is available.
    if ! [[ -f /etc/os-release ]]; then
        printf  "${RED}%s${NORMAL}\n"   \
                "$(gettext 'fatal: no os release available')" >&2
        exit 1
    fi

    # Script-hardening.
    set -o errexit
    set -o errtrace
    set -o nounset
    set -o pipefail

    # Trap signals.
    # The FUNCNAME variable exists only when a shell function is executing.
    trap 'kz.term err     $LINENO ${FUNCNAME:-n/a} "$BASH_COMMAND" $?' ERR
    trap 'kz.term exit    $LINENO ${FUNCNAME:-n/a} "$BASH_COMMAND" $?' EXIT
    trap 'kz.term sighup  $LINENO ${FUNCNAME:-n/a} "$BASH_COMMAND" $?' SIGHUP
    trap 'kz.term sigint  $LINENO ${FUNCNAME:-n/a} "$BASH_COMMAND" $?' SIGINT
    trap 'kz.term sigterm $LINENO ${FUNCNAME:-n/a} "$BASH_COMMAND" $?' SIGTERM

    text="${bold}START logging for script $PROGRAM_NAME${NORMAL}"
    kz.logmsg "$text"
    text="Started ($0 $* as $USER)."
    kz.logmsg "$text"
}


# This function records a message to the log.
kz.logmsg() {
    local grey='\033[90m'
    local message=''

    message=$*

    # If the log message contains unexpected characters such as line breaks,
    # the parser may consider the log line corrupt and *silently* ignore it.
    # Hence, replace all Line Feeds (\n) with LF, all Carriage Returns (\r)
    # with CR, and all Tabs (\t) with TAB.
    message="${message//$'\n'/LF}"
    message="${message//$'\r'/CR}"
    message="${message//$'\t'/TAB}"

    printf "${grey}%b${NORMAL}\n" "$message" |& $PROGRAM_LOGS
}


# This function handles the common script options.
kz.process_options() {
    while true; do
        case $1 in
            -h | --help )
                kz.process_option_help
                ;;
            -u | --usage )
                kz.process_option_usage
                ;;
            -v | --version )
                kz.process_option_version
                ;;
            -- )
                shift
                break
                ;;
            * )
                shift
                continue
                ;;
        esac
    done
}


# This function shows the available help.
kz.process_option_help() {
    local program_name=${PROGRAM_NAME/kz-/kz }
    local text=''

    text="$(eval_gettext "Type 'man \$program_name' for more information.")"
    UI_MODE='cli'
    # shellcheck disable=SC2154
    kz.infomsg "$HELP

$text"
    exit 0
}


# This function shows the available options.
kz.process_option_usage() {
    local program_name=${PROGRAM_NAME/kz-/kz }
    local text=''

    # shellcheck disable=SC2154
    text="$USAGE

$(eval_gettext "Type '\$program_name --help' for more information.")"
    UI_MODE='cli'
    kz.infomsg "$text"
    exit 0
}


# This function displays version, author, and license information.
kz.process_option_version() {
    local build_id='n/a'  # ISO 8601 YYYY-MM-DDTHH:MM:SS
    local text=''

    if [[ -f /usr/share/doc/kz/build.id ]]; then
        build_id=$(cat /usr/share/doc/kz/build.id)
    fi
    text="$(eval_gettext "kz version 4.2.1 (built \$build_id).")

$(gettext 'Written by Karel Zimmer <info@karelzimmer.nl>.')
$(gettext "License CC0 1.0 \
<https://creativecommons.org/publicdomain/zero/1.0>.")"
    UI_MODE='cli'
    kz.infomsg "$text"
    exit 0
}


# This function controls the termination of the scripts.
kz.term() {
    local signal=$1
    local -i lineno=$2
    local function=$3
    local command=$4
    local -i rc=$5

    text="Signal   : $signal\n"
    text+="Line     : $lineno\n"
    text+="Function : $function\n"
    text+="Command  : $command\n"
    text+="Exit code: $rc"
    kz.logmsg "$text"

    case $signal in
        err )
            kz.term_err
            ;;
        exit )
            kz.term_exit
            ;;
        * )
            kz.term_int
            ;;
    esac
}


# This function processes unexpected command errors in scripts.
kz.term_err() {
    local text=''

    text=$(eval_gettext "Program \$PROGRAM_NAME encountered an error.")
    kz.errmsg "$text"

    exit "$rc"
}


# This function processes scripts exits.
kz.term_exit() {
    local bold='\033[1m'
    local text=''

    if [[ ${UI_MODE-} = 'tui' ]]; then
        reset
        clear -x
    fi

    if [[ $rc -eq 0 ]]; then
        text='Cleaning up temporary files...'
        kz.logmsg "$text"
        rm  --force                 \
            --verbose               \
            /tmp/"$PROGRAM_NAME"-*  |& $PROGRAM_LOGS || true
    fi

    text="${bold}END logging for script $PROGRAM_NAME${NORMAL}"
    kz.logmsg "$text"

    trap - ERR EXIT SIGHUP SIGINT SIGTERM

    exit "$rc"
}


# This function processes standard interruption signals.
kz.term_int() {
    local text=''

    if [[ ${UI_MODE-} = 'tui' ]]; then
        reset
        clear -x
    fi

    text="$(eval_gettext "Program \$PROGRAM_NAME has been interrupted.")"
    kz.errmsg "$text"

    exit "$rc"
}
