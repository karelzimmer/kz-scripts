###############################################################################
# SPDX-FileComment: Common module for kz Python scripts
#
# SPDX-FileCopyrightText: Karel Zimmer <info@karelzimmer.nl>
# SPDX-License-Identifier: CC0-1.0
###############################################################################


###############################################################################
# Imports
###############################################################################

import argparse
import gettext
import os
import subprocess
import sys
import time
import systemd.journal  # type: ignore

gettext.bindtextdomain('kz', '/usr/share/locale')
gettext.textdomain('kz')
_ = gettext.gettext


###############################################################################
# Constants
###############################################################################

MODULE_NAME: str = 'kz_common.py'
MODULE_DESC: str = _('Common module for Python scripts')

OPTIONS_USAGE: str = '[-h|--help] [-m|--manual] [-u|--usage] [-v|--version]'

OPTIONS_HELP: str = (f"{_('  -h, --help     show this help text')}\n"
                     f"{_('  -m, --manual   show manual page')}\n"
                     f"{_('  -u, --usage    show a short usage summary')}\n"
                     f"{_('  -v, --version  show program version')}")

OK: int = 0
ERR: int = 1

# List NORMAL last here so that Python debugger (pdb) doesn't bork the display.
BOLD: str = '\033[1m'
RED: str = '\033[1;31m'
NORMAL: str = '\033[0m'

if subprocess.run('type systemctl', executable='bash',
                  stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL,
                  shell=True).returncode != OK:
    print(_('fatal: no systemd available'))
    sys.exit(ERR)

if not os.path.exists('/etc/os-release'):
    print(_('fatal: no os release available'))
    sys.exit(ERR)


###############################################################################
# Functions
###############################################################################

def become_root(PROGRAM_NAME: str, PROGRAM_DESC: str, DISPLAY_NAME: str,
                OPTION_GUI: bool = False) -> None:
    """
    This function checks whether the script is started as user root and
    restarts the script as user root if not.
    """
    EXEC_SUDO: str = 'exec sudo '

    if not become_root_check(DISPLAY_NAME, PROGRAM_DESC, OPTION_GUI):
        term(PROGRAM_NAME, OK)

    if os.getuid() != 0:
        # From "['path/script', 'arg1', ...]" to "'path/script' 'arg1' ...".
        for arg_num in range(len(sys.argv)):
            if arg_num == 0:
                EXEC_SUDO += str(sys.argv[arg_num])
            else:
                EXEC_SUDO += ' ' + str(sys.argv[arg_num])
        TEXT: str = f'Restart ({EXEC_SUDO})'
        logmsg(DISPLAY_NAME, TEXT)

        try:
            subprocess.run(EXEC_SUDO, executable='bash',
                           shell=True, check=True)
        except KeyboardInterrupt:
            TEXT = _('Program {} has been interrupted.').format(PROGRAM_NAME)
            errmsg(DISPLAY_NAME, PROGRAM_DESC, TEXT)
            term(PROGRAM_NAME, ERR)
        except Exception as exc:
            TEXT = str(exc)
            logmsg(PROGRAM_NAME, TEXT)
            TEXT = _('Program {} encountered an error.').format(PROGRAM_NAME)
            errmsg(DISPLAY_NAME, PROGRAM_DESC, TEXT)
            term(PROGRAM_NAME, ERR)
        else:
            term(PROGRAM_NAME, ERR)


def become_root_check(DISPLAY_NAME: str, PROGRAM_DESC: str,
                      OPTION_GUI: bool = False) -> bool:
    """
    This function checks if the user is allowed to become root and returns 0 if
    so, otherwise returns 1 with descriptive message.
    """
    COMMAND: str = 'groups $USER | grep --quiet --regexp=sudo --regexp=wheel'
    if os.getuid() == 0:
        return True
    try:
        subprocess.run(COMMAND, executable='bash', shell=True, check=True)
    except Exception:
        TEXT: str = _('Already performed by the administrator.')
        infomsg(DISPLAY_NAME, PROGRAM_DESC, TEXT, OPTION_GUI)
        return False
    else:
        return True


def check_package_manager(DISPLAY_NAME: str, PROGRAM_DESC: str) -> int:
    """
    This function checks for another running package manager and waits for the
    next check if so.
    """
    CHECK_WAIT: int = 10
    COMMAND1: str = 'grep --quiet rhel /etc/os-release'
    COMMAND2: str = 'sudo fuser --silent /var/cache/debconf/config.dat '
    COMMAND2 += '/var/{lib/{dpkg,apt/lists},cache/apt/archives}/lock*'

    if subprocess.run(COMMAND1, executable='bash',
                      stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL,
                      shell=True).returncode == OK:
        return OK

    while True:
        try:
            subprocess.run(COMMAND2, executable='bash', shell=True, check=True)
        except Exception:
            break
        else:
            TEXT: str = _('Wait for another package manager to finish') + '...'
            infomsg(DISPLAY_NAME, PROGRAM_DESC, TEXT)
            time.sleep(CHECK_WAIT)

    return OK


def errmsg(DISPLAY_NAME: str, PROGRAM_DESC: str, TEXT: str,
           OPTION_GUI: bool = False) -> None:
    """
    This function returns an error message.
    """
    if OPTION_GUI:
        TITLE: str = f"{PROGRAM_DESC} {_('error message')} ({DISPLAY_NAME})"
        COMMAND: str = f'zenity --error                 \
                                --width     600         \
                                --height    100         \
                                --title     "{TITLE}"   \
                                --text      "{TEXT}"'
        subprocess.run(COMMAND, executable='bash', shell=True)
    else:
        print(f'\n{RED}{TEXT}{NORMAL}')


def infomsg(DISPLAY_NAME: str, PROGRAM_DESC: str, TEXT: str = '',
            OPTION_GUI: bool = False) -> None:
    """
    This function returns an informational message.
    """
    if OPTION_GUI:
        TITLE: str = f"{PROGRAM_DESC} {_('information')} ({DISPLAY_NAME})"
        COMMAND: str = f'zenity --info                  \
                                --width     600         \
                                --height    100         \
                                --title     "{TITLE}"   \
                                --text      "{TEXT}"'
        subprocess.run(COMMAND, executable='bash', shell=True)
    else:
        print(TEXT)


def init(DISPLAY_NAME: str) -> None:
    """
    This function performs initial actions.
    """
    TEXT: str = f'==== START logs for script {DISPLAY_NAME} ===='
    logmsg(DISPLAY_NAME, TEXT)


def logmsg(PROGRAM_NAME: str, TEXT: str) -> None:
    """
    This function records a message to the log.
    """
    systemd.journal.sendv(f'SYSLOG_IDENTIFIER={PROGRAM_NAME}',
                          f'MESSAGE={TEXT}')


def process_options(PROGRAM_NAME: str, PROGRAM_DESC: str, DISPLAY_NAME: str,
                    USAGE: str, HELP: str) -> None:
    """
    This function handles the common options and arguments.
    """
    ARGS = None
    PARSER = None
    UNKNOWN = None

    PARSER = argparse.ArgumentParser(prog=DISPLAY_NAME, usage=USAGE,
                                     add_help=False)

    PARSER.add_argument('-h', '--help', action='store_true')
    PARSER.add_argument('-m', '--manual', action='store_true')
    PARSER.add_argument('-u', '--usage', action='store_true')
    PARSER.add_argument('-v', '--version', action='store_true')

    ARGS, UNKNOWN = PARSER.parse_known_args()

    if ARGS.help:
        process_option_help(DISPLAY_NAME, PROGRAM_DESC, HELP, PROGRAM_NAME)
        term(PROGRAM_NAME, OK)
    elif ARGS.manual:
        process_option_manual(PROGRAM_NAME, PROGRAM_DESC, DISPLAY_NAME)
        term(PROGRAM_NAME, OK)
    elif ARGS.usage:
        process_option_usage(DISPLAY_NAME, PROGRAM_DESC, USAGE)
        term(PROGRAM_NAME, OK)
    elif ARGS.version:
        process_option_version(PROGRAM_NAME, PROGRAM_DESC, DISPLAY_NAME)
        term(PROGRAM_NAME, OK)
    elif UNKNOWN:
        None


def process_option_help(DISPLAY_NAME: str, PROGRAM_DESC: str, HELP: str,
                        PROGRAM_NAME: str) -> None:
    """
    This function shows the available help.
    """
    YELP_MAN_URL: str = ''

    if subprocess.run('[[ ${DISPLAY-} ]]', executable='bash',
                      stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL,
                      shell=True).returncode == OK:
        YELP_MAN_URL = f"{_(', or see the ')}"
        YELP_MAN_URL += f'\x1b]8;;man:{PROGRAM_NAME}(1)\x1b\\{DISPLAY_NAME}(1)'
        YELP_MAN_URL += f" {_('man page')}\x1b]8;;\x1b\\"
    TEXT: str = (f'{HELP}\n\n'
                 f'''{_("Type '{} --manual' or 'man {}'{} ").
                      format(DISPLAY_NAME, DISPLAY_NAME, YELP_MAN_URL)}'''
                 f"{_('for more information.')}")
    infomsg(DISPLAY_NAME, PROGRAM_DESC, TEXT)


def process_option_manual(PROGRAM_NAME: str, PROGRAM_DESC: str,
                          DISPLAY_NAME: str) -> None:
    """
    This function displays the manual page..
    """
    COMMAND1: str = f'yelp man:{PROGRAM_NAME}'
    COMMAND2: str = f'man --pager=cat {PROGRAM_NAME}'

    if subprocess.run('[[ ${DISPLAY-} ]]', executable='bash',
                      stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL,
                      shell=True).returncode == OK:
        try:
            subprocess.run(COMMAND1, executable='bash',
                           stderr=subprocess.DEVNULL,
                           shell=True, check=True,)
        except Exception as exc:
            TEXT: str = str(exc)
            logmsg(PROGRAM_NAME, TEXT)
            TEXT = _('Program {} encountered an error.').format(PROGRAM_NAME)
            errmsg(DISPLAY_NAME, PROGRAM_DESC, TEXT)
            term(PROGRAM_NAME, ERR)
    else:
        try:
            subprocess.run(COMMAND2, executable='bash', shell=True, check=True)
        except Exception as exc:
            TEXT = str(exc)
            logmsg(PROGRAM_NAME, TEXT)
            TEXT = _('Program {} encountered an error.').format(PROGRAM_NAME)
            errmsg(DISPLAY_NAME, PROGRAM_DESC, TEXT)
            term(PROGRAM_NAME, ERR)


def process_option_usage(DISPLAY_NAME: str, PROGRAM_DESC: str,
                         USAGE: str) -> None:
    """
    This function shows the available options.
    """
    TEXT: str = (f"{_('Usage:')} {USAGE}\n\n"
                 f'''{_("Type '{} --help' for more information.").
                      format(DISPLAY_NAME)}''')
    infomsg(DISPLAY_NAME, PROGRAM_DESC, TEXT)


def process_option_version(PROGRAM_NAME: str, PROGRAM_DESC: str,
                           DISPLAY_NAME: str) -> None:
    """
    This function displays version, author, and license information.
    """
    BUILD_ID: str = ''  # ISO 8601 YYYY-MM-DDTHH:MM:SS

    try:
        with open('/usr/share/doc/kz/build.id') as fh:
            BUILD_ID = f'{fh.read()}'
    except FileNotFoundError as fnf:
        TEXT: str = str(fnf)
        logmsg(DISPLAY_NAME, TEXT)
        TEXT = _('Build ID cannot be determined.')
        logmsg(DISPLAY_NAME, TEXT)
        BUILD_ID = TEXT
    except Exception as exc:
        TEXT = str(exc)
        logmsg(DISPLAY_NAME, TEXT)
        TEXT = _('Program {} encountered an error.').format(PROGRAM_NAME)
        errmsg(DISPLAY_NAME, PROGRAM_DESC, TEXT)
        term(PROGRAM_NAME, ERR)
    finally:
        TEXT = f"{_('kz version 4.2.1 (built {}).').format(BUILD_ID)}\n\n"
        TEXT += f"{_('Written by Karel Zimmer <info@karelzimmer.nl>.')}\n"
        TEXT += _('License CC0 1.0 \
<https://creativecommons.org/publicdomain/zero/1.0>.')
        infomsg(DISPLAY_NAME, PROGRAM_DESC, TEXT)


def term(PROGRAM_NAME: str, RC: int) -> None:
    """
    This function controls the termination.
    """
    TEXT = f'==== END logs for script {PROGRAM_NAME} ===='
    logmsg(PROGRAM_NAME, TEXT)

    if RC == OK:
        sys.exit(OK)
    else:
        sys.exit(ERR)


def wait_for_enter(PROGRAM_NAME: str, PROGRAM_DESC: str,
                   DISPLAY_NAME: str) -> int:
    """
    This function waits for the user to press Enter.
    """
    try:
        TEXT: str = f"\n{_('Press the Enter key to continue [Enter]: ')}\n"
        input(TEXT)
    except KeyboardInterrupt:
        TEXT = _('Program {} has been interrupted.').format(PROGRAM_NAME)
        errmsg(DISPLAY_NAME, PROGRAM_DESC, TEXT)
        term(PROGRAM_NAME, ERR)
    except Exception as exc:
        TEXT = str(exc)
        logmsg(PROGRAM_NAME, TEXT)
        TEXT = _('Program {} encountered an error.').format(PROGRAM_NAME)
        errmsg(DISPLAY_NAME, PROGRAM_DESC, TEXT)
        term(PROGRAM_NAME, ERR)
    else:
        return OK

    return OK


###############################################################################
# Main
###############################################################################

if __name__ == '__main__':
    TEXT: str = _('{}: i am a module').format(MODULE_NAME)
    print(TEXT)
