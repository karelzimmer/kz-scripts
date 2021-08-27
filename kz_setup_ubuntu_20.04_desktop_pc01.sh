# shellcheck shell=bash
###############################################################################
# Instellingsbestand voor Ubuntu 20.04 LTS desktop op pc01.
#
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.
###############################################################################
# RELEASE_YEAR=2020

# VERSION_NUMBER=04.00.02
# VERSION_DATE=2021-08-27


#1 gedit
#2 Gedit instellen
gsettings set org.gnome.gedit.plugins active-plugins "['sort','spell','smartspaces','changecase','zeitgeistplugin','filebrowser','docinfo','time','codecomment','modelines']"
gsettings set org.gnome.gedit.preferences.editor auto-indent false
gsettings set org.gnome.gedit.preferences.editor bracket-matching true
gsettings set org.gnome.gedit.preferences.editor display-line-numbers true
gsettings set org.gnome.gedit.preferences.editor display-right-margin true
gsettings set org.gnome.gedit.preferences.editor highlight-current-line true
gsettings set org.gnome.gedit.preferences.editor insert-spaces true
gsettings set org.gnome.gedit.preferences.editor right-margin-position 79
gsettings set org.gnome.gedit.preferences.editor tabs-size 4
gsettings set org.gnome.gedit.preferences.editor wrap-last-split-mode 'char'
gsettings set org.gnome.gedit.preferences.editor wrap-mode 'char'
gsettings set org.gnome.gedit.preferences.print print-header true
gsettings set org.gnome.gedit.preferences.print print-line-numbers 1
gsettings set org.gnome.gedit.preferences.print print-syntax-highlighting true
gsettings set org.gnome.gedit.preferences.print print-wrap-mode 'char'
kz_gset --addfavtop --file='org.gnome.gedit.desktop'
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


#1 gnome
#2 GNOME instellen
## Voor een beschrijving voer uit: gsettings describe SCHEMA KEY
if [[ $USER = karel ]]; then gsettings set org.gnome.desktop.background picture-uri 'file:///usr/share/backgrounds/kz_gnome.png'; fi
if [[ $USER = monique ]]; then gsettings set org.gnome.desktop.background picture-uri 'file:///usr/share/backgrounds/kz_olifanten.jpg'; fi
#4 Start Terminalvenster en voer uit:
#4    gsettings reset org.gnome.desktop.background picture-uri


#1 gnome-gmail
#2 GNOME Gmail instellen
if [[ $USER = monique ]]; then kz_gset --addfavtop --file='gnome-gmail.desktop'; fi
#4 Start Terminalvenster en voer uit:
#4    kz_gset --removefav --file='gnome-gmail.desktop'


#1 google-chrome
#2 Google Chrome instellen
kz_gset --removefav --file='firefox.desktop'
#3 1. Start Standaardtoepassingen.
#3 2. Kies bij E-mail voor Gnome Gmail.


#1 python
#2 Python instellen
if [[ $USER = karel ]]; then kz_gset --addfavtop --file='idle.desktop'; fi
#4 Start Terminalvenster en voer uit:
#4    kz_gset --removefav --file='idle.desktop'


#1 search
#2 Vooruit zoeken in history instellen
sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc
echo 'stty -ixon  # Enable fwd search history (i-search)' >> "$HOME"/.bashrc
#4 Start Terminalvenster en voer uit:
#4    sed --in-place --expression='/^stty -ixon/d' "$HOME"/.bashrc


#1 terminal
#2 GNOME Terminal instellen
if [[ $USER = karel ]]; then kz_gset --addfavtop --file='org.gnome.Terminal.desktop'; fi
#4 Start Terminalvenster en voer uit:
#4    kz_gset --removefav --file='org.gnome.Terminal.desktop'


#1 zga-ehrm
#2 Zga eHRM instellen
if [[ $USER = monique ]]; then cp /usr/share/applications/kz_zga_ehrm.desktop "$HOME"/.local/share/applications/; fi
if [[ $USER = monique ]]; then sed --in-place --expression='s/NoDisplay=true/NoDisplay=false/' "$HOME"/.local/share/applications/kz_zga_ehrm.desktop; fi
if [[ $USER = monique ]]; then kz_gset --addfavtop --file='kz_zga_ehrm.desktop'; fi
#4 Start Terminalvenster en voer uit:
#4    rm "$HOME"/.local/share/applications/kz_zga_ehrm.desktop
#4    kz_gset --removefav --file='kz_zga_ehrm.desktop'


#1 zga-intranet
#2 Zga Intranet instellen
if [[ $USER = monique ]]; then cp /usr/share/applications/kz_zga_intranet.desktop "$HOME"/.local/share/applications/; fi
if [[ $USER = monique ]]; then sed --in-place --expression='s/NoDisplay=true/NoDisplay=false/' "$HOME"/.local/share/applications/kz_zga_intranet.desktop; fi
if [[ $USER = monique ]]; then kz_gset --addfavtop --file='kz_zga_intranet.desktop'; fi
#4 Start Terminalvenster en voer uit:
#4    rm "$HOME"/.local/share/applications/kz_zga_intranet.desktop
#4    kz_gset --removefav --file='kz_zga_intranet.desktop'


#1 zga-monaco
#2 Zga Monaco instellen
if [[ $USER = monique ]]; then cp /usr/share/applications/kz_zga_monaco.desktop "$HOME"/.local/share/applications/; fi
if [[ $USER = monique ]]; then sed --in-place --expression='s/NoDisplay=true/NoDisplay=false/' "$HOME"/.local/share/applications/kz_zga_monaco.desktop; fi
if [[ $USER = monique ]]; then kz_gset --addfavtop --file='kz_zga_monaco.desktop'; fi
#4 Start Terminalvenster en voer uit:
#4    rm "$HOME"/.local/share/applications/kz_zga_monaco.desktop
#4    kz_gset --removefav --file='kz_zga_monaco.desktop'


#1 zga-webmail
#2 Zga WebMail instellen
if [[ $USER = monique ]]; then cp /usr/share/applications/kz_zga_webmail.desktop "$HOME"/.local/share/applications/; fi
if [[ $USER = monique ]]; then sed --in-place --expression='s/NoDisplay=true/NoDisplay=false/' "$HOME"/.local/share/applications/kz_zga_webmail.desktop; fi
if [[ $USER = monique ]]; then kz_gset --addfavtop --file='kz_zga_webmail.desktop'; fi
#4 Start Terminalvenster en voer uit:
#4    rm "$HOME"/.local/share/applications/kz_zga_webmail.desktop
#4    kz_gset --removefav --file='kz_zga_webmail.desktop'


# EOF
