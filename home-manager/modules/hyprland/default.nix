# Hyprland modules aggregation.

{ pkgs, ... }:

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

  # Systemd service to fix DPMS after suspend
  systemd.user.services.hyprland-dpms-fix = {
    Unit = {
      Description = "Fix DPMS after suspend";
      After = [ "suspend.target" ];
    };

    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash -c 'sleep 3 && hyprctl dispatch dpms on'";
    };

    Install = {
      WantedBy = [ "suspend.target" ];
    };
  };
}
