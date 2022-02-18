# shellcheck shell=bash
###############################################################################
# Algemene module voor shell scripts.                                         #
#                                                                             #
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.                         #
###############################################################################
PROGRAM_NAME=kz-common.sh
DISPLAY_NAME=${PROGRAM_NAME/kz-/kz }
RELEASE_YEAR=2009


###############################################################################
# Common global constants
###############################################################################

readonly SUCCESS=0
readonly ERROR=1
readonly WARNING=2

# shellcheck disable=SC2034
readonly OPTIONS_SHORT_COMMON='dhuv'
# shellcheck disable=SC2034
readonly OPTIONS_LONG_COMMON='debug,help,usage,version'
# shellcheck disable=SC2034
readonly OPTIONS_USAGE_COMMON="[-u|--usage] [-h|--help] [-v|--version] \
[-d|--debug]"
# shellcheck disable=SC2034
readonly OPTIONS_HELP_COMMON="\
  -h, --help     toon deze hulptekst
  -u, --usage    toon een korte gebruikssamenvatting
  -v, --version  toon de programmaversie
  -d, --debug    neem foutopsporingsinformatie op in het logboek"

DISTRO=$(lsb_release --id --short | tr '[:upper:]' '[:lower:]')
readonly DISTRO
THIS_YEAR=$(date +%Y)
readonly THIS_YEAR


###############################################################################
# Common global variables
###############################################################################

declare -a CMDLINE_ARGS=()
HELP='Gebruik: source kz-common.sh
     of: . kz-common.sh'
LOGCMD=''
LOGCMD_CHECK=''
OPTION_DEBUG=false
OPTION_GUI=false
OPTION_HELP=false
OPTION_USAGE=false
OPTION_VERSION=false
RUN_AS_SUPERUSER=false
TITLE=''
USAGE='Gebruik: source kz-common.sh
     of: . kz-common.sh'
USAGELINE=''

# Terminalattributen, zie 'man terminfo'.  Gebruik ${<variabele-naam>}.
NORMAL=''
BOLD=''
BLUE=''
GREEN=''
RED=''
YELLOW=''


###############################################################################
# Common functions
###############################################################################

function check_on_ac_power {
    local -i on_battery=0

    on_ac_power >/dev/null 2>&1 || on_battery=$?
    if [[ on_battery -eq 1 ]]; then
        warning '
De computer gebruikt nu alleen de accu voor de stroomvoorziening.

Geadviseerd wordt om de computer aan te sluiten op het stopcontact.
'
    fi
}


function error {
    if $OPTION_GUI; then
        TITLE="Foutmelding $DISPLAY_NAME"
        # Constructie '2> >($LOGCMD)' om stderr naar de log te krijgen.
        # Voorbeeld: Unable to init server: Kon niet verbinden:
        #            Verbinding is geweigerd
        #        en: (zenity:47712): Gtk-WARNING **: 10:35:49.339:
        #            cannot open display:
        zenity  --error                 \
                --no-markup             \
                --width     500         \
                --height    100         \
                --title     "$TITLE"    \
                --text      "$@"        \
                --ok-label  'Oké'       2> >($LOGCMD) || true
    else
        printf "${RED}%b\n${NORMAL}" "$@" >&2
    fi
}


function check_user {
    local prompt=''

    if $RUN_AS_SUPERUSER; then
        if [[ $UID -ne 0 ]]; then
            log "Restarted (exec sudo $0 ${CMDLINE_ARGS[*]})." --priority=debug
            prompt="Authenticatie is vereist om '$DISPLAY_NAME' uit te voeren.
[sudo] wachtwoord voor %p: "
            exec sudo --prompt="$prompt" "$0" "${CMDLINE_ARGS[@]}"
        fi
    else
        if [[ $UID -eq 0 ]]; then
            warning "Niet uitvoeren met 'sudo' of als root."
            exit $WARNING
        fi
    fi
}


function info {
    if $OPTION_GUI; then
        TITLE="Informatie $DISPLAY_NAME"
        # Constructie '2> >($LOGCMD)' om stderr naar de log te krijgen.
        # Voorbeeld: Unable to init server: Kon niet verbinden:
        #            Verbinding is geweigerd
        #        en: (zenity:47712): Gtk-WARNING **: 10:35:49.339:
        #            cannot open display:
        zenity  --info                  \
                --no-markup             \
                --width     600         \
                --height    100         \
                --title     "$TITLE"    \
                --text      "$@"        \
                --ok-label  'Oké'       2> >($LOGCMD) || true
    else
        printf '%b\n' "$@"
    fi
}


function init_script {
    # Script-hardening.
    set -o errexit
    set -o errtrace
    set -o nounset
    set -o pipefail
    trap 'signal error   $LINENO ${FUNCNAME:--} "$BASH_COMMAND" $?' ERR
    trap 'signal exit    $LINENO ${FUNCNAME:--} "$BASH_COMMAND" $?' EXIT
    trap 'signal sighup  $LINENO ${FUNCNAME:--} "$BASH_COMMAND" $?' SIGHUP  # 1
    trap 'signal sigint  $LINENO ${FUNCNAME:--} "$BASH_COMMAND" $?' SIGINT  # 2
    trap 'signal sigpipe $LINENO ${FUNCNAME:--} "$BASH_COMMAND" $?' SIGPIPE #13
    trap 'signal sigterm $LINENO ${FUNCNAME:--} "$BASH_COMMAND" $?' SIGTERM #15
    # Enable code-stepping:
    #     trap '(read -p "[$BASH_SOURCE:$LINENO] $BASH_COMMAND?")' DEBUG
    LOGCMD="systemd-cat --identifier=$PROGRAM_NAME"
    LOGCMD_CHECK="journalctl --all --boot --identifier=$PROGRAM_NAME \
--since='$(date '+%Y-%m-%d %H:%M:%S')'"

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

    if [[ -t 1 ]]; then
        NORMAL=$(tput sgr0)
        BOLD=$(tput bold)
        BLUE=${BOLD}$(tput setaf 4)
        GREEN=${BOLD}$(tput setaf 2)
        RED=${BOLD}$(tput setaf 1)
        YELLOW=${BOLD}$(tput setaf 3)
    fi
}


function log {
    printf '%b' "$1" |& $LOGCMD "${2:---priority=info}"
}


function process_common_options {
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
            --)
                break
                ;;
            *)
                shift
                ;;
        esac
    done

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


function process_option_debug {
    # Enable code-stepping.
    #     trap '(read -p "[$BASH_SOURCE:$LINENO] $BASH_COMMAND?")' DEBUG
    warning '*** START DEBUG-SESSIE ***'
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


function process_option_help {
    info "$HELP

Typ 'man $DISPLAY_NAME' voor meer informatie."
}


function process_option_usage {
    info "$USAGE

Typ '$DISPLAY_NAME --help' voor meer informatie."
}


function process_option_version {
    local build=''
    local copyright_years='1970'

    build=$(cat /usr/local/etc/kz-build 2> /dev/null || printf '%s' 'unknown')

    if [[ $RELEASE_YEAR -eq $THIS_YEAR ]]; then
        copyright_years=$RELEASE_YEAR
    else
        copyright_years=$RELEASE_YEAR-$THIS_YEAR
    fi

    info "$DISPLAY_NAME versie 365 (kz build $build)

Geschreven door Karel Zimmer <info@karelzimmer.nl>.

Auteursrecht (c) $copyright_years Karel Zimmer.
GNU Algemene Publieke Licentie <https://www.gnu.org/licenses/gpl.html>."
}


function signal {
    local       signal=${1:-signal?}
    local -i    lineno=${2:-0}
    local       function=${3:-funcname?}
    local       command=${4:-command?}
    local -i    rc=${5:-1}
    local       rc_desc=''
    local -i    rc_desc_signalno=0
    local       status=''

    case $rc in
        0)
            rc_desc='successful termination'
            status="${GREEN}$rc/SUCCESS${NORMAL}"
            ;;
        1)
            rc_desc='terminated with error'
            status="${RED}$rc/ERROR${NORMAL}"
            ;;
        2)
            rc_desc='terminated with warning'
            status="${YELLOW}$rc/WARNING${NORMAL}"
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
        129)                            # SIGHUP (128+ 1)
            rc_desc='hangup'
            ;;
        130)                            # SIGINT (128+ 2)
            rc_desc='terminated by control-c'
            ;;
        13[1-9]|140)                    # 140 (128+12)
            rc_desc_signalno=$((rc - 128))
            rc_desc="typ 'trap -l' and look for '$rc_desc_signalno)'"
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
            error "Programma $PROGRAM_NAME is afgebroken."
            info "
Controleer de log in het Terminalvenster met:
    ${BLUE}$LOGCMD_CHECK${NORMAL}"
            exit "$rc"
            ;;
        exit)
            signal_exit
            if $OPTION_DEBUG; then
                set +o verbose
                set +o xtrace
                BASH_XTRACEFD=''
                exec 4>&-
                warning "*** EINDE DEBUG-SESSIE ***"
                info "
Controleer de log in het Terminalvenster met:
    ${BLUE}$LOGCMD_CHECK${NORMAL}"
                log 'EINDE DEBUG-SESSIE'
            fi
            log "Ended (code=exited, status=$status)." --priority=notice
            trap - ERR EXIT SIGHUP SIGINT SIGPIPE SIGTERM
            exit "$rc"
            ;;
        *)
            warning "Programma $PROGRAM_NAME is onderbroken."
            info "
Controleer de log in het Terminalvenster met:
    ${BLUE}$LOGCMD_CHECK${NORMAL}"
            exit "$rc"
            ;;
    esac
}


function signal_exit {
    case $PROGRAM_NAME in
        kz-getdeb)
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
            rm "$CMDS_FILE" "$CMDS_FILE2" "$TEXT_FILE" "$TEMP_LIST"
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
            rm "$CMDS_FILE" "$CMDS_FILE2" "$TEXT_FILE"
            ;;
        *)
            return $SUCCESS
            ;;
    esac
}


function warning {
    if $OPTION_GUI; then
        TITLE="Waarschuwing $DISPLAY_NAME"
        # Constructie '2> >($LOGCMD)' om stderr naar de log te krijgen.
        # Voorbeeld: Unable to init server: Kon niet verbinden:
        #            Verbinding is geweigerd
        #        en: (zenity:47712): Gtk-WARNING **: 10:35:49.339:
        #            cannot open display:
        zenity  --warning               \
                --no-markup             \
                --width     500         \
                --height    100         \
                --title     "$TITLE"    \
                --text      "$@"        \
                --ok-label  'Oké'       2> >($LOGCMD) || true
    else
        printf "${YELLOW}%b\n${NORMAL}" "$@" >&2
    fi
}
