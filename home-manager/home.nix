{ config, pkgs, ... }:

{
  imports = [
    ./modules/bundle.nix
  ];

  home = {
    username = "yazan";
    homeDirectory = "/home/yazan";
    stateVersion = "25.05";
  };

  programs.home-manager.enable = true;
}