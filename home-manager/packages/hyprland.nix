# List of Hyprland-related packages to install.

{ pkgs, ... }:

with pkgs;
[
  xdg-desktop-portal-hyprland # Hyprland XDG desktop portal
  xdg-desktop-portal-gtk # Hyprland XDG desktop portal
  wl-clipboard # Wayland clipboard
  libsForQt5.xwaylandvideobridge # Xwayland video bridge
  libnotify # notification daemon
  bemoji # emoji picker
  playerctl # player control
  grimblast # screenshot tool
  brightnessctl # brightness control
  cliphist # clipboard history
  wl-clipboard # Wayland clipboard
  wtype # clipboard manager
  hyprpicker # hyprland color picker
]
