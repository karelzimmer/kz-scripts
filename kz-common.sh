# shellcheck shell=bash
###############################################################################
# Algemene module voor shell scripts.                                         #
#                                                                             #
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.                         #
###############################################################################
declare PROGRAM_NAME='kz-common.sh'
declare DISPLAY_NAME=${PROGRAM_NAME/kz-/kz }
declare RELEASE_YEAR=2009

###############################################################################
# Common global constants
###############################################################################

readonly SUCCESS=0
readonly ERROR=1
readonly WARNING=2

# shellcheck disable=SC2034
readonly OPTIONS_SHORT_COMMON='huv'
# shellcheck disable=SC2034
readonly OPTIONS_LONG_COMMON='help,usage,version'
# shellcheck disable=SC2034
readonly OPTIONS_USAGE_COMMON='[-u|--usage] [-h|--help] [-v|--version]'
# shellcheck disable=SC2034
readonly OPTIONS_HELP_COMMON="\
  -h, --help     toon deze hulptekst
  -u, --usage    toon een korte gebruikssamenvatting
  -v, --version  toon de programmaversie"

DISTRO=$(lsb_release --id --short | tr '[:upper:]' '[:lower:]')
readonly DISTRO
THIS_YEAR=$(date +%Y)
readonly THIS_YEAR

###############################################################################
# Common global variables
###############################################################################

declare -a  CMDLINE_ARGS=()
declare     HELP='Gebruik: source kz-common.sh
     of: . kz-common.sh'
declare     LOGCMD_CHECK=''
declare     LOGCMD=''
declare     ERROR_MSG_TO_LOG=false
declare     OPTION_GUI=false
declare     OPTION_HELP=false
declare     OPTION_USAGE=false
declare     OPTION_VERSION=false
declare     RUN_AS_SUPERUSER=false
declare     TITLE=''
declare     USAGE='Gebruik: source kz-common.sh
     of: . kz-common.sh'
declare     USAGELINE=''

# Terminalattributen, zie 'man terminfo'.  Gebruik ${<variabele-naam>}.
declare     BLINK=''
declare     BLUE=''
declare     BOLD=''
declare     CARRIAGE_RETURN=''
declare     CURSOR_INVISABLE=''
declare     CURSOR_VISABLE=''
declare     GREEN=''
declare     NORMAL=''
declare     RED=''
declare     REWRITE_LINE=''
declare     YELLOW=''

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
        if $ERROR_MSG_TO_LOG; then
            log 'ERROR_MSG_TO_LOG is set, no zenity error msg' --priority=debug
            log "$@"
        else
            TITLE="Foutmelding $DISPLAY_NAME"
            # Constructie '2> >($LOGCMD)' om stderr naar de log te krijgen.
            zenity  --error                 \
                    --no-markup             \
                    --width     500         \
                    --height    100         \
                    --title     "$TITLE"    \
                    --text      "$@"        \
                    --ok-label  'Oké'       2> >($LOGCMD) || true &
        fi
    else
        printf "${RED}%b\n${NORMAL}" "$@" >&2
    fi
}


function check_user {
    if $RUN_AS_SUPERUSER; then
        if [[ $UID -ne 0 ]]; then
            log "Restarted (exec sudo $0 ${CMDLINE_ARGS[*]})." --priority=debug
            exec sudo "$0" "${CMDLINE_ARGS[@]}"
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
        set_terminal_attributes
    fi
}


function log {
    printf '%b\n' "$1" |& $LOGCMD "${2:---priority=info}"
}


function logcmd_check {
    temp_log=$(mktemp -t "$PROGRAM_NAME-XXXXXXXXXX.log")
    eval "$LOGCMD_CHECK" > "$temp_log"
    if $OPTION_GUI; then
        zenity  --text-info             \
                --width     1200        \
                --height    600         \
                --title     "$TITLE"    \
                --filename  "$temp_log" \
                --ok-label  'Oké'       2> >($LOGCMD) || true
    else
        cat "$temp_log"
    fi
    rm "$temp_log"
}


function process_common_options {
    while true; do
        case $1 in
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


function reset_terminal_attributes {
    BLINK=''
    BLUE=''
    BOLD=''
    CARRIAGE_RETURN=''
    CURSOR_INVISABLE=''
    CURSOR_VISABLE=''
    GREEN=''
    NORMAL=''
    RED=''
    REWRITE_LINE=''
    YELLOW=''
}


function set_terminal_attributes {
    BOLD=$(tput bold)
    # shellcheck disable=SC2034
    BLINK=$(tput blink)
    BLUE=${BOLD}$(tput setaf 4)
    # shellcheck disable=SC2034
    CARRIAGE_RETURN=$(tput cr)
    # shellcheck disable=SC2034
    CURSOR_INVISABLE=$(tput civis)
    CURSOR_VISABLE=$(tput cvvis)
    GREEN=${BOLD}$(tput setaf 2)
    NORMAL=$(tput sgr0)
    RED=${BOLD}$(tput setaf 1)
    # shellcheck disable=SC2034
    REWRITE_LINE=$(tput cuu1;tput el)
    YELLOW=${BOLD}$(tput setaf 3)
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
            error "${RED}Programma $PROGRAM_NAME is afgebroken.${NORMAL}

Controleer de hier getoonde log.
Of met Terminalvenster-opdracht: ${BLUE}$LOGCMD_CHECK${NORMAL}"
            exit "$rc"
            ;;
        exit)
            signal_exit
            log "Ended (code=exited, status=$status)." --priority=notice
            trap - ERR EXIT SIGHUP SIGINT SIGPIPE SIGTERM
            exit "$rc"
            ;;
        *)
            warning "Programma $PROGRAM_NAME is onderbroken."
            exit "$rc"
            ;;
    esac
}


function signal_exit {
    case $PROGRAM_NAME in
        kz-getdeb)
            rm --force /tmp/kz-common.sh
            # Verwijder niet kz en kz.1 i.v.m. lokale Git-repo.
            rm --force kz.{2..99}
            # Maar wel als in HOME, zoals voorgeschreven in Checklist install.
            cd "$HOME" || exit $ERROR
            rm --force kz kz.1
            if [[ $rc -ne $SUCCESS ]]; then
                log "Als de pakketbeheerder 'apt' foutmeldingen geeft, start \
een Terminalvenster en voer uit:
    ${BLUE}sudo dpkg --configure --pending${NORMAL}
    ${BLUE}sudo apt-get update --fix-missing${NORMAL}
    ${BLUE}sudo apt-get install --fix-broken${NORMAL}
    ${BLUE}sudo update-initramfs -u${NORMAL}" --priority=debug
            fi
            ;;
        kz-install)
            printf '%s' "${NORMAL}${CURSOR_VISABLE}"
            if [[ $rc -ne $SUCCESS ]]; then
                log "Als de pakketbeheerder 'apt' foutmeldingen geeft, start \
een Terminalvenster en voer uit:
    ${BLUE}sudo dpkg --configure --pending${NORMAL}
    ${BLUE}sudo apt-get update --fix-missing${NORMAL}
    ${BLUE}sudo apt-get install --fix-broken${NORMAL}
    ${BLUE}sudo update-initramfs -u${NORMAL}" --priority=debug
            fi
            ;;
        kz-setup)
            printf '%s' "${NORMAL}${CURSOR_VISABLE}"
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
