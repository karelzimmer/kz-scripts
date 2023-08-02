# shellcheck shell=bash source=/dev/null
###############################################################################
# Common module for shell scripts.
#
# This module provides access to general variables and functions.
# Use 'man kz common.sh' for more information.
#
# Written by Karel Zimmer <info@karelzimmer.nl>, CC0 1.0 Universal
# <https://creativecommons.org/publicdomain/zero/1.0>, 2009-2023.
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

# shellcheck disable=SC2034
readonly MODULE_NAME='kz_common.sh'
MODULE_DESC=$(gettext 'Common module for shell scripts')
# shellcheck disable=SC2034
readonly MODULE_DESC

readonly OK=0
readonly ERROR=1

if [[ -n $XDG_CURRENT_DESKTOP ]]; then
    readonly EDITION='desktop'
else
    # shellcheck disable=SC2034
    readonly EDITION='server'
fi

# shellcheck disable=SC2034
OPTIONS_USAGE='[-h|--help] [-u|--usage] [-v|--version]'
# shellcheck disable=SC2034
readonly OPTIONS_USAGE
OPTIONS_HELP="  -h, --help     $(gettext 'give this help list')
  -u, --usage    $(gettext 'give a short usage message')
  -v, --version  $(gettext 'print program version')"
# shellcheck disable=SC2034
readonly OPTIONS_HELP
# shellcheck disable=SC2034
readonly OPTIONS_SHORT='huv'
# shellcheck disable=SC2034
readonly OPTIONS_LONG='help,usage,version'


###############################################################################
# Variables
###############################################################################

declare -a cmdline_args=()
declare logcmd_check=''
declare logcmd=''
declare -i maxrc=0
declare option_gui=false
# pkexec needs absolute path-name, e.g. ./script -> /path/to/script.
declare program_exec=${0/#./$PROGRAM_PATH}
declare text=''
declare title=''

# Terminal attributes, see man terminfo.  Use ${<variabele-name>}.
declare blue=''
declare bold=''
declare green=''
declare normal=''
declare red=''
declare yellow=''


###############################################################################
# Functions
###############################################################################

# This function checks for active updates and waits for the next check.
function check_for_active_updates {
    local -i check_wait=10
    local text
    text=$(eval_gettext \
            "Wait \${check_wait}s for another package manager to finish...")

    if find /snap/core/*/var/cache/debconf/config.dat &> /dev/null; then
        # System with snaps.
        while sudo  fuser                                               \
                    /var/{lib/{dpkg,apt/lists},cache/apt/archives}/lock \
                    /var/cache/debconf/config.dat                       \
                    /snap/core/*/var/cache/debconf/config.dat           \
                    &> /dev/null; do
            printf '%s\n' "$text"
            sleep $check_wait
        done
    else
        # System without snaps.
        while sudo  fuser                                               \
                    /var/{lib/{dpkg,apt/lists},cache/apt/archives}/lock \
                    /var/cache/debconf/config.dat                       \
                    &> /dev/null; do
            printf '%s\n' "$text"
            sleep $check_wait
        done
    fi
}


# This function checks if the computer is running on battery power and prompts
# the user to continue.
function check_on_ac_power {
    local -i on_battery=0

    on_ac_power |& $logcmd || on_battery=$?
    if [[ on_battery -eq 1 ]]; then
        msg_warning "
$(gettext 'The computer now uses only the battery for power.

It is recommended to connect the computer to the wall socket.')"
        wait_for_enter
    fi
}

# This function checks if the user is root and restarts the script if not.
function check_user_root {
    local -i rc=0

    # shellcheck disable=SC2310
    if ! check_user_sudo; then
        msg_info "$(gettext 'Already performed by the administrator.')"
        exit $OK
    fi
    if [[ $UID -ne 0 ]]; then
        if $option_gui; then
            msg_log  "restart (pkexec $program_exec ${cmdline_args[*]})"
            pkexec "$program_exec" "${cmdline_args[@]}" || rc=$?
            exit $rc
        else
            msg_log  "restart (exec sudo $program_exec ${cmdline_args[*]})"
            exec sudo "$program_exec" "${cmdline_args[@]}"
        fi
    fi
}


# This function checks if the user is allowed to use sudo and exits 0 if so,
# otherwise exits 1.
function check_user_sudo {
    # Can user perform sudo?
    if [[ $UID -eq 0 ]]; then
        # For the "grace" period of sudo, or as a root.
        return $OK
    elif groups "$USER" | grep --quiet --regexp='sudo'; then
        return $OK
    else
        return $ERROR
    fi
}


# This function performs initial actions.
function init_script {
    # Script-hardening.
    set -o errexit
    set -o errtrace
    set -o nounset
    set -o pipefail

    logcmd="systemd-cat --identifier=$PROGRAM_NAME"
    logcmd_check="journalctl --all --boot --identifier=$PROGRAM_NAME \
--since='$(date '+%Y-%m-%d %H:%M:%S')'"

    trap 'signal err     $LINENO ${FUNCNAME:--} "$BASH_COMMAND" $?' ERR
    trap 'signal exit    $LINENO ${FUNCNAME:--} "$BASH_COMMAND" $?' EXIT
    trap 'signal sighup  $LINENO ${FUNCNAME:--} "$BASH_COMMAND" $?' SIGHUP
    trap 'signal sigint  $LINENO ${FUNCNAME:--} "$BASH_COMMAND" $?' SIGINT
    trap 'signal sigpipe $LINENO ${FUNCNAME:--} "$BASH_COMMAND" $?' SIGPIPE
    trap 'signal sigterm $LINENO ${FUNCNAME:--} "$BASH_COMMAND" $?' SIGTERM

    msg_log  "started ($program_exec $* as $USER)"

    if [[ $(lsb_release --id --short) = 'Debian' && $UID -ne 0 ]]; then
        if command -v xhost &> /dev/null; then
            xhost +si:localuser:root |& $logcmd
        fi
    fi

    if [[ -t 1 ]]; then
        set_terminal_attributes
    fi

    cmdline_args=("$@")
    USAGE_LINE=$(eval_gettext "Type '\$DISPLAY_NAME --usage' for more \
information.")
    # shellcheck disable=SC2034
    readonly USAGE_LINE
}


# This function determines the highest return code.
function maxrc {
    if [[ $rc -gt $maxrc ]]; then
        maxrc=$rc
    fi
}


# This function returns an error message.
function msg_error {
    if $option_gui; then
        local title
        title=$(eval_gettext "Error message \$DISPLAY_NAME")
        zenity  --error                 \
                --no-markup             \
                --width     600         \
                --height    100         \
                --title     "$title"    \
                --text      "$@"        2> >($logcmd) || true
        msg_log  "$@"
    else
        printf "${red}%b\n${normal}" "$@" >&2
    fi
}


# This function returns an informational message.
function msg_info {
    if $option_gui; then
        local title
        title=$(eval_gettext "Information \$DISPLAY_NAME")
        zenity  --info                  \
                --no-markup             \
                --width     600         \
                --height    100         \
                --title     "$title"    \
                --text      "$@"        2> >($logcmd) || true
    else
        printf '%b\n' "$@"
    fi
}


# This function records a message to the log.
function msg_log {
    printf '%b\n' "$@" |& $logcmd
}


# This function returns a warning message.
function msg_warning {
    if $option_gui; then
        local title
        title=$(eval_gettext "Warning \$DISPLAY_NAME")
        zenity  --warning               \
                --no-markup             \
                --width     600         \
                --height    100         \
                --title     "$title"    \
                --text      "$@"        2> >($logcmd) || true
        msg_log  "$@"
    else
        printf "${yellow}%b\n${normal}" "$@" >&2
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
    # shellcheck disable=SC2154
    msg_info "$HELP

$(eval_gettext "Type 'man \$DISPLAY_NAME' or see the \
\e]8;;man:\$PROGRAM_NAME(1)\e\\\$DISPLAY_NAME man page\e]8;;\e\\ for more \
information.")"
}


# This function shows the available options.
function process_option_usage {
    # shellcheck disable=SC2154
    msg_info "$USAGE

$(eval_gettext "Type '\$DISPLAY_NAME --help' for more information.")"
}


# This function displays version, author, and license information.
function process_option_version {
    local build_id='????-??-??T??:??'
    local grep_expr='# <https://creativecommons.org'
    local program_year='????'

    if [[ -e /usr/local/etc/kz-build-id ]]; then
        build_id=$(cat /usr/local/etc/kz-build-id)
    else
        build_id='????-??-??T??:??'
    fi

    program_year=$(
        grep    --regexp="$grep_expr" "$PROGRAM_PATH/$PROGRAM_NAME" |
        cut     --delimiter=' ' --fields=3
        ) || true
    if [[ $program_year = '' ]]; then
        program_year='????'
    fi

    msg_info "$PROGRAM_NAME (kz) 365 ($build_id)

$(eval_gettext "Written by Karel Zimmer <info@karelzimmer.nl>, CC0 1.0 \
Universal
<https://creativecommons.org/publicdomain/zero/1.0>, \$program_year")"
}


# This function resets the terminal_attributes for the GUI.
function reset_terminal_attributes {
    blue=''
    bold=''
    green=''
    normal=''
    red=''
    yellow=''
}


# This function sets the terminal_attributes for the CLI.
function set_terminal_attributes {
    bold=$(tput bold)
    blue=${bold}$(tput setaf 4)
    green=${bold}$(tput setaf 2)
    normal=$(tput sgr0)
    red=${bold}$(tput setaf 1)
    yellow=${bold}$(tput setaf 3)
}


# This function shows log messages.
function show_log {
    if $option_gui; then
        local temp_log
        temp_log=$(mktemp -t "$PROGRAM_NAME-XXXXXXXXXX.log")
        eval "$logcmd_check" > "$temp_log"
        zenity  --text-info                         \
                --width         1300                \
                --height        600                 \
                --title         'Lograpport'        \
                --filename      "$temp_log"         \
                --cancel-label  "$(gettext 'Exit')" 2> >($logcmd) || true
        rm "$temp_log"
    else
        gnome-terminal --window -- bash -c "$logcmd_check"
    fi
}


# This function processes the signals for which the trap was set by function
# init_script.
function signal {
    local signal=${1:-unknown}
    local -i lineno=${2:-unknown}
    local function=${3:-unknown}
    local command=${4:-unknown}
    local -i rc=${5:-$ERROR}
    local rc_desc=''
    local -i rc_desc_signalno=0
    local status="${red}$rc/error${normal}"

    case $rc in
        0)
            rc_desc='successful termination'
            status="${green}$rc/OK${normal}"
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
    msg_log  "signal: $signal, line: $lineno, function: $function, command: \
$command, code: $rc ($rc_desc)"

    case $signal in
        err)
            msg_error "
$(eval_gettext "Program \$PROGRAM_NAME encountered an error.")"
            exit "$rc"
            ;;
        exit)
            signal_exit
            msg_log  "ended (code=exited, status=$status)"
            trap - ERR EXIT SIGHUP SIGINT SIGPIPE SIGTERM
            exit "$rc"
            ;;
        *)
            msg_warning "
$(eval_gettext "Program \$PROGRAM_NAME has been interrupted.")"
            exit "$rc"
            ;;
    esac
}


# This function controls the final termination of the script.
function signal_exit {
    case $PROGRAM_NAME in
        kz-install)
            if [[ $rc -ne $OK ]]; then
                msg_log  "$(gettext "If the package manager gives apt errors, \
launch a Terminal window and run:")
[1] ${blue}kz update${normal}
[2] ${blue}sudo update-initramfs -u${normal}"
            else
                # shellcheck disable=SC2154
                rm --force "$COMMANDS_FILE"
            fi
            ;;
        kz-setup)
            if [[ $rc -eq $OK ]]; then
                # shellcheck disable=SC2154
                rm --force "$COMMANDS_FILE"
            fi
            ;;
        *)
            :
            ;;
    esac
}


# This function waits for the user to press Enter.
function wait_for_enter {
    if $option_gui; then
        return
    fi
    read -rp "
$(gettext 'Press the Enter key to continue [Enter]: ')" < /dev/tty
}
