# List of applications to install.

{ pkgs, pkgsStable }:

(with pkgsStable; [
  tor-browser # Tor browser
  libreoffice-qt6-fresh # LibreOffice suite
])

++ (with pkgs; [
  anki # Anki flashcards
  gnome-text-editor # Text editor
  alacritty # Terminal emulator
  vscode # Visual Studio Code
  obs-studio # OBS Studio
  obsidian # Obsidian note-taking app
  audacity # Audio editor
  brave # Brave browser
  firefox # Firefox browser
  sqlitebrowser # SQLite browser
  teams-for-linux # Microsoft Teams
  telegram-desktop # Telegram messenger
  vesktop # Discord client
])
