"""
Algemene module voor Python scripts.

Deze module geeft toegang tot algemene functies.
"""
###############################################################################
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.
###############################################################################
import datetime

module_name = 'kz_common.py'
first_released = 2021

version_number = '02.01.00'
version_date = '2021-08-22'


def process_option_usage(display_name):
    print(f"""Gebruik: {display_name} [-g|--gui] [-h|--help] [-u|--usage] \
[-v|--version]

Typ '{display_name} --help' voor meer informatie.""")


def process_option_version(display_name, version_number, version_date,
                           first_released):
    """
    Deze functie toont versie-informatie, auteur, en auteursrecht.
    """
    now = datetime.datetime.now()
    this_year = now.year
    copyright_years = 1970

    if first_released == this_year:
        copyright_years = first_released
    else:
        copyright_years = str(first_released) + '-' + str(this_year)
    print(f"""{display_name} {version_number} ({version_date})

Geschreven door Karel Zimmer <info@karelzimmer.nl>.

Auteursrecht (c) {copyright_years} Karel Zimmer.
GNU Algemene Publieke Licentie <https://www.gnu.org/licenses/gpl.html>.""")


if __name__ == '__main__':
    print(f'{module_name}: ik ben een module')

# EOF
