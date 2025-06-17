{ config, pkgs, ... }:

{
  imports = [
    ./modules
  ];

  home = {
    username = "yazan";
    homeDirectory = "/home/yazan";
    stateVersion = "25.05";
  };

  home.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS =
      "\\\${HOME}/.steam/root/compatibilitytools.d";
  };

  programs.home-manager.enable = true;
}