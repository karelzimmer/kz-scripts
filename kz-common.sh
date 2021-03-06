# shellcheck shell=bash
###############################################################################
# Algemene module voor shell scripts.
#
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.
###############################################################################

declare PROGRAM_NAME='kz-common.sh'
declare DISPLAY_NAME=${PROGRAM_NAME/kz-/kz }
declare RELEASE_YEAR=2009

###############################################################################
# Common global constants
###############################################################################

readonly SUCCESS=0
readonly ERROR=1

# shellcheck disable=SC2034
readonly OPTIONS_SHORT_COMMON='huv'
# shellcheck disable=SC2034
readonly OPTIONS_LONG_COMMON='help,usage,version'
# shellcheck disable=SC2034
readonly OPTIONS_USAGE_COMMON='[-h|--help] [-u|--usage] [-v|--version]'
# shellcheck disable=SC2034
readonly OPTIONS_HELP_COMMON="\
  -h, --help     toon deze hulptekst
  -u, --usage    toon een korte gebruikssamenvatting
  -v, --version  toon de programmaversie"

DASHES=$(printf '%.0s=' {1..79})
readonly DASHES

###############################################################################
# Common global variables
###############################################################################

declare -a  CMDLINE_ARGS=()
declare     HELP='Gebruik: source kz-common.sh
     of: . kz-common.sh'
declare     LOGCMD_CHECK=''
declare     NOERROR=false
declare     LESS_OPTIONS=''
declare     LOGCMD=''
declare     OPTION_GUI=false
declare     OPTION_HELP=false
declare     OPTION_USAGE=false
declare     OPTION_VERSION=false
declare     PROGRAM=''
declare     TITLE=''
declare     USAGE='Gebruik: source kz-common.sh
     of: . kz-common.sh'

# Terminalattributen, zie 'man terminfo'.  Gebruik ${<variabele-naam>}.
declare     BLINK=''
declare     BLUE=''
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

function check_dpkg {
    local -i wait_for_aptd=5

    if ls /snap/core/*/var/cache/debconf/config.dat &> /dev/null; then
        while sudo  fuser                                               \
                    /var/{lib/{dpkg,apt/lists},cache/apt/archives}/lock \
                    /var/cache/debconf/config.dat                       \
                    /snap/core/*/var/cache/debconf/config.dat           \
                    &> /dev/null; do
            log 'Wacht tot andere pakketbeheerder klaar is...'
            sleep $wait_for_aptd
        done
    else
        while sudo  fuser                                               \
                    /var/{lib/{dpkg,apt/lists},cache/apt/archives}/lock \
                    /var/cache/debconf/config.dat                       \
                    &> /dev/null; do
            log 'Wacht tot andere pakketbeheerder klaar is...'
            sleep $wait_for_aptd
        done
    fi
}


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


function check_user_root {
    local -i pkexec_rc=0

    if ! check_user_sudo; then
        info 'Reeds uitgevoerd door de beheerder.'
        exit $SUCCESS
    fi
    if [[ $UID -ne 0 ]]; then
        if $OPTION_GUI; then
            log "Restarted (pkexec $PROGRAM ${CMDLINE_ARGS[*]})." \
                --priority=debug
            pkexec "$PROGRAM" "${CMDLINE_ARGS[@]}" || pkexec_rc=$?
            NOERROR=true exit $pkexec_rc
        else
            log "Restarted (exec sudo $0 ${CMDLINE_ARGS[*]})." \
                --priority=debug
            exec sudo "$0" "${CMDLINE_ARGS[@]}"
        fi
    fi
}


function check_user_sudo {
    # Mag gebruiker sudo uitvoeren?
    if [[ $UID -eq 0 ]]; then
        # Voor de "grace"-periode van sudo, of als root.
        return $SUCCESS
    elif groups "$USER" | grep --quiet --regexp='sudo'; then
        return $SUCCESS
    else
        return $ERROR
    fi
}


function error {
    if $NOERROR; then
        return $SUCCESS
    fi
    if $OPTION_GUI; then
        TITLE="Foutmelding $DISPLAY_NAME"
        # Constructie '2> >($LOGCMD)' om stderr naar de log te krijgen.
        zenity  --error                 \
                --no-markup             \
                --width     500         \
                --height    100         \
                --title     "$TITLE"    \
                --text      "$@"        \
                --ok-label  'Ok??'       2> >($LOGCMD) || true
    else
        printf "${RED}%b\n${NORMAL}" "$@" >&2
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
                --ok-label  'Ok??'       2> >($LOGCMD) || true
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
    # trap '(read -p "[$BASH_SOURCE:$LINENO] $BASH_COMMAND?")' DEBUG
    LOGCMD="systemd-cat --identifier=$PROGRAM_NAME"
    LOGCMD_CHECK="journalctl --all --boot --identifier=$PROGRAM_NAME \
--since='$(date '+%Y-%m-%d %H:%M:%S')'"

    # For pkexec to work with policy file it is needed to replace e.g.
    # './kz-install' by '/home/karel/kz-scripts/kz-install'.
    PROGRAM=${0/./$PROGRAM_PATH}
    CMDLINE_ARGS=("$@")

    log "$DASHES"
    log "Started ($PROGRAM ${CMDLINE_ARGS[*]} as $USER)." --priority=notice
    if [[ $(lsb_release --id --short) = 'Debian' && $UID -ne 0 ]]; then
        xhost +si:localuser:root |& $LOGCMD --priority=debug
    fi

    # shellcheck disable=SC2034
    USAGELINE="Typ '$DISPLAY_NAME --usage' voor meer informatie."

    # Less-opties, overgenomen (en aangepast, zie 'man less', zoek PROMPTS)
    # van:
    # 1. systemctl en journalctl, zie bijvoorbeeld 'man systemctl', zoek LESS
    #    ("FRSXMK")
    # 2. man, zie 'man man', zoek LESS
    LESS_OPTIONS="--LONG-PROMPT --no-init --quit-if-one-screen --quit-on-intr \
--RAW-CONTROL-CHARS --prompt=MTekstuitvoer $DISPLAY_NAME ?ltregel %lt?L van \
%L.:byte %bB?s van %s..? .?e (EINDE) :?pB %pB\%. .(druk h voor hulp of q voor \
stoppen)"

    if [[ -t 1 ]]; then
        set_terminal_attributes
    fi
}


function log {
    printf '%b\n' "$1" |& $LOGCMD "${2:---priority=info}"
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
    local copyright_years=1970
    local this_year=1970

    build=$(cat /usr/local/etc/kz-build 2> /dev/null || printf '%s' 'unknown')

    this_year=$(date +%Y)
    if [[ $RELEASE_YEAR -eq $this_year ]]; then
        copyright_years=$this_year
    else
        copyright_years=$RELEASE_YEAR-$this_year
    fi

    info "$DISPLAY_NAME versie 365 (kz build $build)

Geschreven door Karel Zimmer <info@karelzimmer.nl>.

Auteursrecht (c) $copyright_years Karel Zimmer.
GNU Algemene Publieke Licentie <https://www.gnu.org/licenses/gpl.html>."
}

function process_usage {
    info "Typ '$DISPLAY_NAME --usage' voor meer informatie." >&2
}

function reset_terminal_attributes {
    BLINK=''
    BLUE=''
    CURSOR_INVISABLE=''
    CURSOR_VISABLE=''
    GREEN=''
    NORMAL=''
    RED=''
    REWRITE_LINE=''
    YELLOW=''
}


function set_terminal_attributes {
    # shellcheck disable=SC2034
    BLINK=$(tput bold; tput blink)
    BLUE=$(tput bold; tput setaf 4)
    # shellcheck disable=SC2034
    CURSOR_INVISABLE=$(tput civis)
    CURSOR_VISABLE=$(tput cvvis)
    GREEN=$(tput bold; tput setaf 2)
    NORMAL=$(tput sgr0)
    RED=$(tput bold; tput setaf 1)
    # shellcheck disable=SC2034
    REWRITE_LINE=$(tput cuu1; tput el)
    YELLOW=$(tput bold; tput setaf 3)
}


function signal {
    local       signal=${1:-signal?}
    local -i    lineno=${2:-0}
    local       function=${3:-funcname?}
    local       command=${4:-command?}
    local -i    rc=${5:-1}
    local       rc_desc=''
    local -i    rc_desc_signalno=0
    local       status="${RED}$rc/ERROR${NORMAL}"

    case $rc in
        0)
            rc_desc='successful termination'
            status="${GREEN}$rc/SUCCESS${NORMAL}"
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
            exit "$rc"
            ;;
        exit)
            signal_exit
            log "Ended (code=exited, status=$status)." --priority=notice
            log "$DASHES"
            trap - ERR EXIT SIGHUP SIGINT SIGPIPE SIGTERM
            if [[ $rc -ne $SUCCESS ]]; then
                signal_exit_log 'E??n of meerdere opdrachten zijn fout gegaan.'
            fi
            exit "$rc"
            ;;
        *)
            error "Programma $PROGRAM_NAME is onderbroken."
            exit "$rc"
            ;;
    esac
}


function signal_exit {
    local apt_error="Als de pakketbeheerder 'apt' foutmeldingen geeft, start \
een Terminalvenster en voer uit:
[1] ${BLUE}sudo dpkg --configure --pending${NORMAL}
[2] ${BLUE}sudo apt-get update --fix-missing${NORMAL}
[3] ${BLUE}sudo apt-get install --fix-broken${NORMAL}
[4] ${BLUE}sudo update-initramfs -u${NORMAL}"

    case $PROGRAM_NAME in
        kz-getdeb)
            # Verwijder niet kz en kz.1 i.v.m. script kz en man-pagina kz.1.
            rm --force kz.{2..99} /tmp/kz-common.sh
            # Maar wel als in HOME, zoals beschreven in Checklist installatie.
            cd "$HOME"
            rm --force kz kz.1

            if [[ $rc -ne $SUCCESS ]]; then
                log "$apt_error" --priority=debug
            fi
            ;;
        kz-install)
            printf "${NORMAL}%s" "${CURSOR_VISABLE}"

            if [[ $rc -ne $SUCCESS ]]; then
                log "$apt_error" --priority=debug
            fi
            ;;
        kz-setup)
            printf "${NORMAL}%s" "${CURSOR_VISABLE}"
            ;;
        *)
            return $SUCCESS
            ;;
    esac
}


function signal_exit_log {
    local temp_log=''

    if $NOERROR; then
        return $SUCCESS
    fi
    temp_log=$(mktemp -t "$PROGRAM_NAME-XXXXXXXXXX.log")
    {
        printf "${RED}%s\n${NORMAL}" "$@"
        printf "%s\n" 'Logberichten:'
        eval "$LOGCMD_CHECK"
        printf "%s ${BLUE}%s${NORMAL}\n" 'Log-opdracht:' "$LOGCMD_CHECK"
    } > "$temp_log"
    if $OPTION_GUI; then
        TITLE="Logberichten $DISPLAY_NAME"
        zenity  --text-info             \
                --width     1200        \
                --height    600         \
                --title     "$TITLE"    \
                --filename  "$temp_log" \
                --ok-label  'Ok??'       2> >($LOGCMD) || true
    else
        less "$LESS_OPTIONS" "$temp_log"
    fi
    rm "$temp_log"
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
                --ok-label  'Ok??'       2> >($LOGCMD) || true
    else
        printf "${YELLOW}%b\n${NORMAL}" "$@" >&2
    fi
}

true
