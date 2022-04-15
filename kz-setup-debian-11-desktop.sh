# shellcheck shell=bash
###############################################################################
# Instelbestand voor Debian 11 LTS desktop.                                   #
#                                                                             #
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.                         #
###############################################################################

#1 adguard (adblocker)
:
#2 Voor Chrome:
#2 ~~~~~~~~~~~~
#2 1. Start Google Chrome webbrowser.
#2 2. Klik rechtsboven op Meer⋮.
#2 3. Klik vervolgens op Meer hulpprogramma's > Extensies.
#2 4. Bij AdGuard-advertentieblokkeerder zet schuifje op uit of klik op Verwijderen.
#2
#2 Voor Firefox:
#2 ~~~~~~~~~~~~~
#2 1. Start Firefox webbrowser.
#2 2. Ga naar Menu openen ☰ > Add-ons (Ctrl+Shift+A).
#2 3. Klik links op Extensies.
#2 4. Bij AdGuard-advertentieblokkeerder klik op Uitschakelen of Verwijderen.

#1 bitwarden (wachtwoordbeheer)
kz-gset --addfavaft=bitwarden_bitwarden
#2 Voor Chrome:
#2 ~~~~~~~~~~~~
#2 1. Start Google Chrome webbrowser.
#2 2. Klik rechtsboven op Meer⋮.
#2 3. Klik vervolgens op Meer hulpprogramma's > Extensies.
#2 4. Bij 'Bitwarden (Gratis wachtwoordbeheer' zet schuifje op uit of klik op Verwijderen.
#2 5. Start Terminalvenster en voer uit:
#2       kz-gset --delfav=bitwarden_bitwarden
#2
#2 Voor Firefox:
#2 ~~~~~~~~~~~~~
#2 1. Start Firefox webbrowser.
#2 2. Ga naar Menu openen ☰  > Add-ons (Ctrl+Shift+A).
#2 3. Klik links op Extensies.
#2 4. Bij 'Bitwarden (Gratis wachtwoordbeheer' klik op Uitschakelen of Verwijderen.
#2 5. Start Terminalvenster en voer uit:
#2       kz-gset --delfav=bitwarden_bitwarden

#1 google-chrome (webbrowser)
## Integratie van GNOME Shell-extensies voor webbrowsers; https://extensions.gnome.org.
kz-gset --addfavbef=google-chrome
#2 1. Start Google Chrome
#2 2. Ga naar chrome://extensions/
#2 3. Bij Gnome-shell-integratie zet schuifje op uit of klik op Verwijderen.
#2 4. Start Terminalvenster en voer uit:
#2       kz-gset --delfav=google-chrome

#1 citrix (telewerken)
## Aka Citrix Workspace app, Citrix Receiver, ICA Client.
xdg-mime default wfica.desktop application/x-ica

#1 gnome (bureaubladomgeving)
gnome-extensions enable dash-to-dock@micxgx.gmail.com
gsettings set org.gnome.desktop.calendar show-weekdate true
gsettings set org.gnome.desktop.interface clock-show-date true
gsettings set org.gnome.desktop.interface show-battery-percentage true
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
gsettings set org.gnome.desktop.screensaver lock-enabled false
gsettings set org.gnome.desktop.session idle-delay 600
gsettings set org.gnome.nautilus.icon-view default-zoom-level 'large'
gsettings set org.gnome.nautilus.preferences click-policy 'single'
gsettings set org.gnome.settings-daemon.peripherals.touchscreen orientation-lock true
gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
gsettings set org.gnome.settings-daemon.plugins.media-keys max-screencast-length 0
gsettings set org.gnome.settings-daemon.plugins.power idle-dim false
gsettings set org.gnome.settings-daemon.plugins.power power-button-action 'interactive'
gsettings set org.gnome.shell.extensions.dash-to-dock apply-custom-theme true
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 32
gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed true
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height true
gsettings set org.gnome.shell.extensions.dash-to-dock icon-size-fixed true
gsettings set org.gnome.Terminal.Legacy.Settings new-terminal-mode 'tab'
kz-gset --addappfolder --folder='KZ Scripts'
#2 Start Terminalvenster en voer uit:
#2    gnome-extensions disable dash-to-dock@micxgx.gmail.com
#2    gsettings reset org.gnome.app-folders folder-children
#2    gsettings reset org.gnome.calendar show-weekdate
#2    gsettings reset org.gnome.interface clock-show-date
#2    gsettings reset org.gnome.interface show-battery-percentage
#2    gsettings reset org.gnome.peripherals.touchpad tap-to-click
#2    gsettings reset org.gnome.screensaver lock-enabled
#2    gsettings reset org.gnome.nautilus.icon-view default-zoom-level
#2    gsettings reset org.gnome.nautilus.preferences click-policy
#2    gsettings reset org.gnome.settings-daemon.peripherals.touchscreen orientation-lock
#2    gsettings reset org.gnome.settings-daemon.plugins.color night-light-enabled
#2    gsettings reset org.gnome.settings-daemon.plugins.media-keys max-screencast-length
#2    gsettings reset org.gnome.settings-daemon.plugins.power idle-dim
#2    gsettings reset org.gnome.settings-daemon.plugins.power power-button-action
#2    gsettings reset org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 32
#2    gsettings reset org.gnome.shell.extensions.dash-to-dock dock-fixed true
#2    gsettings reset org.gnome.shell.extensions.dash-to-dock extend-height true
#2    gsettings reset org.gnome.shell.extensions.dash-to-dock icon-size-fixed true
#2    gsettings reset org.gnome.Terminal.Legacy.Settings new-terminal-mode
#2    gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed
#2    kz-gset --removeappfolder --folder='KZ Scripts'

#1 skype (beeldbellen)
kz-gset --addfavaft=skype_skypeforlinux
#2 Start Terminalvenster en voer uit:
#2    kz-gset --delfav=skype_skypeforlinux

#1 spotify (muziekspeler)
kz-gset --addfavaft=spotify_spotify
#2 Start Terminalvenster en voer uit:
#2    kz-gset --delfav=spotify_spotify

#1 teams (samenwerken)
kz-gset --addfavaft=teams
#2 Start Terminalvenster en voer uit:
#2    kz-gset --delfav=teams

#1 thunderbird (e-mail)
:
#2 Verwijder de extenstie voor Google Agenda via:
#2 1. Start Thunderbird.
#2 2. Ga naar Menu openen ☰  > Add-ons.
#2 3. Klik links op Extensies.
#2 4. Bij 'Provider voor Google Agenda' zet schuifje op uit of klik ... en kies
#2    Verwijderen.

#1 zoom (samenwerken)
kz-gset --addfavaft=Zoom
#2 Start Terminalvenster en voer uit:
#2    kz-gset --delfav=Zoom
