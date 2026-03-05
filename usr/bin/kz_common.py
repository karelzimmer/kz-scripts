# #############################################################################
# SPDX-FileComment: Common module for kz Python scripts
#
# SPDX-FileCopyrightText: Karel Zimmer <info@karelzimmer.nl>
# SPDX-License-Identifier: CC0-1.0
# #############################################################################


# #############################################################################
# Imports
# #############################################################################

import gettext
import os
import subprocess
import sys
import time
from systemd import journal  # type: ignore

gettext.bindtextdomain('kz', '/usr/share/locale')
gettext.textdomain('kz')
_ = gettext.gettext


# #############################################################################
# Constants
# #############################################################################

# List NORMAL last here so that debugging doesn't bork the display.
BOLD: str = '\033[1m'
GREEN: str = BOLD + '\033[32m'
RED: str = BOLD + '\033[31m'
NORMAL: str = '\033[0m'


# #############################################################################
# Functions
# #############################################################################

def become_check(PROGRAM_NAME: str, PROGRAM_DESC: str,
                 OPTION_GUI: bool = False) -> int:
    """
    This function checks if the user is allowed to become root and returns 0 if
    so, otherwise exits 0 with descriptive message.
    """
    check_become_root: str = "groups $USER | grep --quiet --regexp='sudo'" + \
        " --regexp='wheel'"
    text: str = ''

    if subprocess.run(check_become_root, executable='bash',
                      stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL,
                      shell=True).returncode == 0:
        return 0
    else:
        text = GREEN + _('Already performed by the administrator.') + NORMAL
        infomsg(PROGRAM_NAME, PROGRAM_DESC, text, OPTION_GUI)
        sys.exit(0)


def check_debian_package_manager(PROGRAM_NAME: str, PROGRAM_DESC: str) -> int:
    """
    This function checks if a Debian package manager is already running and
    waits for the next check if so.
    """
    check_debian_package_manager: str = 'pkexec /usr/bin/kz_common-pkexec'
    check_rhel: str = "grep --quiet --regexp='rhel' /etc/os-release"
    text: str = ''

    if subprocess.run(check_rhel, executable='bash',
                      stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL,
                      shell=True).returncode == 0:
        return 0

    text = BOLD + _('Wait for another package manager to finish...') + NORMAL

    while True:
        try:
            subprocess.run(check_debian_package_manager, executable='bash',
                           shell=True, check=True)
        except Exception:
            break
        else:
            infomsg(PROGRAM_NAME, PROGRAM_DESC, text)
            time.sleep(2)

    return 0


def logmsg(PROGRAM_NAME: str, TEXT: str) -> None:
    """
    This function records a informational message to the log.
    """
    journal.sendv(f'SYSLOG_IDENTIFIER={PROGRAM_NAME}', f'MESSAGE={TEXT}')


def errmsg(PROGRAM_NAME: str, PROGRAM_DESC: str, TEXT: str,
           OPTION_GUI: bool = False) -> None:
    """
    This function returns an error message.
    """
    logmsg(PROGRAM_NAME, TEXT)
    if OPTION_GUI:
        title: str = PROGRAM_DESC
        zenity: str = f'zenity --error                  \
                                --width     600         \
                                --height    100         \
                                --title     "{title}"   \
                                --text      "{TEXT}"'
        subprocess.run(zenity, executable='bash', shell=True)
    else:
        print(f'{RED}{TEXT}{NORMAL}')


def infomsg(PROGRAM_NAME: str, PROGRAM_DESC: str, TEXT: str,
            OPTION_GUI: bool = False) -> None:
    """
    This function returns an informational message.
    """
    logmsg(PROGRAM_NAME, TEXT)
    if OPTION_GUI:
        title: str = PROGRAM_DESC
        zenity: str = f'zenity --info                   \
                                --width     600         \
                                --height    100         \
                                --title     "{title}"   \
                                --text      "{TEXT}"'
        subprocess.run(zenity, executable='bash', shell=True)
    else:
        print(TEXT)


def init(PROGRAM_NAME: str) -> None:
    """
    This function performs initial actions.
    """
    text: str = ''

    # Check if systemd is available.
    if subprocess.run('type systemctl', executable='bash',
                      stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL,
                      shell=True).returncode != 0:
        text = _('fatal: no systemd available')
        print(f'{RED}{text}{NORMAL}', file=sys.stderr)
        sys.exit(1)

    # Check if os release is available.
    if not os.path.exists('/etc/os-release'):
        text = _('fatal: no os release available')
        print(f'{RED}{text}{NORMAL}', file=sys.stderr)
        sys.exit(1)

    # Check if started as root.
    if os.getuid() == 0:
        text = _('fatal: must not be run as root')
        print(f'{RED}{text}{NORMAL}', file=sys.stderr)
        sys.exit(1)

    text = f'==== START logs for script {PROGRAM_NAME}'
    logmsg(PROGRAM_NAME, text)
    text = f"Started ({' '.join(sys.argv)} as {os.getlogin()})."
    logmsg(PROGRAM_NAME, text)


def process_option_help(PROGRAM_NAME: str, PROGRAM_DESC: str,
                        HELP: str) -> None:
    """
    This function shows the available help.
    """
    yelp_man_url: str = ''
    program_name: str = PROGRAM_NAME.replace('kz-', 'kz ')
    text: str = ''

    if subprocess.run('[[ -n ${DISPLAY-} ]]', executable='bash',
                      stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL,
                      shell=True).returncode == 0:
        yelp_man_url = _(', or see the ') + '\x1b]8;;man:' + PROGRAM_NAME + \
            '(1)\x1b\\' + program_name + '(1) ' + _('man page') + \
            '\x1b]8;;\x1b\\'

    text = HELP + '\n\n' + \
        _("Type '{} --manual' or 'man {}'{} ").\
        format(program_name, program_name, yelp_man_url) + \
        _('for more information.')
    infomsg(PROGRAM_NAME, PROGRAM_DESC, text)


def process_option_manual(PROGRAM_NAME: str, PROGRAM_DESC: str) -> None:
    """
    This function displays the manual page..
    """
    exc: BaseException
    man: str = f'man {PROGRAM_NAME}'
    text: str = ''
    yelp: str = f'yelp man:{PROGRAM_NAME}'

    if subprocess.run('[[ -n ${DISPLAY-} ]]', executable='bash',
                      stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL,
                      shell=True).returncode == 0:
        try:
            subprocess.run(yelp, executable='bash',
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
            subprocess.run(man, executable='bash', shell=True, check=True)
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
    text: str = ''

    text = USAGE + '\n\n' + _("Type '{} --help' for more information.").\
        format(program_name)
    infomsg(PROGRAM_NAME, PROGRAM_DESC, text)


def process_option_version(PROGRAM_NAME: str, PROGRAM_DESC: str) -> None:
    """
    This function displays version, author, and license information.
    """
    build_id: str = 'n/a'  # ISO 8601 YYYY-MM-DDTHH:MM:SS
    fnf: BaseException
    exc: BaseException
    text: str = ''

    try:
        with open('/usr/share/doc/kz/build.id') as fh:
            build_id = f'{fh.read()}'
    except FileNotFoundError as fnf:
        text = str(fnf)
        logmsg(PROGRAM_NAME, text)
    except Exception as exc:
        text = str(exc)
        logmsg(PROGRAM_NAME, text)
        text = _('Program {} encountered an error.').format(PROGRAM_NAME)
        errmsg(PROGRAM_NAME, PROGRAM_DESC, text)
        term(PROGRAM_NAME, 1)
    finally:
        text = _('kz version 4.2.1 (built {}).').format(build_id) + '\n\n' + \
            _('Written by Karel Zimmer <info@karelzimmer.nl>.') + '\n' + \
            _('License CC0 1.0 ' +
                '<https://creativecommons.org/publicdomain/zero/1.0>.')
        infomsg(PROGRAM_NAME, PROGRAM_DESC, text)


def term(PROGRAM_NAME: str, rc: int) -> None:
    """
    This function controls the termination.
    """
    status: str = '1/FAILURE'
    text: str = ''

    if rc == 0:
        status = '0/SUCCESS'

    text = f'Ended (code=exited, status={status}).'
    logmsg(PROGRAM_NAME, text)
    text = f'==== END logs for script {PROGRAM_NAME}'
    logmsg(PROGRAM_NAME, text)

    if rc == 0:
        sys.exit(0)
    else:
        sys.exit(1)


def wait_for_enter(PROGRAM_NAME: str, PROGRAM_DESC: str) -> int:
    """
    This function waits for the user to press Enter.
    """
    exc: BaseException
    text: str = ''

    try:
        text = '\n' + _('Press the Enter key to continue [Enter]: ') + '\n'
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
