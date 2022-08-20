"""
Algemene module voor Python scripts.

Deze module geeft toegang tot algemene functies.
"""
###############################################################################
# Algemene module voor Python scripts.
#
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.
###############################################################################

import argparse
import datetime
import subprocess
import sys
import time


###############################################################################
# Common global constants
###############################################################################

module_name = 'kz_common.py'
release_year = 2021


###############################################################################
# Common global variables
###############################################################################

###############################################################################
# Functions
###############################################################################

def check_dpkg():
    """
    Deze functie controleert op al een lopende Debian pakketbeheerder.
    """
    dpkg_wait = 5
    snaps = True

    try:
        subprocess.run('ls /snap/core/*/var/cache/debconf/config.dat',
                       shell=True, check=True, stdout=subprocess.DEVNULL,
                       stderr=subprocess.DEVNULL)
    except Exception:
        snaps = False

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
                print(f'Wacht {dpkg_wait}s tot andere pakketbeheerder klaar '
                      'is...')
                time.sleep(dpkg_wait)
            except Exception:
                break
        else:
            try:
                subprocess.run('sudo fuser /var/cache/apt/archives/lock '
                               '/var/lib/apt/lists/lock  /var/lib/dpkg/lock '
                               '/var/cache/debconf/config.dat',
                               shell=True, check=True,
                               stdout=subprocess.DEVNULL,
                               stderr=subprocess.DEVNULL)
                print(f'Wacht {dpkg_wait}s tot andere pakketbeheerder klaar '
                      'is...')
                time.sleep(dpkg_wait)
            except Exception:
                break


def process_common_options(desc, display_name):
    """
    Deze functie verwerkt de algemene opties.
    """
    parser = argparse.ArgumentParser(prog=display_name,
                                     description=desc,
                                     epilog="Typ 'man " + display_name +
                                     "' voor meer informatie.")
    parser.add_argument('-u', '--usage', action='store_true',
                        help='toon een korte gebruikssamenvatting')
    parser.add_argument('-v', '--version', action='store_true',
                        help='toon programmaversie')
    args = parser.parse_args()

    if args.usage:
        process_option_usage(display_name)
        sys.exit(0)
    elif args.version:
        process_option_version(display_name, release_year)
        sys.exit(0)


def process_option_usage(display_name):
    """
    Deze functie toont de beschikbare opties.
    """
    print(f"""Gebruik: {display_name} [-h|--help] [-u|--usage] [-v|--version]

Typ '{display_name} --help' voor meer informatie.""")


def process_option_version(display_name, release_year):
    """
    Deze functie toont versie-informatie, auteur, en auteursrecht.
    """
    build = ''
    copyright_years = '1970'
    now = datetime.datetime.now()
    this_year = now.year

    try:
        with open('/usr/local/etc/kz-build') as fh:
            build = fh.read()
    except FileNotFoundError:
        build = 'unknown'
    except OSError as ex:
        print(ex)

    if release_year == this_year:
        copyright_years = release_year
    else:
        copyright_years = str(release_year) + '-' + str(this_year)

    print(f"""{display_name} versie 365 (kz build {build})

Geschreven door Karel Zimmer <info@karelzimmer.nl>.

Auteursrecht © {copyright_years} Karel Zimmer.
GNU Algemene Publieke Licentie <https://www.gnu.org/licenses/gpl.html>.""")


###############################################################################
# Main
###############################################################################

if __name__ == '__main__':
    print(f'{module_name}: ik ben een module')
