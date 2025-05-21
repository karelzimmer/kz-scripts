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
from systemd import journal  # type: ignore

gettext.bindtextdomain('kz', '/usr/share/locale')
gettext.textdomain('kz')
_ = gettext.gettext


###############################################################################
# Constants
###############################################################################

OK: int = 0
ERR: int = 1

# List NORMAL last here so that Python debugger (pdb) doesn't bork the display.
RED: str = '\033[1;31m'
NORMAL: str = '\033[0m'

if subprocess.run('type systemctl', executable='bash',
                  stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL,
                  shell=True).returncode != OK:
    print(f"{RED}{_('fatal: no systemd available')}{NORMAL}")
    sys.exit(ERR)

if not os.path.exists('/etc/os-release'):
    print(f"{RED}{_('fatal: no os release available')}{NORMAL}")
    sys.exit(ERR)


###############################################################################
# Globals
###############################################################################

TEXT: str = ''


###############################################################################
# Functions
###############################################################################

def become_root(PROGRAM_NAME: str, PROGRAM_DESC: str,
                OPTION_GUI: bool = False) -> None:
    """
    This function checks whether the script is started as user root and
    restarts the script as user root if not.
    """
    exc: str = ''
    exec_sudo: str = 'exec sudo '

    if not become_root_check(PROGRAM_NAME, PROGRAM_DESC, OPTION_GUI):
        term(PROGRAM_NAME, OK)

    if os.getuid() != 0:
        # From "['path/script', 'arg1', ...]" to "'path/script' 'arg1' ...".
        for arg_num in range(len(sys.argv)):
            if arg_num == 0:
                exec_sudo += str(sys.argv[arg_num])
            else:
                exec_sudo += ' ' + str(sys.argv[arg_num])
        TEXT = f'Restart ({exec_sudo})'
        logmsg(PROGRAM_NAME, TEXT)

        try:
            subprocess.run(exec_sudo, executable='bash',
                           shell=True, check=True)
        except KeyboardInterrupt:
            TEXT = _('Program {} has been interrupted.').format(PROGRAM_NAME)
            errmsg(PROGRAM_NAME, PROGRAM_DESC, TEXT)
            term(PROGRAM_NAME, ERR)
        except Exception as exc:
            TEXT = str(exc)
            logmsg(PROGRAM_NAME, TEXT)
            TEXT = _('Program {} encountered an error.').format(PROGRAM_NAME)
            errmsg(PROGRAM_NAME, PROGRAM_DESC, TEXT)
            term(PROGRAM_NAME, ERR)
        else:
            term(PROGRAM_NAME, OK)


def become_root_check(PROGRAM_NAME: str, PROGRAM_DESC: str,
                      OPTION_GUI: bool = False) -> bool:
    """
    This function checks if the user is allowed to become root and returns 0 if
    so, otherwise returns 1 with descriptive message.
    """
    command: str = 'groups $USER | grep --quiet --regexp=sudo --regexp=wheel'

    if os.getuid() == 0:
        return True
    try:
        subprocess.run(command, executable='bash', shell=True, check=True)
    except Exception:
        TEXT = _('Already performed by the administrator.')
        infomsg(PROGRAM_NAME, PROGRAM_DESC, TEXT, OPTION_GUI)
        return False
    else:
        return True


def check_package_manager(PROGRAM_NAME: str, PROGRAM_DESC: str) -> int:
    """
    This function checks for another running package manager and waits for the
    next check if so.
    """
    sleep: int = 5
    command1: str = 'grep --quiet rhel /etc/os-release'
    command2: str = 'sudo fuser --silent /var/cache/debconf/config.dat '
    command2 += '/var/{lib/{dpkg,apt/lists},cache/apt/archives}/lock*'

    if subprocess.run(command1, executable='bash',
                      stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL,
                      shell=True).returncode == OK:
        return OK

    while True:
        try:
            subprocess.run(command2, executable='bash', shell=True, check=True)
        except Exception:
            break
        else:
            TEXT = _('Wait {} seconds for another package manager to \
finish').format(sleep)
            TEXT += '...'
            infomsg(PROGRAM_NAME, PROGRAM_DESC, TEXT)
            time.sleep(sleep)

    return OK


def errmsg(PROGRAM_NAME: str, PROGRAM_DESC: str, TEXT: str,
           OPTION_GUI: bool = False) -> None:
    """
    This function returns an error message.
    """
    logmsg(PROGRAM_NAME, TEXT)
    if OPTION_GUI:
        program_name: str = PROGRAM_NAME.replace('kz-', 'kz ')
        title: str = f"{PROGRAM_DESC} {_('error message')} ({program_name})"
        command: str = f'zenity --error                 \
                                --width     600         \
                                --height    100         \
                                --title     "{title}"   \
                                --text      "{TEXT}"'
        subprocess.run(command, executable='bash', shell=True)
    else:
        print(f'\n{RED}{TEXT}{NORMAL}')


def infomsg(PROGRAM_NAME: str, PROGRAM_DESC: str, TEXT: str = '',
            OPTION_GUI: bool = False) -> None:
    """
    This function returns an informational message.
    """
    logmsg(PROGRAM_NAME, TEXT)
    if OPTION_GUI:
        program_name: str = PROGRAM_NAME.replace('kz-', 'kz ')
        title: str = f"{PROGRAM_DESC} {_('information')} ({program_name})"
        command: str = f'zenity --info                  \
                                --width     600         \
                                --height    100         \
                                --title     "{title}"   \
                                --text      "{TEXT}"'
        subprocess.run(command, executable='bash', shell=True)
    else:
        print(TEXT)


def init(PROGRAM_NAME: str) -> None:
    """
    This function performs initial actions.
    """
    TEXT = f"\
==== START logs for script {PROGRAM_NAME} ==================================\n"
    logmsg(PROGRAM_NAME, TEXT)
    TEXT = f"Started ({' '.join(sys.argv)} as {os.getlogin()}) ===="
    logmsg(PROGRAM_NAME, TEXT)


def logmsg(PROGRAM_NAME: str, TEXT: str) -> None:
    """
    This function records a message to the log.
    """
    journal.sendv(f'SYSLOG_IDENTIFIER={PROGRAM_NAME}', f'MESSAGE={TEXT}')


def process_option_help(PROGRAM_NAME: str, PROGRAM_DESC: str,
                        HELP: str) -> None:
    """
    This function shows the available help.
    """
    yelp_man_url: str = ''
    program_name: str = PROGRAM_NAME.replace('kz-', 'kz ')

    if subprocess.run('[[ ${DISPLAY-} ]]', executable='bash',
                      stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL,
                      shell=True).returncode == OK:
        yelp_man_url = f"{_(', or see the ')}"
        yelp_man_url += f'\x1b]8;;man:{PROGRAM_NAME}(1)\x1b\\{program_name}(1)'
        yelp_man_url += f" {_('man page')}\x1b]8;;\x1b\\"
    TEXT = (f'{HELP}\n\n'
            f'''{_("Type '{} --manual' or 'man {}'{} ").
                 format(program_name, program_name, yelp_man_url)}'''
            f"{_('for more information.')}")
    infomsg(PROGRAM_NAME, PROGRAM_DESC, TEXT)


def process_option_manual(PROGRAM_NAME: str, PROGRAM_DESC: str) -> None:
    """
    This function displays the manual page..
    """
    command1: str = f'yelp man:{PROGRAM_NAME}'
    command2: str = f'man --pager=cat {PROGRAM_NAME}'
    exc: str = ''

    if subprocess.run('[[ ${DISPLAY-} ]]', executable='bash',
                      stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL,
                      shell=True).returncode == OK:
        try:
            subprocess.run(command1, executable='bash',
                           stderr=subprocess.DEVNULL,
                           shell=True, check=True,)
        except Exception as exc:
            TEXT = str(exc)
            logmsg(PROGRAM_NAME, TEXT)
            TEXT = _('Program {} encountered an error.').format(PROGRAM_NAME)
            errmsg(PROGRAM_NAME, PROGRAM_DESC, TEXT)
            term(PROGRAM_NAME, ERR)
    else:
        try:
            subprocess.run(command2, executable='bash', shell=True, check=True)
        except Exception as exc:
            TEXT = str(exc)
            logmsg(PROGRAM_NAME, TEXT)
            TEXT = _('Program {} encountered an error.').format(PROGRAM_NAME)
            errmsg(PROGRAM_NAME, PROGRAM_DESC, TEXT)
            term(PROGRAM_NAME, ERR)


def process_option_usage(PROGRAM_NAME: str, PROGRAM_DESC: str,
                         USAGE: str) -> None:
    """
    This function shows the available options.
    """
    program_name: str = PROGRAM_NAME.replace('kz-', 'kz ')

    TEXT = (f"{_('Usage:')} {USAGE}\n\n"
            f'''{_("Type '{} --help' for more information.").
                 format(program_name)}''')
    infomsg(PROGRAM_NAME, PROGRAM_DESC, TEXT)


def process_option_version(PROGRAM_NAME: str, PROGRAM_DESC: str) -> None:
    """
    This function displays version, author, and license information.
    """
    build_id: str = ''  # ISO 8601 YYYY-MM-DDTHH:MM:SS
    fnf: str = ''
    exc: str = ''

    try:
        with open('/usr/share/doc/kz/build.id') as fh:
            build_id = f'{fh.read()}'
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
        errmsg(PROGRAM_NAME, PROGRAM_DESC, TEXT)
        term(PROGRAM_NAME, ERR)
    finally:
        TEXT = f"{_('kz version 4.2.1 (built {}).').format(build_id)}\n\n"
        TEXT += f"{_('Written by Karel Zimmer <info@karelzimmer.nl>.')}\n"
        TEXT += _('License CC0 1.0 \
<https://creativecommons.org/publicdomain/zero/1.0>.')
        infomsg(PROGRAM_NAME, PROGRAM_DESC, TEXT)


def term(PROGRAM_NAME: str, rc: int) -> None:
    """
    This function controls the termination.
    """
    status: str = '1/FAILURE'

    if rc == OK:
        status = '0/SUCCESS'

    TEXT = f'Ended (code=exited, status={status}).'
    logmsg(PROGRAM_NAME, TEXT)
    TEXT = f'\
==== END logs for script {PROGRAM_NAME} ======================================'
    logmsg(PROGRAM_NAME, TEXT)

    if rc == OK:
        sys.exit(OK)
    else:
        sys.exit(ERR)


def wait_for_enter(PROGRAM_NAME: str, PROGRAM_DESC: str) -> int:
    """
    This function waits for the user to press Enter.
    """
    exc: str = ''

    try:
        TEXT = f"\n{_('Press the Enter key to continue [Enter]: ')}\n"
        logmsg(PROGRAM_NAME, TEXT)
        input(TEXT)
    except KeyboardInterrupt:
        TEXT = _('Program {} has been interrupted.').format(PROGRAM_NAME)
        errmsg(PROGRAM_NAME, PROGRAM_DESC, TEXT)
        term(PROGRAM_NAME, ERR)
    except Exception as exc:
        TEXT = str(exc)
        logmsg(PROGRAM_NAME, TEXT)
        TEXT = _('Program {} encountered an error.').format(PROGRAM_NAME)
        errmsg(PROGRAM_NAME, PROGRAM_DESC, TEXT)
        term(PROGRAM_NAME, ERR)
    else:
        return OK

    return OK
