# Hyprpaper (wallpaper utility) configuration.
# This module enables Hyprpaper, a Wayland wallpaper utility for Hyprland.
# The actual wallpaper configuration is managed by Stylix in ../stylix.nix.

{
  # Enable Hyprpaper wallpaper service
  # Wallpaper images and configuration are managed by Stylix theme system
  services.hyprpaper = {
    enable = true; # Enable Hyprpaper for wallpaper management
  };
}
