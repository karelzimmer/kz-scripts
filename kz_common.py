"""
Algemene module voor Python scripts.

Deze module geeft toegang tot algemene functies.
"""
###############################################################################
# Algemene module voor Python scripts.
#
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.
###############################################################################
import sys
import argparse
import datetime

module_name = 'kz_common.py'
release_year = 2021

version_number = '02.02.03'
version_date = '2021-10-04'


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
        process_option_version(display_name, version_number,
                               version_date, release_year)
        sys.exit(0)


def process_option_usage(display_name):
    """
    Deze functie toont de beschikbare opties.
    """
    print(f"""Gebruik: {display_name} [-u|--usage] [-h|--help] [-v|--version]

Typ '{display_name} --help' voor meer informatie.""")


def process_option_version(display_name, version_number, version_date,
                           release_year):
    """
    Deze functie toont versie-informatie, auteur, en auteursrecht.
    """
    now = datetime.datetime.now()
    this_year = now.year
    copyright_years = 1970

    if release_year == this_year:
        copyright_years = release_year
    else:
        copyright_years = str(release_year) + '-' + str(this_year)
    print(f"""{display_name} {version_number} ({version_date})

Geschreven door Karel Zimmer <info@karelzimmer.nl>.

Auteursrecht (c) {copyright_years} Karel Zimmer.
GNU Algemene Publieke Licentie <https://www.gnu.org/licenses/gpl.html>.""")


if __name__ == '__main__':
    print(f'{module_name}: ik ben een module')

# EOF
