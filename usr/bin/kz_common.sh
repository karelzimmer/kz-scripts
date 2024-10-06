# This module provides global variables and functions.
#
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
# Variables
###############################################################################

declare     KZ_MODULE_NAME='kz_common.sh'
declare     KZ_MODULE_DESC
            # shellcheck disable=SC2034
            KZ_MODULE_DESC=$(gettext 'Common module for shell scripts')

declare     KZ_USAGE
# shellcheck disable=SC2034
declare     KZ_OPTIONS_USAGE="[-h|--help] [-m|--manual] [-u|--usage] \
[-v|--version]"

declare     KZ_HELP
declare     KZ_OPTIONS_HELP
            # shellcheck disable=SC2034
            KZ_OPTIONS_HELP="$(gettext '  -h, --help     show this help text')
$(gettext '  -m, --manual   show manual page')
$(gettext '  -u, --usage    show a short usage summary')
$(gettext '  -v, --version  show program version')"

# shellcheck disable=SC2034
declare     KZ_OPTIONS_SHORT='hmuv'
# shellcheck disable=SC2034
declare     KZ_OPTIONS_LONG='help,manual,usage,version'

declare     KZ_OK=0
declare     KZ_ERROR=1

declare -i  KZ_RC=$KZ_OK
declare     KZ_TEXT=''

# shellcheck disable=SC2034
declare     KZ_BOLD='\033[1m'
declare     KZ_RED='\033[1;31m'
# shellcheck disable=SC2034
declare     KZ_GREEN='\033[1;32m'
declare     KZ_NORMAL='\033[0m'

declare     KZ_DESKTOP_ENVIRONMENT
if [[ -n $(type -t {{cinnamon,gnome,lxqt,mate,xfce4}-session,ksmserver}) ]]
then
    KZ_DESKTOP_ENVIRONMENT=true
else
    KZ_DESKTOP_ENVIRONMENT=false
fi

declare     KZ_GNOME=true
# shellcheck disable=SC2034
if [[ -n $(type -t gnome-session) ]]; then
    KZ_GNOME=true
else
    KZ_GNOME=false
fi

declare     KZ_DEBIAN
# shellcheck disable=SC2034
if [[ $(lsb_release --id --short) = 'Debian' ]]; then
    KZ_DEBIAN=true
else
    KZ_DEBIAN=false
fi

declare     KZ_UBUNTU
# shellcheck disable=SC2034
if [[ $(lsb_release --id --short) = 'Ubuntu' ]]; then
    KZ_UBUNTU=true
else
    KZ_UBUNTU=false
fi

declare     KZ_DEB
# shellcheck disable=SC2034
if [[ -n $(type -t {dpkg,apt-get,apt}) ]]; then
    KZ_DEB=true
else
    KZ_DEB=false
fi

declare     KZ_RPM
# shellcheck disable=SC2034
if [[ -n $(type -t {rpm,yum,dnf}) ]]; then
    # Additional testing is needed because rpm may be installed on a system
    # that uses Debian package management system APT. APT is not available on a
    # system that uses Red Hat package management system KZ_RPM.
    if $KZ_DEB; then
        KZ_RPM=false
    else
        KZ_RPM=true
    fi
else
    KZ_RPM=false
fi

declare     KZ_ERREXIT=true
declare     KZ_OPTION_GUI=false
declare     KZ_TITLE=''


###############################################################################
# Functions
###############################################################################

# This function checks whether the script is started as user root and restarts
# the script as user root if not.
function become_root() {
    # pkexec needs fully qualified path to the program to be executed.
    local L_PKEXEC_PROGRAM=/usr/bin/$KZ_PROGRAM_NAME

    become_root_check || exit $KZ_OK

    if [[ $UID -ne 0 ]]; then

        if $KZ_OPTION_GUI; then
            export DISPLAY
            xhost +si:localuser:root |& $LOGCMD
            KZ_TEXT="Restart (pkexec $L_PKEXEC_PROGRAM \
${COMMANDLINE_ARGS[*]})..."
            logmsg "$KZ_TEXT"
            # Because this script will be started again, do not trap twice.
            trap - ERR EXIT SIGHUP SIGINT SIGPIPE SIGTERM
            pkexec "$L_PKEXEC_PROGRAM" "${COMMANDLINE_ARGS[@]}" || KZ_RC=$?
            exit $KZ_RC
        else
            KZ_TEXT="Restart (exec sudo $KZ_PROGRAM_NAME \
${COMMANDLINE_ARGS[*]})..."
            logmsg "$KZ_TEXT"
            exec sudo "$KZ_PROGRAM_NAME" "${COMMANDLINE_ARGS[@]}"
        fi

    fi
}


# This function checks if the user is allowed to become root and returns 0 if
# so, otherwise returns 1 with descriptive message.
function become_root_check() {
    if [[ $UID -eq 0 ]]; then
        return $KZ_OK
    elif groups "$USER" | grep --quiet --regexp='sudo' --regexp='wheel'; then
        return $KZ_OK
    else
        KZ_TEXT=$(gettext 'Already performed by the administrator.')
        infomsg "$KZ_TEXT"
        return $KZ_ERROR
    fi
}


# This function checks for another running APT package manager and waits for
# the next check if so.
function check_apt_package_manager() {
    local   -i  L_CHECK_WAIT=10

    if ! $KZ_DEB; then
        return $KZ_OK
    fi

    while sudo  fuser                           \
                --silent                        \
                /var/cache/debconf/config.dat   \
                /var/{lib/{dpkg,apt/lists},cache/apt/archives}/lock*; do
        KZ_TEXT=$(gettext 'Wait for another package manager to finish')
        if $KZ_OPTION_GUI; then
            logmsg "$KZ_TEXT..."
            # Inform the user in 'zenity --progress' why there is a wait.
            printf '%s\n' "#$KZ_TEXT"
        else
            infomsg "$KZ_TEXT..."
        fi
        sleep $L_CHECK_WAIT
    done
}


# This function returns an error message.
function errormsg() {
    if $KZ_OPTION_GUI; then
        KZ_TITLE=$(eval_gettext "\$KZ_PROGRAM_DESC error message \
(\$KZ_DISPLAY_NAME)")
        zenity  --error                 \
                --width     600         \
                --height    100         \
                --title     "$KZ_TITLE"    \
                --text      "$*"        2> >($LOGCMD) || true
    else
        printf "${KZ_RED}%b${KZ_NORMAL}\n" "$*" >&2
    fi
}


# This function returns an informational message.
function infomsg() {
    if $KZ_OPTION_GUI; then
        KZ_TITLE=$(eval_gettext "\$KZ_PROGRAM_DESC information \
(\$KZ_DISPLAY_NAME)")
        zenity  --info                  \
                --width     600         \
                --height    100         \
                --title     "$KZ_TITLE"    \
                --text      "$*"        2> >($LOGCMD) || true
    else
        printf '%b\n' "$*"
    fi
}


# This function performs initial actions such as set traps (script-hardening).
function init_script() {
    # Script-hardening.
    set -o errexit
    set -o errtrace
    set -o nounset
    set -o pipefail

    declare  -g LOGCMD="systemd-cat --identifier=$KZ_PROGRAM_NAME"
    declare -ag COMMANDLINE_ARGS=("$@")

    trap 'term err     $LINENO ${FUNCNAME:--} "$BASH_COMMAND" $?' ERR
    trap 'term exit    $LINENO ${FUNCNAME:--} "$BASH_COMMAND" $?' EXIT
    trap 'term sighup  $LINENO ${FUNCNAME:--} "$BASH_COMMAND" $?' SIGHUP
    trap 'term sigint  $LINENO ${FUNCNAME:--} "$BASH_COMMAND" $?' SIGINT
    trap 'term sigpipe $LINENO ${FUNCNAME:--} "$BASH_COMMAND" $?' SIGPIPE
    trap 'term sigterm $LINENO ${FUNCNAME:--} "$BASH_COMMAND" $?' SIGTERM

    KZ_TEXT="==== START logs for script $KZ_PROGRAM_NAME ====
Started ($KZ_PROGRAM_NAME $* as $USER)."
    logmsg "$KZ_TEXT"
}


# This function records a message to the log.
function logmsg() {
    printf '%b\n' "$*" |& $LOGCMD
}


# This function handles the common options.
function process_options() {
    while true; do
        case $1 in
            -h | --help )
                process_option_help
                exit $KZ_OK
                ;;
            -m | --manual )
                process_option_manual
                exit $KZ_OK
                ;;
            -u | --usage )
                process_option_usage
                exit $KZ_OK
                ;;
            -v | --version )
                process_option_version
                exit $KZ_OK
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
    local L_YELP_MAN_URL=''

    if $KZ_DESKTOP_ENVIRONMENT; then
        L_YELP_MAN_URL="$(gettext ', or see the ')"
        L_YELP_MAN_URL+="\033]8;;man:$KZ_PROGRAM_NAME(1)\033\\"
        L_YELP_MAN_URL+="$KZ_DISPLAY_NAME(1) "
        L_YELP_MAN_URL+="$(gettext 'man page')\033]8;;\033\\"
    fi

    KZ_TEXT="$(eval_gettext "Type '\$KZ_DISPLAY_NAME --manual' or 'man \
\$KZ_DISPLAY_NAME'\$L_YELP_MAN_URL for more information.")"
    printf '%b\n\n%b\n' "$KZ_HELP" "$KZ_TEXT"
}


# This function displays the manual page.
function process_option_manual() {
    if [[ -n $(type -t yelp) ]]; then
        yelp man:"$KZ_PROGRAM_NAME"
    else
        man --pager=cat "$KZ_PROGRAM_NAME"
    fi
}


# This function shows the available options.
function process_option_usage() {
    KZ_TEXT="$(eval_gettext "Type '\$KZ_DISPLAY_NAME --help' for more \
information.")"
    printf '%b\n\n%b\n' "$KZ_USAGE" "$KZ_TEXT"
}


# This function displays version, author, and license information.
function process_option_version() {
    local L_BUILD_ID=''

    if [[ -e /usr/share/doc/kz/kz-build.id ]]; then
        L_BUILD_ID=$(cat /usr/share/doc/kz/kz-build.id)
    else
        KZ_TEXT=$(gettext 'Build ID cannot be determined.')
        logmsg "$KZ_TEXT"
        # shellcheck disable=SC2034
        L_BUILD_ID=$KZ_TEXT
    fi

    KZ_TEXT="$(eval_gettext "kz version 4.2.1 (\$L_BUILD_ID).")

$(gettext 'Written by Karel Zimmer <info@karelzimmer.nl>.')
$(gettext "License CC0 1.0 <https://creativecommons.org/publicdomain/zero/1.0>\
.")"
    infomsg "$KZ_TEXT"
}


# This function controls the termination.
function term() {
    local       L_SIGNAL=${1:-unknown}
    local   -i  L_LINENO=${2:-unknown}
    local       L_FUNCTION=${3:-unknown}
    local       L_COMMAND=${4:-unknown}
                KZ_RC=${5:-$KZ_ERROR}
    local       L_RC_DESC=''
    local   -i  L_RC_DESC_SIGNALNO=0
    local       L_STATUS=$KZ_RC/error

    case $KZ_RC in
        0 )
            L_RC_DESC='successful termination'
            L_STATUS=$KZ_RC/KZ_OK
            ;;
        1 )
            L_RC_DESC='terminated with error'
            ;;
        6[4-9] | 7[0-8] )                   # 64--78
            L_RC_DESC="open file '/usr/include/sysexits.h' and look for \
'$KZ_RC'"
            ;;
        100 )
            if $KZ_DEB; then
                L_RC_DESC='apt/dpkg exited with error'
            elif $KZ_RPM; then
                L_RC_DESC='there are updates available'
            else
                L_RC_DESC="previous errors/it didn't work"
            fi
            ;;
        126 )
            L_RC_DESC='command cannot execute'
            ;;
        127 )
            L_RC_DESC='command not found'
            ;;
        128 )
            L_RC_DESC='invalid argument to exit'
            ;;
        129 )                               # SIGHUP (128 + 1)
            L_RC_DESC='hangup'
            ;;
        130 )                               # SIGINT (128 + 2)
            L_RC_DESC='terminated by control-c'
            ;;
        13[1-9] | 140 )                     # 131 (128 + 3)--140 (128 + 12)
            L_RC_DESC_SIGNALNO=$(( KZ_RC - 128 ))
            L_RC_DESC="typ 'trap -l' and look for $L_RC_DESC_SIGNALNO"
            ;;
        141 )                               # SIGPIPE (128 + 13)
            L_RC_DESC='broken pipe: write to pipe with no readers'
            ;;
        142 )                               # SIGALRM (128 + 14)
            L_RC_DESC='timer signal from alarm'
            ;;
        143 )                               # SIGTERM (128 + 15)
            L_RC_DESC='termination signal'
            ;;
        14[4-9] | 1[5-8][0-9] | 19[0-2])    # 144 (128 + 16)--192 (128 + 64)
            L_RC_DESC_SIGNALNO=$(( KZ_RC - 128 ))
            L_RC_DESC="typ 'trap -l' and look for $L_RC_DESC_SIGNALNO"
            ;;
        200 )
            # Red Hat or Red Hat-based system.
            L_RC_DESC="There was a problem with acquiring or releasing of \
locks."
            ;;
        255 )
            L_RC_DESC='exit status out of range'
            ;;
        * )
            L_RC_DESC='unknown error'
            ;;
    esac

    KZ_TEXT="Signal: $L_SIGNAL, line: $L_LINENO, function: $L_FUNCTION, "
    KZ_TEXT+="command: $L_COMMAND, code: $KZ_RC ($L_RC_DESC)."
    logmsg "$KZ_TEXT"

    case $L_SIGNAL in
        err )
            if $KZ_ERREXIT; then
                KZ_TEXT=$(eval_gettext "Program \$KZ_PROGRAM_NAME encountered \
an error.")
                errormsg "$KZ_TEXT"
            fi

            if [[ $KZ_PROGRAM_NAME = 'kz-get' ]]; then
                infomsg "
$(gettext 'To try to resolve, run:')
sudo apt remove kz
wget karelzimmer.nl/getkz
bash getkz"
            fi

            exit "$KZ_RC"
            ;;
        exit )
            if [[ $KZ_PROGRAM_NAME = 'kz-get' ]]; then
                logmsg "Delete kz get files ($KZ_MODULE_NAME)..."
                rm  --force                 \
                    --verbose               \
                    getkz                   \
                    getkz.{1..99}           \
                    "$KZ_DEB_LOCAL_FILE"    \
                    "$KZ_COMMON_LOCAL_FILE" |& $LOGCMD
            fi

            KZ_TEXT="Ended (code=exited, status=$L_STATUS).
==== END logs for script $KZ_PROGRAM_NAME ===="
            logmsg "$KZ_TEXT"

            trap - ERR EXIT SIGHUP SIGINT SIGPIPE SIGTERM

            exit "$KZ_RC"
            ;;
        * )
            KZ_TEXT=$(eval_gettext "Program \$KZ_PROGRAM_NAME has been \
interrupted.")
            errormsg "$KZ_TEXT"

            exit "$KZ_RC"
            ;;
    esac
}


# This function waits for the user to press Enter.
function wait_for_enter() {
    local L_PROMPT

    L_PROMPT="$(gettext 'Press the Enter key to continue [Enter]: ')"
    logmsg "$L_PROMPT"
    printf '\n'
    read -rp "$L_PROMPT" < /dev/tty
    printf '\n'
}
