# Gaming-related configurations (Steam, MangoHud, etc.).
# This module provides a custom gaming configuration with Steam,
# performance monitoring, and compatibility tools for running Windows games.

{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Custom module options for gaming configuration
  options.mySystem.gaming = {
    enable = lib.mkEnableOption "gaming support with Steam and related tools";

    enableGamescope = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable gamescope session for Steam";
    };
  };

  # Configuration applied when gaming is enabled
  config = lib.mkIf config.mySystem.gaming.enable {
    programs = {
      steam = {
        enable = true; # Enable Steam gaming platform
        gamescopeSession.enable = config.mySystem.gaming.enableGamescope; # Enable GameScope session
      };
    };

    # Environment variables for Steam and compatibility tools
    environment.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d"; # Proton compatibility tools path
    };

    # Gaming-related system packages
    environment.systemPackages = with pkgs; [
      mangohud # Vulkan overlay for performance monitoring
      protonup # Tool for managing Proton compatibility layers
    ];
  };
}
