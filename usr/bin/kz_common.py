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
# Imports
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
# Variables
###############################################################################

KZ_MODULE_NAME = 'kz_common.py'
KZ_MODULE_DESC = _('Common module for Python scripts')

KZ_USAGE = None
KZ_OPTIONS_USAGE = '[-h|--help] [-m|--manual] [-u|--usage] [-v|--version]'

KZ_HELP = None
KZ_OPTIONS_HELP = (f"{_('  -h, --help     show this help text')}\n"
                   f"{_('  -m, --manual   show manual page')}\n"
                   f"{_('  -u, --usage    show a short usage summary')}\n"
                   f"{_('  -v, --version  show program version')}")

KZ_OK = 0
KZ_ERROR = 1

KZ_RC = KZ_OK
KZ_TEXT = ''

KZ_BOLD = '\033[1m'
KZ_RED = '\033[1;31m'
KZ_GREEN = '\033[1;32m'
KZ_NORMAL = '\033[0m'

if subprocess.run('[[ -n $(type -t '
                  '{{cinnamon,gnome,lxqt,mate,xfce4}-session,ksmserver}) ]]',
                  shell=True, executable='bash').returncode == KZ_OK:
    KZ_DESKTOP_ENVIRONMENT = True
else:
    KZ_DESKTOP_ENVIRONMENT = False

if subprocess.run("[[ $(lsb_release --id --short) = 'Debian' ]]",
                  shell=True, executable='bash').returncode == KZ_OK:
    KZ_DEBIAN = True
else:
    KZ_DEBIAN = False

if subprocess.run("[[ $(lsb_release --id --short) = 'Ubuntu' ]]",
                  shell=True, executable='bash').returncode == KZ_OK:
    KZ_UBUNTU = True
else:
    KZ_UBUNTU = False

if subprocess.run('[[ -n $(type -t {dpkg,apt-get,apt}) ]]',
                  shell=True, executable='bash').returncode == KZ_OK:
    KZ_DEB = True
else:
    KZ_DEB = False

if subprocess.run('[[ -n $(type -t {rpm,yum,dnf}) ]]',
                  shell=True, executable='bash').returncode == KZ_OK:
    # Additional testing is needed because rpm may be installed on a system
    # that uses Debian package management system APT. APT is not available on a
    # system that uses Red Hat package management system KZ_RPM.
    if KZ_DEB:
        KZ_RPM = False
    else:
        KZ_RPM = True
else:
    KZ_RPM = False


###############################################################################
# Functions
###############################################################################

def become_root(KZ_PROGRAM_NAME):
    """
    This function checks whether the script is started as user root and
    restarts the script as user root if not.
    """
    L_EXEC_SUDO = 'sudo '

    if not become_root_check(KZ_PROGRAM_NAME):
        KZ_TEXT = ''
        term(KZ_PROGRAM_NAME, KZ_TEXT, KZ_OK)

    if os.getuid() != 0:
        # From "['path/script', 'arg1', ...]" to "'path/script' 'arg1' ...".
        for arg_num in range(len(sys.argv)):
            if arg_num == 0:
                L_EXEC_SUDO += str(sys.argv[arg_num])
            else:
                L_EXEC_SUDO += ' ' + str(sys.argv[arg_num])
        KZ_TEXT = f'Restart ({L_EXEC_SUDO})'
        logmsg(KZ_PROGRAM_NAME, KZ_TEXT)

        try:
            subprocess.run(L_EXEC_SUDO, shell=True, check=True)
        except KeyboardInterrupt:
            KZ_TEXT = _('Program {} has been interrupted.').\
                format(KZ_PROGRAM_NAME)
            term(KZ_PROGRAM_NAME, KZ_TEXT, KZ_ERROR)
        except Exception as exc:
            KZ_TEXT = str(exc)
            logmsg(KZ_PROGRAM_NAME, KZ_TEXT)
            KZ_TEXT = _('Program {} encountered an error.').\
                format(KZ_PROGRAM_NAME)
            term(KZ_PROGRAM_NAME, KZ_TEXT, KZ_ERROR)
        else:
            KZ_TEXT = ''
            term(KZ_PROGRAM_NAME, KZ_TEXT, KZ_OK)


def become_root_check(KZ_PROGRAM_NAME):
    """
    This function checks if the user is allowed to become root and returns 0 if
    so, otherwise returns 1 with descriptive message.
    """
    if os.getuid() == 0:
        return True
    try:
        subprocess.run('groups $USER | grep --quiet --regexp=sudo \
                       --regexp=wheel', shell=True, check=True)
    except Exception:
        KZ_TEXT = _('Already performed by the administrator.')
        infomsg(KZ_PROGRAM_NAME, KZ_TEXT)
        return False
    else:
        return True


def check_apt_package_manager(KZ_PROGRAM_NAME):
    """
    This function checks for another running APT package manager and waits for
    the next check if so.
    """
    L_CHECK_WAIT = 10

    if KZ_RPM:
        return KZ_OK

    while True:
        try:
            subprocess.run('sudo fuser '
                           '--silent '
                           '/var/cache/debconf/config.dat '
                           '/var/{lib/{dpkg,apt/lists},cache/apt/archives}/'
                           'lock*',
                           shell=True, executable='bash', check=True)
        except Exception:
            break
        else:
            KZ_TEXT = _('Wait for another package manager to finish') + '...'
            infomsg(KZ_PROGRAM_NAME, KZ_TEXT)
            time.sleep(L_CHECK_WAIT)


def errormsg(KZ_PROGRAM_NAME, KZ_TEXT):
    """
    This function returns an error message.
    """
    print(f'{KZ_RED}{KZ_TEXT}{KZ_NORMAL}')


def infomsg(KZ_PROGRAM_NAME, KZ_TEXT):
    """
    This function returns an informational message.
    """
    print(f'{KZ_TEXT}')


def init_script(KZ_PROGRAM_NAME, KZ_DISPLAY_NAME):
    """
    This function performs initial actions.
    """
    KZ_TEXT = f'==== START logs for script {KZ_PROGRAM_NAME} ===='
    logmsg(KZ_PROGRAM_NAME, KZ_TEXT)


def logmsg(KZ_PROGRAM_NAME, KZ_TEXT):
    """
    This function records a message to the log.
    """
    journal.sendv(f'SYSLOG_IDENTIFIER={KZ_PROGRAM_NAME}', f'MESSAGE={KZ_TEXT}')


def process_options(KZ_PROGRAM_NAME, KZ_PROGRAM_DESC, KZ_DISPLAY_NAME):
    """
    This function handles the common options.
    """
    L_PARSER = argparse.ArgumentParser(prog=KZ_DISPLAY_NAME, usage=KZ_USAGE,
                                       add_help=False)

    L_PARSER.add_argument('-h', '--help', action='store_true')
    L_PARSER.add_argument('-m', '--manual', action='store_true')
    L_PARSER.add_argument('-u', '--usage', action='store_true')
    L_PARSER.add_argument('-v', '--version', action='store_true')
    args = L_PARSER.parse_args()

    if args.help:
        process_option_help(KZ_PROGRAM_NAME, KZ_PROGRAM_DESC, KZ_DISPLAY_NAME)
        KZ_TEXT = ''
        term(KZ_PROGRAM_NAME, KZ_TEXT, KZ_OK)
    elif args.manual:
        process_option_manual(KZ_PROGRAM_NAME)
        KZ_TEXT = ''
        term(KZ_PROGRAM_NAME, KZ_TEXT, KZ_OK)
    elif args.usage:
        process_option_usage(KZ_PROGRAM_NAME, KZ_DISPLAY_NAME)
        KZ_TEXT = ''
        term(KZ_PROGRAM_NAME, KZ_TEXT, KZ_OK)
    elif args.version:
        process_option_version(KZ_PROGRAM_NAME)
        KZ_TEXT = ''
        term(KZ_PROGRAM_NAME, KZ_TEXT, KZ_OK)


def process_option_help(KZ_PROGRAM_NAME, KZ_PROGRAM_DESC, KZ_DISPLAY_NAME):
    """
    This function shows the available help.
    """
    L_YELP_MAN_URL = ''

    if KZ_DESKTOP_ENVIRONMENT:
        L_YELP_MAN_URL = f"{_(', or see the ')}"
        L_YELP_MAN_URL += f'\x1b]8;;man:{KZ_PROGRAM_NAME}(1)\x1b\\'
        L_YELP_MAN_URL += f'{KZ_DISPLAY_NAME}(1)'
        L_YELP_MAN_URL += f" {_('man page')}\x1b]8;;\x1b\\"
    KZ_TEXT = f'{KZ_HELP}\n\n'
    KZ_TEXT += _("Type '{} --manual' or 'man {}'{} for more information.").\
        format(KZ_DISPLAY_NAME, KZ_DISPLAY_NAME, L_YELP_MAN_URL)
    infomsg(KZ_PROGRAM_NAME, KZ_TEXT)


def process_option_manual(KZ_PROGRAM_NAME):
    """
    This function displays the manual page..
    """
    try:
        subprocess.run(f'man --pager=cat {KZ_PROGRAM_NAME}', shell=True,
                       check=True)
    except Exception as exc:
        KZ_TEXT = str(exc)
        logmsg(KZ_PROGRAM_NAME, KZ_TEXT)
        KZ_TEXT = _('Program {} encountered an error.').format(KZ_PROGRAM_NAME)
        term(KZ_PROGRAM_NAME, KZ_TEXT, KZ_ERROR)
    else:
        return KZ_OK


def process_option_usage(KZ_PROGRAM_NAME, KZ_DISPLAY_NAME):
    """
    This function shows the available options.
    """
    KZ_TEXT = (f"{_('KZ_USAGE:')} {KZ_USAGE}\n\n"
               f'''{_("Type '{} --help' for more information.").
                    format(KZ_DISPLAY_NAME)}''')
    infomsg(KZ_PROGRAM_NAME, KZ_TEXT)


def process_option_version(KZ_PROGRAM_NAME):
    """
    This function displays version, author, and license information.
    """
    L_BUILD_ID = ''

    try:
        with open('/usr/share/doc/kz/kz-build.id') as fh:
            L_BUILD_ID = f'{fh.read()}'
    except FileNotFoundError as fnf:
        KZ_TEXT = str(fnf)
        logmsg(KZ_PROGRAM_NAME, KZ_TEXT)
        KZ_TEXT = _('Build ID cannot be determined.')
        logmsg(KZ_PROGRAM_NAME, KZ_TEXT)
        build_id = KZ_TEXT
    except Exception as exc:
        KZ_TEXT = str(exc)
        logmsg(KZ_PROGRAM_NAME, KZ_TEXT)
        KZ_TEXT = _('Program {} encountered an error.').format(KZ_PROGRAM_NAME)
        term(KZ_PROGRAM_NAME, KZ_TEXT, KZ_ERROR)
    finally:
        KZ_TEXT = f"{_('kz version 4.2.1 ({}).').format(L_BUILD_ID)}\n\n"
        KZ_TEXT += f"{_('Written by Karel Zimmer <info@karelzimmer.nl>.')}\n"
        KZ_TEXT += _('License CC0 1.0 \
<https://creativecommons.org/publicdomain/zero/1.0>.')
        infomsg(KZ_PROGRAM_NAME, KZ_TEXT)


def term(KZ_PROGRAM_NAME, KZ_TEXT, KZ_RC):
    """
    This function controls the termination.
    """
    if KZ_RC == KZ_OK:
        if KZ_TEXT:
            infomsg(KZ_PROGRAM_NAME, KZ_TEXT)
    else:
        if KZ_TEXT:
            errormsg(KZ_PROGRAM_NAME, KZ_TEXT)
    KZ_TEXT = f'==== END logs for script {KZ_PROGRAM_NAME} ===='
    logmsg(KZ_PROGRAM_NAME, KZ_TEXT)

    if KZ_RC == KZ_OK:
        sys.exit(KZ_OK)
    else:
        sys.exit(KZ_ERROR)


def wait_for_enter(KZ_PROGRAM_NAME):
    """
    This function waits for the user to press Enter.
    """
    try:
        KZ_TEXT = f"\n{_('Press the Enter key to continue [Enter]: ')}\n"
        input(KZ_TEXT)
    except KeyboardInterrupt:
        KZ_TEXT = _('Program {} has been interrupted.').format(KZ_PROGRAM_NAME)
        term(KZ_PROGRAM_NAME, KZ_TEXT, KZ_ERROR)
    except Exception as exc:
        KZ_TEXT = str(exc)
        logmsg(KZ_PROGRAM_NAME, KZ_TEXT)
        KZ_TEXT = _('Program {} encountered an error.').format(KZ_PROGRAM_NAME)
        term(KZ_PROGRAM_NAME, KZ_TEXT, KZ_ERROR)
    else:
        return KZ_OK


###############################################################################
# Main
###############################################################################

if __name__ == '__main__':
    KZ_TEXT = _('{}: i am a module').format(KZ_MODULE_NAME)
    infomsg(KZ_MODULE_NAME, KZ_TEXT)
