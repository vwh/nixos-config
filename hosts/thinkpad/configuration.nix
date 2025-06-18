{ pkgs, stateVersion, hostname, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./local-packages.nix
    ../../nixos/modules
  ];

  environment.systemPackages = [ pkgs.home-manager ];

  services.power-profiles-daemon.enable = true;
  services.fwupd.enable               = true;

  networking.hostName = hostname;

  system.stateVersion = stateVersion;
}