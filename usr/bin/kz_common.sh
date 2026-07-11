# shellcheck shell=bash source=/dev/null disable=SC2034,SC2154
# #############################################################################
# SPDX-FileComment: Common module for kz Bash scripts
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
readonly BOLD='\033[1m'
readonly GREEN='\033[1;32m'
readonly RED='\033[1;31m'
readonly NORMAL='\033[0m'

# Where the the code is stored locally.
GITROOT=$(xdg-user-dir PROJECTS)
readonly GITROOT


# #############################################################################
# Globals
# #############################################################################


# #############################################################################
# Functions
# #############################################################################

# This function returns an error message.
function kz.errmsg() {
    kz.logmsg "$*"
    if [[ ${UI_MODE-} = 'gui' ]]; then
        # shellcheck disable=SC2154
        zenity  --error                     \
                --width     600             \
                --height    100             \
                --title     "$PROGRAM_DESC" \
                --text      "$*"            \
                2> /dev/null                || true
    elif [[ ${UI_MODE-} = 'tui' ]]; then
        # This tput locks the cursor position top-left to prevent flickering.
        tput cup 0 0
        # shellcheck disable=SC2153,SC2154
        dialog  --colors                    \
                --backtitle "$PROGRAM_NAME" \
                --title     "$PROGRAM_DESC" \
                --msgbox    "\Zb\Z1$*\Zn"   \
                0 0                         || true
    else
        printf "$RED%b$NORMAL\n" "$*" >&2
    fi
}


# This function returns an informational message.
function kz.infomsg() {
    kz.logmsg "$*"
    if [[ ${UI_MODE-} = 'gui' ]]; then
        zenity  --info                      \
                --width     600             \
                --height    100             \
                --title     "$PROGRAM_DESC" \
                --text      "$*"            \
                2> /dev/null                || true
    elif [[ ${UI_MODE-} = 'tui' ]]; then
        # This tput locks the cursor position top-left to prevent flickering.
        tput cup 0 0
        dialog  --backtitle "$PROGRAM_NAME" \
                --title     "$PROGRAM_DESC" \
                --msgbox    "$*"            \
                0 0                         || true
    else
        printf '%b\n' "$*"
    fi
}


# This function performs initial actions.
function kz.init() {
    local text=''

    # Check if systemd is available .
    if ! type systemctl &> /dev/null; then
        printf  "$RED%s$NORMAL\n"   \
                "$(gettext 'fatal: no systemd available')" >&2
        exit 1
    fi

    # Check if os release is available.
    if ! [[ -f /etc/os-release ]]; then
        printf  "$RED%s$NORMAL\n"   \
                "$(gettext 'fatal: no os release available')" >&2
        exit 1
    fi

    # Check if started as root.
    if [[ $UID -eq 0 ]]; then
        printf  "$RED%s$NORMAL\n"   \
                "$(gettext 'fatal: must not be run as root')" >&2
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

    text="\
==== START logs for script $PROGRAM_NAME ====================================="
    kz.logmsg "$text"
    text="Started ($0 $* as $USER)."
    kz.logmsg "$text"
}


# This function records an informational message to the log.
function kz.logmsg() {
    printf '%b\n' "$*" |& $PROGRAM_LOGS
}


# This function shows the available help.
function kz.process_option_help() {
    local program_name=${PROGRAM_NAME/kz-/kz }
    local text=''
    local yelp_man=''
    local yelp_man_url=''

    if [[ -n ${XDG_CURRENT_DESKTOP-} ]]; then
        yelp_man_url="\033]8;;man:$PROGRAM_NAME(1)\033\\$program_name(1)"
        yelp_man=$(eval_gettext ", or see the \$yelp_man_url man page")
        yelp_man+="\033]8;;\033\\"
    fi

    text="$(eval_gettext "Type '\$program_name --manual' or 'man \
\$program_name'\$yelp_man for more information.")"
    UI_MODE='cli'
    # shellcheck disable=SC2154
    kz.infomsg "$HELP

$text"
}


# This function displays the manual page.
function kz.process_option_manual() {
    if [[ -n ${XDG_CURRENT_DESKTOP-} ]]; then
        yelp man:"$PROGRAM_NAME" 2> /dev/null
    else
        man "$PROGRAM_NAME"
    fi
}


# This function shows the available options.
function kz.process_option_usage() {
    local program_name=${PROGRAM_NAME/kz-/kz }
    local text=''

    # shellcheck disable=SC2154
    text="$USAGE

$(eval_gettext "Type '\$program_name --help' for more information.")"
    UI_MODE='cli'
    kz.infomsg "$text"
}


# This function displays version, author, and license information.
function kz.process_option_version() {
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
}


# This function controls the termination of the scripts.
function kz.term() {
    local signal=$1
    local -i lineno=$2
    local function=$3
    local command=$4
    local -i rc=$5

    local -i rc_desc_signalno=0
    local rc_desc=''
    local status=$rc/FAILURE
    local text=''

    case $rc in
        0 )
            rc_desc='successful termination'
            status=0/SUCCESS
            ;;
        1 )
            rc_desc='terminated with error'
            ;;
        6[4-9] | 7[0-8] )                   # 64--78
            rc_desc="open file '/usr/include/sysexits.h' and look for '$rc'"
            ;;
        100 )
            if grep --quiet --regexp='debian' /etc/os-release; then
                rc_desc='apt/dpkg exited with error'
            elif grep --quiet --regexp='rhel\|fedora' /etc/os-release; then
                rc_desc='there are updates available'
            else
                rc_desc="previous errors/it didn't work"
            fi
            ;;
        126 )
            rc_desc='command cannot execute'
            ;;
        127 )
            rc_desc='command not found'
            ;;
        128 )
            rc_desc='invalid argument to exit'
            ;;
        129 )                               # SIGHUP (128 + 1)
            rc_desc='hangup'
            ;;
        130 )                               # SIGINT (128 + 2)
            rc_desc='terminated by control-c'
            ;;
        13[1-9] | 140 )                     # 131 (128 + 3)--140 (128 + 12)
            rc_desc_signalno=$(( rc - 128 ))
            rc_desc="typ 'trap -l' and look for $rc_desc_signalno"
            ;;
        141 )                               # SIGPIPE (128 + 13)
            rc_desc='broken pipe: write to pipe with no readers'
            ;;
        142 )                               # SIGALRM (128 + 14)
            rc_desc='timer signal from alarm'
            ;;
        143 )                               # SIGTERM (128 + 15)
            rc_desc='termination signal'
            ;;
        14[4-9] | 1[5-8][0-9] | 19[0-2])    # 144 (128 + 16)--192 (128 + 64)
            rc_desc_signalno=$(( rc - 128 ))
            rc_desc="typ 'trap -l' and look for $rc_desc_signalno"
            ;;
        200 )
            # Red Hat or Red Hat-based system.
            rc_desc='There was a problem with acquiring or releasing of locks.'
            ;;
        255 )
            rc_desc='exit status out of range'
            ;;
        * )
            rc_desc='unknown error'
            ;;
    esac

    text="Signal: $signal, line: $lineno, function: $function, "
    text+="command: $command, exit code: $rc ($rc_desc)."
    kz.logmsg "$text"

    case $signal in
        err )
            text="$(eval_gettext \
"Program \$PROGRAM_NAME encountered an error.")"
            kz.errmsg "$text"
            text="$(eval_gettext \
"Error \$rc on line \$lineno in function \$function while executing command: \
\$command")"
            if [[ -z ${XDG_CURRENT_DESKTOP-} ]]; then
                text+="
$(gettext "Use \"journalctl -xe\" to check what went wrong.")"
            else
                text+="
$(gettext "Use \"journalctl -xe\" to check what went wrong.")
$(gettext "The last few lines of the log are displayed here.")
                $(
                    journalctl  --all                           \
                                --catalog                       \
                                --lines                         \
                                --no-pager                      \
                                --pager-end                     \
                                --identifier="$PROGRAM_NAME"
                )"
            fi
            kz.errmsg "$text"
            exit "$rc"
            ;;
        exit )
            if [[ ${UI_MODE-} = 'tui' ]]; then
                clear -x
            fi
            if [[ $rc -eq 0 ]]; then
                text='Cleaning up temporary files...'
                kz.logmsg "$text"
                rm --force --verbose /tmp/"$PROGRAM_NAME"-* |& $PROGRAM_LOGS
            fi
            text="Ended (code=exited, status=$status)."
            kz.logmsg "$text"
            text="\
==== END logs for script $PROGRAM_NAME ======================================="
            kz.logmsg "$text"
            trap - ERR EXIT SIGHUP SIGINT SIGTERM
            exit "$rc"
            ;;
        * )
            if [[ ${UI_MODE-} = 'tui' ]]; then
                reset
            fi
            text="$(eval_gettext \
"Program \$PROGRAM_NAME has been interrupted.")"
            kz.errmsg "$text"
            exit "$rc"
            ;;
    esac
}
