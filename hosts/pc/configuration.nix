{ pkgs, stateVersion, hostname, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./local-packages.nix
    ../../nixos/modules
  ];

  environment.systemPackages = [ pkgs.home-manager ];

  networking.hostName = hostname;

  system = {
    stateVersion = stateVersion;
    autoUpgrade.enable = true;
    autoUpgrade.dates = "weekly";
  };
}