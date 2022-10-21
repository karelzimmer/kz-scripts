#!/bin/bash
###############################################################################
# Start VM hugowin732.
#
# Geschreven in 2020 door Karel Zimmer <info@karelzimmer.nl>, Creative Commons
# Publiek Domein Verklaring <http://creativecommons.org/publicdomain/zero/1.0>.
###############################################################################

readonly TEXT='Virtuele Machine hugowin732 wordt gestart (kan even duren...)'
readonly TITLE='VirtualBox'

function start_vm {
     while ! lsmod | grep --quiet --regexp='vbox'; do
         sleep 5
     done
    VBoxManage startvm 'hugowin732'
}

start_vm                        |
zenity  --progress              \
        --pulsate               \
        --auto-close            \
        --no-cancel             \
        --width     450         \
        --height    50          \
        --title     "$TITLE"    \
        --text      "$TEXT"
