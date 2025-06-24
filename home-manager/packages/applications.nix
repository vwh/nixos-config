{ pkgs, pkgsStable }:

(with pkgsStable; [
  tor-browser
  libreoffice-qt6-fresh
  gnome-tweaks
  gnome-calendar
  gnome-clocks
])

++ (with pkgs; [
  anki
  alacritty
  vscode
  code-cursor
  obs-studio
  obsidian
  audacity
  brave
  firefox
  sqlitebrowser
  teams-for-linux
  telegram-desktop
  vesktop
])
