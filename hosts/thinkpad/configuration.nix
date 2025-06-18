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

  hardware.nvidia.prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };

      # integrated
      intelBusId = "PCI:0@2:0:0";

      # dedicated
      nvidiaBusId = "PCI:2@0:0:0";
    };

  networking.hostName = hostname;

  system.stateVersion = stateVersion;
}