{ pkgsStable, ... }:

(with pkgsStable; [
  gnome-software
  gnome-tweaks
  gnome-calendar
  gnome-clocks
])

++ (with pkgsStable.gnomeExtensions; [
  clipboard-history
  dash-to-panel
  desktop-icons-ng-ding
  blur-my-shell
  vitals
])
