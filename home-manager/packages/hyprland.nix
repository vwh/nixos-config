# List of Hyprland-related packages to install.

{ pkgs, pkgsStable }:

(with pkgsStable; [
  # Utilities
  bemoji # emoji picker
  hyprshot # screenshot tool
  brightnessctl # brightness control
  hyprpicker # hyprland color picker

  # Clipboard tools
  cliphist # clipboard history
  wl-clipboard # Wayland clipboard
  wtype # clipboard manager
])

++ (with pkgs; [
  xdg-desktop-portal-hyprland # Hyprland XDG desktop portal
  xdg-desktop-portal-gtk # Hyprland XDG desktop portal
  libsForQt5.xwaylandvideobridge # Xwayland video bridge
  libnotify # notification daemon
  playerctl # player control
])
