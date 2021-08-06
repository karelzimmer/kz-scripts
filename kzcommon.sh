# shellcheck shell=bash
# shellcheck disable=SC2034
###############################################################################
# Algemene module voor shell scripts.
#
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.
#
# Auteursrecht (c) 2009-2021 Karel Zimmer.
# GNU Algemene Publieke Licentie <https://www.gnu.org/licenses/gpl.html>.
#
# ReleaseNumber: 26.15.14
# DateOfRelease: 2021-07-23
###############################################################################


###############################################################################
# Common global constants
###############################################################################

readonly    PROGRAM_NAME=$(basename "$0")
readonly    PROGRAM_PATH=$(realpath "$(dirname  "$0")")
readonly    CALLED=$(printf '%s' "$0 $*" | xargs --null)

readonly    DASHES=$(printf '%.0s=' {1..79})

declare -ir SUCCESS=0
declare -ir ERROR=1
declare -ir WARNING=2

readonly    OPTIONS_SHORT_COMMON='dghuv'
readonly    OPTIONS_LONG_COMMON='debug,gui,help,usage,version'
readonly    OPTIONS_USAGE_COMMON="[-d|--debug] [-g|--gui] [-h|--help] \
[-u|--usage] [-v|--version] [--]"
readonly    OPTIONS_HELP_COMMON="\
  -d --debug    geef foutopsporingsinformatie weer in het logboek
  -g --gui      start in grafische modus
  -h --help     deze hulptekst tonen
  -u --usage    een korte gebruikssamenvatting tonen
  -v --version  de versie tonen
  --            stop verwerken opdrachtregelopties"


###############################################################################
# Common global variables
###############################################################################

declare     BACKUP_TO_DELETE=''
declare     HELP=''
declare -i  GETOPT_RC=0
declare     LESS_OPTIONS=''
declare     LOGCMD=''
declare     LOGCMD_CHECK=''
declare     LOGCMD_DEBUG=''
declare     OPTION_DEBUG=false
declare     OPTION_GUI=false
declare     OPTION_HELP=false
declare     OPTION_USAGE=false
declare     OPTION_VERSION=false
declare     PARSED=''
declare     RUN_AS_SUPERUSER=false
declare     STATUS_BUSY=''
declare     STATUS_ERROR=''
declare     STATUS_SUCCESS=''
declare     STATUS_WARNING=''
declare     TERMINAL=false
declare     TEXT=''
declare     TITLE=''
declare     USAGE=''
declare     USAGELINE=''

# Terminalattributen, zie 'man terminfo'.  Gebruik ${<variabele-naam>}.
declare     CARRIAGE_RETURN=''
declare     NORMAL=''
declare     BLINK=''
declare     RED=''
declare     GREEN=''
declare     YELLOW=''
declare     BLUE=''
declare     CURSOR_INVISABLE=''
declare     CURSOR_VISABLE=''
declare     ERASE_LINE=''
declare     UP_ONE_LINE=''


###############################################################################
# Common functions
###############################################################################

check_dpkg() {
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
        TITLE="Foutmelding $PROGRAM_NAME"
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
            log "restart w/ exec sudo $CALLED"
            # shellcheck disable=SC2086
            exec sudo $CALLED
        fi
    else
        if [[ $UID -eq 0 ]]; then
            info "$PROGRAM_NAME: niet uitvoeren met 'sudo' of als root"
            exit $ERROR
        fi
    fi
}


info() {
    if $OPTION_GUI; then
        TITLE="Informatie $PROGRAM_NAME"
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
    LOGCMD="systemd-cat --identifier=$PROGRAM_NAME --priority=info"
    LOGCMD_CHECK="[sudo] journalctl --all --no-pager \
--identifier=$PROGRAM_NAME --since='$(date '+%Y-%m-%d %H:%M:%S')'"
    LOGCMD_DEBUG="systemd-cat --identifier=$PROGRAM_NAME --priority=debug"
    log "started as $CALLED (from $PWD)"

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

    if [[ $(lsb_release --id --short) = 'Debian' && $UID -ne 0 ]]; then
        log '(++) Met Debian heeft gebruiker root toegang nodig tot mijn'
        log '(++) X-sessie voor het kunnen gebruiken van zenity in kzscripts'
        log '(++) met RUN_AS_SUPERUSER=true:'
        log '(++) xhost +si:localuser:root'
        xhost +si:localuser:root |& $LOGCMD
    fi

    # Less-opties, overgenomen (en aangepast, zie 'man less', zoek PROMPTS)
    # van:
    # 1. systemctl en journalctl, zie bijv. 'man systemctl', zoek LESS
    #    ("FRSXMK")
    # 2. man, zie 'mam man', zoek LESS
    LESS_OPTIONS="--LONG-PROMPT --no-init --quit-if-one-screen --quit-on-intr \
--RAW-CONTROL-CHARS --prompt=M Tekstuitvoer $PROGRAM_NAME ?ltregel \
%lt?L/%L.:byte %bB?s/%s..? .?e (EINDE) :?pB %pB\%. .(druk h voor hulp of q \
voor stoppen)"
}


log() {
    printf '%b' "$@" |& $LOGCMD
}


log_debug() {
    printf '%b' "$@" |& $LOGCMD_DEBUG
}


process_general_options() {
    while true; do
        case $1 in
            -d|--debug)
                OPTION_DEBUG=true
                shift
                ;;
            -g|--gui)
                OPTION_GUI=true
                shift
                ;;
            -h|--help)
                OPTION_HELP=true
                shift
                ;;
            -u|--usage)
                OPTION_USAGE=true
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

    if ! $OPTION_GUI && [[ -t 1 ]]; then
        # Tekstuitvoer non-gui naar de terminal.
        CARRIAGE_RETURN=$(tput cr)
        NORMAL=$(tput sgr0)
        BLINK=$(tput blink)
        RED=$(tput setaf 1)
        GREEN=$(tput setaf 2)
        YELLOW=$(tput setaf 3)
        BLUE=$(tput setaf 4)
        CURSOR_INVISABLE=$(tput civis)
        CURSOR_VISABLE=$(tput cvvis)
        ERASE_LINE="$(tput el)\c"
        UP_ONE_LINE=$(tput cuu1)
    fi
    STATUS_ERROR="[${RED}FOUT${NORMAL}]"
    STATUS_SUCCESS="[${GREEN}GOED${NORMAL}]"
    STATUS_BUSY="[${BLINK}WERK${NORMAL}]"
    STATUS_WARNING="[${YELLOW}WAARSCHUWING${NORMAL}]"

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
    log_debug 'START DEBUG-SESSIE'
    log_debug 'Start show current environment'
    log_debug 'uname --all:'
    log_debug "$(uname --all)"
    log_debug 'lsb_release --all:'
    log_debug "$(lsb_release --all 2> >($LOGCMD_DEBUG))"
    log_debug 'cat /etc/os-release:'
    log_debug "$(cat /etc/os-release)"
    log_debug 'declare -p:'
    log_debug "$(declare -p)"
    log_debug 'End show current environment'
    log_debug 'Routing bash xtrace to FD4'
    exec 4> >($LOGCMD_DEBUG)
    BASH_XTRACEFD=4
    log 'Setting bash options'
    set -o verbose
    set -o xtrace
    log_debug 'Let the fun begin...'
    # shellcheck disable=SC2016
    ps4='+(${BASH_SOURCE}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
    export PS4=$ps4
    unset ps4
}


process_option_help() {
    printf "%s\n\n%s\n" "$HELP" "Typ 'man $PROGRAM_NAME' voor meer informatie."
}


process_option_usage() {
    printf "%s\n\n%s\n" \
            "$USAGE"    \
            "Typ '$PROGRAM_NAME --help' voor meer informatie."
}


process_option_version() {
    local release_number='00.00.00'
    local copyright_years='1970'
    local release_date='1970-01-01'

    copyright_years=$(
        grep    --regexp='Auteursrecht '        \
                "$PROGRAM_PATH/$PROGRAM_NAME"   |
        awk     '{print $4;exit}'
        )
    release_number=$(
        awk -F'ReleaseNumber: '                 \
            '/ReleaseNumber: /{print $2;exit}'  \
            "$PROGRAM_PATH/$PROGRAM_NAME"
        )
    release_number=${release_number:0:8}
    release_date=$(
        awk -F'DateOfRelease: '                 \
            '/DateOfRelease: /{print $2;exit}'  \
            "$PROGRAM_PATH/$PROGRAM_NAME"
        )
    release_date=${release_date:0:10}
    info "$PROGRAM_NAME $release_number ($release_date)

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

    log_debug "signal: $signal, line: $lineno, function: $function, command: \
$command, code: $rc ($rc_desc)"

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
            log "ended (code=exited, status=$status)"
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
        kzbackup)
            if [[ -e $BACKUP_TO_DELETE ]]; then
                info 'Programma kzbackup is onderbroken.

Opgeslagen back-up wordt verwijderd.'
                rm "$BACKUP_TO_DELETE" |& $LOGCMD
                info 'Opgeslagen back-up is verwijderd.'
            fi
            ;;
        kzinstall)
            printf '%s' "${NORMAL}${CURSOR_VISABLE}"
            log_debug "Als de pakketbeheerder 'apt' foutmeldingen geeft, \
start dan een Terminalvenster, en voer uit:
    ${BLUE}sudo dpkg --configure --pending${NORMAL}
    ${BLUE}sudo apt-get update --fix-missing${NORMAL}
    ${BLUE}sudo apt-get install --fix-broken${NORMAL}
    ${BLUE}sudo update-initramfs -u${NORMAL}"
            if [[ $rc -eq $SUCCESS ]]; then
                rm --force /tmp/"$PROGRAM_NAME"-??????????.cmds
                rm --force /tmp/"$PROGRAM_NAME"-??????????.text
            fi
            ;;
        kzsetup)
            printf '%s' "${NORMAL}${CURSOR_VISABLE}"
            if [[ $rc -eq $SUCCESS ]]; then
                rm --force /tmp/"$PROGRAM_NAME"-??????????.cmds
                rm --force /tmp/"$PROGRAM_NAME"-??????????.text
            fi
            ;;
        *)
            return $SUCCESS
            ;;
    esac
}


warning() {
    if $OPTION_GUI; then
        TITLE="Waarschuwing $PROGRAM_NAME"
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
