# #############################################################################
# SPDX-FileComment: Common module for kz Python scripts.
#
# SPDX-FileCopyrightText: Karel Zimmer <info@karelzimmer.nl>
# SPDX-License-Identifier: CC0-1.0
# #############################################################################


# #############################################################################
# Imports
# #############################################################################

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
BLUE: str = '\033[1;34m'
GREEN: str = '\033[1;32m'
RED: str = '\033[1;31m'
NORMAL: str = '\033[0m'


# #############################################################################
# Functions
# #############################################################################

def errmsg(PROGRAM_NAME: str, PROGRAM_DESC: str, UI_MODE: str,
           TEXT: str) -> None:
    """
    This function returns an error message.
    """
    logmsg(PROGRAM_NAME, f'{RED}{TEXT}{NORMAL}')
    if UI_MODE == 'gui':
        zenity: str = f'zenity      --error                         \
                                    --no-markup                     \
                                    --width     600                 \
                                    --height    100                 \
                                    --title     "{PROGRAM_DESC}"    \
                                    --text      "{TEXT}"            || true'
        try:
            subprocess.run(zenity, executable='bash', shell=True,
                           stderr=subprocess.DEVNULL)
        except KeyboardInterrupt:
            text = _('Program {} has been interrupted.').format(PROGRAM_NAME)
            errmsg(PROGRAM_NAME, PROGRAM_DESC, UI_MODE, text)
            term(PROGRAM_NAME, 130)
        except Exception as exc:
            text = str(exc)
            logmsg(PROGRAM_NAME, text)
            text = _('Program {} encountered an error.').format(PROGRAM_NAME)
            errmsg(PROGRAM_NAME, PROGRAM_DESC, UI_MODE, text)
            term(PROGRAM_NAME, 1)
    elif UI_MODE == 'tui':
        dialog: str = f'dialog  --mouse                             \
                                --colors                            \
                                --backtitle "{PROGRAM_NAME}"        \
                                --title     "{PROGRAM_DESC}"        \
                                --msgbox    "\\Zb\\Z1{TEXT}\\Zn"    \
                                0 0                                 || true'
        try:
            subprocess.run(dialog, executable='bash', shell=True,
                           stderr=subprocess.DEVNULL)
        except KeyboardInterrupt:
            text = _('Program {} has been interrupted.').format(PROGRAM_NAME)
            errmsg(PROGRAM_NAME, PROGRAM_DESC, UI_MODE, text)
            term(PROGRAM_NAME, 130)
        except Exception as exc:
            text = str(exc)
            logmsg(PROGRAM_NAME, text)
            text = _('Program {} encountered an error.').format(PROGRAM_NAME)
            errmsg(PROGRAM_NAME, PROGRAM_DESC, UI_MODE, text)
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
                                    --no-markup                     \
                                    --width     600                 \
                                    --height    100                 \
                                    --title     "{PROGRAM_DESC}"    \
                                    --text      "{TEXT}"            || true'
        try:
            subprocess.run(zenity, executable='bash', shell=True,
                           stderr=subprocess.DEVNULL)
        except KeyboardInterrupt:
            text = _('Program {} has been interrupted.').format(PROGRAM_NAME)
            errmsg(PROGRAM_NAME, PROGRAM_DESC, UI_MODE, text)
            term(PROGRAM_NAME, 130)
        except Exception as exc:
            text = str(exc)
            logmsg(PROGRAM_NAME, text)
            text = _('Program {} encountered an error.').format(PROGRAM_NAME)
            errmsg(PROGRAM_NAME, PROGRAM_DESC, UI_MODE, text)
            term(PROGRAM_NAME, 1)
    elif UI_MODE == 'tui':
        dialog: str = f'dialog  --mouse                         \
                                --backtitle "{PROGRAM_NAME}"    \
                                --title     "{PROGRAM_DESC}"    \
                                --msgbox    "{TEXT}"            \
                                0 0                             || true'
        try:
            subprocess.run(dialog, executable='bash', shell=True,
                           stderr=subprocess.DEVNULL)
        except KeyboardInterrupt:
            text = _('Program {} has been interrupted.').format(PROGRAM_NAME)
            errmsg(PROGRAM_NAME, PROGRAM_DESC, UI_MODE, text)
            term(PROGRAM_NAME, 130)
        except Exception as exc:
            text = str(exc)
            logmsg(PROGRAM_NAME, text)
            text = _('Program {} encountered an error.').format(PROGRAM_NAME)
            errmsg(PROGRAM_NAME, PROGRAM_DESC, UI_MODE, text)
            term(PROGRAM_NAME, 1)
    else:
        print(TEXT)


def init(PROGRAM_NAME: str) -> None:
    """
    This function performs initial actions.
    """
    bold: str = '\033[1m'
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

    text = f'{bold}START logging for script {PROGRAM_NAME}{NORMAL}'
    logmsg(PROGRAM_NAME, text)
    text = f"Started ({' '.join(sys.argv)} as {os.getlogin()})."
    logmsg(PROGRAM_NAME, text)


def logmsg(PROGRAM_NAME: str, TEXT: str) -> None:
    """
    This function records a message to the log.
    """
    grey: str = '\033[90m'
    message: str = ''
    payload: bytes
    sock: socket.socket

    # This also works fine...
    # from systemd import journal  # type: ignore
    # journal.sendv(f'SYSLOG_IDENTIFIER={PROGRAM_NAME}', f'MESSAGE={TEXT}')
    # ...but not on older distributions, e.g. Rocky Linux 8.

    # Replace all Newlines (\n) with NL, all Carriage Returns (\r) with CR, and
    # all Tabs (\t) with TAB
    message = TEXT.replace('\n', 'NL').replace('\r', 'CR').replace('\t', 'TAB')

    # Build the structured journal data package (field radius separated by \n).
    payload = (
        f"SYSLOG_IDENTIFIER={PROGRAM_NAME}\n"
        f"MESSAGE={grey}{message}{NORMAL}\n"
        ).encode('utf-8')
    print(f"[{PROGRAM_NAME}] {payload}") # DEBUG

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


def process_option_manual(PROGRAM_NAME: str, PROGRAM_DESC: str,
                          UI_MODE: str = 'cli') -> None:
    """
    This function displays the manual page.
    """
    exc: BaseException
    man_cli: str = f'man {PROGRAM_NAME}'
    man_gui: str = f'yelp man:{PROGRAM_NAME}'
    man_tui: str = f'man --html {PROGRAM_NAME}'
    text: str = ''

    if UI_MODE == 'gui':
        try:
            subprocess.run(man_gui, executable='bash',
                           stderr=subprocess.DEVNULL,
                           shell=True, check=True,)
        except KeyboardInterrupt:
            text = _('Program {} has been interrupted.').format(PROGRAM_NAME)
            errmsg(PROGRAM_NAME, PROGRAM_DESC, UI_MODE, text)
            term(PROGRAM_NAME, 130)
        except subprocess.CalledProcessError as exc:
            text = str(exc)
            logmsg(PROGRAM_NAME, text)
            text = _('Program {} encountered an error.').format(PROGRAM_NAME)
            errmsg(PROGRAM_NAME, PROGRAM_DESC, UI_MODE, text)
            term(PROGRAM_NAME, exc.returncode)
    elif UI_MODE == 'tui':
        try:
            subprocess.run(man_tui, executable='bash', shell=True,
                           check=True)
        except KeyboardInterrupt:
            text = _('Program {} has been interrupted.').format(PROGRAM_NAME)
            errmsg(PROGRAM_NAME, PROGRAM_DESC, UI_MODE, text)
            term(PROGRAM_NAME, 130)
        except subprocess.CalledProcessError as exc:
            text = str(exc)
            logmsg(PROGRAM_NAME, text)
            text = _('Program {} encountered an error.').format(PROGRAM_NAME)
            errmsg(PROGRAM_NAME, PROGRAM_DESC, UI_MODE, text)
            term(PROGRAM_NAME, exc.returncode)
    else:
        try:
            subprocess.run(man_cli, executable='bash', shell=True, check=True)
        except KeyboardInterrupt:
            text = _('Program {} has been interrupted.').format(PROGRAM_NAME)
            errmsg(PROGRAM_NAME, PROGRAM_DESC, UI_MODE, text)
            term(PROGRAM_NAME, 130)
        except subprocess.CalledProcessError as exc:
            text = str(exc)
            logmsg(PROGRAM_NAME, text)
            text = _('Program {} encountered an error.').format(PROGRAM_NAME)
            errmsg(PROGRAM_NAME, PROGRAM_DESC, UI_MODE, text)
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


def term(PROGRAM_NAME: str, rc: int, UI_MODE: str = 'cli') -> None:
    """
    This function controls the termination.
    """
    bold: str = '\033[1m'
    status: str = '1/FAILURE'
    text: str = ''

    if UI_MODE == 'tui':
        subprocess.run('reset', executable='bash', shell=True)
        subprocess.run('clear -x', executable='bash', shell=True)

    if rc == 0:
        status = '0/SUCCESS'

    text = f'Ended (code=exited, status={status}).'
    logmsg(PROGRAM_NAME, text)
    text = f'{bold}END logging for script {PROGRAM_NAME}{NORMAL}'
    logmsg(PROGRAM_NAME, text)

    if rc == 0:
        sys.exit(0)
    else:
        sys.exit(1)
