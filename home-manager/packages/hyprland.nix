# Hyprland window manager and Wayland utilities.
# This module provides essential packages for the Hyprland Wayland
# compositor, including utilities, clipboard management, and desktop integration.

{ pkgs, pkgsStable }:

(with pkgsStable; [
  # Hyprland-specific utilities and tools
  bemoji # Emoji picker for Wayland
  hyprshot # Screenshot utility for Hyprland
  brightnessctl # Screen brightness control
  hyprpicker # Color picker for Hyprland

  # Clipboard management for Wayland
  cliphist # Clipboard history manager
  wl-clipboard # Wayland clipboard utilities
  wtype # Wayland keyboard and mouse input simulation
])

++ (with pkgs; [
  # Desktop integration and portals
  xdg-desktop-portal-hyprland # Hyprland XDG desktop portal backend
  xdg-desktop-portal-gtk # GTK XDG desktop portal frontend
  libsForQt5.xwaylandvideobridge # XWayland video bridge for screen sharing
  libnotify # Desktop notification library
  playerctl # Media player control utility
])
