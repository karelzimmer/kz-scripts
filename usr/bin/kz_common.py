"""
This module provides global variables and functions.
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
MODULE_DESC = _('Common module for Python scripts')
MODULE_PATH = f"{os.path.realpath(os.path.dirname(__file__))}"

OK = 0
ERROR = 1

NORMAL = '\033[0m'
BOLD = '\033[1m'

RED = '\033[1;31m'
YELLOW = '\033[1;33m'
BLUE = '\033[1;34m'


###############################################################################
# Variables
###############################################################################

PROGRAM_NAME = ''
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
        check_sudo_true()

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
            term_script(PROGRAM_NAME)
            sys.exit(ERROR)
        except Exception as exc:
            text = str(exc)
            msg_log(PROGRAM_NAME, text)
            text = _('Program {} encountered an error.').format(PROGRAM_NAME)
            msg_error(PROGRAM_NAME, text)
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
        subprocess.run('groups $USER | grep --quiet --regexp=sudo',
                       shell=True, check=True,
                       stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    except Exception:
        text = _('Already performed by the administrator.')
        msg_info(PROGRAM_NAME, text)
        return False
    else:
        return True


def check_for_active_updates():
    """
    This function checks for active updates and waits for the next check if so.
    """
    check_wait = 10

    check_sudo_true()
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
            text = _('Wait {}s for another package manager to finish...').\
                format(check_wait)
            msg_info(PROGRAM_NAME, text)
            time.sleep(check_wait)


def check_on_ac_power(PROGRAM_NAME):
    """
    This function checks to see if the computer is running on battery power and
    prompts the user to continue if so.
    """
    if subprocess.run('on_ac_power', shell=True,
                      stderr=subprocess.DEVNULL).returncode == 1:
        text = _('The computer now uses only the battery for power.\n\n'
                 'It is recommended to connect the computer to the wall socket\
.')
        msg_warning(PROGRAM_NAME, text)
        try:
            text = f"\n{_('Press the Enter key to continue [Enter]: ')}"
            input(text)
        except KeyboardInterrupt:
            text = _('Program {} has been interrupted.').format(PROGRAM_NAME)
            msg_error(PROGRAM_NAME, text)
            term_script(PROGRAM_NAME)
            sys.exit(ERROR)
        except Exception as exc:
            text = str(exc)
            msg_log(PROGRAM_NAME, text)
            text = _('Program {} encountered an error.').format(PROGRAM_NAME)
            msg_error(PROGRAM_NAME, text)
            term_script(PROGRAM_NAME)
            sys.exit(ERROR)
        else:
            return(OK)


def check_sudo_true():
    """
    This function prompts the user for the [sudo] password if necessary.
    """
    subprocess.run('sudo --non-interactive true || true', shell=True)
    try:
        subprocess.run('sudo true', shell=True)
    except KeyboardInterrupt:
        text = _('Program {} has been interrupted.').format(PROGRAM_NAME)
        msg_error(PROGRAM_NAME, text)
        term_script(PROGRAM_NAME)
        sys.exit(ERROR)
    except Exception as exc:
        text = str(exc)
        msg_log(PROGRAM_NAME, text)
        text = _('Program {} encountered an error.').format(PROGRAM_NAME)
        msg_error(PROGRAM_NAME, text)
        term_script(PROGRAM_NAME)
        sys.exit(ERROR)
    else:
        return(OK)


def init_script(PROGRAM_NAME):
    """
    This function performs initial actions.
    """
    text = f'==== START logs for script {PROGRAM_NAME} ===='
    msg_log(PROGRAM_NAME, text)


def msg_error(PROGRAM_NAME, text):
    """
    This function returns an error message and logs it.
    """
    print(f'{RED}{text}{NORMAL}')


def msg_info(PROGRAM_NAME, text):
    """
    This function returns an informational message and logs it.
    """
    print(f'{text}')


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
    man_url = f'\x1b]8;;man:{PROGRAM_NAME}(1)\x1b\\{DISPLAY_NAME} '
    man_url += f"{_('man page')}\x1b]8;;\x1b\\"

    text = (f"{_('Usage: {} [OPTION...]').format(DISPLAY_NAME)}\n\n"
            f'{PROGRAM_DESC}.\n\n'
            f"{_('Options:')}\n"
            f"{_('  -h, --help     give this help list')}\n"
            f"{_('  -u, --usage    give a short usage message')}\n"
            f"{_('  -v, --version  print program version')}\n\n"
            f'''{_("Type 'man {}' or see the {} for more information.").
               format(DISPLAY_NAME, man_url)}''')
    msg_info(PROGRAM_NAME, text)


def process_option_usage(DISPLAY_NAME):
    """
    This function shows the available options.
    """
    text = (f"{_('Usage: {}').format(DISPLAY_NAME)}"
            ' [-h|--help] [-u|--usage] [-v|--version]\n\n'
            f'''{_("Type '{} --help' for more information.").
                format(DISPLAY_NAME)}''')
    msg_info(PROGRAM_NAME, text)


def process_option_version(PROGRAM_NAME):
    """
    This function displays version, author, and license information.
    """
    build_id = ''
    command = ''
    grep_expr = '# <https://creativecommons.org'
    program_year = ''

    try:
        with open('/etc/kz-build.id') as fh:
            build_id = f' ({fh.read()})'
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
        term_script(PROGRAM_NAME)
        sys.exit(ERROR)
    finally:
        command = f"grep '--regexp={grep_expr}' {MODULE_PATH}/{PROGRAM_NAME} |"
        command += f" cut --delimiter=' ' --fields=3"
        program_year = subprocess.check_output(command, shell=True,
                                               stderr=subprocess.DEVNULL)
        program_year = program_year.decode('utf-8').strip()
        if program_year == '':
            text = _('Program year cannot be determined.')
            msg_log(PROGRAM_NAME, text)
            program_year = '.'
        else:
            program_year = ', ' + program_year

        text = (f'kz 4.2.1{build_id}\n\n'
                f"{_('Written by')}"
                ' Karel Zimmer <info@karelzimmer.nl>, CC0 1.0 Universal\n\n'
                '<https://creativecommons.org/publicdomain/zero/1.0>'
                f'{program_year}')
        msg_info(PROGRAM_NAME, text)


def term_script(PROGRAM_NAME):
    """
    This function controls the termination of the script.
    """
    text = f'==== END logs for script {PROGRAM_NAME} ===='
    msg_log(PROGRAM_NAME, text)


###############################################################################
# Main Script
###############################################################################

if __name__ == '__main__':
    text = _('{}: i am a module').format(MODULE_NAME)
    msg_info(PROGRAM_NAME, text)
