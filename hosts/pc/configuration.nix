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
    ./modules
  ];

  networking.hostName = hostname;

  system = {
    inherit stateVersion;
  };

  environment.systemPackages = [ pkgs.home-manager ];
}
