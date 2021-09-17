# shellcheck shell=bash
# #############################################################################
# Instellingsbestand voor Debian 11 LTS desktop.
#
# Geschreven door Karel Zimmer <info@karelzimmer.nl>.
# #############################################################################
# RELEASE_YEAR=2021

# VERSION_NUMBER=01.02.03
# VERSION_DATE=2021-09-17


#1 adguard
#2 Adguard (adblocker) instellen
:
#3 Voor Chrome:
#3 ~~~~~~~~~~~~
#3 1. Start Google Chrome webbrowser.
#3 2. Ga naar https://adguard.com/nl/download-extension/chrome.html
#3 3. Klik op Toev. aan Chrome.
#3 4. Klik op Extensie toevoegen.
#3
#3 Voor Firefox:
#3 ~~~~~~~~~~~~~
#3 1. Start Firefox webbrowser.
#3 2. Ga naar https://adguard.com/nl/download-extension/firefox.html
#3 3. Klik op Toevoegen aan Firefox.
#3 4. Klik op Toevoegen.
#3 5. Klik op Oké, begrepen.
#4
#4 Voor Chrome:
#4 ~~~~~~~~~~~~
#4 1. Start Google Chrome webbrowser.
#4 2. Klik rechtsboven op Meer⋮.
#4 3. Klik vervolgens op Meer hulpprogramma's > Extensies.
#4 4. Bij AdGuard-advertentieblokkeerder zet schuifje op uit of klik op Verwijderen.
#4
#4 Voor Firefox:
#4 ~~~~~~~~~~~~~
#4 1. Start Firefox webbrowser.
#4 2. Ga naar Menu openen ☰ > Add-ons (Ctrl+Shift+A).
#4 3. Klik links op Extensies.
#4 4. Bij AdGuard-advertentieblokkeerder klik op Uitschakelen of Verwijderen.


#1 alias
#2 Aliassen  (alias) instellen
sed --in-place --expression='s/#alias/alias/g' "$HOME"/.bashrc


#1 bitwarden
#2 Bitwarden (wachtwoordkluis) instellen
kz-gset --addfavbottom --file='bitwarden_bitwarden.desktop'
#3 Ingebruikname van Bitwarden bestaat uit de volgende stappen:
#3 1. Start Bitwarden.
#3 2. Maak een account aan met een sterk(!) Hoofdwachtwoord.
#3 3. Exporteer de opgeslagen wachtwoorden uit de bestaande wachtwoordbeheerder.
#3 4. Importeer de opgeslagen wachtwoorden in Bitwarden.
#3 5. Verwijder de uit de oude wachtwoordbeheerder geëxporteerde wachtwoorden.
#3 6. Verwijder de oude wachtwoordbeheerder.
#3 -----------------------------------------------
#3 Met het gebruik van Bitwarden wordt het opslaan
#3 van wachtwoorden in de browser sterk afgeraden.
#3 -----------------------------------------------
#3 Dit betekent voor de browser:
#3 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#3 1. Stop het (automatisch) opslaan van wachtwoorden.
#3 2. Verwijder opgeslagen wachtwoorden.
#3 3. Voeg de Bitwarden-extensie toe.
#3
#3 Voor Chrome betekent dit:
#3 ~~~~~~~~~~~~~~~~~~~~~~~~~
#3 1. Stop het (automatisch) opslaan van wachtwoorden.
#3    1. Klik rechtsboven op de gebruikersafbeelding en kies Je Google-account beheren.
#3    2. Klik aan de linkerkant op Beveiliging.
#3    3. Scroll naar beneden en klik op Wachtwoordmanager.
#3    4. Klik rechtsboven op tandwielsymbool.
#3    5. Zet schuifjes 'Automatisch inloggen' en 'Aanbieden om wachtwoorden op te slaan' uit.
#3 2. Verwijder opgeslagen wachtwoorden.
#3    1. Klik rechtsboven op Meer⋮.
#3    2. Klik op Instellingen.
#3    3. Klik onder 'Privacy en beveiliging' op Browsegegevens wissen.
#3    4. Klik op Geavanceerd (tab).
#3    5. Vink aan 'Wachtwoorden en andere inloggegevens' en klik op Gegevens wissen.
#3 3. Voeg de Bitwarden-extensie toe.
#3    1. Ga naar https://bitwarden.com/download/.
#3    2. Scroll naar beneden en rechts van WEB BROWSER klik op Google Chrome.
#3    3. Klik op Toev. aan Chrome.
#3    4. Klik rechtsboven op Bitwarden-icoontje en geef het Hoofdwachtwoord.
#3    5. Eventueel, met licht veiligheidsrisico, maar groot gebruikersgemak:
#3       1. Klik in Bitwarden-extensie op Instellingen en klik onder BEVEILIGING op
#3          'Time-out van de kluis' en selecteer Nooit.
#3       2. Klik in Bitwarden-extensie op Instellingen en klik onder OVERIG op
#3          Opties en vink aan Automatisch invullen bij laden van pagina.
#4
#4 Voor Chrome:
#4 ~~~~~~~~~~~~
#4 1. Start Google Chrome webbrowser.
#4 2. Klik rechtsboven op Meer⋮.
#4 3. Klik vervolgens op Meer hulpprogramma's > Extensies.
#4 4. Bij 'Bitwarden - Gratis wachtwoordbeheer' zet schuifje op uit of klik op Verwijderen.
#4 5. Start Terminalvenster en voer uit:
#4       kz-gset --removefav --file='bitwarden_bitwarden.desktop'
#4
#4 Voor Firefox:
#4 ~~~~~~~~~~~~~
#4 1. Start Firefox webbrowser.
#4 2. Ga naar Menu openen ☰ > Add-ons (Ctrl+Shift+A).
#4 3. Klik links op Extensies.
#4 4. Bij 'Bitwarden - Gratis wachtwoordbeheer' klik op Uitschakelen of Verwijderen.
#4 5. Start Terminalvenster en voer uit:
#4       kz-gset --removefav --file='bitwarden_bitwarden.desktop'


#1 dashtodock
#2 Dash to Dock (starter) instellen
gnome-extensions enable dash-to-dock@micxgx.gmail.com
gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed true
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height true
#4 Start Terminalvenster en voer uit:
#4    gnome-shell-extension-tool --disable-extension=dash-to-dock@micxgx.gmail.com
#4    gsettings reset org.gnome.shell.extensions.dash-to-dock dock-fixed
#4    gsettings reset org.gnome.shell.extensions.dash-to-dock extend-height


#1 gnome
#2 GNOME (bureaubladomgeving) instellen
## Voor een beschrijving voer uit: gsettings describe SCHEMA KEY
kz-gset --addappfolder --folder='KZ Scripts'
gsettings set org.gnome.desktop.calendar show-weekdate true
gsettings set org.gnome.desktop.interface clock-show-date true
gsettings set org.gnome.desktop.interface show-battery-percentage true
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
gsettings set org.gnome.desktop.screensaver lock-enabled false
gsettings set org.gnome.nautilus.icon-view default-zoom-level 'large'
gsettings set org.gnome.nautilus.preferences click-policy 'single'
gsettings set org.gnome.settings-daemon.peripherals.touchscreen orientation-lock true
gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
gsettings set org.gnome.settings-daemon.plugins.media-keys max-screencast-length 0
gsettings set org.gnome.settings-daemon.plugins.power idle-dim false
gsettings set org.gnome.settings-daemon.plugins.power power-button-action 'interactive'
gsettings set org.gnome.Terminal.Legacy.Settings new-terminal-mode 'tab'
#4 Start Terminalvenster en voer uit:
#4    kz-gset --removeappfolder --folder='KZ Scripts'
#4    gsettings reset org.gnome.desktop.app-folders folder-children
#4    gsettings reset org.gnome.desktop.calendar show-weekdate
#4    gsettings reset org.gnome.desktop.interface clock-show-date
#4    gsettings reset org.gnome.desktop.interface show-battery-percentage
#4    gsettings reset org.gnome.desktop.peripherals.touchpad tap-to-click
#4    gsettings reset org.gnome.desktop.screensaver lock-enabled
#4    gsettings reset org.gnome.nautilus.icon-view default-zoom-level
#4    gsettings reset org.gnome.nautilus.preferences click-policy
#4    gsettings reset org.gnome.settings-daemon.peripherals.touchscreen orientation-lock
#4    gsettings reset org.gnome.settings-daemon.plugins.color night-light-enabled
#4    gsettings reset org.gnome.settings-daemon.plugins.media-keys max-screencast-length
#4    gsettings reset org.gnome.settings-daemon.plugins.power idle-dim
#4    gsettings reset org.gnome.settings-daemon.plugins.power power-button-action
#4    gsettings reset org.gnome.Terminal.Legacy.Settings new-terminal-mode


#1 google-chrome
#2 Google Chrome (webbrowser) instellen
kz-gset --addfavtop --file='google-chrome.desktop'
## Integratie van GNOME Shell-extensies voor webbrowsers;
## https://extensions.gnome.org
#3 1. Start Google Chrome.
#3 2. Indien nodig importeer Firefox bladwijzers via klik op Meer⋮.
#3 3. Kies Bladwijzers en dan Bladwijzers en instellingen importeren.
#3 4. Ga naar https://chrome.google.com/webstore/category/extensions
#3 5. Zoek naar gnome en klik op gnome-shell integration
#3 6. Klik op Gnome-shell-integratie
#3 7. Klik op Toev. aan Chrome.
#3 8. Klik op Extensie toevoegen.
#3
#3 Om standaard te mailen met Gmail en Google Chrome voer uit:
#3 1. Start Standaardtoepassingen.
#3 2. Kies bij E-mail voor Gnome Gmail.
#4 1. Start Google Chrome
#4 2. Ga naar chrome://extensions/
#4 3. Bij Gnome-shell-integratie zet schuifje op uit of klik op Verwijderen.
#4 4. Start Terminalvenster en voer uit:
#4       kz-gset --removefav --file='google-chrome.desktop'


#1 icaclient
#2 Citrix Workspace app (telewerken) instellen
## Citrix Receiver, ICA Client
xdg-mime default wfica.desktop application/x-ica


#1 skype
#2 Skype (beeldbellen) instellen
kz-gset --addfavbottom --file='skype_skypeforlinux.desktop'
#4 Start Terminalvenster en voer uit:
#4    kz-gset --removefav --file='skype_skypeforlinux.desktop'


#1 spotify
#2 Spotify (muziekspeler) instellen
kz-gset --addfavbottom --file='spotify_spotify.desktop'
#4 Start Terminalvenster en voer uit:
#4    kz-gset --removefav --file='spotify_spotify.desktop'


#1 thunderbird
#2 Thunderbird (e-mail) installen
kz-gset --addfavtop --file='thunderbird.desktop'
#3 Voeg de extenstie voor Google Agenda toe via:
#3 1. Start Thunderbird.
#3 2. Ga naar Menu openen ☰ > Add-ons.
#3 3. Zoek 'Google Agenda'
#3 4. Klik achter 'Provider for Google Calendar' op '+ Toevoegen...'.
#3 5. Volg de aanwijzingen op het scherm.
#4 Verwijder de extenstie voor Google Agenda via:
#4 1. Start Thunderbird.
#4 2. Ga naar Menu openen ☰ > Add-ons.
#4 3. Klik links op Extensies.
#4 4. Bij 'Provider voor Google Agenda' zet schuifje op uit of klik ... en kies
#4    Verwijderen.


#1 zoom
#2 Zoom (telewerken) instellen
kz-gset --addfavbottom --file='Zoom.desktop'
#4 Start Terminalvenster en voer uit:
#4    kz-gset --removefav --file='Zoom.desktop'


# EOF
