"""
This module provides access to global constants and functions.
"""
###############################################################################
# SPDX-FileComment: Common module for kz Python scripts
#
# SPDX-FileCopyrightText: Karel Zimmer <info@karelzimmer.nl>
# SPDX-License-Identifier: CC0-1.0
###############################################################################


###############################################################################
# Imports
###############################################################################

import distro
import gettext
import os
import subprocess
import sys
import time
from systemd import journal  # type: ignore

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
GREEN: str = '\033[1;32m'
NORMAL: str = '\033[0m'

COMMAND: str = 'type systemctl'
if subprocess.run(COMMAND, executable='bash',
                  stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL,
                  shell=True).returncode != OK:
    print(_('fatal: no systemd available'))
    sys.exit(ERR)

# Rocky Linux 9: redhat-lsb package not available ==> source /etc/os-release.
if not os.path.exists('/etc/os-release'):
    print(_('fatal: no os release available'))
    sys.exit(ERR)

APT: bool = False
RPM: bool = False
COMMAND1: str = "grep --quiet --regexp='debian' /etc/os-release"
COMMAND2: str = "grep --quiet --regexp='rhel' /etc/os-release"
if subprocess.run(COMMAND1, executable='bash',
                  stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL,
                  shell=True).returncode == OK:
    APT = True
elif subprocess.run(COMMAND2, executable='bash',
                    stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL,
                    shell=True).returncode == OK:
    RPM = True
else:
    print(_('fatal: unknown distribution'))
    sys.exit(ERR)

KNOWN_DESKTOP_ENVIRONMENT: str = ''
KNOWN_DESKTOP_ENVIRONMENTS: list[str] = ["cinnamon-session", "gnome-session",
                                         "lxqt-session", "mate-session",
                                         "xfce4-session", "ksmserver"]
GUI: bool = False
for KNOWN_DESKTOP_ENVIRONMENT in KNOWN_DESKTOP_ENVIRONMENTS:
    COMMAND = f'type {KNOWN_DESKTOP_ENVIRONMENT}'
    if subprocess.run(COMMAND, executable='bash',
                      stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL,
                      shell=True).returncode == OK:
        GUI = True


###############################################################################
# Functions
###############################################################################

def become_root(PROGRAM_NAME: str, PROGRAM_DESC: str) -> None:
    """
    This function checks whether the script is started as user root and
    restarts the script as user root if not.
    """
    EXEC_SUDO: str = 'exec sudo '
    PROGRAM_ID = PROGRAM_NAME.replace('kz ', 'kz-')

    if not become_root_check(PROGRAM_NAME, PROGRAM_DESC):
        RC: int = OK
        term(PROGRAM_NAME, RC)

    if os.getuid() != 0:
        # From "['path/script', 'arg1', ...]" to "'path/script' 'arg1' ...".
        for arg_num in range(len(sys.argv)):
            if arg_num == 0:
                EXEC_SUDO += str(sys.argv[arg_num])
            else:
                EXEC_SUDO += ' ' + str(sys.argv[arg_num])
        TEXT: str = f'Restart ({EXEC_SUDO})'
        logmsg(PROGRAM_NAME, TEXT)

        try:
            subprocess.run(EXEC_SUDO, executable='bash',
                           shell=True, check=True)
        except KeyboardInterrupt:
            TEXT = _('Program {} has been interrupted.').format(PROGRAM_ID)
            errmsg(PROGRAM_NAME, PROGRAM_DESC, TEXT)
            RC = ERR
            term(PROGRAM_NAME, RC)
        except Exception as exc:
            TEXT = str(exc)
            logmsg(PROGRAM_NAME, TEXT)
            TEXT = _('Program {} encountered an error.').format(PROGRAM_ID)
            errmsg(PROGRAM_NAME, PROGRAM_DESC, TEXT)
            RC = ERR
            term(PROGRAM_NAME, RC)
        else:
            RC = OK
            term(PROGRAM_NAME, RC)


def become_root_check(PROGRAM_NAME: str, PROGRAM_DESC: str) -> bool:
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
        infomsg(PROGRAM_NAME, PROGRAM_DESC, TEXT)
        return False
    else:
        return True


def check_apt_package_manager(PROGRAM_NAME: str, PROGRAM_DESC: str) -> int:
    """
    This function checks for another running APT package manager and waits for
    the next check if so.
    """
    CHECK_WAIT: int = 10
    COMMAND: str = 'sudo fuser --silent /var/cache/debconf/config.dat '
    COMMAND += '/var/{lib/{dpkg,apt/lists},cache/apt/archives}/lock*'

    if RPM:
        return OK

    while True:
        try:
            subprocess.run(COMMAND, executable='bash',
                           shell=True, check=True)
        except Exception:
            break
        else:
            TEXT: str = _('Wait for another package manager to finish') + '...'
            infomsg(PROGRAM_NAME, PROGRAM_DESC, TEXT)
            time.sleep(CHECK_WAIT)

    return OK


def errmsg(PROGRAM_NAME: str, PROGRAM_DESC: str, TEXT: str,
           OPTION_GUI: bool = False) -> None:
    """
    This function returns an error message.
    """
    PROGRAM_ID: str = PROGRAM_NAME.replace('kz ', 'kz-')

    if OPTION_GUI:
        TITLE: str = f"{PROGRAM_DESC} {_('error message')} ({PROGRAM_NAME})"
        COMMAND: str = f'zenity --error                 \
                                --width     600         \
                                --height    100         \
                                --title     "{TITLE}"   \
                                --text      "{TEXT}"'
        subprocess.run(COMMAND, executable='bash', shell=True, check=True)
    else:
        print(f'\n{RED}{TEXT}{NORMAL}')


def infomsg(PROGRAM_NAME: str, PROGRAM_DESC: str, TEXT: str = '',
            OPTION_GUI: bool = False) -> None:
    """
    This function returns an informational message.
    """
    if OPTION_GUI:
        TITLE: str = f"{PROGRAM_DESC} {_('information')} ({PROGRAM_NAME})"
        COMMAND: str = f'zenity --info                  \
                                --width     600         \
                                --height    100         \
                                --title     "{TITLE}"   \
                                --text      "{TEXT}"'
        subprocess.run(COMMAND, executable='bash', shell=True, check=True)
    else:
        print(f'{TEXT}')


def init_script(PROGRAM_NAME: str) -> None:
    """
    This function performs initial actions.
    """
    TEXT: str = f'==== START logs for script {PROGRAM_NAME} ===='
    logmsg(PROGRAM_NAME, TEXT)


def logmsg(PROGRAM_NAME: str, TEXT: str) -> None:
    """
    This function records a message to the log.
    """
    PROGRAM_ID: str = PROGRAM_NAME.replace('kz ', 'kz-')

    journal.sendv(f'SYSLOG_IDENTIFIER={PROGRAM_ID}', f'MESSAGE={TEXT}')


def process_option_help(PROGRAM_NAME: str, PROGRAM_DESC: str,
                        HELP: str) -> None:
    """
    This function shows the available help.
    """
    PROGRAM_ID: str = PROGRAM_NAME.replace('kz ', 'kz-')
    YELP_MAN_URL: str = ''

    if GUI:
        YELP_MAN_URL = f"{_(', or see the ')}"
        YELP_MAN_URL += f'\x1b]8;;man:{PROGRAM_ID}\x1b\\{PROGRAM_ID} '
        YELP_MAN_URL += f"{_('man page')}\x1b]8;;\x1b\\"
    TEXT: str = (f'{HELP}\n\n'
                 f'''{_("Type '{} --manual' or 'man {}'{} ").
                      format(PROGRAM_NAME, PROGRAM_NAME, YELP_MAN_URL)}'''
                 f"{_('for more information.')}")
    infomsg(PROGRAM_NAME, PROGRAM_DESC, TEXT)


def process_option_manual(PROGRAM_NAME: str, PROGRAM_DESC: str) -> int:
    """
    This function displays the manual page..
    """
    PROGRAM_ID: str = PROGRAM_NAME.replace('kz ', 'kz-')
    COMMAND1: str = f'yelp man:{PROGRAM_ID}'
    COMMAND2: str = f'man --pager=cat {PROGRAM_NAME}'

    if GUI:
        try:
            subprocess.run(COMMAND1, executable='bash',
                           stderr=subprocess.DEVNULL,
                           shell=True, check=True,)
        except Exception as exc:
            TEXT: str = str(exc)
            logmsg(PROGRAM_NAME, TEXT)
            TEXT = _('Program {} encountered an error.').format(PROGRAM_ID)
            errmsg(PROGRAM_NAME, PROGRAM_DESC, TEXT)
            RC = ERR
            term(PROGRAM_NAME, RC)
        else:
            return OK
    else:
        try:
            subprocess.run(COMMAND2, executable='bash', shell=True, check=True)
        except Exception as exc:
            TEXT = str(exc)
            logmsg(PROGRAM_NAME, TEXT)
            TEXT = _('Program {} encountered an error.').format(PROGRAM_ID)
            errmsg(PROGRAM_NAME, PROGRAM_DESC, TEXT)
            RC = ERR
            term(PROGRAM_NAME, RC)
        else:
            return OK

    return OK


def process_option_usage(PROGRAM_NAME: str, PROGRAM_DESC: str,
                         USAGE: str) -> None:
    """
    This function shows the available options.
    """
    TEXT: str = (f"{_('Usage:')} {USAGE}\n\n"
                 f'''{_("Type '{} --help' for more information.").
                      format(PROGRAM_NAME)}''')
    infomsg(PROGRAM_NAME, PROGRAM_DESC, TEXT)


def process_option_version(PROGRAM_NAME: str, PROGRAM_DESC: str) -> None:
    """
    This function displays version, author, and license information.
    """
    BUILD_ID: str = ''
    PROGRAM_ID = PROGRAM_NAME.replace('kz ', 'kz-')

    try:
        with open('/usr/share/doc/kz/build.id') as fh:
            BUILD_ID = f'{fh.read()}'
    except FileNotFoundError as fnf:
        TEXT: str = str(fnf)
        logmsg(PROGRAM_NAME, TEXT)
        TEXT = _('Build ID cannot be determined.')
        logmsg(PROGRAM_NAME, TEXT)
        BUILD_ID = TEXT
    except Exception as exc:
        TEXT = str(exc)
        logmsg(PROGRAM_NAME, TEXT)
        TEXT = _('Program {} encountered an error.').format(PROGRAM_ID)
        errmsg(PROGRAM_NAME, PROGRAM_DESC, TEXT)
        RC = ERR
        term(PROGRAM_NAME, RC)
    finally:
        TEXT = f"{_('kz version 4.2.1 ({}).').format(BUILD_ID)}\n\n"
        TEXT += f"{_('Written by Karel Zimmer <info@karelzimmer.nl>.')}\n"
        TEXT += _('License CC0 1.0 \
<https://creativecommons.org/publicdomain/zero/1.0>.')
        infomsg(PROGRAM_NAME, PROGRAM_DESC, TEXT)


def term(PROGRAM_NAME: str, RC: int) -> None:
    """
    This function controls the termination.
    """
    PROGRAM_ID = PROGRAM_NAME.replace('kz ', 'kz-')

    TEXT = f'==== END logs for script {PROGRAM_ID} ===='
    logmsg(PROGRAM_NAME, TEXT)

    if RC == OK:
        sys.exit(OK)
    else:
        sys.exit(ERR)


def wait_for_enter(PROGRAM_NAME: str, PROGRAM_DESC: str) -> int:
    """
    This function waits for the user to press Enter.
    """
    PROGRAM_ID = PROGRAM_NAME.replace('kz ', 'kz-')

    try:
        TEXT: str = f"\n{_('Press the Enter key to continue [Enter]: ')}\n"
        input(TEXT)
    except KeyboardInterrupt:
        TEXT = _('Program {} has been interrupted.').format(PROGRAM_ID)
        errmsg(PROGRAM_NAME, PROGRAM_DESC, TEXT)
        RC = ERR
        term(PROGRAM_NAME, RC)
    except Exception as exc:
        TEXT = str(exc)
        logmsg(PROGRAM_NAME, TEXT)
        TEXT = _('Program {} encountered an error.').format(PROGRAM_ID)
        errmsg(PROGRAM_NAME, PROGRAM_DESC, TEXT)
        RC = ERR
        term(PROGRAM_NAME, RC)
    else:
        return OK

    return OK


###############################################################################
# Main
###############################################################################

if __name__ == '__main__':
    TEXT: str = _('{}: i am a module').format(MODULE_NAME)
    print(TEXT)
