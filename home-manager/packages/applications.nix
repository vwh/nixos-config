# List of applications to install.

{ pkgs, pkgsStable }:

(with pkgsStable; [
  # Applications
  tor-browser # Tor browser
  libreoffice-qt6-fresh # LibreOffice suite

  # Themes
  gruvbox-gtk-theme # Gruvbox GTK theme
  gruvbox-kvantum # Gruvbox Qt theme
  gnome-themes-extra # Base for many GTK themes
])

++ (with pkgs; [
  # Browsers
  brave # Brave browser
  firefox # Firefox browser

  # Communication
  element-desktop # Matrix client
  vesktop # Discord client
  telegram-desktop # Telegram messenger
  slack # Slack client
  teams-for-linux # Microsoft Teams

  # Tools
  anki # Anki flashcards
  obsidian # Obsidian note-taking app
])
