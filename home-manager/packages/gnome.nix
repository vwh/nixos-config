# List of GNOME-related packages and extensions to install.

{ pkgsStable, ... }:

(with pkgsStable; [
  gnome-software # Software manager
  gnome-tweaks # Tweaks
  gnome-calendar # Calendar
  gnome-clocks # Clocks
  gnome-disk-utility # Disk management (formats, partitions)
  gnome-text-editor # Text editor
])

++ (with pkgsStable.gnomeExtensions; [
  clipboard-history # Clipboard history
  dash-to-panel # Dash to panel
  desktop-icons-ng-ding # Desktop icons
  blur-my-shell # Blur my shell
  vitals # Vitals
])
