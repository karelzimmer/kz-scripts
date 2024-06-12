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
# Import
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
# Constants
###############################################################################

MODULE_NAME = 'kz_common.py'
MODULE_DESC = _('Common module for Python scripts')
MODULE_PATH = f"{os.path.dirname(os.path.realpath(__file__))}"

OK = 0
ERROR = 1

NORMAL = '\033[0m'
BOLD = '\033[1m'

RED = '\033[1;31m'
GREEN = '\033[1;32m'


###############################################################################
# Variables
###############################################################################

text = ''


###############################################################################
# Functions
###############################################################################

def become_root(PROGRAM_NAME):
    """
    This function checks whether the script is started as user root and
    restarts the script as user root if not.
    """
    exec_sudo = 'sudo '

    if not become_root_check(PROGRAM_NAME):
        term_script(PROGRAM_NAME)
        sys.exit(OK)

    if os.getuid() != 0:
        # From "['path/script', 'arg1', ...]" to "'path/script' 'arg1' ...".
        for arg_num in range(len(sys.argv)):
            if arg_num == 0:
                exec_sudo += str(sys.argv[arg_num])
            else:
                exec_sudo += ' ' + str(sys.argv[arg_num])
        text = f'restart ({exec_sudo})'
        logmsg(PROGRAM_NAME, text)

        try:
            subprocess.run(exec_sudo, shell=True, check=True)
        except KeyboardInterrupt:
            text = _('Program {} has been interrupted.').format(PROGRAM_NAME)
            errormsg(PROGRAM_NAME, text)
            term_script(PROGRAM_NAME)
            sys.exit(ERROR)
        except Exception as exc:
            text = str(exc)
            logmsg(PROGRAM_NAME, text)
            text = _('Program {} encountered an error.').format(PROGRAM_NAME)
            errormsg(PROGRAM_NAME, text)
            term_script(PROGRAM_NAME)
            sys.exit(ERROR)
        else:
            sys.exit(OK)


def become_root_check(PROGRAM_NAME):
    """
    This function checks if the user is allowed to become root and returns 0 if
    so, otherwise returns 1 with descriptive message.
    """
    if os.getuid() == 0:
        return True
    try:
        subprocess.run('groups $USER | grep --quiet --regexp=sudo', shell=True,
                       check=True)
    except Exception:
        text = _('Already performed by the administrator.')
        infomsg(PROGRAM_NAME, text)
        return False
    else:
        return True


def check_on_ac_power(PROGRAM_NAME):
    """
    This function checks to see if the computer is running on battery power and
    prompts the user to continue if so.
    """
    if subprocess.run('on_ac_power', shell=True).returncode == 1:
        text = _('The computer now uses only the battery for power.\n\n'
                 'It is recommended to connect the computer to the wall socket\
.')
        infomsg(PROGRAM_NAME, text)
        try:
            text = f"\n{_('Press the Enter key to continue [Enter]: ')}"
            input(text)
        except KeyboardInterrupt:
            text = _('Program {} has been interrupted.').format(PROGRAM_NAME)
            errormsg(PROGRAM_NAME, text)
            term_script(PROGRAM_NAME)
            sys.exit(ERROR)
        except Exception as exc:
            text = str(exc)
            logmsg(PROGRAM_NAME, text)
            text = _('Program {} encountered an error.').format(PROGRAM_NAME)
            errormsg(PROGRAM_NAME, text)
            term_script(PROGRAM_NAME)
            sys.exit(ERROR)
        else:
            return OK


def check_package_manager(PROGRAM_NAME):
    """
    This function checks for another active package manager and waits for the
    next check if so.
    """
    check_wait = 10

    while True:
        try:
            subprocess.run('sudo fuser '
                           '--silent '
                           '/var/cache/apt/archives/lock '
                           '/var/cache/debconf/config.dat '
                           '/var/lib/apt/lists/lock '
                           '/var/lib/dpkg/lock-frontend '
                           '/var/lib/dpkg/lock',
                           shell=True, check=True)
        except Exception:
            break
        else:
            text = _('Wait for another package manager to finish') + '...'
            infomsg(PROGRAM_NAME, text)
            time.sleep(check_wait)


def init_script(PROGRAM_NAME):
    """
    This function performs initial actions.
    """
    text = f'==== START logs for script {PROGRAM_NAME} ===='
    logmsg(PROGRAM_NAME, text)


def errormsg(PROGRAM_NAME, text):
    """
    This function returns an error message.
    """
    print(f'{RED}{text}{NORMAL}')


def infomsg(PROGRAM_NAME, text):
    """
    This function returns an informational message.
    """
    print(f'{text}')


def logmsg(PROGRAM_NAME, text):
    """
    This function records a message to the log.
    """
    journal.sendv(f'SYSLOG_IDENTIFIER={PROGRAM_NAME}', f'MESSAGE={text}')


def process_options(PROGRAM_NAME, PROGRAM_DESC, DISPLAY_NAME):
    """
    This function handles the general options.
    """
    USAGE_LINE = _("type '{} --usage' for more information").\
        format(DISPLAY_NAME)

    parser = argparse.ArgumentParser(prog=DISPLAY_NAME, usage=USAGE_LINE,
                                     add_help=False)
    parser.add_argument('-h', '--help', action='store_true')
    parser.add_argument('-m', '--manual', action='store_true')
    parser.add_argument('-u', '--usage', action='store_true')
    parser.add_argument('-v', '--version', action='store_true')
    args = parser.parse_args()

    if args.help:
        process_option_help(DISPLAY_NAME, PROGRAM_DESC, PROGRAM_NAME)
        term_script(PROGRAM_NAME)
        sys.exit(OK)
    elif args.manual:
        process_option_manual(PROGRAM_NAME)
        term_script(PROGRAM_NAME)
        sys.exit(OK)
    elif args.usage:
        process_option_usage(DISPLAY_NAME, PROGRAM_NAME)
        term_script(PROGRAM_NAME)
        sys.exit(OK)
    elif args.version:
        process_option_version(PROGRAM_NAME)
        term_script(PROGRAM_NAME)
        sys.exit(OK)


def process_option_help(DISPLAY_NAME, PROGRAM_DESC, PROGRAM_NAME):
    """
    This function shows the available help.
    """
    man_url = f'\x1b]8;;man:{PROGRAM_NAME}(1)\x1b\\{DISPLAY_NAME} '
    man_url += f"{_('man page')}\x1b]8;;\x1b\\"

    text = (f"{_('Usage: {} [OPTION...]').format(DISPLAY_NAME)}\n\n"
            f'{PROGRAM_DESC}.\n\n'
            f"{_('Options:')}\n"
            f"{_('  -h, --help     give this help list')}\n"
            f"{_('  -m, --manual   show manual page')}\n"
            f"{_('  -u, --usage    give a short usage message')}\n"
            f"{_('  -v, --version  print program version')}\n\n"
            f'''{_("Type 'man {}' or see the {} for more information.").
                 format(DISPLAY_NAME, man_url)}''')
    infomsg(PROGRAM_NAME, text)


def process_option_manual(PROGRAM_NAME):
    """
    This function displays the manual page..
    """
    try:
        subprocess.run(f'man --pager=cat {PROGRAM_NAME}', shell=True,
                       check=True)
    except Exception as exc:
        text = str(exc)
        logmsg(PROGRAM_NAME, text)
        text = _('Program {} encountered an error.').format(PROGRAM_NAME)
        errormsg(PROGRAM_NAME, text)
        term_script(PROGRAM_NAME)
        sys.exit(ERROR)
    else:
        return OK


def process_option_usage(DISPLAY_NAME, PROGRAM_NAME):
    """
    This function shows the available options.
    """
    text = (f"{_('Usage: {}').format(DISPLAY_NAME)}"
            ' [-h|--help] [-m|--manual] [-u|--usage] [-v|--version]\n\n'
            f'''{_("Type '{} --help' for more information.").
                 format(DISPLAY_NAME)}''')
    infomsg(PROGRAM_NAME, text)


def process_option_version(PROGRAM_NAME):
    """
    This function displays version, author, and license information.
    """
    build_id = ''

    try:
        with open('/etc/kz-build.id') as fh:
            build_id = f'{fh.read()}'
    except FileNotFoundError as fnf:
        text = str(fnf)
        logmsg(PROGRAM_NAME, text)
        text = _('Build ID cannot be determined')
        logmsg(PROGRAM_NAME, text)
        build_id = text
    except Exception as exc:
        text = str(exc)
        logmsg(PROGRAM_NAME, text)
        text = _('Program {} encountered an error.').format(PROGRAM_NAME)
        errormsg(PROGRAM_NAME, text)
        term_script(PROGRAM_NAME)
        sys.exit(ERROR)
    finally:
        text = f"{_('kz version 4.2.1 (built {}).').format(build_id)}\n\n"
        text += f"{_('Written by Karel Zimmer <info@karelzimmer.nl>.')}\n"
        text += _('CC0 1.0 Universal <https://creativecommons.org/publicdomain\
/zero/1.0>.')
        infomsg(PROGRAM_NAME, text)


def term_script(PROGRAM_NAME):
    """
    This function controls the termination of the script.
    """
    text = f'==== END logs for script {PROGRAM_NAME} ===='
    logmsg(PROGRAM_NAME, text)


###############################################################################
# Main Script
###############################################################################

if __name__ == '__main__':
    text = _('{}: i am a module').format(MODULE_NAME)
    infomsg(MODULE_NAME, text)
