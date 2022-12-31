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
import os
import subprocess
import sys
import time


###############################################################################
# Constants
###############################################################################

module_name = 'kz_common.py'
module_desc = 'Algemene module voor Python scripts'
module_path = f"{os.path.realpath(os.path.dirname(__file__))}"

ok = 0
err = 1


###############################################################################
# Variables
###############################################################################


###############################################################################
# Functions
###############################################################################

def check_dpkgd_snapd():
    """
    Deze functie controleert op al een lopende Debian pakketbeheerder.
    """
    dpkg_wait = 10

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
            print(f"\nProgramma {program_name} is afgebroken.")
            sys.exit(err)


def check_user_root(display_name):
    """
    Deze functie controleert of de gebruiker root is.
    """
    if check_user_sudo() != ok:
        print(f'Reeds uitgevoerd door de beheerder.')
        sys.exit(ok)
    else:
        try:
            subprocess.run('sudo -n true', shell=True, check=True,
                           stdout=subprocess.DEVNULL,
                           stderr=subprocess.DEVNULL)
        except Exception:
            print(f'Authenticatie is vereist om {display_name} uit te voeren.')
            try:
                subprocess.run('sudo true', shell=True, check=True)
            except KeyboardInterrupt:
                print(f"\nProgramma {display_name} is afgebroken.")
                sys.exit(err)
            except Exception as ex:
                print(ex)
                sys.exit(err)


def check_user_sudo():
    """
    Deze functie controleert of de gebruiker sudo mag gebruiken.
    """
    if os.getuid() == 0:
        return(ok)
    try:
        subprocess.run('groups $USER | grep --quiet --regexp=sudo',
                       shell=True, check=True,
                       stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    except Exception:
        return(err)
    else:
        return(ok)


def process_options(program_name, program_desc, display_name):
    """
    Deze functie verwerkt de algemene opties.
    """
    parser = argparse.ArgumentParser(prog=display_name, add_help=False)
    parser.add_argument('-h', '--help', action='store_true')
    parser.add_argument('-u', '--usage', action='store_true')
    parser.add_argument('-v', '--version', action='store_true')
    args = parser.parse_args()

    if args.help:
        process_option_help(display_name, program_desc)
        sys.exit(ok)
    elif args.usage:
        process_option_usage(display_name)
        sys.exit(ok)
    elif args.version:
        process_option_version(program_name)
        sys.exit(ok)

def process_option_help(display_name, program_desc):
    """
    Deze functie toont de beschikbare hulp.
    """
    print(f"""Gebruik: {display_name} [OPTIE...]

{program_desc}.

Opties:
  -h, --help     toon deze hulptekst
  -u, --usage    toon een korte gebruikssamenvatting
  -v, --version  toon de programmaversie

Typ 'man {display_name}' voor meer informatie.""")


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
    build_id = '1970-01-01'
    cmd = ''
    program_year = 1970

    try:
        with open('/usr/local/etc/kz-build-id') as fh:
            build_id = fh.read()
    except FileNotFoundError:
        build_id = '1970-01-01'
    except Exception as ex:
        print(ex)
        sys.exit(err)
    finally:
        cmd = f"grep '# Geschreven in ' {module_path}/{program_name}"
        cmd = f"{cmd} | cut --delimiter=' ' --fields=4"
        program_year = subprocess.check_output(cmd, shell=True,
                                               stderr=subprocess.DEVNULL)
        program_year = program_year.decode('utf-8').strip()
        if program_year == '':
            program_year = 1970
        print(f"""{program_name} (kz) 365 ({build_id})

Geschreven in {program_year} door Karel Zimmer <info@karelzimmer.nl>, \
Creative Commons
Publiek Domein Verklaring \
<http://creativecommons.org/publicdomain/zero/1.0>.""")


###############################################################################
# Main
###############################################################################

if __name__ == '__main__':
    print(f'{module_name}: ik ben een module')
