# shellcheck shell=bash source=/dev/null
# #############################################################################
# SPDX-FileComment: Common module for kz Bash scripts
#
# SPDX-FileCopyrightText: Karel Zimmer <info@karelzimmer.nl>
# SPDX-License-Identifier: CC0-1.0
# #############################################################################


# #############################################################################
# Imports
# #############################################################################

export TEXTDOMAIN=kz
export TEXTDOMAINDIR=/usr/share/locale
source /usr/bin/gettext.sh


# #############################################################################
# Functions
# #############################################################################

# This function checks if the script was started in the terminal as user root
# and restarts the script as user root if not.
function kz.become() {
    local text=''

    kz.become_check || exit 0

    if ! ( ${OPTION_GUI:-false} || [[ $UID -eq 0 ]] ); then
        # shellcheck disable=SC2153,SC2154
        text="Restart (exec sudo $PROGRAM_NAME ${COMMANDLINE_ARGS[*]})..."
        kz.logmsg "$text"
        exec sudo "$PROGRAM_NAME" "${COMMANDLINE_ARGS[@]}"
        exit
    fi
}


# This function checks if the user is allowed to become root and returns 0 if
# so, otherwise returns 1 with descriptive message.
function kz.become_check() {
    local text=''

    if [[ $UID -eq 0 ]]; then
        return 0
    elif groups "$USER" | grep --quiet --regexp='sudo' --regexp='wheel'; then
        return 0
    else
        text=$(gettext 'Already performed by the administrator.')
        kz.infomsg "$text"
        return 1
    fi
}


# This function checks if a Debian package manager is already running and waits
# for the next check if so.
function kz.check_debian_package_manager() {
    local text=''

    if grep --quiet rhel /etc/os-release; then
        return 0
    fi

    while pkexec /usr/bin/kz_common-pkexec; do
        text=$(gettext "Wait for another package manager to finish")
        if ${OPTION_GUI:-false}; then
            kz.logmsg "$text..."
            # Inform the user in 'zenity --progress' why there is a wait.
            printf '%s\n' "#$text"
            # Prevent 'zenity progress' from getting stuck due to the speed of
            # executing a command.
            sleep 0.1
        else
            kz.infomsg "$text..."
        fi
        sleep 1
    done
}


# This function check that the repos are in the desired state.
function kz.check_repos() {
    local err_flag=false
    local repo=''
    local repos='kz-deb kz-docs kz-rpm kz-scripts kz-uploads'
    local startdir=$PWD
    local text=''

    text=$(gettext 'Check that all repos are on branch main')...
    kz.infomsg "$text"

    for repo in $repos; do
        cd "$HOME/$repo"
        if [[ $(git branch --show-current) != 'main' ]]; then
            text=$(eval_gettext "Repo \$repo not on branch main.")
            kz.errmsg "$text"
            git status
            err_flag=true
        fi
    done

    text=$(gettext 'Check that all repos are clean')...
    kz.infomsg "$text"

    for repo in $repos; do
        cd "$HOME/$repo"

        # Prevent false positives.
        # shellcheck disable=SC2154
        git status |& $PROGRAM_LOGS

        if ! git diff-index --quiet HEAD; then
            text=$(eval_gettext "Repo \$repo is not clean.")
            kz.errmsg "$text"
            git status
            err_flag=true
        fi
    done

    cd "$startdir"

    if $err_flag; then
        return 1
    else
        return 0
    fi
}


# This function records a debugging message to the log.
function kz.debugmsg() {
    printf '%b\n' "$*" |& $PROGRAM_LOGS --priority=debug
}


# This function returns an error message.
function kz.errmsg() {
    local program_name=${PROGRAM_NAME/kz-/kz }
    local title=''

    kz.debugmsg "$*"
    if ${OPTION_GUI:-false}; then
        # shellcheck disable=SC2154
        title="$PROGRAM_DESC $(gettext 'error message')"
        zenity  --error                 \
                --width     600         \
                --height    100         \
                --title     "$title"    \
                --text      "$*"        2> /dev/null || true
    else
        printf "\033[1;31m%b\033[0m\n" "$*" >&2
    fi
}


# This function returns an informational message.
function kz.infomsg() {
    local program_name=${PROGRAM_NAME/kz-/kz }
    local title=''

    kz.debugmsg "$*"
    if ${OPTION_GUI:-false}; then
        title="$PROGRAM_DESC $(gettext 'information')"
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
function kz.init() {
    local text=''

    # Check if systemd is available.
    if ! type systemctl &> /dev/null; then
        printf  '\033[1;31m%b\n\033[0m' \
                "$(gettext 'fatal: no systemd available')" >&2
        exit 1
    fi

    # Check if os release is available.
    if ! [[ -f /etc/os-release ]]; then
        printf  '\033[1;31m%b\n\033[0m' \
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

    text="==== START logs for script $PROGRAM_NAME ==========================="
    kz.logmsg "$text"
    text="Started ($0 as $USER)."
    kz.logmsg "$text"
}


# This function records a informational message to the log.
function kz.logmsg() {
    printf '%b\n' "$*" |& $PROGRAM_LOGS
}


# This function shows the available help.
function kz.process_option_help() {
    local program_name=${PROGRAM_NAME/kz-/kz }
    local text=''
    local yelp_man_url=''

    if [[ -n ${DISPLAY-} ]]; then
        yelp_man_url="$(gettext ', or see the ')"
        yelp_man_url+="\033]8;;man:$PROGRAM_NAME(1)\033\\$program_name(1) "
        yelp_man_url+="$(gettext 'man page')\033]8;;\033\\"
    fi

    text="$(eval_gettext "Type '\$program_name --manual' or 'man \
\$program_name'\$yelp_man_url for more information.")"
    # shellcheck disable=SC2154
    kz.infomsg "$HELP

$text"
}


# This function displays the manual page.
function kz.process_option_manual() {
    if [[ -n ${DISPLAY-} ]]; then
        yelp man:"$PROGRAM_NAME" 2> /dev/null
    else
        man --pager=cat "$PROGRAM_NAME"
    fi
}


# This function shows the available options.
function kz.process_option_usage() {
    local program_name=${PROGRAM_NAME/kz-/kz }
    local text=''

    # shellcheck disable=SC2154
    text="$USAGE

$(eval_gettext "Type '\$program_name --help' for more information.")"
    kz.infomsg "$text"
}


# This function displays version, author, and license information.
function kz.process_option_version() {
    local build_id='' # ISO 8601 YYYY-MM-DDTHH:MM:SS
    local text=''

    if [[ -f /usr/share/doc/kz/build.id ]]; then
        build_id=$(cat /usr/share/doc/kz/build.id)
    else
        text=$(gettext 'Build ID cannot be determined.')
        kz.logmsg "$text"
        # shellcheck disable=SC2034
        build_id=$text
    fi

    text="$(eval_gettext "kz version 4.2.1 (built \$build_id).")

$(gettext 'Written by Karel Zimmer <info@karelzimmer.nl>.')
$(gettext "License CC0 1.0 \
<https://creativecommons.org/publicdomain/zero/1.0>.")"
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

    text="Signal: $signal, line: $lineno, function: $function, "
    text+="command: $command, exit code: $rc ($rc_desc)."
    kz.logmsg "$text"

    case $signal in
        err )
            text="
$(eval_gettext "Program \$PROGRAM_NAME encountered an error.")"
            kz.errmsg "$text"
            exit "$rc"
            ;;
        exit )
            # Clean up temporary files.
            text='Cleaning up temporary files...'
            kz.logmsg "$text"
            rm  --verbose   \
                --force     \
                /tmp/"$PROGRAM_NAME-"*??????????*.* |& $PROGRAM_LOGS || true
            text="Ended (code=exited, status=$status)."
            kz.logmsg "$text"
            text="==== END logs for script $PROGRAM_NAME ====================="
            kz.logmsg "$text"
            trap - ERR EXIT SIGHUP SIGINT SIGTERM
            exit "$rc"
            ;;
        * )
            text="
$(eval_gettext "Program \$PROGRAM_NAME has been interrupted.")"
            kz.errmsg "$text"
            exit "$rc"
            ;;
    esac
}


# This function waits for the user to press Enter.
function kz.wait_for_enter() {
    local prompt=''

    prompt="$(gettext 'Press the Enter key to continue [Enter]: ')"
    kz.debugmsg "$prompt"
    printf '\n'
    read -rp "$prompt" < /dev/tty
    printf '\n'
}
