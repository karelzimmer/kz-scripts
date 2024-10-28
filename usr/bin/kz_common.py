"""
This module provides global constants and functions.
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

import gettext
import os
import subprocess
import sys
import time
from systemd import journal

gettext.bindtextdomain('kz', '/usr/share/locale')
gettext.textdomain('kz')
_ = gettext.gettext


###############################################################################
# Constants
###############################################################################

MODULE_NAME = 'kz_common.py'
MODULE_DESC = _('Common module for Python scripts')

OPTIONS_USAGE = '[-h|--help] [-m|--manual] [-u|--usage] [-v|--version]'

OPTIONS_HELP = (f"{_('  -h, --help     show this help text')}\n"
                f"{_('  -m, --manual   show manual page')}\n"
                f"{_('  -u, --usage    show a short usage summary')}\n"
                f"{_('  -v, --version  show program version')}")

OK = 0
ERR = 1

# List NORMAL last here so that Python debugger (pdb) doesn't bork the display.
BOLD = '\033[1m'
RED = '\033[1;31m'
GREEN = '\033[1;32m'
NORMAL = '\033[0m'

if subprocess.run('[[ -n $(type -t '
                  '{{cinnamon,gnome,lxqt,mate,xfce4}-session,ksmserver}) ]]',
                  shell=True, executable='bash').returncode == OK:
    DESKTOP_ENVIRONMENT = True
else:
    DESKTOP_ENVIRONMENT = False

# Rocky Linux 9: redhat-lsb package not available ==> source /etc/os-release.
if subprocess.run("source /etc/os-release; [[ $ID = 'debian' ]]",
                  shell=True, executable='bash').returncode == OK:
    DEBIAN = True
else:
    DEBIAN = False

if subprocess.run("source /etc/os-release; [[ $ID = 'ubuntu' ]]",
                  shell=True, executable='bash').returncode == OK:
    UBUNTU = True
else:
    UBUNTU = False

if subprocess.run('[[ -n $(type -t {dpkg,apt-get,apt}) ]]',
                  shell=True, executable='bash').returncode == OK:
    APT = True
else:
    APT = False

if subprocess.run('[[ -n $(type -t {rpm,yum,dnf}) ]]',
                  shell=True, executable='bash').returncode == OK:
    # Additional testing is needed because rpm may be installed on a system
    # that uses Debian package management system APT. APT is not available on a
    # system that uses Red Hat package management system RPM.
    if APT:
        RPM = False
    else:
        RPM = True
else:
    RPM = False


###############################################################################
# Functions
###############################################################################

def become_root(PROGRAM_NAME: str, DISPLAY_NAME: str,
                PROGRAM_DESC: str) -> None:
    """
    This function checks whether the script is started as user root and
    restarts the script as user root if not.
    """
    EXEC_SUDO = 'sudo '

    if not become_root_check(DISPLAY_NAME, PROGRAM_DESC):
        RC = OK
        term(PROGRAM_NAME, RC)

    if os.getuid() != 0:
        # From "['path/script', 'arg1', ...]" to "'path/script' 'arg1' ...".
        for arg_num in range(len(sys.argv)):
            if arg_num == 0:
                EXEC_SUDO += str(sys.argv[arg_num])
            else:
                EXEC_SUDO += ' ' + str(sys.argv[arg_num])
        TEXT = f'Restart ({EXEC_SUDO})'
        logmsg(PROGRAM_NAME, TEXT)

        try:
            subprocess.run(EXEC_SUDO, shell=True, check=True)
        except KeyboardInterrupt:
            RC = ERR
            TEXT = _('Program {} has been interrupted.').format(PROGRAM_NAME)
            term(PROGRAM_NAME, RC, DISPLAY_NAME, PROGRAM_DESC, TEXT)
        except Exception as exc:
            TEXT = str(exc)
            logmsg(PROGRAM_NAME, TEXT)
            RC = ERR
            TEXT = _('Program {} encountered an error.').format(PROGRAM_NAME)
            term(PROGRAM_NAME, RC, DISPLAY_NAME, PROGRAM_DESC, TEXT)
        else:
            RC = OK
            term(PROGRAM_NAME, RC)


def become_root_check(DISPLAY_NAME: str, PROGRAM_DESC: str) -> bool:
    """
    This function checks if the user is allowed to become root and returns 0 if
    so, otherwise returns 1 with descriptive message.
    """
    if os.getuid() == 0:
        return True
    try:
        subprocess.run('groups $USER | grep --quiet --regexp=sudo \
                       --regexp=wheel', shell=True, check=True)
    except Exception:
        TEXT = _('Already performed by the administrator.')
        infomsg(DISPLAY_NAME, PROGRAM_DESC, TEXT)
        return False
    else:
        return True


def check_apt_package_manager(DISPLAY_NAME: str, PROGRAM_DESC: str) -> None:
    """
    This function checks for another running APT package manager and waits for
    the next check if so.
    """
    CHECK_WAIT = 10

    if RPM:
        return OK

    while True:
        try:
            subprocess.run('sudo fuser '
                           '--silent '
                           '/var/cache/debconf/config.dat '
                           '/var/{lib/{dpkg,apt/lists},cache/apt/archives}/'
                           'lock*',
                           shell=True, executable='bash', check=True)
        except Exception:
            break
        else:
            TEXT = _('Wait for another package manager to finish') + '...'
            infomsg(DISPLAY_NAME, PROGRAM_DESC, TEXT)
            time.sleep(CHECK_WAIT)


def errmsg(DISPLAY_NAME: str, PROGRAM_DESC: str, TEXT: str,
           OPTION_GUI: bool = False) -> None:
    """
    This function returns an error message.
    """
    if OPTION_GUI:
        TITLE = f"{PROGRAM_DESC} {_('error message')} ({DISPLAY_NAME})"
        COMMAND = f'zenity  --error                 \
                            --width     600         \
                            --height    100         \
                            --title     "{TITLE}"   \
                            --text      "{TEXT}"'
        subprocess.run({COMMAND}, shell=True, check=True, executable='bash')
    else:
        print(f'{RED}{TEXT}{NORMAL}')


def infomsg(DISPLAY_NAME: str, PROGRAM_DESC: str, TEXT: str = '',
            OPTION_GUI: bool = False) -> None:
    """
    This function returns an informational message.
    """
    if OPTION_GUI:
        TITLE = f"{PROGRAM_DESC} {_('information')} ({DISPLAY_NAME})"
        COMMAND = f'zenity  --info                  \
                            --width     600         \
                            --height    100         \
                            --title     "{TITLE}"   \
                            --text      "{TEXT}"'
        subprocess.run({COMMAND}, shell=True, check=True, executable='bash')
    else:
        print(f'{TEXT}')


def init_script(PROGRAM_NAME: str) -> None:
    """
    This function performs initial actions.
    """
    TEXT = f'==== START logs for script {PROGRAM_NAME} ===='
    logmsg(PROGRAM_NAME, TEXT)


def logmsg(PROGRAM_NAME: str, TEXT: str) -> None:
    """
    This function records a message to the log.
    """
    journal.sendv(f'SYSLOG_IDENTIFIER={PROGRAM_NAME}', f'MESSAGE={TEXT}')


def process_option_help(PROGRAM_NAME: str, DISPLAY_NAME: str,
                        PROGRAM_DESC: str, HELP: str) -> None:
    """
    This function shows the available help.
    """
    YELP_MAN_URL = ''

    if DESKTOP_ENVIRONMENT:
        YELP_MAN_URL = f"{_(', or see the ')}"
        YELP_MAN_URL += f'\x1b]8;;man:{PROGRAM_NAME}(1)\x1b\\{DISPLAY_NAME}(1)'
        YELP_MAN_URL += f" {_('man page')}\x1b]8;;\x1b\\"
    TEXT = (f'{HELP}\n\n'
            f'''{_("Type '{} --manual' or 'man {}'{} for more information.").
                 format(DISPLAY_NAME, DISPLAY_NAME, YELP_MAN_URL)}''')
    infomsg(DISPLAY_NAME, PROGRAM_DESC, TEXT)


def process_option_manual(PROGRAM_NAME: str, DISPLAY_NAME: str,
                          PROGRAM_DESC: str) -> None:
    """
    This function displays the manual page..
    """
    try:
        subprocess.run(f'man --pager=cat {PROGRAM_NAME}', shell=True,
                       check=True)
    except Exception as exc:
        TEXT = str(exc)
        logmsg(PROGRAM_NAME, TEXT)
        RC = ERR
        TEXT = _('Program {} encountered an error.').format(PROGRAM_NAME)
        term(PROGRAM_NAME, RC, DISPLAY_NAME, PROGRAM_DESC, TEXT)
    else:
        return OK


def process_option_usage(DISPLAY_NAME: str, PROGRAM_DESC: str,
                         USAGE: str) -> None:
    """
    This function shows the available options.
    """
    TEXT = (f"{_('Usage:')} {USAGE}\n\n"
            f'''{_("Type '{} --help' for more information.").
                 format(DISPLAY_NAME)}''')
    infomsg(DISPLAY_NAME, PROGRAM_DESC, TEXT)


def process_option_version(PROGRAM_NAME: str, DISPLAY_NAME: str,
                           PROGRAM_DESC: str) -> None:
    """
    This function displays version, author, and license information.
    """
    BUILD_ID = ''

    try:
        with open('/usr/share/doc/kz/kz-build.id') as fh:
            BUILD_ID = f'{fh.read()}'
    except FileNotFoundError as fnf:
        TEXT = str(fnf)
        logmsg(PROGRAM_NAME, TEXT)
        TEXT = _('Build ID cannot be determined.')
        logmsg(PROGRAM_NAME, TEXT)
        build_id = TEXT
    except Exception as exc:
        TEXT = str(exc)
        logmsg(PROGRAM_NAME, TEXT)
        RC = ERR
        TEXT = _('Program {} encountered an error.').format(PROGRAM_NAME)
        term(PROGRAM_NAME, RC, DISPLAY_NAME, PROGRAM_DESC, TEXT)
    finally:
        TEXT = f"{_('kz version 4.2.1 ({}).').format(BUILD_ID)}\n\n"
        TEXT += f"{_('Written by Karel Zimmer <info@karelzimmer.nl>.')}\n"
        TEXT += _('License CC0 1.0 \
<https://creativecommons.org/publicdomain/zero/1.0>.')
        infomsg(DISPLAY_NAME, PROGRAM_DESC, TEXT)


def term(PROGRAM_NAME: str, RC: int, DISPLAY_NAME: str = None,
         PROGRAM_DESC: str = None, TEXT: str = None,
         OPTION_GUI: bool = False) -> None:
    """
    This function controls the termination.
    """
    if RC == OK:
        if TEXT:
            infomsg(DISPLAY_NAME, PROGRAM_DESC, TEXT, OPTION_GUI)
    else:
        if TEXT:
            errmsg(DISPLAY_NAME, PROGRAM_DESC, TEXT, OPTION_GUI)
    TEXT = f'==== END logs for script {PROGRAM_NAME} ===='
    logmsg(PROGRAM_NAME, TEXT)

    if RC == OK:
        sys.exit(OK)
    else:
        sys.exit(ERR)


def wait_for_enter(PROGRAM_NAME: str, DISPLAY_NAME: str,
                   PROGRAM_DESC: str) -> None:
    """
    This function waits for the user to press Enter.
    """
    try:
        TEXT = f"\n{_('Press the Enter key to continue [Enter]: ')}\n"
        input(TEXT)
    except KeyboardInterrupt:
        RC = ERR
        TEXT = _('Program {} has been interrupted.').format(PROGRAM_NAME)
        term(PROGRAM_NAME, RC, DISPLAY_NAME, PROGRAM_DESC, TEXT)
    except Exception as exc:
        TEXT = str(exc)
        logmsg(PROGRAM_NAME, TEXT)
        RC = ERR
        TEXT = _('Program {} encountered an error.').format(PROGRAM_NAME)
        term(PROGRAM_NAME, RC, DISPLAY_NAME, PROGRAM_DESC, TEXT)
    else:
        return OK


###############################################################################
# Main
###############################################################################

if __name__ == '__main__':
    TEXT = _('{}: i am a module').format(MODULE_NAME)
    print(TEXT)
