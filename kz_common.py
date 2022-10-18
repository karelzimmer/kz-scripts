"""
Algemene module voor Python scripts.

Deze module geeft toegang tot algemene functies.
"""
###############################################################################
# Algemene module voor Python scripts.
#
# Geschreven in 2021 door Karel Zimmer <info@karelzimmer.nl>, Creative Commons
# Publiek Domein Verklaring <http://creativecommons.org/publicdomain/zero/1.0>.
###############################################################################

import argparse
import subprocess
import sys
import time


###############################################################################
# Common global constants
###############################################################################

module_name = 'kz_common.py'
module_desc = 'Algemene module voor Python scripts'

ok = 0
err = 1


###############################################################################
# Common global variables
###############################################################################


###############################################################################
# Functions
###############################################################################

def check_dpkgd_snapd():
    """
    Deze functie controleert op al een lopende Debian pakketbeheerder.
    """
    dpkg_wait = 5

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
                print(f'Wacht {dpkg_wait}s tot andere pakketbeheerder klaar '
                      'is...')
                time.sleep(dpkg_wait)
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
                print(f'Wacht {dpkg_wait}s tot andere pakketbeheerder klaar '
                      'is...')
                time.sleep(dpkg_wait)


def check_on_ac_power(program_name):
    """
    Deze functie controleert de stroomvoorziening.
    """
    if subprocess.run('on_ac_power', shell=True).returncode == 1:
        print('De computer gebruikt nu alleen de accu voor de '
              'stroomvoorziening.'
              '\nGeadviseerd wordt om de computer aan te sluiten op het '
              'stopcontact.')
        try:
            input('\nDruk op de Enter-toets om door te gaan [Enter]: ')
        except KeyboardInterrupt:
            sys.exit(err)


def check_user_sudo(program_name):
    """
    Deze functie controleert of de gebruiker sudo-rechten heeft.
    """
    try:
        subprocess.run('groups $USER | grep --quiet --regexp=sudo',
                       shell=True, check=True,
                       stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    except Exception:
        print(f'Reeds uitgevoerd door de beheerder.')
        sys.exit(ok)
    else:
        try:
            subprocess.run('sudo -n true', shell=True, check=True,
                           stdout=subprocess.DEVNULL,
                           stderr=subprocess.DEVNULL)
        except Exception:
            print(f"Authenticatie is vereist om {program_name} uit te voeren.")
            try:
                subprocess.run('sudo true', shell=True, check=True)
            except KeyboardInterrupt:
                sys.exit(err)
            except Exception as ex:
                print(ex)
                sys.exit(err)


def process_options(program_name, program_desc, display_name):
    """
    Deze functie verwerkt de algemene opties.
    """
    parser = argparse.ArgumentParser(prog=display_name,
                                     description=program_desc + '.',
                                     epilog="Typ 'man " + display_name +
                                     "' voor meer informatie.")
    parser.add_argument('-u', '--usage', action='store_true',
                        help='toon een korte gebruikssamenvatting')
    parser.add_argument('-v', '--version', action='store_true',
                        help='toon programmaversie')
    args = parser.parse_args()

    if args.usage:
        process_option_usage(display_name)
        sys.exit(ok)
    elif args.version:
        process_option_version(program_name)
        sys.exit(ok)


def process_option_usage(display_name):
    """
    Deze functie toont de beschikbare opties.
    """
    print(f"""Gebruik: {display_name} [-h|--help] [-u|--usage] [-v|--version]

Typ '{display_name} --help' voor meer informatie.""")


def process_option_version(program_name):
    """
    Deze functie toont informatie over de versie, auteur, en licentie.
    """
    try:
        with open('/usr/local/etc/kz-build-id') as fh:
            build = fh.read()
            year = build.partition('-')[0]
    except FileNotFoundError:
        build = 'unknown'
        year = 1970
    except Exception as ex:
        print(ex)
        sys.exit(err)
    finally:
        print(f"""{program_name} (kz) 365 ({build})

Geschreven in {year} door Karel Zimmer <info@karelzimmer.nl>, Creative Commons
Publiek Domein Verklaring <http://creativecommons.org/publicdomain/zero/1.0>.\
""")


###############################################################################
# Main
###############################################################################

if __name__ == '__main__':
    print(f'{module_name}: ik ben een module')
