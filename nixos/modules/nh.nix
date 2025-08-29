# Nix Helper (nh) - Simple configuration module.
# Installs nh and sets up basic environment for better NixOS management.

{
  config,
  lib,
  pkgs,
  user,
  ...
}:

{
  # Simple nh configuration - just install and setup environment
  environment = {
    # Install nh package
    systemPackages = with pkgs; [ nh ];

    # Set FLAKE environment variable using user from flake
    sessionVariables = {
      FLAKE = "/home/${user}/System";
    };
  };

  # Basic nh directories
  systemd.tmpfiles.rules = [ "d /var/cache/nh 0755 root root -" ];
}
