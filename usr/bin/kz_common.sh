# This module provides global variables and functions.
#
# shellcheck shell=bash source=/dev/null disable=SC2155,SC2034
###############################################################################
# SPDX-FileComment: Common module for Bourne-Again shell scripts
#
# SPDX-FileCopyrightText: Karel Zimmer <info@karelzimmer.nl>
# SPDX-License-Identifier: CC0-1.0
###############################################################################


###############################################################################
# Import
###############################################################################

export TEXTDOMAIN=kz
export TEXTDOMAINDIR=/usr/share/locale
source /usr/bin/gettext.sh


###############################################################################
# Constants
###############################################################################

readonly MODULE_NAME='kz_common.sh'
readonly MODULE_DESC=$(gettext 'Common module for shell scripts')
readonly MODULE_PATH=$(dirname "$(realpath "$0")")

readonly OK=0
readonly ERROR=1

readonly NORMAL='\033[0m'
readonly BOLD='\033[1m'

readonly RED='\033[1;31m'
readonly GREEN='\033[1;32m'
readonly YELLOW='\033[1;33m'

readonly OPTIONS_USAGE="[-h|--help] [-m|--manual] [-u|--usage] [-v|--versio\
n]"
readonly OPTIONS_HELP="$(gettext '  -h, --help     give this help list')
$(gettext '  -m, --manual   show manual page')
$(gettext '  -u, --usage    give a short usage message')
$(gettext '  -v, --version  print program version')"

readonly OPTIONS_SHORT='hmuv'
readonly OPTIONS_LONG='help,manual,usage,version'

readonly DISTRO=$(lsb_release --id --short | tr '[:upper:]' '[:lower:]')
if  type gnome-session &> /dev/null ||
    type lxqt-session  &> /dev/null ||
    type xfce4-session &> /dev/null; then
readonly EDITION='desktop'
else
readonly EDITION='server'
fi


###############################################################################
# Variables
###############################################################################

declare     errexit=true
declare     kz_deb_local_file=''
declare     option_gui=false
declare     text=''
declare     title=''
declare -a  commandline_args=()

###############################################################################
# Functions
###############################################################################

# This function checks whether the script is started as user root and restarts
# the script as user root if not.
function become_root {
    local   -i  pkexec_rc=0
    local       program_exec=$MODULE_PATH/$PROGRAM_NAME

    become_root_check || exit $OK

    if [[ $UID -ne 0 ]]; then
        if $option_gui; then
            export DISPLAY=:0.0
            xhost +si:localuser:root |& $LOGCMD
            msg_log "restart (pkexec $program_exec ${commandline_args[*]})"
            pkexec "$program_exec" "${commandline_args[@]}" || pkexec_rc=$?
            exit $pkexec_rc
        else
            msg_log "restart (exec sudo $program_exec ${commandline_args[*]})"
            exec sudo "$program_exec" "${commandline_args[@]}"
        fi
    fi
}


# This function checks if the user is allowed to become root and returns 0 if
# so, otherwise returns 1 with descriptive message.
function become_root_check {
    if [[ $UID -eq 0 ]]; then
        return $OK
    elif groups "$USER" | grep --quiet --regexp='sudo'; then
        return $OK
    else
        text=$(gettext 'Already performed by the administrator.')
        msg_info "$text"
        return $ERROR
    fi
}


# This function checks for active updates and waits for the next check if so.
function check_for_active_updates {
    while sudo  fuser                                       \
                /snap/core/*/var/cache/debconf/config.dat   \
                /var/cache/apt/archives/lock                \
                /var/cache/debconf/config.dat               \
                /var/lib/apt/lists/lock                     \
                /var/lib/dpkg/lock                          \
                /var/lib/dpkg/lock-frontend                 \
                &> /dev/null; do
        text="$(gettext 'Wait for another package manager to finish...')"
        msg_log "$text"
        sleep 1
    done
}


# This function checks to see if the computer is running on battery power and
# prompts the user to continue if so.
function check_on_ac_power {
    local   -i  on_battery=0

    on_ac_power |& $LOGCMD || on_battery=$?
    if [[ on_battery -eq 1 ]]; then
        text=$(gettext "The computer now uses only the battery for power.

It is recommended to connect the computer to the wall socket.")
        msg_warning "$text"
        $option_gui || wait_for_enter
    fi
}


# This function performs initial actions such as set traps (script-hardening).
function init_script {
    # Script-hardening.
    set -o errexit
    set -o errtrace
    set -o nounset
    set -o pipefail

    readonly LOGCMD="systemd-cat --identifier=$PROGRAM_NAME"

    trap 'signal err     $LINENO ${FUNCNAME:--} "$BASH_COMMAND" $?' ERR
    trap 'signal exit    $LINENO ${FUNCNAME:--} "$BASH_COMMAND" $?' EXIT
    trap 'signal sighup  $LINENO ${FUNCNAME:--} "$BASH_COMMAND" $?' SIGHUP
    trap 'signal sigint  $LINENO ${FUNCNAME:--} "$BASH_COMMAND" $?' SIGINT
    trap 'signal sigpipe $LINENO ${FUNCNAME:--} "$BASH_COMMAND" $?' SIGPIPE
    trap 'signal sigterm $LINENO ${FUNCNAME:--} "$BASH_COMMAND" $?' SIGTERM

    text="==== START logs for script $PROGRAM_NAME ====
started ($MODULE_PATH/$PROGRAM_NAME $* as $USER)"
    msg_log "$text"

    commandline_args=("$@")
    readonly USAGE_LINE=$(eval_gettext "Type '\$DISPLAY_NAME --usage' for more\
 information.")
}


# This function returns an error message.
function msg_error {
    if $option_gui; then
        title=$(eval_gettext "Error message \$DISPLAY_NAME (\$PROGRAM_DESC)")
        zenity  --error                 \
                --width     600         \
                --height    100         \
                --title     "$title"    \
                --text      "$*"        2> >($LOGCMD) || true
    else
        printf "$RED%b$NORMAL\n" "$*" >&2
    fi
}


# This function returns an informational message.
function msg_info {
    if $option_gui; then
        title=$(eval_gettext "Information \$DISPLAY_NAME (\$PROGRAM_DESC)")
        zenity  --info                  \
                --width     600         \
                --height    100         \
                --title     "$title"    \
                --text      "$*"        2> >($LOGCMD) || true
    else
        printf '%b\n' "$*"
    fi
}


# This function records a message to the log.
function msg_log {
    printf '%b\n' "$*" |& $LOGCMD
}


# This function returns a warning message.
function msg_warning {
    if $option_gui; then
        title=$(eval_gettext "Warning \$DISPLAY_NAME (\$PROGRAM_DESC)")
        zenity  --warning               \
                --width     600         \
                --height    100         \
                --title     "$title"    \
                --text      "$*"        2> >($LOGCMD) || true
    else
        printf "$YELLOW%b$NORMAL\n" "$*" >&2
    fi
}


# This function covers the general options.
function process_common_options {
    while true; do
        case $1 in
            -h|--help)
                process_option_help
                exit $OK
                ;;
            -m|--manual)
                process_option_manual
                exit $OK
                ;;
            -u|--usage)
                process_option_usage
                exit $OK
                ;;
            -v|--version)
                process_option_version
                exit $OK
                ;;
            --)
                break
                ;;
            *)
                shift
                ;;
        esac
    done
}


# This function shows the available help.
function process_option_help {
    local   man_url="\033]8;;man:$PROGRAM_NAME(1)\033\\$DISPLAY_NAME "
            man_url+="$(gettext 'man page')\033]8;;\033\\"

    text="$(eval_gettext "Type '\$DISPLAY_NAME --manual' or 'man \$DISPLAY_NAM\
E', or see the \$man_url for more information.")"
    printf  '%b\n\n%b\n'    \
            "$HELP"         \
            "$text"
}


# This function displays the manual page.
function process_option_manual {
    yelp man:"$PROGRAM_NAME" &> /dev/null || man --pager=cat "$PROGRAM_NAME"
}


# This function shows the available options.
function process_option_usage {
    text="$(eval_gettext "Type '\$DISPLAY_NAME --help' for more information.")"
    printf  '%b\n\n%b\n'    \
            "$USAGE"        \
            "$text"
}


# This function displays version, author, and license information.
function process_option_version {
    local   build_id=''

    if [[ -e /etc/kz-build.id ]]; then
        build_id=$(cat /etc/kz-build.id)
    else
        text=$(gettext 'Build ID cannot be determined')
        msg_log "$text"
        build_id=$text
    fi

    text="$(eval_gettext "kz version 4.2.1 (built \$build_id).")

$(gettext 'Written by Karel Zimmer <info@karelzimmer.nl>.')
$(gettext "CC0 1.0 Universal <https://creativecommons.org/publicdomain/zero/1.\
0>.")"
    msg_info "$text"
}


# This function processes the signals for which the trap was set by function
# init_script (script-hardening).
function signal {
    local       signal=${1:-unknown}
    local   -i  lineno=${2:-unknown}
    local       function=${3:-unknown}
    local       command=${4:-unknown}
    local   -i  rc=${5:-$ERROR}
    local       rc_desc=''
    local   -i  rc_desc_signalno=0
    local       status=$rc/error

    case $rc in
        0)
            rc_desc='successful termination'
            status=$rc/OK
            ;;
        1)
            rc_desc='terminated with error'
            ;;
        6[4-9]|7[0-8])                  # 64--78
            rc_desc="open file '/usr/include/sysexits.h' and look for '$rc'"
            ;;
        126)
            rc_desc='command cannot execute'
            ;;
        127)
            rc_desc='command not found'
            ;;
        128)
            rc_desc='invalid argument to exit'
            ;;
        129)                            # SIGHUP (128+1)
            rc_desc='hangup'
            ;;
        130)                            # SIGINT (128+2)
            rc_desc='terminated by control-c'
            ;;
        13[1-9]|140)                    # 140 (128+12)
            rc_desc_signalno=$((rc - 128))
            rc_desc="typ 'trap -l' and look for $rc_desc_signalno"
            ;;
        141)                            # SIGPIPE (128+13)
            rc_desc='broken pipe: write to pipe with no readers'
            ;;
        142)                            # SIGALRM (128+14)
            rc_desc='timer signal from alarm'
            ;;
        143)                            # SIGTERM (128+15)
            rc_desc='termination signal'
            ;;
        14[4-9]|1[5-8][0-9]|19[0-2])    # 144 (128+16)--192 (128+64)
            rc_desc_signalno=$((rc - 128))
            rc_desc="typ 'trap -l' and look for $rc_desc_signalno"
            ;;
        255)
            rc_desc='exit status out of range'
            ;;
        *)
            rc_desc='unknown error'
            ;;
    esac
    text="signal: $signal, line: $lineno, function: $function, command: "
    text+="$command, code: $rc ($rc_desc)"
    msg_log "$text"

    case $signal in
        err)
            if $errexit; then
                text=$(eval_gettext "Program \$PROGRAM_NAME encountered an err\
or.")
                msg_error "$text"
                exit "$rc"
            fi
            ;;
        exit)
            # Cleanup kz-getdeb files.
            rm  --force                 \
                --verbose               \
                getdeb                  \
                getdeb.{1..99}          \
                "$kz_deb_local_file"    |& $LOGCMD
            text="ended (code=exited, status=$status)
==== END logs for script $PROGRAM_NAME ===="
            msg_log "$text"
            trap - ERR EXIT SIGHUP SIGINT SIGPIPE SIGTERM
            exit "$rc"
            ;;
        *)
            text=$(eval_gettext "Program \$PROGRAM_NAME has been interrupted.")
            msg_error "$text"
            exit "$rc"
            ;;
    esac
}


# This function waits for the user to press Enter.
function wait_for_enter {
    local prompt="$(gettext 'Press the Enter key to continue [Enter]: ')"

    msg_log "$prompt"
    read -rp "$prompt" < /dev/tty
}
