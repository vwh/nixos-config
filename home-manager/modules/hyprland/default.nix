# Hyprland modules aggregation.
# This module imports all Hyprland-related configurations including
# the main compositor settings, keybindings, utilities, and desktop components.

{
  imports = [
    ./swaync # Sway notification center configuration
    ./waybar # Status bar configuration
    ./wofi # Application launcher configuration
    ./binds.nix # Keybindings and custom scripts
    ./hypridle.nix # Idle management daemon
    ./hyprlock.nix # Screen locker configuration
    ./hyprpaper.nix # Wallpaper utility
    ./main.nix # Main Hyprland compositor settings
  ];
}
