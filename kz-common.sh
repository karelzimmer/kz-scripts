# shellcheck shell=bash
###############################################################################
# Algemene module voor shell scripts.
#
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.
###############################################################################
PROGRAM_NAME=kz-common.sh
DISPLAY_NAME=${PROGRAM_NAME/kz-/kz }
RELEASE_YEAR=2009

VERSION_NUMBER=27.02.11
VERSION_DATE=2021-09-21


###############################################################################
# Common global constants
###############################################################################

readonly SUCCESS=0
readonly ERROR=1
readonly WARNING=2

# shellcheck disable=SC2034
readonly OPTIONS_SHORT_COMMON='dghuv'
# shellcheck disable=SC2034
readonly OPTIONS_LONG_COMMON='debug,gui,help,usage,version'
# shellcheck disable=SC2034
readonly OPTIONS_USAGE_COMMON="[-u|--usage] [-h|--help] [-v|--version] \
[-g|--gui] [-d|--debug]"
# shellcheck disable=SC2034
readonly OPTIONS_HELP_COMMON="\
  -h --help     toon deze hulptekst
  -u --usage    toon een korte gebruikssamenvatting
  -v --version  toon programmaversie
  -g --gui      start in grafische modus
  -d --debug    neem foutopsporingsinformatie op in het logboek"

DISTRO=$(lsb_release --id --short | tr '[:upper:]' '[:lower:]')
readonly DISTRO
THIS_YEAR=$(date +%Y); readonly THIS_YEAR


###############################################################################
# Common global variables
###############################################################################

declare -a  CMDLINE_ARGS=()
declare     BACKUP_TO_DELETE=''
declare     HELP='Gebruik: source kz-common.sh
     of: . kz-common.sh'
declare     LOGCMD=''
declare     LOGCMD_CHECK=''
declare     OPTION_DEBUG=false
declare     OPTION_GUI=false
declare     OPTION_HELP=false
declare     OPTION_USAGE=false
declare     OPTION_VERSION=false
declare     RUN_AS_SUPERUSER=false
declare     TERMINAL=false
declare     TEXT=''
declare     TITLE=''
declare     USAGE='Gebruik: source kz-common.sh
     of: . kz-common.sh'
declare     USAGELINE=''

# Terminalattributen, zie 'man terminfo'.  Gebruik ${<variabele-naam>}.
declare     NORMAL=''
declare     BOLD=''
declare     RED=''
declare     GREEN=''
declare     YELLOW=''
declare     BLUE=''


###############################################################################
# Common functions
###############################################################################

check_on_ac_power() {
    local -i on_battery=0

    on_ac_power >/dev/null 2>&1 || on_battery=$?
    if [[ on_battery -eq 1 ]]; then
        warning '
De computer gebruikt nu alleen de accu voor de stroomvoorziening.

Geadviseerd wordt om de computer aan te sluiten op het stopcontact.
'
    fi
}


error() {
    if $OPTION_GUI; then
        TITLE="Foutmelding $DISPLAY_NAME"
        # Constructie '2> >($LOGCMD)' om stderr naar de log te krijgen.
        # Voorbeeld: Unable to init server: Kon niet verbinden:
        #            Verbinding is geweigerd
        #        en: (zenity:47712): Gtk-WARNING **: 10:35:49.339:
        #            cannot open display:
        if ! zenity --error                 \
                    --no-markup             \
                    --width     500         \
                    --height    100         \
                    --title     "$TITLE"    \
                    --text      "$@"        \
                    --ok-label  'Oké'       2> >($LOGCMD); then
            true
        fi
    else
        printf "${RED}%b${NORMAL}\n" "$@"
    fi
}


check_user() {
    if $RUN_AS_SUPERUSER; then
        if [[ $UID -ne 0 ]]; then
            log "Restarted (exec sudo $0 ${CMDLINE_ARGS[*]})." --priority=debug
            exec sudo "$0" "${CMDLINE_ARGS[@]}"
        fi
    else
        if [[ $UID -eq 0 ]]; then
            info "$DISPLAY_NAME: niet uitvoeren met 'sudo' of als root"
            exit $WARNING
        fi
    fi
}


info() {
    if $OPTION_GUI; then
        TITLE="Informatie $DISPLAY_NAME"
        # Constructie '2> >($LOGCMD)' om stderr naar de log te krijgen.
        # Voorbeeld: Unable to init server: Kon niet verbinden:
        #            Verbinding is geweigerd
        #        en: (zenity:47712): Gtk-WARNING **: 10:35:49.339:
        #            cannot open display:
        if ! zenity --info                  \
                    --no-markup             \
                    --width     600         \
                    --height    100         \
                    --title     "$TITLE"    \
                    --text      "$@"        \
                    --ok-label  'Oké'       2> >($LOGCMD); then
            true
        fi
    else
        printf '%b\n' "$@"
    fi
}


init_script() {
    # Script-hardening.
    set -o errexit
    set -o errtrace
    set -o nounset
    set -o pipefail
    # bash 5.0: trap exit: ${FUNCNAME[0]}: ongebonden variabele
    # Enable code-stepping:
    #     trap '(read -p "[$BASH_SOURCE:$LINENO] $BASH_COMMAND?")' DEBUG
    trap 'signal error   $LINENO ${FUNCNAME:--} "$BASH_COMMAND" $?' ERR
    trap 'signal exit    $LINENO ${FUNCNAME:--} "$BASH_COMMAND" $?' EXIT
    trap 'signal sighup  $LINENO ${FUNCNAME:--} "$BASH_COMMAND" $?' SIGHUP  # 1
    trap 'signal sigint  $LINENO ${FUNCNAME:--} "$BASH_COMMAND" $?' SIGINT  # 2
    trap 'signal sigterm $LINENO ${FUNCNAME:--} "$BASH_COMMAND" $?' SIGTERM #15

    LOGCMD="systemd-cat --identifier=$PROGRAM_NAME"
    LOGCMD_CHECK="[sudo] journalctl --all --no-pager \
--identifier=$PROGRAM_NAME --since='$(date '+%Y-%m-%d %H:%M:%S')'"

    CMDLINE_ARGS=("$@")
    log "Started (as $USER $0 ${CMDLINE_ARGS[*]} from $PWD)." --priority=notice
    if [[ $DISTRO = 'debian' && $UID -ne 0 ]]; then
        log '(++) Met Debian heeft gebruiker root toegang nodig
(++) tot mijn X-sessie voor het kunnen gebruiken van
(++) zenity in kz-scripts met RUN_AS_SUPERUSER=true:
(++) xhost +si:localuser:root' --priority=debug
        xhost +si:localuser:root |& $LOGCMD --priority=debug
    fi

    # shellcheck disable=SC2034
    USAGELINE="Typ '$DISPLAY_NAME --usage' voor meer informatie."
}


log() {
    printf '%b' "$1" |& $LOGCMD "${2:---priority=info}"
}


process_common_options() {
    while true; do
        case $1 in
            -d|--debug)
                OPTION_DEBUG=true
                shift
                ;;
            -u|--usage)
                OPTION_USAGE=true
                shift
                ;;
            -h|--help)
                OPTION_HELP=true
                shift
                ;;
            -v|--version)
                OPTION_VERSION=true
                shift
                ;;
            -g|--gui)
                OPTION_GUI=true
                shift
                ;;
            --)
                break
                ;;
            *)
                shift
                ;;
        esac
    done

    if ! $OPTION_GUI && [[ -t 1 ]]; then
        # Tekstuitvoer non-gui naar de terminal.
        NORMAL=$(tput sgr0)
        BOLD=$(tput bold)
        RED=${BOLD}$(tput setaf 1)
        GREEN=${BOLD}$(tput setaf 2)
        YELLOW=${BOLD}$(tput setaf 3)
        BLUE=${BOLD}$(tput setaf 4)
    fi

    if $OPTION_DEBUG; then
        process_option_debug
    fi
    if $OPTION_HELP; then
        process_option_help
        exit $SUCCESS
    elif $OPTION_USAGE; then
        process_option_usage
        exit $SUCCESS
    elif $OPTION_VERSION; then
        process_option_version
        exit $SUCCESS
    fi
}


process_option_debug() {
    # Enable code-stepping.
    #     trap '(read -p "[$BASH_SOURCE:$LINENO] $BASH_COMMAND?")' DEBUG
    printf "${YELLOW}%s\n${NORMAL}" '*** START DEBUG-SESSIE ***'
    log 'START DEBUG-SESSIE' --priority=debug
    log 'Start show current environment' --priority=debug
    log 'uname --all:' --priority=debug
    log "$(uname --all)" --priority=debug
    log 'lsb_release --all:' --priority=debug
    log "$(lsb_release --all 2> >($LOGCMD --priority=debug))"
    log 'cat /etc/os-release:' --priority=debug
    log "$(cat /etc/os-release)" --priority=debug
    log 'declare -p:' --priority=debug
    log "$(declare -p)" --priority=debug
    log 'End show current environment' --priority=debug
    log 'Routing bash xtrace to FD4' --priority=debug
    exec 4> >($LOGCMD --priority=debug)
    BASH_XTRACEFD=4
    log 'Setting bash options'
    set -o verbose
    set -o xtrace
    log 'Let the fun begin...' --priority=debug
    # shellcheck disable=SC2016
    ps4='+(${BASH_SOURCE}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
    export PS4=$ps4
    unset ps4
}


process_option_help() {
    printf  '%s\n\n%s\n'    \
            "$HELP"         \
            "Typ 'man $DISPLAY_NAME' voor meer informatie."
}


process_option_usage() {
    printf '%s\n\n%s\n' \
            "$USAGE"    \
            "Typ '$DISPLAY_NAME --help' voor meer informatie."
}


process_option_version() {
    local copyright_years='1970'

    if [[ $RELEASE_YEAR -eq $THIS_YEAR ]]; then
        copyright_years=$RELEASE_YEAR
    else
        copyright_years=$RELEASE_YEAR-$THIS_YEAR
    fi
    info "$DISPLAY_NAME $VERSION_NUMBER ($VERSION_DATE)

Geschreven door Karel Zimmer <info@karelzimmer.nl>.

Auteursrecht (c) $copyright_years Karel Zimmer.
GNU Algemene Publieke Licentie <https://www.gnu.org/licenses/gpl.html>."
}


signal() {
    local       signal=${1:-signal?}
    local   -i  lineno=${2:-0}
    local       function=${3:-funcname?}
    local       command=${4:-command?}
    local   -i  rc=${5:-1}
    local       rc_desc=''
    local   -i  rc_desc_signalno=0
    local       status="${RED}$ERROR/ERROR${NORMAL}"

    case $rc in
        0)
            rc_desc='successful termination'
            status="${GREEN}$rc/SUCCESS${NORMAL}"
            ;;
        1)
            rc_desc='terminated with error'
            ;;
        2)
            rc_desc='terminated with warning'
            status="${YELLOW}$rc/WARNING${NORMAL}"
            ;;
        6[4-9]|7[0-8])                  # 64 - 78
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
        129)                            # sighup (128+ 1)
            rc_desc='hangup'
            ;;
        130)                            # sigint (128+ 2)
            rc_desc='terminated by control-c'
            ;;
        13[1-9]|14[0-2])                # 131 (128+3) - 142 (128+14)
            rc_desc_signalno=$((rc - 128))
            rc_desc="typ 'trap -l' and look for '$rc_desc_signalno)'"
            ;;
        143)                            # sigterm (128+15)
            rc_desc='termination signal'
            ;;
        14[4-9]|1[5-8][0-9]|19[0-2])    # 144 (128+16) - 192 (128+64)
            rc_desc_signalno=$((rc - 128))
            rc_desc="typ 'trap -l' and look for '$rc_desc_signalno)'"
            ;;
        255)
            rc_desc='exit status out of range'
            ;;
        *)
            rc_desc='unknown error'
            ;;
    esac

    log "signal: $signal, line: $lineno, function: $function, command: \
$command, code: $rc ($rc_desc)" --priority=debug

    case $signal in
        error)
            error "Opdracht is afgebroken."
            exit "$rc"
            ;;
        exit)
            signal_exit
            if $OPTION_DEBUG; then
                set +o verbose
                set +o xtrace
                BASH_XTRACEFD=''
                exec 4>&-
                printf "${YELLOW}%s\n${NORMAL}" '*** EINDE DEBUG-SESSIE ***'
                printf '%s\n' "Opdracht om de log uit te lezen:
    ${BLUE}$LOGCMD_CHECK${NORMAL}"
                log 'EINDE DEBUG-SESSIE'
            fi
            log "Ended (code=exited, status=$status)." --priority=notice
            # Een non-gui script gestart met optie gui.
            if $TERMINAL; then
                TEXT="Druk op de Enter-toets om verder te gaan [Enter]: "
                # < /dev/tty voor als FD 1 al in gebruik is.
                read -rp "$TEXT" < /dev/tty
            fi
            trap - ERR EXIT SIGINT SIGPIPE SIGTERM SIGHUP
            exit "$rc"
            ;;
        *)
            warning "Opdracht is onderbroken."
            exit "$rc"
            ;;
    esac
}


signal_exit() {
    case $PROGRAM_NAME in
        kz-backup)
            if [[ -e $BACKUP_TO_DELETE ]]; then
                info 'Programma kz-backup is onderbroken.

Opgeslagen back-up wordt verwijderd.'
                rm "$BACKUP_TO_DELETE" |& $LOGCMD
                info 'Opgeslagen back-up is verwijderd.'
            fi
            ;;
        kz-getdeb)
            rm --force /tmp/"$PROGRAM_NAME"-??????????.deb /tmp/kz-common.sh
            # Script kz-getdeb verwijdert niet kz en kz.1 ivm lokale Git-repo.
            rm --force kz.{2..99}
            # Maar wel als in HOME, zoals voorgeschreven.
            cd "$HOME" || exit $ERROR
            rm --force kz kz.1
            if [[ $rc -ne $SUCCESS ]]; then
                log "Als de pakketbeheerder 'apt' foutmeldingen geeft, start \
dan een Terminalvenster, en voer uit:
    ${BLUE}sudo dpkg --configure --pending${NORMAL}
    ${BLUE}sudo apt-get update --fix-missing${NORMAL}
    ${BLUE}sudo apt-get install --fix-broken${NORMAL}
    ${BLUE}sudo update-initramfs -u${NORMAL}" --priority=debug
            fi
            ;;
        kz-install)
            printf '%s' "${NORMAL}${CURSOR_VISABLE}"
            rm --force /tmp/"$PROGRAM_NAME"-??????????.*
            if [[ $rc -ne $SUCCESS ]]; then
                log "Als de pakketbeheerder 'apt' foutmeldingen geeft, start \
dan een Terminalvenster, en voer uit:
    ${BLUE}sudo dpkg --configure --pending${NORMAL}
    ${BLUE}sudo apt-get update --fix-missing${NORMAL}
    ${BLUE}sudo apt-get install --fix-broken${NORMAL}
    ${BLUE}sudo update-initramfs -u${NORMAL}" --priority=debug
            fi
            ;;
        kz-setup)
            printf '%s' "${NORMAL}${CURSOR_VISABLE}"
            rm --force /tmp/"$PROGRAM_NAME"-??????????.*
            ;;
        *)
            return $SUCCESS
            ;;
    esac
}


warning() {
    if $OPTION_GUI; then
        TITLE="Waarschuwing $DISPLAY_NAME"
        # Constructie '2> >($LOGCMD)' om stderr naar de log te krijgen.
        # Voorbeeld: Unable to init server: Kon niet verbinden:
        #            Verbinding is geweigerd
        #        en: (zenity:47712): Gtk-WARNING **: 10:35:49.339:
        #            cannot open display:
        if ! zenity --warning               \
                    --no-markup             \
                    --width     500         \
                    --height    100         \
                    --title     "$TITLE"    \
                    --text      "$@"        \
                    --ok-label  'Oké'       2> >($LOGCMD); then
            true
        fi
    else
        printf "${YELLOW}%b${NORMAL}\n" "$@" >&2
    fi
}


# EOF
