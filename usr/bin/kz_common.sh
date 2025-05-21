# shellcheck shell=bash source=/dev/null
###############################################################################
# SPDX-FileComment: Common module for kz Bash scripts
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

readonly OK=0
readonly ERR=1

# List NORMAL last here so that -x doesn't bork the display.
readonly RED='\033[1;31m'
readonly NORMAL='\033[0m'

if ! type systemctl &> /dev/null; then
    printf '%b\n' "$RED$(gettext 'fatal: no systemd available')$NORMAL" >&2
    exit $ERR
fi

if ! [[ -f /etc/os-release ]]; then
    printf '%b\n' "$RED$(gettext 'fatal: no os release available')$NORMAL" >&2
    exit $ERR
fi


###############################################################################
# Globals
###############################################################################

declare TEXT=''


###############################################################################
# Functions
###############################################################################

# This function checks whether the script is started as user root and restarts
# the script as user root if not.
function become_root() {
    # pkexec needs fully qualified path to the program to be executed.
    # shellcheck disable=SC2153
    local pkexec_program=/usr/bin/$PROGRAM_NAME

    become_root_check || exit $OK

    if [[ $UID -ne 0 ]]; then
        export DISPLAY
        if ${OPTION_GUI:-false}; then
            xhost +si:localuser:root |& $PROGRAM_LOGS
            TEXT="Restart (pkexec $pkexec_program ${COMMANDLINE_ARGS[*]})..."
            logmsg "$TEXT"
            # Because $pkexec_program will be started again, do not trap twice.
            trap - ERR EXIT SIGHUP SIGINT SIGPIPE SIGTERM
            pkexec "$pkexec_program" "${COMMANDLINE_ARGS[@]}"
        else
            TEXT="Restart (exec sudo $PROGRAM_NAME ${COMMANDLINE_ARGS[*]})..."
            logmsg "$TEXT"
            exec sudo "$PROGRAM_NAME" "${COMMANDLINE_ARGS[@]}"
        fi
        exit
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
        return $ERR
    fi
}


# This function checks for another running package manager and waits for the
# next check if so.
function check_package_manager() {
    local -i sleep=5

    if grep --quiet rhel /etc/os-release; then
        return $OK
    fi

    while sudo  fuser                           \
                --silent                        \
                /var/cache/debconf/config.dat   \
                /var/{lib/{dpkg,apt/lists},cache/apt/archives}/lock*; do
        TEXT=$(eval_gettext "Wait \$sleep seconds for another package manager \
to finish")
        if ${OPTION_GUI:-false}; then
            logmsg "$TEXT..."
            # Inform the user in 'zenity --progress' why there is a wait.
            printf '%s\n' "#$TEXT"
        else
            infomsg "$TEXT..."
        fi
        sleep $sleep
    done
}


# This function check that the repos are in the desired state.
function check_repos() {
    local err_flag=false
    local repo=''
    local repos='kz-deb kz-docs kz-rpm kz-scripts kz-uploads'
    local startdir=$PWD

    TEXT=$(gettext 'Check that all repos are on branch main')...
    infomsg "$TEXT"

    for repo in $repos; do
        cd "$HOME/$repo"
        if [[ $(git branch --show-current) != 'main' ]]; then
            TEXT=$(eval_gettext "Repo \$repo not on branch main.")
            errmsg "$TEXT"
            git status
            err_flag=true
        fi
    done

    TEXT=$(gettext 'Check that all repos are clean')...
    infomsg "$TEXT"

    for repo in $repos; do
        cd "$HOME/$repo"

        # Prevent false positives.
        git status |& $PROGRAM_LOGS

        if ! git diff-index --quiet HEAD; then
            TEXT=$(eval_gettext "Repo \$repo is not clean.")
            errmsg "$TEXT"
            git status
            err_flag=true
        fi
    done

    cd "$startdir"

    if $err_flag; then
        return $ERR
    else
        return $OK
    fi
}


# This function records a debugging message to the log.
function debugmsg() {
    printf '%b\n' "$*" |& $PROGRAM_LOGS --priority=debug
}


# This function returns an error message.
function errmsg() {
    local program_name=${PROGRAM_NAME/kz-/kz }
    local title=''

    debugmsg "$*"
    if ${OPTION_GUI:-false}; then
        title="$PROGRAM_DESC $(gettext 'error message') ($program_name)"
        zenity  --error                 \
                --width     600         \
                --height    100         \
                --title     "$title"    \
                --text      "$*"        2> /dev/null || true
    else
        printf "$RED%b$NORMAL\n" "$*" >&2
    fi
}


# This function returns an informational message.
function infomsg() {
    local program_name=${PROGRAM_NAME/kz-/kz }
    local title=''

    debugmsg "$*"
    if ${OPTION_GUI:-false}; then
        title="$PROGRAM_DESC $(gettext 'information') ($program_name)"
        zenity  --info                  \
                --width     600         \
                --height    100         \
                --title     "$title"    \
                --text      "$*"        2> /dev/null || true
    else
        printf '%b\n' "$*"
    fi
}


# This function performs initial actions.
function init() {
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

    TEXT="\
==== START logs for script $PROGRAM_NAME ======================================
Started ($0 as $USER)."
    logmsg "$TEXT"

    declare -ag COMMANDLINE_ARGS=("$@")
}


# This function records a informational message to the log.
function logmsg() {
    printf '%b\n' "$*" |& $PROGRAM_LOGS
}


# This function shows the available help.
function process_option_help() {
    local program_name=${PROGRAM_NAME/kz-/kz }
    local yelp_man_url=''

    if [[ ${DISPLAY-} ]]; then
        yelp_man_url="$(gettext ', or see the ')"
        yelp_man_url+="\033]8;;man:$PROGRAM_NAME(1)\033\\$program_name(1) "
        yelp_man_url+="$(gettext 'man page')\033]8;;\033\\"
    fi

    TEXT="$(eval_gettext "Type '\$program_name --manual' or 'man \
\$program_name'\$yelp_man_url for more information.")"
    infomsg "$HELP

$TEXT"
}


# This function displays the manual page.
function process_option_manual() {
    if [[ ${DISPLAY-} ]]; then
        yelp man:"$PROGRAM_NAME" 2> /dev/null
    else
        man --pager=cat "$PROGRAM_NAME"
    fi
}


# This function shows the available options.
function process_option_usage() {
    local program_name=${PROGRAM_NAME/kz-/kz }

    TEXT="$(eval_gettext "Type '\$program_name --help' for more information.")"
    infomsg "$USAGE

$TEXT"
}


# This function displays version, author, and license information.
function process_option_version() {
    local build_id='' # ISO 8601 YYYY-MM-DDTHH:MM:SS

    if [[ -f /usr/share/doc/kz/build.id ]]; then
        build_id=$(cat /usr/share/doc/kz/build.id)
    else
        TEXT=$(gettext 'Build ID cannot be determined.')
        logmsg "$TEXT"
        # shellcheck disable=SC2034
        build_id=$TEXT
    fi

    TEXT="$(eval_gettext "kz version 4.2.1 (built \$build_id).")

$(gettext 'Written by Karel Zimmer <info@karelzimmer.nl>.')
$(gettext "License CC0 1.0 \
<https://creativecommons.org/publicdomain/zero/1.0>.")"
    infomsg "$TEXT"
}


# This function controls the termination.
function term_sig() {
    local signal=$1
    local -i lineno=$2
    local function=$3
    local command=$4
    local -i rc=$5

    local -i rc_desc_signalno=0
    local rc_desc=''
    local status=$rc/FAILURE

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
            if grep --quiet debian /etc/os-release; then
                rc_desc='apt/dpkg exited with error'
            elif grep --quiet rhel /etc/os-release; then
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

    TEXT="Signal: $signal, line: $lineno, function: $function, command: \
$command, exit code: $rc ($rc_desc)."
    logmsg "$TEXT"

    case $signal in
        err )
            if ${ERREXIT:-true}; then
                TEXT="
$(eval_gettext "Program \$PROGRAM_NAME encountered an error.")"
                errmsg "$TEXT"
            fi
            exit "$rc"
            ;;
        exit )
            # Clean up temporary files.
            TEXT='Cleaning up temporary files...'
            logmsg "$TEXT"
            rm  --verbose   \
                --force     \
                /tmp/"$PROGRAM_NAME-"*??????????* |& $PROGRAM_LOGS || true
            TEXT="Ended (code=exited, status=$status).
==== END logs for script $PROGRAM_NAME ======================================="
            logmsg "$TEXT"
            trap - ERR EXIT SIGHUP SIGINT SIGPIPE SIGTERM
            exit "$rc"
            ;;
        * )
            TEXT="
$(eval_gettext "Program \$PROGRAM_NAME has been interrupted.")"
            errmsg "$TEXT"
            exit "$rc"
            ;;
    esac
}


# This function waits for the user to press Enter.
function wait_for_enter() {
    local prompt=''

    prompt="$(gettext 'Press the Enter key to continue [Enter]: ')"
    logmsg "$prompt"
    printf '\n'
    read -rp "$prompt" < /dev/tty
    printf '\n'
}
