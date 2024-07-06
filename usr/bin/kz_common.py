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

OPTIONS_USAGE = '[-h|--help] [-m|--manual] [-u|--usage] [-v|--version]'

OPTIONS_HELP = (f"{_('  -h, --help     give this help list')}\n"
                f"{_('  -m, --manual   show manual page')}\n"
                f"{_('  -u, --usage    give a short usage message')}\n"
                f"{_('  -v, --version  print program version')}")

OPTIONS_SHORT = 'hmuv'
OPTIONS_LONG = 'help,manual,usage,version'

# Determine whether a desktop environment is available.
if subprocess.run('[[ -n $('
                  'type {{cinnamon,gnome,lxqt,mate,xfce4}-session,ksmserver} '
                  '2> /dev/null'
                  ') ]]',
                  shell=True, executable='/usr/bin/bash').returncode == OK:
    DESKTOP_ENVIRONMENT = True
else:
    DESKTOP_ENVIRONMENT = False


###############################################################################
# Variables
###############################################################################

text = ''
rc = OK


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
        text = ''
        term(PROGRAM_NAME, text, OK)

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
            term(PROGRAM_NAME, text, ERROR)
        except Exception as exc:
            text = str(exc)
            logmsg(PROGRAM_NAME, text)
            text = _('Program {} encountered an error.').format(PROGRAM_NAME)
            term(PROGRAM_NAME, text, ERROR)
        else:
            text = ''
            term(PROGRAM_NAME, text, OK)


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
        wait_for_enter(PROGRAM_NAME)


def check_package_manager(PROGRAM_NAME):
    """
    This function checks for another running package manager and waits for the
    next check if so.
    """
    check_wait = 10

    while True:
        try:
            subprocess.run('sudo fuser '
                           '--silent '
                           '/var/cache/debconf/config.dat '
                           '/var/{lib/{dpkg,apt/lists},cache/apt/archives}/'
                           'lock*',
                           shell=True, executable='/usr/bin/bash', check=True)
        except Exception:
            break
        else:
            text = _('Wait for another package manager to finish') + '...'
            infomsg(PROGRAM_NAME, text)
            time.sleep(check_wait)


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


def init_script(PROGRAM_NAME, DISPLAY_NAME):
    """
    This function performs initial actions.
    """
    global USAGE_LINE

    text = f'==== START logs for script {PROGRAM_NAME} ===='
    logmsg(PROGRAM_NAME, text)
    USAGE_LINE = _("type '{} --usage' for more information").\
        format(DISPLAY_NAME)


def logmsg(PROGRAM_NAME, text):
    """
    This function records a message to the log.
    """
    journal.sendv(f'SYSLOG_IDENTIFIER={PROGRAM_NAME}', f'MESSAGE={text}')


def process_options(PROGRAM_NAME, PROGRAM_DESC, DISPLAY_NAME):
    """
    This function handles the common options.
    """
    parser = argparse.ArgumentParser(prog=DISPLAY_NAME, usage=USAGE_LINE,
                                     add_help=False)
    parser.add_argument('-h', '--help', action='store_true')
    parser.add_argument('-m', '--manual', action='store_true')
    parser.add_argument('-u', '--usage', action='store_true')
    parser.add_argument('-v', '--version', action='store_true')
    args = parser.parse_args()

    if args.help:
        process_option_help(PROGRAM_NAME, PROGRAM_DESC, DISPLAY_NAME)
        text = ''
        term(PROGRAM_NAME, text, OK)
    elif args.manual:
        process_option_manual(PROGRAM_NAME)
        text = ''
        term(PROGRAM_NAME, text, OK)
    elif args.usage:
        process_option_usage(PROGRAM_NAME, DISPLAY_NAME)
        text = ''
        term(PROGRAM_NAME, text, OK)
    elif args.version:
        process_option_version(PROGRAM_NAME)
        text = ''
        term(PROGRAM_NAME, text, OK)


def process_option_help(PROGRAM_NAME, PROGRAM_DESC, DISPLAY_NAME):
    """
    This function shows the available help.
    """
    yelp_man_url = ''

    if DESKTOP_ENVIRONMENT:
        yelp_man_url = f"{_(', or see the ')}"
        yelp_man_url += f'\x1b]8;;man:{PROGRAM_NAME}(1)\x1b\\{DISPLAY_NAME} '
        yelp_man_url += f"{_('man page')}\x1b]8;;\x1b\\"

    text = (f"{_('Usage: {} [OPTION...]').format(DISPLAY_NAME)}\n\n"
            f'{PROGRAM_DESC}.\n\n'
            f"{_('Options:')}\n"
            f'{OPTIONS_HELP}\n\n'
            f'''{_("Type '{} --manual' or 'man {}'{} for more information.").
                 format(DISPLAY_NAME, DISPLAY_NAME, yelp_man_url)}''')
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
        term(PROGRAM_NAME, text, ERROR)
    else:
        return OK


def process_option_usage(PROGRAM_NAME, DISPLAY_NAME):
    """
    This function shows the available options.
    """
    text = (f"{_('Usage: {}').format(DISPLAY_NAME)} {OPTIONS_USAGE}\n\n"
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
        text = _('Build ID cannot be determined.')
        logmsg(PROGRAM_NAME, text)
        build_id = text
    except Exception as exc:
        text = str(exc)
        logmsg(PROGRAM_NAME, text)
        text = _('Program {} encountered an error.').format(PROGRAM_NAME)
        term(PROGRAM_NAME, text, ERROR)
    finally:
        text = f"{_('kz version 4.2.1 (built {}).').format(build_id)}\n\n"
        text += f"{_('Written by Karel Zimmer <info@karelzimmer.nl>.')}\n"
        text += _('CC0 1.0 Universal <https://creativecommons.org/publicdomain\
/zero/1.0>.')
        infomsg(PROGRAM_NAME, text)


def term(PROGRAM_NAME, text, rc):
    """
    This function controls the termination.
    """
    if rc == OK:
        if text:
            infomsg(PROGRAM_NAME, text)
    else:
        if text:
            errormsg(PROGRAM_NAME, text)
    text = f'==== END logs for script {PROGRAM_NAME} ===='
    logmsg(PROGRAM_NAME, text)
    if rc == OK:
        sys.exit(OK)
    else:
        sys.exit(ERROR)


def wait_for_enter(PROGRAM_NAME):
    """
    This function waits for the user to press Enter.
    """
    try:
        text = f"\n{_('Press the Enter key to continue [Enter]: ')}\n"
        input(text)
    except KeyboardInterrupt:
        text = _('Program {} has been interrupted.').format(PROGRAM_NAME)
        term(PROGRAM_NAME, text, ERROR)
    except Exception as exc:
        text = str(exc)
        logmsg(PROGRAM_NAME, text)
        text = _('Program {} encountered an error.').format(PROGRAM_NAME)
        term(PROGRAM_NAME, text, ERROR)
    else:
        return OK


###############################################################################
# Main Script
###############################################################################

if __name__ == '__main__':
    text = _('{}: i am a module').format(MODULE_NAME)
    infomsg(MODULE_NAME, text)
