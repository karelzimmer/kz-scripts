#!/bin/bash
# RELEASE_YEAR=2017
# VERSION_NUMBER=002

TITLE='VirtualBox'
TEXT='Virtuele Machine hugowin732 wordt gestart (kan even duren...)'

start_vm() {
     while ! lsmod | grep vbox; do
         sleep 5
     done
    VBoxManage startvm "hugowin732"
}

start_vm |
zenity  --progress              \
        --pulsate               \
        --auto-close            \
        --no-cancel             \
        --width     450         \
        --height    50          \
        --title     "$TITLE"    \
        --text      "$TEXT"

# EOF
