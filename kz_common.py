"""
Algemene module voor Python scripts.

Deze module geeft toegang tot algemene functies.
"""
###############################################################################
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.
#
# Auteursrecht (c) 2021 Karel Zimmer.
# GNU Algemene Publieke Licentie <https://www.gnu.org/licenses/gpl.html>.
#
# ReleaseNumber: 02.00.00
# DateOfRelease: 2021-08-08
###############################################################################
module_name = 'kz_common.py'


def process_option_version(program_name):
    """
    Deze functie zoekt versie-informatie in <program_name>,
    en toont deze info samen met auteur en auteursrecht.
    """
    release_number = release_date = copyright_years = None

    # Find release_number, release_date, and copyright_years in filename.
    try:
        with open(__file__.replace(module_name, program_name)) as fh:
            for line in fh:
                if 'Auteursrecht (c) ' in line and copyright_years is None:
                    data = line.split()
                    copyright_years = data[3]
                if '# ReleaseNumber:' in line and release_number is None:
                    data = line.split(': ')
                    # e.g. data = ['# RelNum', '01.00.00\n'], remove \n.
                    release_number = data[1].rstrip('\n')
                if '# DateOfRelease:' in line and release_date is None:
                    data = line.split(': ')
                    # e.g. data = ['# RelDat', '1970-01-01\n'], remove \n.
                    release_date = data[1].rstrip('\n')
                if (release_number is not None
                        and release_date is not None
                        and copyright_years is not None):
                    break
    except Exception as ex:
        print(ex)
        return 1

    print(f"""{program_name} {release_number} ({release_date})

Geschreven door Karel Zimmer <info@karelzimmer.nl>.

Auteursrecht (c) {copyright_years} Karel Zimmer.
GNU Algemene Publieke Licentie <https://www.gnu.org/licenses/gpl.html>.""")


if __name__ == '__main__':
    print(f'{module_name}: ik ben een module')

# EOF
