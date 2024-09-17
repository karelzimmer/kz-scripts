"""
This module provides global variables and functions.
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

import argparse
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
# Variables
###############################################################################

MODULE_NAME = 'kz_common.py'
MODULE_DESC = _('Common module for Python scripts')

PROGRAM_PATH = '/usr/bin'

USAGE = None
OPTIONS_USAGE = '[-h|--help] [-m|--manual] [-u|--usage] [-v|--version]'

HELP = None
OPTIONS_HELP = (f"{_('  -h, --help     show this help text')}\n"
                f"{_('  -m, --manual   show manual page')}\n"
                f"{_('  -u, --usage    show a short usage summary')}\n"
                f"{_('  -v, --version  show program version')}")

OK = 0
ERROR = 1

RC = OK
TEXT = ''

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

if subprocess.run('[[ -n $(type -t apt) ]]',
                  shell=True, executable='bash').returncode == OK:
    APT = True
else:
    APT = False

if subprocess.run('[[ -n $(type -t yum) ]]',
                  shell=True, executable='bash').returncode == OK:
    RPM = True
else:
    RPM = False


###############################################################################
# Functions
###############################################################################

def become_root(PROGRAM_NAME):
    """
    This function checks whether the script is started as user root and
    restarts the script as user root if not.
    """
    EXEC_SUDO = 'sudo '

    if not become_root_check(PROGRAM_NAME):
        TEXT = ''
        term(PROGRAM_NAME, TEXT, OK)

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
            TEXT = _('Program {} has been interrupted.').format(PROGRAM_NAME)
            term(PROGRAM_NAME, TEXT, ERROR)
        except Exception as exc:
            TEXT = str(exc)
            logmsg(PROGRAM_NAME, TEXT)
            TEXT = _('Program {} encountered an error.').format(PROGRAM_NAME)
            term(PROGRAM_NAME, TEXT, ERROR)
        else:
            TEXT = ''
            term(PROGRAM_NAME, TEXT, OK)


def become_root_check(PROGRAM_NAME):
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
        infomsg(PROGRAM_NAME, TEXT)
        return False
    else:
        return True


def check_on_ac_power(PROGRAM_NAME):
    """
    This function checks to see if the computer is running on battery power and
    prompts the user to continue if so.
    """
    if subprocess.run('on_ac_power', shell=True).returncode == 1:
        TEXT = _('The computer now uses only the battery for power.\n\n'
                 'It is recommended to connect the computer to the wall \
socket.')
        infomsg(PROGRAM_NAME, TEXT)
        wait_for_enter(PROGRAM_NAME)


def check_apt_package_manager(PROGRAM_NAME):
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
            infomsg(PROGRAM_NAME, TEXT)
            time.sleep(CHECK_WAIT)


def errormsg(PROGRAM_NAME, TEXT):
    """
    This function returns an error message.
    """
    print(f'{RED}{TEXT}{NORMAL}')


def infomsg(PROGRAM_NAME, TEXT):
    """
    This function returns an informational message.
    """
    print(f'{TEXT}')


def init_script(PROGRAM_NAME, DISPLAY_NAME):
    """
    This function performs initial actions.
    """
    TEXT = f'==== START logs for script {PROGRAM_NAME} ===='
    logmsg(PROGRAM_NAME, TEXT)


def logmsg(PROGRAM_NAME, TEXT):
    """
    This function records a message to the log.
    """
    journal.sendv(f'SYSLOG_IDENTIFIER={PROGRAM_NAME}', f'MESSAGE={TEXT}')


def process_options(PROGRAM_NAME, PROGRAM_DESC, DISPLAY_NAME):
    """
    This function handles the common options.
    """
    PARSER = argparse.ArgumentParser(prog=DISPLAY_NAME, usage=USAGE,
                                     add_help=False)

    PARSER.add_argument('-h', '--help', action='store_true')
    PARSER.add_argument('-m', '--manual', action='store_true')
    PARSER.add_argument('-u', '--usage', action='store_true')
    PARSER.add_argument('-v', '--version', action='store_true')
    args = PARSER.parse_args()

    if args.help:
        process_option_help(PROGRAM_NAME, PROGRAM_DESC, DISPLAY_NAME)
        TEXT = ''
        term(PROGRAM_NAME, TEXT, OK)
    elif args.manual:
        process_option_manual(PROGRAM_NAME)
        TEXT = ''
        term(PROGRAM_NAME, TEXT, OK)
    elif args.usage:
        process_option_usage(PROGRAM_NAME, DISPLAY_NAME)
        TEXT = ''
        term(PROGRAM_NAME, TEXT, OK)
    elif args.version:
        process_option_version(PROGRAM_NAME)
        TEXT = ''
        term(PROGRAM_NAME, TEXT, OK)


def process_option_help(PROGRAM_NAME, PROGRAM_DESC, DISPLAY_NAME):
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
    infomsg(PROGRAM_NAME, TEXT)


def process_option_manual(PROGRAM_NAME):
    """
    This function displays the manual page..
    """
    try:
        subprocess.run(f'man --pager=cat {PROGRAM_NAME}', shell=True,
                       check=True)
    except Exception as exc:
        TEXT = str(exc)
        logmsg(PROGRAM_NAME, TEXT)
        TEXT = _('Program {} encountered an error.').format(PROGRAM_NAME)
        term(PROGRAM_NAME, TEXT, ERROR)
    else:
        return OK


def process_option_usage(PROGRAM_NAME, DISPLAY_NAME):
    """
    This function shows the available options.
    """
    TEXT = (f"{_('Usage:')} {USAGE}\n\n"
            f'''{_("Type '{} --help' for more information.").
                 format(DISPLAY_NAME)}''')
    infomsg(PROGRAM_NAME, TEXT)


def process_option_version(PROGRAM_NAME):
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
        TEXT = _('Program {} encountered an error.').format(PROGRAM_NAME)
        term(PROGRAM_NAME, TEXT, ERROR)
    finally:
        TEXT = f"{_('kz version 4.2.1 ({}).').format(BUILD_ID)}\n\n"
        TEXT += f"{_('Written by Karel Zimmer <info@karelzimmer.nl>.')}\n"
        TEXT += _('License CC0 1.0 \
<https://creativecommons.org/publicdomain/zero/1.0>.')
        infomsg(PROGRAM_NAME, TEXT)


def term(PROGRAM_NAME, TEXT, RC):
    """
    This function controls the termination.
    """
    if RC == OK:
        if TEXT:
            infomsg(PROGRAM_NAME, TEXT)
    else:
        if TEXT:
            errormsg(PROGRAM_NAME, TEXT)
    TEXT = f'==== END logs for script {PROGRAM_NAME} ===='
    logmsg(PROGRAM_NAME, TEXT)

    if RC == OK:
        sys.exit(OK)
    else:
        sys.exit(ERROR)


def wait_for_enter(PROGRAM_NAME):
    """
    This function waits for the user to press Enter.
    """
    try:
        TEXT = f"\n{_('Press the Enter key to continue [Enter]: ')}\n"
        input(TEXT)
    except KeyboardInterrupt:
        TEXT = _('Program {} has been interrupted.').format(PROGRAM_NAME)
        term(PROGRAM_NAME, TEXT, ERROR)
    except Exception as exc:
        TEXT = str(exc)
        logmsg(PROGRAM_NAME, TEXT)
        TEXT = _('Program {} encountered an error.').format(PROGRAM_NAME)
        term(PROGRAM_NAME, TEXT, ERROR)
    else:
        return OK


###############################################################################
# Main
###############################################################################

if __name__ == '__main__':
    TEXT = _('{}: i am a module').format(MODULE_NAME)
    infomsg(MODULE_NAME, TEXT)
