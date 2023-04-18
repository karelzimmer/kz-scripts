#!/bin/bash
# shellcheck shell=bash
###############################################################################
# Start VM hugowin732.
#
# Written in 2020 by Karel Zimmer <info@karelzimmer.nl>, Creative Commons
# Public Domain Dedication <https://creativecommons.org/publicdomain/zero/1.0>.
###############################################################################

text=$(gettext 'Virtual Machine Hugowin732 is started (can take a while ...)')
title='VirtualBox'

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
        --title     "$title"    \
        --text      "$text"
