# shellcheck shell=bash
###############################################################################
# Instellingsbestand voor Ubuntu 20.04 LTS desktop op pc01.
#
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.
###############################################################################
# RELEASE_YEAR=2020

# VERSION_NUMBER=04.00.01
# VERSION_DATE=2021-08-22


#1
#2 Gedit instellen
if [[ $HOSTNAME = pc01 && $USER = karel ]]; then gsettings set org.gnome.gedit.plugins active-plugins "['sort','spell','smartspaces','changecase','zeitgeistplugin','filebrowser','docinfo','time','codecomment','modelines']"; fi
if [[ $HOSTNAME = pc01 && $USER = karel ]]; then gsettings set org.gnome.gedit.preferences.editor auto-indent false; fi
if [[ $HOSTNAME = pc01 && $USER = karel ]]; then gsettings set org.gnome.gedit.preferences.editor bracket-matching true; fi
if [[ $HOSTNAME = pc01 && $USER = karel ]]; then gsettings set org.gnome.gedit.preferences.editor display-line-numbers true; fi
if [[ $HOSTNAME = pc01 && $USER = karel ]]; then gsettings set org.gnome.gedit.preferences.editor display-right-margin true; fi
if [[ $HOSTNAME = pc01 && $USER = karel ]]; then gsettings set org.gnome.gedit.preferences.editor highlight-current-line true; fi
if [[ $HOSTNAME = pc01 && $USER = karel ]]; then gsettings set org.gnome.gedit.preferences.editor insert-spaces true; fi
if [[ $HOSTNAME = pc01 && $USER = karel ]]; then gsettings set org.gnome.gedit.preferences.editor right-margin-position 79; fi
if [[ $HOSTNAME = pc01 && $USER = karel ]]; then gsettings set org.gnome.gedit.preferences.editor tabs-size 4; fi
if [[ $HOSTNAME = pc01 && $USER = karel ]]; then gsettings set org.gnome.gedit.preferences.editor wrap-last-split-mode 'char'; fi
if [[ $HOSTNAME = pc01 && $USER = karel ]]; then gsettings set org.gnome.gedit.preferences.editor wrap-mode 'char'; fi
if [[ $HOSTNAME = pc01 && $USER = karel ]]; then gsettings set org.gnome.gedit.preferences.print print-header true; fi
if [[ $HOSTNAME = pc01 && $USER = karel ]]; then gsettings set org.gnome.gedit.preferences.print print-line-numbers 1; fi
if [[ $HOSTNAME = pc01 && $USER = karel ]]; then gsettings set org.gnome.gedit.preferences.print print-syntax-highlighting true; fi
if [[ $HOSTNAME = pc01 && $USER = karel ]]; then gsettings set org.gnome.gedit.preferences.print print-wrap-mode 'char'; fi
if [[ $HOSTNAME = pc01 && $USER = karel ]]; then kz_gset --addfavtop --file='org.gnome.gedit.desktop'; fi
#4 Start Terminalvenster en voer uit:
#4    gsettings reset org.gnome.gedit.plugins active-plugins
#4    gsettings reset org.gnome.gedit.preferences.editor auto-indent
#4    gsettings reset org.gnome.gedit.preferences.editor bracket-matching
#4    gsettings reset org.gnome.gedit.preferences.editor display-line-numbers
#4    gsettings reset org.gnome.gedit.preferences.editor display-right-margin
#4    gsettings reset org.gnome.gedit.preferences.editor highlight-current-line
#4    gsettings reset org.gnome.gedit.preferences.editor insert-spaces
#4    gsettings reset org.gnome.gedit.preferences.editor right-margin-position
#4    gsettings reset org.gnome.gedit.preferences.editor tabs-size
#4    gsettings reset org.gnome.gedit.preferences.editor wrap-last-split-mode
#4    gsettings reset org.gnome.gedit.preferences.editor wrap-mode
#4    gsettings reset org.gnome.gedit.preferences.print print-header
#4    gsettings reset org.gnome.gedit.preferences.print print-line-numbers
#4    gsettings reset org.gnome.gedit.preferences.print print-syntax-highlighting
#4    gsettings reset org.gnome.gedit.preferences.print print-wrap-mode
#4    kz_gset --removefav --file='org.gnome.gedit.desktop'


#1
#2 GNOME Gmail instellen
if [[ $HOSTNAME = pc01 && $USER = monique ]]; then kz_gset --addfavtop --file='gnome-gmail.desktop'; fi
#4 Start Terminalvenster en voer uit:
#4    kz_gset --removefav --file='gnome-gmail.desktop'


#1
#2 GNOME instellen
## Voor een beschrijving voer uit: gsettings describe SCHEMA KEY
if [[ $HOSTNAME = pc01 && $USER = karel ]]; then gsettings set org.gnome.desktop.background picture-uri 'file:///usr/share/backgrounds/kz_gnome.png'; fi
if [[ $HOSTNAME = pc01 && $USER = monique ]]; then gsettings set org.gnome.desktop.background picture-uri 'file:///usr/share/backgrounds/kz_olifanten.jpg'; fi
#4 Start Terminalvenster en voer uit:
#4    gsettings reset org.gnome.desktop.background picture-uri


#1
#2 Google Chrome instellen
if [[ $HOSTNAME = pc01 && ($USER = karel || $USER = monique) ]]; then kz_gset --removefav --file='firefox.desktop'; fi
#3 1. Start Standaardtoepassingen.
#3 2. Kies bij E-mail voor Gnome Gmail.


#1
#2 Python instellen
if [[ $HOSTNAME = pc01 && $USER = karel ]]; then kz_gset --addfavtop --file='idle.desktop'; fi
#4 Start Terminalvenster en voer uit:
#4    kz_gset --removefav --file='idle.desktop'


#1
#2 GNOME Terminal instellen
if [[ $HOSTNAME = pc01 && $USER = karel ]]; then kz_gset --addfavtop --file='org.gnome.Terminal.desktop'; fi
#4 Start Terminalvenster en voer uit:
#4    kz_gset --removefav --file='org.gnome.Terminal.desktop'


#1
#2 Vooruit zoeken in history instellen
if [[ $HOSTNAME = pc01 && $USER = karel ]]; then sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc; fi
if [[ $HOSTNAME = pc01 && $USER = karel ]]; then echo 'stty -ixon  # Enable fwd search history (i-search)' >> "$HOME"/.bashrc; fi
#4 Start Terminalvenster en voer uit:
#4    sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc


#1
#2 Zga eHRM instellen
if [[ $HOSTNAME = pc01 && $USER = monique ]]; then cp /usr/share/applications/kz_zga_ehrm.desktop "$HOME"/.local/share/applications/; fi
if [[ $HOSTNAME = pc01 && $USER = monique ]]; then sed --in-place --expression='s/NoDisplay=true/NoDisplay=false/' "$HOME"/.local/share/applications/kz_zga_ehrm.desktop; fi
if [[ $HOSTNAME = pc01 && $USER = monique ]]; then kz_gset --addfavtop --file='kz_zga_ehrm.desktop'; fi
#4 Start Terminalvenster en voer uit:
#4    rm "$HOME"/.local/share/applications/kz_zga_ehrm.desktop
#4    kz_gset --removefav --file='kz_zga_ehrm.desktop'


#1
#2 Zga Intranet instellen
if [[ $HOSTNAME = pc01 && $USER = monique ]]; then cp /usr/share/applications/kz_zga_intranet.desktop "$HOME"/.local/share/applications/; fi
if [[ $HOSTNAME = pc01 && $USER = monique ]]; then sed --in-place --expression='s/NoDisplay=true/NoDisplay=false/' "$HOME"/.local/share/applications/kz_zga_intranet.desktop; fi
if [[ $HOSTNAME = pc01 && $USER = monique ]]; then kz_gset --addfavtop --file='kz_zga_intranet.desktop'; fi
#4 Start Terminalvenster en voer uit:
#4    rm "$HOME"/.local/share/applications/kz_zga_intranet.desktop
#4    kz_gset --removefav --file='kz_zga_intranet.desktop'


#1
#2 Zga Monaco instellen
if [[ $HOSTNAME = pc01 && $USER = monique ]]; then cp /usr/share/applications/kz_zga_monaco.desktop "$HOME"/.local/share/applications/; fi
if [[ $HOSTNAME = pc01 && $USER = monique ]]; then sed --in-place --expression='s/NoDisplay=true/NoDisplay=false/' "$HOME"/.local/share/applications/kz_zga_monaco.desktop; fi
if [[ $HOSTNAME = pc01 && $USER = monique ]]; then kz_gset --addfavtop --file='kz_zga_monaco.desktop'; fi
#4 Start Terminalvenster en voer uit:
#4    rm "$HOME"/.local/share/applications/kz_zga_monaco.desktop
#4    kz_gset --removefav --file='kz_zga_monaco.desktop'


#1
#2 Zga WebMail instellen
if [[ $HOSTNAME = pc01 && $USER = monique ]]; then cp /usr/share/applications/kz_zga_webmail.desktop "$HOME"/.local/share/applications/; fi
if [[ $HOSTNAME = pc01 && $USER = monique ]]; then sed --in-place --expression='s/NoDisplay=true/NoDisplay=false/' "$HOME"/.local/share/applications/kz_zga_webmail.desktop; fi
if [[ $HOSTNAME = pc01 && $USER = monique ]]; then kz_gset --addfavtop --file='kz_zga_webmail.desktop'; fi
#4 Start Terminalvenster en voer uit:
#4    rm "$HOME"/.local/share/applications/kz_zga_webmail.desktop
#4    kz_gset --removefav --file='kz_zga_webmail.desktop'


# EOF
