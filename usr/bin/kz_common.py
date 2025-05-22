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
# Functions
###############################################################################

def become_root(PROGRAM_NAME: str, PROGRAM_DESC: str,
                OPTION_GUI: bool = False) -> None:
    """
    This function checks if the script was started as user root and restarts
    the script as user root if not.
    """
    exc: str = ''
    exec_sudo: str = 'exec sudo '
    text: str

    if not become_root_check(PROGRAM_NAME, PROGRAM_DESC, OPTION_GUI):
        term(PROGRAM_NAME, 0)

    if os.getuid() != 0:
        # From "['path/script', 'arg1', ...]" to "'path/script' 'arg1' ...".
        for arg_num in range(len(sys.argv)):
            if arg_num == 0:
                exec_sudo += str(sys.argv[arg_num])
            else:
                exec_sudo += ' ' + str(sys.argv[arg_num])
        text = f'Restart ({exec_sudo})'
        logmsg(PROGRAM_NAME, text)

        try:
            subprocess.run(exec_sudo, executable='bash',
                           shell=True, check=True)
        except KeyboardInterrupt:
            text = _('Program {} has been interrupted.').format(PROGRAM_NAME)
            errmsg(PROGRAM_NAME, PROGRAM_DESC, text)
            term(PROGRAM_NAME, 1)
        except Exception as exc:
            text = str(exc)
            logmsg(PROGRAM_NAME, text)
            text = _('Program {} encountered an error.').format(PROGRAM_NAME)
            errmsg(PROGRAM_NAME, PROGRAM_DESC, text)
            term(PROGRAM_NAME, 1)
        else:
            term(PROGRAM_NAME, 0)


def become_root_check(PROGRAM_NAME: str, PROGRAM_DESC: str,
                      OPTION_GUI: bool = False) -> bool:
    """
    This function checks if the user is allowed to become root and returns 0 if
    so, otherwise returns 1 with descriptive message.
    """
    command: str = 'groups $USER | grep --quiet --regexp=sudo --regexp=wheel'
    text: str

    if os.getuid() == 0:
        return True
    try:
        subprocess.run(command, executable='bash', shell=True, check=True)
    except Exception:
        text = _('Already performed by the administrator.')
        infomsg(PROGRAM_NAME, PROGRAM_DESC, text, OPTION_GUI)
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
    text: str

    if subprocess.run(command1, executable='bash',
                      stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL,
                      shell=True).returncode == 0:
        return 0

    while True:
        try:
            subprocess.run(command2, executable='bash', shell=True, check=True)
        except Exception:
            break
        else:
            text = _('Wait {} seconds for another package manager to \
finish').format(sleep)
            text += '...'
            infomsg(PROGRAM_NAME, PROGRAM_DESC, text)
            time.sleep(sleep)

    return 0


def debugmsg(PROGRAM_NAME: str, TEXT: str) -> None:
    """
    This function records a debugging message to the log.
    """
    journal.sendv(f'SYSLOG_IDENTIFIER={PROGRAM_NAME}', f'MESSAGE={TEXT}',
                  f'PRIORITY=7')


def errmsg(PROGRAM_NAME: str, PROGRAM_DESC: str, TEXT: str,
           OPTION_GUI: bool = False) -> None:
    """
    This function returns an error message.
    """
    debugmsg(PROGRAM_NAME, TEXT)
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
        print(f'\n\033[1;31m{TEXT}\033[0m')


def infomsg(PROGRAM_NAME: str, PROGRAM_DESC: str, TEXT: str = '',
            OPTION_GUI: bool = False) -> None:
    """
    This function returns an informational message.
    """
    debugmsg(PROGRAM_NAME, TEXT)
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
    text: str

    if subprocess.run('type systemctlxx', executable='bash',
                    stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL,
                    shell=True).returncode != 0:
        print(f"\033[1;31m{_('fatal: no systemd available')}\033[0m",
            file=sys. stderr)
        sys.exit(1)

    if not os.path.exists('/etc/os-release'):
        print(f"\033[1;31m{_('fatal: no os release available')}\033[0m",
            file=sys. stderr)
        sys.exit(1)

    text = f'\
==== START logs for script {PROGRAM_NAME} ==================================\n'
    logmsg(PROGRAM_NAME, text)
    text = f"Started ({' '.join(sys.argv)} as {os.getlogin()}) ===="
    logmsg(PROGRAM_NAME, text)


def logmsg(PROGRAM_NAME: str, TEXT: str) -> None:
    """
    This function records a informational message to the log.
    """
    journal.sendv(f'SYSLOG_IDENTIFIER={PROGRAM_NAME}', f'MESSAGE={TEXT}')


def process_option_help(PROGRAM_NAME: str, PROGRAM_DESC: str,
                        HELP: str) -> None:
    """
    This function shows the available help.
    """
    yelp_man_url: str = ''
    program_name: str = PROGRAM_NAME.replace('kz-', 'kz ')
    text: str

    if subprocess.run('[[ ${DISPLAY-} ]]', executable='bash',
                      stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL,
                      shell=True).returncode == 0:
        yelp_man_url = f"{_(', or see the ')}"
        yelp_man_url += f'\x1b]8;;man:{PROGRAM_NAME}(1)\x1b\\{program_name}(1)'
        yelp_man_url += f" {_('man page')}\x1b]8;;\x1b\\"

    text = (f'{HELP}\n\n'
            f'''{_("Type '{} --manual' or 'man {}'{} ").
                 format(program_name, program_name, yelp_man_url)}'''
            f"{_('for more information.')}")
    infomsg(PROGRAM_NAME, PROGRAM_DESC, text)


def process_option_manual(PROGRAM_NAME: str, PROGRAM_DESC: str) -> None:
    """
    This function displays the manual page..
    """
    command1: str = f'yelp man:{PROGRAM_NAME}'
    command2: str = f'man --pager=cat {PROGRAM_NAME}'
    exc: str = ''
    text: str

    if subprocess.run('[[ ${DISPLAY-} ]]', executable='bash',
                      stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL,
                      shell=True).returncode == 0:
        try:
            subprocess.run(command1, executable='bash',
                           stderr=subprocess.DEVNULL,
                           shell=True, check=True,)
        except Exception as exc:
            text = str(exc)
            logmsg(PROGRAM_NAME, text)
            text = _('Program {} encountered an error.').format(PROGRAM_NAME)
            errmsg(PROGRAM_NAME, PROGRAM_DESC, text)
            term(PROGRAM_NAME, 1)
    else:
        try:
            subprocess.run(command2, executable='bash', shell=True, check=True)
        except Exception as exc:
            text = str(exc)
            logmsg(PROGRAM_NAME, text)
            text = _('Program {} encountered an error.').format(PROGRAM_NAME)
            errmsg(PROGRAM_NAME, PROGRAM_DESC, text)
            term(PROGRAM_NAME, 1)


def process_option_usage(PROGRAM_NAME: str, PROGRAM_DESC: str,
                         USAGE: str) -> None:
    """
    This function shows the available options.
    """
    program_name: str = PROGRAM_NAME.replace('kz-', 'kz ')
    text: str

    text = (f"{_('Usage:')} {USAGE}\n\n"
            f'''{_("Type '{} --help' for more information.").
                 format(program_name)}''')
    infomsg(PROGRAM_NAME, PROGRAM_DESC, text)


def process_option_version(PROGRAM_NAME: str, PROGRAM_DESC: str) -> None:
    """
    This function displays version, author, and license information.
    """
    build_id: str = ''  # ISO 8601 YYYY-MM-DDTHH:MM:SS
    fnf: str = ''
    exc: str = ''
    text: str

    try:
        with open('/usr/share/doc/kz/build.id') as fh:
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
        errmsg(PROGRAM_NAME, PROGRAM_DESC, text)
        term(PROGRAM_NAME, 1)
    finally:
        text = f"{_('kz version 4.2.1 (built {}).').format(build_id)}\n\n"
        text += f"{_('Written by Karel Zimmer <info@karelzimmer.nl>.')}\n"
        text += _('License CC0 1.0 \
<https://creativecommons.org/publicdomain/zero/1.0>.')
        infomsg(PROGRAM_NAME, PROGRAM_DESC, text)


def term(PROGRAM_NAME: str, rc: int) -> None:
    """
    This function controls the termination.
    """
    status: str = '1/FAILURE'
    text: str

    if rc == 0:
        status = '0/SUCCESS'

    text = f'Ended (code=exited, status={status}).'
    logmsg(PROGRAM_NAME, text)
    text = f'\
==== END logs for script {PROGRAM_NAME} ======================================'
    logmsg(PROGRAM_NAME, text)

    if rc == 0:
        sys.exit(0)
    else:
        sys.exit(1)


def wait_for_enter(PROGRAM_NAME: str, PROGRAM_DESC: str) -> int:
    """
    This function waits for the user to press Enter.
    """
    exc: str = ''
    text: str

    try:
        text = f"\n{_('Press the Enter key to continue [Enter]: ')}\n"
        debugmsg(PROGRAM_NAME, text)
        input(text)
    except KeyboardInterrupt:
        text = _('Program {} has been interrupted.').format(PROGRAM_NAME)
        errmsg(PROGRAM_NAME, PROGRAM_DESC, text)
        term(PROGRAM_NAME, 1)
    except Exception as exc:
        text = str(exc)
        logmsg(PROGRAM_NAME, text)
        text = _('Program {} encountered an error.').format(PROGRAM_NAME)
        errmsg(PROGRAM_NAME, PROGRAM_DESC, text)
        term(PROGRAM_NAME, 1)

    return 0
