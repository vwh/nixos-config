# Gaming-related configurations (Steam, MangoHud, etc.).

{ pkgs, ... }:

{
  programs = {
    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
  };

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
  };

  environment.systemPackages = with pkgs; [
    mangohud # Vulkan overlay
    protonup # Proton compatibility tool
  ];
}
