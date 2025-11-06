# Hyprland window manager and Wayland utilities.
# This module provides essential packages for the Hyprland Wayland
# compositor, including utilities, clipboard management, and desktop integration.

{ pkgs, pkgsStable }:

(with pkgsStable; [
  # Hyprland-specific utilities and tools
  bemoji # Emoji picker for Wayland
  brightnessctl # Screen brightness control
  hyprpicker # Color picker for Hyprland

  # Screenshot utilities
  grim # Screenshot utility for Wayland
  slurp # Region selection utility for Wayland

  # Clipboard management for Wayland
  cliphist # Clipboard history manager
  wl-clipboard # Wayland clipboard utilities
  wtype # Wayland keyboard and mouse input simulation
])

++ (with pkgs; [
  # Desktop integration and portals
  xdg-desktop-portal-hyprland # Hyprland XDG desktop portal backend
  xdg-desktop-portal-gtk # GTK XDG desktop portal frontend
  # kdePackages.xwaylandvideobridge # XWayland video bridge - temporarily removed (not available)
  libnotify # Desktop notification library
  playerctl # Media player control utility
])
