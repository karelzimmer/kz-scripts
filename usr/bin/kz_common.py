"""
This module provides general variables and functions.
"""
###############################################################################
# Common module for Python scripts.
#
# Written by Karel Zimmer <info@karelzimmer.nl>, CC0 1.0 Universal
# <https://creativecommons.org/publicdomain/zero/1.0>, 2021-2024.
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
MODULE_DESC = (_('Common module for Python scripts'))
MODULE_PATH = f"{os.path.realpath(os.path.dirname(__file__))}"

OK = 0
ERROR = 1

NORMAL = '\033[0m'
BOLD = '\033[1m'
DIM = '\033[2m'
ITALIC = '\033[3m'
UNDERLINE = '\033[4m'
BLINK = '\033[5m'
REVERSE = '\033[7m'
HIDDEN = '\033[8m'

RED = '\033[31m'
GREEN = '\033[32m'
YELLOW = '\033[33m'
BLUE = '\033[34m'
MAGENTA = '\033[35m'
CYAN = '\033[36m'
GRAY = '\033[37m'


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

    become_root_check()

    if os.getuid() != 0:
        subprocess.run('sudo --non-interactive true || true', shell=True)

        # From "['path/script', 'arg1', ...]" to "'path/script' 'arg1' ...".
        for arg_num in range(len(sys.argv)):
            if arg_num == 0:
                exec_sudo += str(sys.argv[arg_num])
            else:
                exec_sudo += ' ' + str(sys.argv[arg_num])
        text = f'restart ({exec_sudo})'
        msg_log(PROGRAM_NAME, text)

        try:
            subprocess.run(exec_sudo, shell=True, check=True)
        except KeyboardInterrupt:
            text = _('Program {} has been interrupted.').format(PROGRAM_NAME)
            msg_error(PROGRAM_NAME, text)
            sys.exit(ERROR)
        except Exception as exc:
            text = str(exc)
            msg_log(PROGRAM_NAME, text)
            text = _('Program {} encountered an error.').format(PROGRAM_NAME)
            msg_error(PROGRAM_NAME, text)
            sys.exit(ERROR)
        else:
            sys.exit(OK)


def become_root_check():
    """
    This function checks if the user is allowed to become root and returns 0 if
    so, otherwise exits 0 with descriptive message.
    """
    if os.getuid() == 0:
        return(OK)
    try:
        subprocess.run('groups $USER | grep --quiet --regexp=sudo',
                       shell=True, check=True,
                       stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    except Exception:
        print(_('Already performed by the administrator.'))
        sys.exit(OK)
    else:
        return(OK)


def check_for_active_updates():
    """
    This function checks for active updates and waits for the next check if so.
    """
    check_wait = 10

    subprocess.run('sudo --non-interactive true || true', shell=True)
    while True:
        try:
            subprocess.run('sudo fuser '
                           '/snap/core/*/var/cache/debconf/config.dat '
                           '/var/cache/apt/archives/lock '
                           '/var/cache/debconf/config.dat '
                           '/var/lib/apt/lists/lock '
                           '/var/lib/dpkg/lock-frontend '
                           '/var/lib/dpkg/lock',
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
    This function checks to see if the computer is running on battery power and
    prompts the user to continue if so.
    """
    if subprocess.run('on_ac_power', shell=True,
                      stderr=subprocess.DEVNULL).returncode == 1:
        text = _('The computer now uses only the battery for power.\n\n'
                 'It is recommended to connect the computer to the wall \
socket.')
        msg_warning(PROGRAM_NAME, text)
        try:
            input('\n' + _('Press the Enter key to continue [Enter]: '))
        except KeyboardInterrupt:
            text = _('Program {} has been interrupted.').format(PROGRAM_NAME)
            msg_error(PROGRAM_NAME, text)
            sys.exit(ERROR)
        except Exception as exc:
            text = str(exc)
            msg_log(PROGRAM_NAME, text)
            text = _('Program {} encountered an error.').format(PROGRAM_NAME)
            msg_error(PROGRAM_NAME, text)
            sys.exit(ERROR)
        else:
            return(OK)


def init_script(PROGRAM_NAME):
    """
    This function performs initial actions.
    """
    text = f'==== START log {PROGRAM_NAME} ===='
    msg_log(PROGRAM_NAME, text)


def msg_error(PROGRAM_NAME, text):
    """
    This function returns an error message and logs it.
    """
    print(f'{RED}{text}{NORMAL}')
    msg_log(PROGRAM_NAME, f'{RED}{text}{NORMAL}')


def msg_log(PROGRAM_NAME, text):
    """
    This function records a message to the log.
    """
    journal.sendv(f'SYSLOG_IDENTIFIER={PROGRAM_NAME}', f'MESSAGE={text}')


def msg_warning(PROGRAM_NAME, text):
    """
    This function returns a warning message and logs it.
    """
    print(f'{YELLOW}{text}{NORMAL}')
    msg_log(PROGRAM_NAME, f'{YELLOW}{text}{NORMAL}')


def process_options(PROGRAM_NAME, PROGRAM_DESC, DISPLAY_NAME):
    """
    This function handles the general options.
    """
    USAGE_LINE = _("type '{} --usage' for more information").\
        format(DISPLAY_NAME)

    parser = argparse.ArgumentParser(prog=DISPLAY_NAME, usage=USAGE_LINE,
                                     add_help=False)
    parser.add_argument('-h', '--help', action='store_true')
    parser.add_argument('-u', '--usage', action='store_true')
    parser.add_argument('-v', '--version', action='store_true')
    args = parser.parse_args()

    if args.help:
        process_option_help(DISPLAY_NAME, PROGRAM_DESC, PROGRAM_NAME)
        term_script(PROGRAM_NAME)
        sys.exit(OK)
    elif args.usage:
        process_option_usage(DISPLAY_NAME)
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
    man_url = '\x1b]8;;man:' + PROGRAM_NAME + '(1)\x1b\\' + DISPLAY_NAME
    man_url = man_url + ' ' + _('man page') + '\x1b]8;;\x1b\\'
    print(_('Usage: {} [OPTION...]\n').format(DISPLAY_NAME) +
          '\n' +
          PROGRAM_DESC + '.\n' +
          '\n' +
          _('Options:') + '\n' +
          _('  -h, --help     give this help list') + '\n' +
          _('  -u, --usage    give a short usage message') + '\n' +
          _('  -v, --version  print program version') + '\n' +
          '\n' +
          _("Type 'man {}' or see the {} for more information.").
          format(DISPLAY_NAME, man_url))


def process_option_usage(DISPLAY_NAME):
    """
    This function shows the available options.
    """
    print(_('Usage: {}').format(DISPLAY_NAME) +
          ' [-h|--help] [-u|--usage] [-v|--version]\n' +
          '\n' +
          _("Type '{} --help' for more information.").format(DISPLAY_NAME))


def process_option_version(PROGRAM_NAME):
    """
    This function displays version, author, and license information.
    """
    build_id = ''
    command = ''
    grep_expr = '# <https://creativecommons.org'
    program_year = ''

    try:
        with open('/usr/local/etc/kz-build.id') as fh:
            build_id = ' (' + fh.read() + ')'
    except FileNotFoundError as fnf:
        text = str(fnf)
        msg_log(PROGRAM_NAME, text)
        text = _('Build ID cannot be determined.')
        msg_log(PROGRAM_NAME, text)
        build_id = ''
    except Exception as exc:
        text = str(exc)
        msg_log(PROGRAM_NAME, text)
        text = _('Program {} encountered an error.').format(PROGRAM_NAME)
        msg_error(PROGRAM_NAME, text)
        sys.exit(ERROR)
    finally:
        command = f"grep '--regexp={grep_expr}' {MODULE_PATH}/{PROGRAM_NAME}"
        command = f"{command} | cut --delimiter=' ' --fields=3"
        program_year = subprocess.check_output(command, shell=True,
                                               stderr=subprocess.DEVNULL)
        program_year = program_year.decode('utf-8').strip()
        if program_year == '':
            text = _('Program year cannot be determined.')
            msg_log(PROGRAM_NAME, text)
            program_year = '.'
        else:
            program_year = ', ' + program_year

        print('kz 2.4.7' + build_id + '\n' +
              '\n' +
              _('Written by') + 'Karel Zimmer <info@karelzimmer.nl>,' +
              ' CC0 1.0 Universal\n' +
              '<https://creativecommons.org/publicdomain/zero/1.0>' +
              program_year)


def term_script(PROGRAM_NAME):
    """
    This function controls the termination of the script.
    """
    text = f'==== END log {PROGRAM_NAME} ===='
    msg_log(PROGRAM_NAME, text)


###############################################################################
# Main Script
###############################################################################

if __name__ == '__main__':
    print(_('{}: i am a module').format(MODULE_NAME))
