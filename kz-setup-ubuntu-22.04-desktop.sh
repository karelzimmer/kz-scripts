# shellcheck shell=bash
###############################################################################
# Instelbestand voor Ubuntu 22.04 LTS desktop.                                #
#                                                                             #
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.                         #
###############################################################################

#1 adguard (adblocker)
:
#2 Voor Chrome:
#2 ~~~~~~~~~~~~
#2 1. Start Google Chrome webbrowser.
#2 2. Ga naar https://adguard.com/nl/download-extension/chrome.html
#2 3. Klik op Toev. aan Chrome.
#2 4. Klik op Extensie toevoegen.
#2
#2 Voor Firefox:
#2 ~~~~~~~~~~~~~
#2 1. Start Firefox webbrowser.
#2 2. Ga naar https://adguard.com/nl/download-extension/firefox.html
#2 3. Klik op Toevoegen aan Firefox.
#2 4. Klik op Toevoegen.
#2 5. Klik op Oké, begrepen.
#3 Voor Chrome:
#3 ~~~~~~~~~~~~
#3 1. Start Google Chrome webbrowser.
#3 2. Klik rechtsboven op Meer⋮.
#3 3. Klik vervolgens op Meer hulpprogramma's > Extensies.
#3 4. Bij AdGuard-advertentieblokkeerder zet schuifje op uit of klik op Verwijderen.
#3
#3 Voor Firefox:
#3 ~~~~~~~~~~~~~
#3 1. Start Firefox webbrowser.
#3 2. Ga naar Menu openen ☰ > Add-ons (Ctrl+Shift+A).
#3 3. Klik links op Extensies.
#3 4. Bij AdGuard-advertentieblokkeerder klik op Uitschakelen of Verwijderen.

#1 bitwarden (wachtwoordbeheer)
kz-gset --addfavaft=bitwarden_bitwarden
#2 Ingebruikname van Bitwarden bestaat uit de volgende stappen:
#2 1. Start Bitwarden.
#2 2. Maak een account aan met een sterk(!) Hoofdwachtwoord.
#2 3. Exporteer de opgeslagen wachtwoorden uit de bestaande wachtwoordbeheerder.
#2 4. Importeer de opgeslagen wachtwoorden in Bitwarden.
#2 5. Verwijder de uit de oude wachtwoordbeheerder geëxporteerde wachtwoorden.
#2 6. Verwijder de oude wachtwoordbeheerder.
#2 -----------------------------------------------
#2 Met het gebruik van Bitwarden wordt het opslaan
#2 van wachtwoorden in de browser sterk afgeraden.
#2 -----------------------------------------------
#2 Dit betekent voor de browser:
#2 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#2 1. Stop het (automatisch) opslaan van wachtwoorden.
#2 2. Verwijder opgeslagen wachtwoorden.
#2 3. Voeg de Bitwarden-extensie toe.
#2
#2 Voor Chrome betekent dit:
#2 ~~~~~~~~~~~~~~~~~~~~~~~~~
#2 1. Stop het (automatisch) opslaan van wachtwoorden.
#2    1. Klik rechtsboven op de gebruikersafbeelding en kies Je Google-account beheren.
#2    2. Klik aan de linkerkant op Beveiliging.
#2    3. Scroll naar beneden en klik op Wachtwoordmanager.
#2    4. Klik rechtsboven op tandwielsymbool.
#2    5. Zet schuifjes 'Automatisch inloggen' en 'Aanbieden om wachtwoorden op te slaan' uit.
#2 2. Verwijder opgeslagen wachtwoorden.
#2    1. Klik rechtsboven op Meer⋮.
#2    2. Klik op Instellingen.
#2    3. Klik onder 'Privacy en beveiliging' op Browsegegevens wissen.
#2    4. Klik op Geavanceerd (tab).
#2    5. Vink aan 'Wachtwoorden en andere inloggegevens' en klik op Gegevens wissen.
#2 3. Voeg de Bitwarden-extensie toe.
#2    1. Ga naar https://bitwarden.com/download/.
#2    2. Scroll naar beneden en rechts van WEB BROWSER klik op Google Chrome.
#2    3. Klik op Toev. aan Chrome.
#2    4. Klik rechtsboven op Bitwarden-icoontje en geef het Hoofdwachtwoord.
#2    5. Eventueel, met licht veiligheidsrisico, maar groot gebruikersgemak:
#2       1. Klik in Bitwarden-extensie op Instellingen en klik onder BEVEILIGING op
#2          'Time-out van de kluis' en selecteer Nooit.
#2       2. Klik in Bitwarden-extensie op Instellingen en klik onder OVERIG op
#2          Opties en vink aan Automatisch invullen bij laden van pagina en
#2          selecteer Automatisch invullen bij laden van pagina.
#3 Voor Chrome:
#3 ~~~~~~~~~~~~
#3 1. Start Google Chrome webbrowser.
#3 2. Klik rechtsboven op Meer⋮.
#3 3. Klik vervolgens op Meer hulpprogramma's > Extensies.
#3 4. Bij 'Bitwarden (Gratis wachtwoordbeheer' zet schuifje op uit of klik op Verwijderen.
#3 5. Start Terminalvenster en voer uit:
#3       kz-gset --delfav=bitwarden_bitwarden
#3
#3 Voor Firefox:
#3 ~~~~~~~~~~~~~
#3 1. Start Firefox webbrowser.
#3 2. Ga naar Menu openen ☰  > Add-ons (Ctrl+Shift+A).
#3 3. Klik links op Extensies.
#3 4. Bij 'Bitwarden (Gratis wachtwoordbeheer' klik op Uitschakelen of Verwijderen.
#3 5. Start Terminalvenster en voer uit:
#3       kz-gset --delfav=bitwarden_bitwarden

#1 google-chrome (webbrowser)
kz-gset --addfavbef=google-chrome
## Integratie van GNOME Shell-extensies voor webbrowsers https://extensions.gnome.org.
#2 1. Start Google Chrome.
#2 2. Indien nodig importeer Firefox bladwijzers via klik op Meer⋮.
#2 3. Kies Bladwijzers en dan Bladwijzers en instellingen importeren.
#2 4. Ga naar https://chrome.google.com/webstore/category/extensions
#2 5. Zoek naar gnome en klik op gnome-shell integration
#2 6. Klik op Gnome-shell-integratie
#2 7. Klik op Toev. aan Chrome.
#2 8. Klik op Extensie toevoegen.
#2
#2 Om standaard te mailen met Gmail en Google Chrome voer uit:
#2 1. Start Standaardtoepassingen.
#2 2. Kies bij E-mail voor Gnome Gmail.
#3 1. Start Google Chrome
#3 2. Ga naar chrome://extensions/
#3 3. Bij Gnome-shell-integratie zet schuifje op uit of klik op Verwijderen.
#3 4. Start Terminalvenster en voer uit:
#3       kz-gset --delfav=google-chrome

#1 citrix (telewerken)
## Aka Citrix Workspace app, Citrix Receiver, ICA Client.
xdg-mime default wfica.desktop application/x-ica

#1 gnome (bureaubladomgeving)
kz-gset --addappfolder='KZ Scripts'
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
gsettings set org.gnome.settings-daemon.plugins.power idle-dim false
gsettings set org.gnome.settings-daemon.plugins.power power-button-action 'interactive'
gsettings set org.gnome.shell.extensions.ding show-home false
gsettings set org.gnome.Terminal.Legacy.Settings new-terminal-mode 'tab'
#3 Start Terminalvenster en voer uit:
#3    kz-gset --delappfolder=KZ Scripts
#3    gsettings reset org.gnome.desktop.app-folders folder-children
#3    gsettings reset org.gnome.desktop.calendar show-weekdate
#3    gsettings reset org.gnome.desktop.interface clock-show-date
#3    gsettings reset org.gnome.desktop.interface show-battery-percentage
#3    gsettings reset org.gnome.desktop.peripherals.touchpad tap-to-click
#3    gsettings reset org.gnome.desktop.screensaver lock-enabled
#3    gsettings reset org.gnome.desktop.session idle-delay
#3    gsettings reset org.gnome.nautilus.icon-view default-zoom-level
#3    gsettings reset org.gnome.nautilus.preferences click-policy
#3    gsettings reset org.gnome.settings-daemon.peripherals.touchscreen orientation-lock
#3    gsettings reset org.gnome.settings-daemon.plugins.color night-light-enabled
#3    gsettings reset org.gnome.settings-daemon.plugins.power idle-dim
#3    gsettings reset org.gnome.settings-daemon.plugins.power power-button-action
#3    gsettings reset org.gnome.shell.extensions.ding show-home false
#3    gsettings reset org.gnome.Terminal.Legacy.Settings new-terminal-mode

#1 skype (beeldbellen)
kz-gset --addfavaft=skype_skypeforlinux
#3 Start Terminalvenster en voer uit:
#3    kz-gset --delfav=skype_skypeforlinux

#1 spotify (muziekspeler)
kz-gset --addfavaft=spotify_spotify
#3 Start Terminalvenster en voer uit:
#3    kz-gset --delfav=spotify_spotify

#1 teams (samenwerken)
kz-gset --addfavaft=teams
#3 Start Terminalvenster en voer uit:
#3    kz-gset --delfav=teams

#1 thunderbird (e-mail)
:
#2 Voeg de extenstie voor Google Agenda toe via:
#2 1. Start Thunderbird.
#2 2. Ga naar Menu openen ☰  > Add-ons.
#2 3. Zoek 'Google Agenda'
#2 4. Klik achter 'Provider for Google Calendar' op '+ Toevoegen...'.
#2 5. Volg de aanwijzingen op het scherm.
#3 Verwijder de extenstie voor Google Agenda via:
#3 1. Start Thunderbird.
#3 2. Ga naar Menu openen ☰  > Add-ons.
#3 3. Klik links op Extensies.
#3 4. Bij 'Provider voor Google Agenda' zet schuifje op uit of klik ... en kies
#3    Verwijderen.

#1 zoom (samenwerken)
kz-gset --addfavaft=Zoom
#3 Start Terminalvenster en voer uit:
#3    kz-gset --delfav=Zoom
