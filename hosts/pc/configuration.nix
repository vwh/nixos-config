# Main NixOS configuration for the 'pc' host.
{
  pkgs,
  stateVersion,
  hostname,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./local-packages.nix
    ../../nixos/modules
  ];

  networking.hostName = hostname;
  programs.gamemode.enable = true;

  system = {
    inherit stateVersion;
  };

  environment.systemPackages = [ pkgs.home-manager ];
}
