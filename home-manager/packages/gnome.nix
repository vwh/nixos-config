{ pkgsStable, ... }:

(with pkgsStable; [
  flatpak
  gnome-software
  gnome-tweaks
  gnome-calendar
  gnome-clocks
  tor-browser
  libreoffice-qt6-fresh
])

++ (with pkgsStable.gnomeExtensions; [
  clipboard-history
  dash-to-panel
  desktop-icons-ng-ding
  blur-my-shell
  vitals
])
