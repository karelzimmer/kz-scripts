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

declare     MODULE_NAME='kz_common.sh'
declare     MODULE_DESC
            # shellcheck disable=SC2034
            MODULE_DESC=$(gettext 'Common module for shell scripts')

declare     USAGE
# shellcheck disable=SC2034
declare     OPTIONS_USAGE="[-h|--help] [-m|--manual] [-u|--usage] \
[-v|--version]"

declare     HELP
declare     OPTIONS_HELP
            # shellcheck disable=SC2034
            OPTIONS_HELP="$(gettext '  -h, --help     show this help text')
$(gettext '  -m, --manual   show manual page')
$(gettext '  -u, --usage    show a short usage summary')
$(gettext '  -v, --version  show program version')"

# shellcheck disable=SC2034
declare     OPTIONS_SHORT='hmuv'
# shellcheck disable=SC2034
declare     OPTIONS_LONG='help,manual,usage,version'

declare     OK=0
declare     ERROR=1

declare -i  RC=$OK
declare     TEXT=''

# shellcheck disable=SC2034
declare     BOLD='\033[1m'
declare     RED='\033[1;31m'
# shellcheck disable=SC2034
declare     GREEN='\033[1;32m'
declare     NORMAL='\033[0m'

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
    # system that uses Red Hat package management system RPM.
    if $KZ_DEB; then
        KZ_RPM=false
    else
        KZ_RPM=true
    fi
else
    KZ_RPM=false
fi

declare     ERREXIT=true
declare     OPTION_GUI=false
declare     TITLE=''


###############################################################################
# Functions
###############################################################################

# This function checks whether the script is started as user root and restarts
# the script as user root if not.
function become_root() {
    # pkexec needs fully qualified path to the program to be executed.
    local       PKEXEC_PROGRAM=/usr/bin/$PROGRAM_NAME

    become_root_check || exit $OK

    if [[ $UID -ne 0 ]]; then

        if $OPTION_GUI; then
            export DISPLAY
            xhost +si:localuser:root |& $LOGCMD
            TEXT="Restart (pkexec $PKEXEC_PROGRAM ${COMMANDLINE_ARGS[*]})..."
            logmsg "$TEXT"
            # Because $PKEXEC_PROGRAM will be started again, do not trap twice.
            trap - ERR EXIT SIGHUP SIGINT SIGPIPE SIGTERM
            pkexec "$PKEXEC_PROGRAM" "${COMMANDLINE_ARGS[@]}" || RC=$?
            exit $RC
        else
            TEXT="Restart (exec sudo $PROGRAM_NAME ${COMMANDLINE_ARGS[*]})..."
            logmsg "$TEXT"
            exec sudo "$PROGRAM_NAME" "${COMMANDLINE_ARGS[@]}"
        fi

    fi
}


# This function checks if the user is allowed to become root and returns 0 if
# so, otherwise returns 1 with descriptive message.
function become_root_check() {
    if [[ $UID -eq 0 ]]; then
        return $OK
    elif groups "$USER" | grep --quiet --regexp='sudo' --regexp='wheel'; then
        return $OK
    else
        TEXT=$(gettext 'Already performed by the administrator.')
        infomsg "$TEXT"
        return $ERROR
    fi
}


# This function checks for another running APT package manager and waits for
# the next check if so.
function check_apt_package_manager() {
    local   -i  CHECK_WAIT=10

    if ! $KZ_DEB; then
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
function errormsg() {
    if $OPTION_GUI; then
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
function infomsg() {
    if $OPTION_GUI; then
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
function init_script() {
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
Started ($PROGRAM_NAME $* as $USER)."
    logmsg "$TEXT"
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
    local YELP_MAN_URL=''

    if $KZ_DESKTOP_ENVIRONMENT; then
        YELP_MAN_URL="$(gettext ', or see the ')"
        YELP_MAN_URL+="\033]8;;man:$PROGRAM_NAME(1)\033\\$DISPLAY_NAME(1) "
        YELP_MAN_URL+="$(gettext 'man page')\033]8;;\033\\"
    fi

    TEXT="$(eval_gettext "Type '\$DISPLAY_NAME --manual' or 'man \$DISPLAY_NAM\
E'\$YELP_MAN_URL for more information.")"
    printf '%b\n\n%b\n' "$HELP" "$TEXT"
}


# This function displays the manual page.
function process_option_manual() {
    if [[ -n $(type -t yelp) ]]; then
        yelp man:"$PROGRAM_NAME"
    else
        man --pager=cat "$PROGRAM_NAME"
    fi
}


# This function shows the available options.
function process_option_usage() {
    TEXT="$(eval_gettext "Type '\$DISPLAY_NAME --help' for more information.")"
    printf '%b\n\n%b\n' "$USAGE" "$TEXT"
}


# This function displays version, author, and license information.
function process_option_version() {
    local BUILD_ID=''

    if [[ -e /usr/share/doc/kz/kz-build.id ]]; then
        BUILD_ID=$(cat /usr/share/doc/kz/kz-build.id)
    else
        TEXT=$(gettext 'Build ID cannot be determined.')
        logmsg "$TEXT"
        # shellcheck disable=SC2034
        BUILD_ID=$TEXT
    fi

    TEXT="$(eval_gettext "kz version 4.2.1 (\$BUILD_ID).")

$(gettext 'Written by Karel Zimmer <info@karelzimmer.nl>.')
$(gettext "License CC0 1.0 <https://creativecommons.org/publicdomain/zero/1.0>\
.")"
    infomsg "$TEXT"
}


# This function controls the termination.
function term() {
    local       SIGNAL=${1:-unknown}
    local   -i  LINENO=${2:-unknown}
    local       FUNCTION=${3:-unknown}
    local       COMMAND=${4:-unknown}
                RC=${5:-$ERROR}
    local       RC_DESC=''
    local   -i  RC_DESC_SIGNALNO=0
    local       STATUS=$RC/error

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
            if $KZ_DEB; then
                RC_DESC='apt/dpkg exited with error'
            elif $KZ_RPM; then
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

    TEXT="Signal: $SIGNAL, line: $LINENO, function: $FUNCTION, command: "
    TEXT+="$COMMAND, code: $RC ($RC_DESC)."
    logmsg "$TEXT"

    case $SIGNAL in
        err )
            if $ERREXIT; then
                TEXT=$(eval_gettext "Program \$PROGRAM_NAME encountered an \
error.")
                errormsg "$TEXT"
            fi

            if [[ $PROGRAM_NAME = 'kz-get' ]]; then
                infomsg "
$(gettext 'To try to resolve, run:')
sudo apt remove kz
wget karelzimmer.nl/getkz
bash getkz"
            fi

            exit "$RC"
            ;;
        exit )
            if [[ $PROGRAM_NAME = 'kz-get' ]]; then
                logmsg "Delete kz get files ($MODULE_NAME)..."
                rm  --force                 \
                    --verbose               \
                    getkz                   \
                    getkz.{1..99}           \
                    "$KZ_DEB_LOCAL_FILE"    \
                    "$KZ_COMMON_LOCAL_FILE" |& $LOGCMD
            fi

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
function wait_for_enter() {
    local PROMPT

    PROMPT="$(gettext 'Press the Enter key to continue [Enter]: ')"
    logmsg "$PROMPT"
    printf '\n'
    read -rp "$PROMPT" < /dev/tty
    printf '\n'
}
