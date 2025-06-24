{ pkgs, pkgsStable }:

(with pkgsStable; [
  flatpak
  gnome-software
  gnome-tweaks
  gnome-calendar
  gnome-clocks
  tor-browser
  libreoffice-qt6-fresh
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
