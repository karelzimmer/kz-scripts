"""
Common module for Python scripts.

This module provides general variables and functions.
"""
###############################################################################
# Common module for Python scripts.
#
# This module provides access to general variables and functions.
# Use 'man kz common.py' for more information.
#
# Written by Karel Zimmer <info@karelzimmer.nl>, CC0 1.0 Universal
# <https://creativecommons.org/publicdomain/zero/1.0>, 2021-2023.
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

gettext.bindtextdomain('kz', '/usr/share/locale')
gettext.textdomain('kz')
_ = gettext.gettext


###############################################################################
# Constants
###############################################################################

MODULE_NAME = 'kz_common.py'
MODULE_DESC = (_('Common module for Python scripts'))
MODULE_PATH = f"{os.path.realpath(os.path.dirname(__file__))}"

OK = 0
ERROR = 1

BOLD = '\033[1m'
NORMAL = '\033[0m'


###############################################################################
# Variables
###############################################################################


###############################################################################
# Functions
###############################################################################

def check_for_active_updates():
    """
    This function checks for active updates and waits for the next check.
    """
    check_wait = 10

    try:
        subprocess.run('ls /snap/core/*/var/cache/debconf/config.dat',
                       shell=True, check=True, stdout=subprocess.DEVNULL,
                       stderr=subprocess.DEVNULL)
    except Exception:
        snaps = False
    else:
        snaps = True

    while True:
        if snaps:
            try:
                subprocess.run('sudo fuser /var/cache/apt/archives/lock '
                               '/var/lib/apt/lists/lock  /var/lib/dpkg/lock '
                               '/var/cache/debconf/config.dat '
                               '/snap/core/*/var/cache/debconf/config.dat',
                               shell=True, check=True,
                               stdout=subprocess.DEVNULL,
                               stderr=subprocess.DEVNULL)
            except Exception:
                break
            else:
                print(_('Wait {}s for another package manager to finish...').
                      format(check_wait))
                time.sleep(check_wait)
        else:
            try:
                subprocess.run('sudo fuser /var/cache/apt/archives/lock '
                               '/var/lib/apt/lists/lock  /var/lib/dpkg/lock '
                               '/var/cache/debconf/config.dat',
                               shell=True, check=True,
                               stdout=subprocess.DEVNULL,
                               stderr=subprocess.DEVNULL)
            except Exception:
                break
            else:
                print(_('Wait {}s for another package manager to finish...').
                      format(check_wait))
                time.sleep(check_wait)


def check_on_ac_power(PROGRAM_NAME):
    """
    This function checks if the computer is running on battery power and
    prompts the user to continue.
    """
    if subprocess.run('on_ac_power', shell=True,
                      stderr=subprocess.DEVNULL).returncode == 1:
        print('\n' + _('The computer now uses only the battery for power.\n\n'
              'It is recommended to connect the computer to the wall socket.'))
        try:
            input('\n' + _('Press the Enter key to continue [Enter]: '))
        except KeyboardInterrupt:
            print('\n' + _('Program {} has been interrupted.').
                  format(PROGRAM_NAME))
            sys.exit(ERROR)


def check_user_root(PROGRAM_NAME, DISPLAY_NAME):
    """
    This function checks if the user is root.
    """
    if check_user_sudo() != OK:
        print(_('Already performed by the administrator.'))
        sys.exit(OK)
    else:
        try:
            subprocess.run('sudo -n true', shell=True, check=True,
                           stdout=subprocess.DEVNULL,
                           stderr=subprocess.DEVNULL)
        except Exception:
            try:
                subprocess.run('sudo true', shell=True, check=True)
            except KeyboardInterrupt:
                print('\n' + _('Program {} has been interrupted.').
                      format(PROGRAM_NAME))
                sys.exit(ERROR)
            except Exception as ex:
                print(ex)
                sys.exit(ERROR)


def check_user_sudo():
    """
    This function checks if the user is allowed to use sudo and exits 0 if so,
    otherwise exits 1.
    """
    if os.getuid() == 0:
        return(OK)
    try:
        subprocess.run('groups $USER | grep --quiet --regexp=sudo',
                       shell=True, check=True,
                       stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    except Exception:
        return(ERROR)
    else:
        return(OK)


def process_option(PROGRAM_NAME, PROGRAM_DESC, DISPLAY_NAME):
    """
    This function handles the general options.
    """
    USAGE_LINE = _("type '{} --usage' for more information").\
        format(DISPLAY_NAME)

    parser = argparse.ArgumentParser(prog=DISPLAY_NAME, add_help=False,
                                     usage=USAGE_LINE)
    parser.add_argument('-h', '--help', action='store_true')
    parser.add_argument('-u', '--usage', action='store_true')
    parser.add_argument('-v', '--version', action='store_true')
    args = parser.parse_args()

    if args.help:
        process_option_help(DISPLAY_NAME, PROGRAM_DESC, PROGRAM_NAME)
        sys.exit(OK)
    elif args.usage:
        process_option_usage(DISPLAY_NAME)
        sys.exit(OK)
    elif args.version:
        process_option_version(PROGRAM_NAME)
        sys.exit(OK)


def process_option_help(DISPLAY_NAME, PROGRAM_DESC, PROGRAM_NAME):
    """
    This function shows the available help.
    """
    print(_('Usage: {} [OPTION...]\n'
            '\n'
            '{}.\n'
            '\n'
            'Options:\n'
            '  -h, --help     give this help list\n'
            '  -u, --usage    give a short usage message\n'
            '  -v, --version  print program version\n\n'
            "Type 'man {}' or see the \
\x1b]8;;man:{}(1)\x1b\\{} man page\x1b]8;;\x1b\\ for more information.").
          format(DISPLAY_NAME, PROGRAM_DESC, DISPLAY_NAME, PROGRAM_NAME,
                 DISPLAY_NAME))


def process_option_usage(DISPLAY_NAME):
    """
    This function shows the available options.
    """
    print(_('Usage: {} [-h|--help] [-u|--usage] [-v|--version]\n'
            '\n'
            "Type '{} --help' for more information.").
          format(DISPLAY_NAME, DISPLAY_NAME))


def process_option_version(PROGRAM_NAME):
    """
    This function displays version, author, and license information.
    """
    build_id = '????-??-?? ??:??'
    cmd = ''
    grep_expr = '# <https://creativecommons.org'
    program_year = '????'

    try:
        with open('/usr/local/etc/kz-build-id') as fh:
            build_id = fh.read()
    except FileNotFoundError:
        build_id = '????-??-?? ??:??'
    except Exception as ex:
        print(ex)
        sys.exit(ERROR)
    finally:
        cmd = f"grep '--regexp={grep_expr}' {MODULE_PATH}/{PROGRAM_NAME}"
        cmd = f"{cmd} | cut --delimiter=' ' --fields=3"
        program_year = subprocess.check_output(cmd, shell=True,
                                               stderr=subprocess.DEVNULL)
        program_year = program_year.decode('utf-8').strip()
        if program_year == '':
            program_year = '????'

        print(_('{} (kz) 365 ({})\n'
                '\n'
                'Written by Karel Zimmer <info@karelzimmer.nl>, CC0 1.0 \
Universal\n'
                '<https://creativecommons.org/publicdomain/zero/1.0>, {}')
              .format(PROGRAM_NAME, build_id, program_year))


###############################################################################
# Main Script
###############################################################################

if __name__ == '__main__':
    print(_('{}: i am a module').format(MODULE_NAME))
