"""
Algemene module voor Python scripts.

Deze module geeft toegang tot algemene functies.
"""
###############################################################################
# Algemene module voor Python scripts.
#
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.
###############################################################################
import datetime

module_name = 'kz_common.py'
release_year = 2021

version_number = '02.01.00'
version_date = '2021-08-22'


def process_option_usage(display_name):
    print(f"""Gebruik: {display_name} [-g|--gui] [-h|--help] [-u|--usage] \
[-v|--version]

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
