# Main NixOS configuration for the 'thinkpad' host.

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

  environment.systemPackages = with pkgs; [
    home-manager
    gnome.gnome-power-statistics
    pulseaudio
  ];

  services.pulseaudio.enable = true;
}
