# GNOME desktop environment packages and extensions for enhanced
# GNOME functionality and customization.

{ pkgsStable, ... }:

with pkgsStable;
with pkgsStable.gnomeExtensions;
[
  # === GNOME Core Applications ===
  gnome-software # Software manager
  gnome-tweaks # Tweaks
  gnome-calendar # Calendar
  gnome-clocks # Clocks
  gnome-disk-utility # Disk management (formats, partitions)
  gnome-text-editor # Text editor

  # === GNOME Extensions ===
  clipboard-history # Clipboard history manager
  dash-to-panel # Convert dash to panel
  desktop-icons-ng-ding # Desktop icons
  blur-my-shell # Blur effects for shell elements
  vitals # System monitoring indicators
]
