# #############################################################################
# SPDX-FileComment: Common module for kz Python scripts.
#
# SPDX-FileCopyrightText: Karel Zimmer <info@karelzimmer.nl>
# SPDX-License-Identifier: CC0-1.0
# #############################################################################


# #############################################################################
# Imports
# #############################################################################

from base64 import encode
import gettext
import os
import socket
import subprocess
import sys

gettext.bindtextdomain('kz', '/usr/share/locale')
gettext.textdomain('kz')
_ = gettext.gettext


# #############################################################################
# Constants
# #############################################################################

# List NORMAL last here so that debugging doesn't bork the display.
BOLD: str = '\033[1m'
GREEN: str = '\033[1;32m'
RED: str = '\033[1;31m'
NORMAL: str = '\033[0m'

# Where the the code is stored locally.
GITROOT: str = subprocess.run('xdg-user-dir PROJECTS', stdout=subprocess.PIPE,
                              shell=True, text=True).stdout.strip('\n')


# #############################################################################
# Functions
# #############################################################################

def errmsg(PROGRAM_NAME: str, PROGRAM_DESC: str, UI_MODE: str,
           TEXT: str) -> None:
    """
    This function returns an error message.
    """
    logmsg(PROGRAM_NAME, TEXT)
    if UI_MODE == 'gui':
        zenity: str = f'zenity      --error                         \
                                    --width     600                 \
                                    --height    100                 \
                                    --title     "{PROGRAM_DESC}"    \
                                    --text      "{TEXT}"            || true'
        try:
            subprocess.run(zenity, executable='bash', shell=True,
                           stderr=subprocess.DEVNULL)
        except KeyboardInterrupt:
            text = _('Program {} has been interrupted.').format(PROGRAM_NAME)
            errmsg(PROGRAM_NAME, PROGRAM_DESC, 'cli', text)
            term(PROGRAM_NAME, 130)
        except Exception as exc:
            text = str(exc)
            logmsg(PROGRAM_NAME, text)
            text = _('Program {} encountered an error.').format(PROGRAM_NAME)
            errmsg(PROGRAM_NAME, PROGRAM_DESC, 'cli', text)
            term(PROGRAM_NAME, 1)
    elif UI_MODE == 'tui':
        dialog: str = f'dialog  --backtitle "{PROGRAM_NAME}"    \
                                --title     "{PROGRAM_DESC}"    \
                                --msgbox    "{TEXT}"            \
                                0 0                             || true'
        try:
            subprocess.run(dialog, executable='bash', shell=True,
                           stderr=subprocess.DEVNULL)
        except KeyboardInterrupt:
            text = _('Program {} has been interrupted.').format(PROGRAM_NAME)
            errmsg(PROGRAM_NAME, PROGRAM_DESC, 'cli', text)
            term(PROGRAM_NAME, 130)
        except Exception as exc:
            text = str(exc)
            logmsg(PROGRAM_NAME, text)
            text = _('Program {} encountered an error.').format(PROGRAM_NAME)
            errmsg(PROGRAM_NAME, PROGRAM_DESC, 'cli', text)
            term(PROGRAM_NAME, 1)
    else:
        print(f'{RED}{TEXT}{NORMAL}', file=sys.stderr)


def infomsg(PROGRAM_NAME: str, PROGRAM_DESC: str, UI_MODE: str,
            TEXT: str) -> None:
    """
    This function returns an informational message.
    """
    logmsg(PROGRAM_NAME, TEXT)
    if UI_MODE == 'gui':
        zenity: str = f'zenity      --info                          \
                                    --width     600                 \
                                    --height    100                 \
                                    --title     "{PROGRAM_DESC}"    \
                                    --text      "{TEXT}"            || true'
        try:
            subprocess.run(zenity, executable='bash', shell=True,
                           stderr=subprocess.DEVNULL)
        except KeyboardInterrupt:
            text = _('Program {} has been interrupted.').format(PROGRAM_NAME)
            errmsg(PROGRAM_NAME, PROGRAM_DESC, 'cli', text)
            term(PROGRAM_NAME, 130)
        except Exception as exc:
            text = str(exc)
            logmsg(PROGRAM_NAME, text)
            text = _('Program {} encountered an error.').format(PROGRAM_NAME)
            errmsg(PROGRAM_NAME, PROGRAM_DESC, 'cli', text)
            term(PROGRAM_NAME, 1)
    elif UI_MODE == 'tui':
        dialog: str = f'dialog  --backtitle "{PROGRAM_NAME}"    \
                                --title     "{PROGRAM_DESC}"    \
                                --msgbox    "{TEXT}"            \
                                0 0                             || true'
        try:
            subprocess.run(dialog, executable='bash', shell=True,
                           stderr=subprocess.DEVNULL)
        except KeyboardInterrupt:
            text = _('Program {} has been interrupted.').format(PROGRAM_NAME)
            errmsg(PROGRAM_NAME, PROGRAM_DESC, 'cli', text)
            term(PROGRAM_NAME, 130)
        except Exception as exc:
            text = str(exc)
            logmsg(PROGRAM_NAME, text)
            text = _('Program {} encountered an error.').format(PROGRAM_NAME)
            errmsg(PROGRAM_NAME, PROGRAM_DESC, 'cli', text)
            term(PROGRAM_NAME, 1)
    else:
        print(TEXT)


def init(PROGRAM_NAME: str) -> None:
    """
    This function performs initial actions.
    """
    text: str = ''

    # Check if systemd is available.
    if subprocess.run('type systemctl', executable='bash',
                      stdout=subprocess.DEVNULL, shell=True).returncode != 0:
        text = _('fatal: no systemd available')
        print(f'{RED}{text}{NORMAL}', file=sys.stderr)
        sys.exit(1)

    # Check if os release is available.
    if not os.path.exists('/etc/os-release'):
        text = _('fatal: no os release available')
        print(f'{RED}{text}{NORMAL}', file=sys.stderr)
        sys.exit(1)

    text = f'\
==== START logs for script {PROGRAM_NAME} ===================================='
    logmsg(PROGRAM_NAME, text)
    text = f"Started ({' '.join(sys.argv)} as {os.getlogin()})."
    logmsg(PROGRAM_NAME, text)


def logmsg(PROGRAM_NAME: str, TEXT: str) -> None:
    """
    This function records a informational message to the log.
    """
    log: bytes = b''
    sock: socket.socket

    # This also works fine...
    # from systemd import journal  # type: ignore
    # journal.sendv(f'SYSLOG_IDENTIFIER={PROGRAM_NAME}', f'MESSAGE={TEXT}')
    # ...but not on older distributions, e.g. Rocky Linux 8.

    # Build the structured journal data package (field radius separated by \n).
    payload = (
        f"SYSLOG_IDENTIFIER={PROGRAM_NAME}\n"
        f"MESSAGE={TEXT}\n"
        ).encode('utf-8')

    # Connect to the local systemd journal socket.
    sock = socket.socket(socket.AF_UNIX, socket.SOCK_DGRAM)
    try:
        sock.connect('/run/systemd/journal/socket')
        sock.sendall(payload)
    except Exception:
        # Fallback to stdout if systemd-journald is not reachable.
        print(f"[{PROGRAM_NAME}] {TEXT}")
    finally:
        sock.close()


def process_option_help(PROGRAM_NAME: str, PROGRAM_DESC: str,
                        HELP: str) -> None:
    """
    This function shows the available help.
    """
    yelp_man_url: str = ''
    yelp_man: str = ''
    program_name: str = PROGRAM_NAME.replace('kz-', 'kz ')
    text: str = ''

    if subprocess.run('[[ -n ${XDG_CURRENT_DESKTOP-} ]]', executable='bash',
                      stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL,
                      shell=True).returncode == 0:
        yelp_man_url = f'\x1b]8;;man:{PROGRAM_NAME}(1)\x1b\\{program_name}(1)'
        yelp_man = _(", or see the {} man page").format(yelp_man_url)
        yelp_man += '\x1b]8;;\x1b\\'

    text = f'{HELP}\n\n'
    text += (
        _("Type '{} --manual' or 'man {}'{} ")
        ).format(program_name, program_name, yelp_man)
    text += _('for more information.')
    infomsg(PROGRAM_NAME, PROGRAM_DESC, 'cli', text)


def process_option_manual(PROGRAM_NAME: str, PROGRAM_DESC: str) -> None:
    """
    This function displays the manual page..
    """
    exc: BaseException
    man: str = f'man {PROGRAM_NAME}'
    text: str = ''
    yelp: str = f'yelp man:{PROGRAM_NAME}'

    if subprocess.run('[[ -n ${XDG_CURRENT_DESKTOP-} ]]', executable='bash',
                      stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL,
                      shell=True).returncode == 0:
        try:
            subprocess.run(yelp, executable='bash',
                           stderr=subprocess.DEVNULL,
                           shell=True, check=True,)
        except KeyboardInterrupt:
            text = _('Program {} has been interrupted.').format(PROGRAM_NAME)
            errmsg(PROGRAM_NAME, PROGRAM_DESC, 'cli', text)
            term(PROGRAM_NAME, 130)
        except subprocess.CalledProcessError as exc:
            text = str(exc)
            logmsg(PROGRAM_NAME, text)
            text = _('Program {} encountered an error.').format(PROGRAM_NAME)
            errmsg(PROGRAM_NAME, PROGRAM_DESC, 'cli', text)
            term(PROGRAM_NAME, exc.returncode)
    else:
        try:
            subprocess.run(man, executable='bash', shell=True, check=True)
        except KeyboardInterrupt:
            text = _('Program {} has been interrupted.').format(PROGRAM_NAME)
            errmsg(PROGRAM_NAME, PROGRAM_DESC, 'cli', text)
            term(PROGRAM_NAME, 130)
        except subprocess.CalledProcessError as exc:
            text = str(exc)
            logmsg(PROGRAM_NAME, text)
            text = _('Program {} encountered an error.').format(PROGRAM_NAME)
            errmsg(PROGRAM_NAME, PROGRAM_DESC, 'cli', text)
            term(PROGRAM_NAME, exc.returncode)


def process_option_usage(PROGRAM_NAME: str, PROGRAM_DESC: str,
                         USAGE: str) -> None:
    """
    This function shows the available options.
    """
    program_name: str = PROGRAM_NAME.replace('kz-', 'kz ')
    text: str = ''

    text = f'{USAGE}\n\n'
    text += _("Type '{} --help' for more information.").format(program_name)
    text += _('for more information.')

    infomsg(PROGRAM_NAME, PROGRAM_DESC, 'cli', text)


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
        errmsg(PROGRAM_NAME, PROGRAM_DESC, 'cli', text)
        term(PROGRAM_NAME, 1)
    finally:
        text = f'{_('kz version 4.2.1 (built {}).').format(build_id)}\n\n'
        text += f'{_("Written by Karel Zimmer <info@karelzimmer.nl>.")}\n'
        text += _('License CC0 1.0 ' +
                  '<https://creativecommons.org/publicdomain/zero/1.0>.')
        infomsg(PROGRAM_NAME, PROGRAM_DESC, 'cli', text)


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
    text = f'\
==== END logs for script {PROGRAM_NAME} ======================================'
    logmsg(PROGRAM_NAME, text)

    if rc == 0:
        sys.exit(0)
    else:
        sys.exit(1)
