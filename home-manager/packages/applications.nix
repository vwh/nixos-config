{ pkgs, pkgsStable }:

(with pkgsStable; [
  tor-browser
  libreoffice-qt6-fresh
  gnome-tweaks
])
++ (with pkgs; [
  anki
  alacritty
  vscode
  obs-studio
  obsidian
  audacity
  brave
  firefox
  chromium
  sqlitebrowser
  teams-for-linux
  telegram-desktop
])
