# Main NixOS configuration for the 'thinkpad' host.
# This configuration defines the laptop setup with power management,
# hardware-specific configurations, and mobile-optimized settings.

{
  inputs,
  pkgs,
  stateVersion,
  hostname,
  user,
  gitConfig,
  pkgsStable,
  ...
}:

{
  # Import all configuration modules in order of precedence
  imports = [
    ./hardware-configuration.nix # Auto-generated hardware configuration
    ./local-packages.nix # Host-specific package overrides
    ../../nixos/modules # Shared NixOS modules
    ./modules # Host-specific modules (power, nvidia, etc.)
  ];

  # Network configuration
  networking.hostName = hostname; # Set hostname from flake parameter

  # System state version for compatibility
  system = {
    inherit stateVersion; # NixOS state version from flake
  };

  # System module configurations with all options explicitly set
  mySystem = {
    gaming = {
      enable = false;
      enableGamescope = false;
    };
    sandboxing = {
      enable = true;
      enableUserNamespaces = true;
      enableWrappedBinaries = false;
    };
    bluetooth = {
      enable = true;
      powerOnBoot = false;
    };
    flatpak = {
      enable = true;
    };
    mullvadVpn = {
      enable = true;
    };
    tor = {
      enable = true;
    };
    dnscryptProxy = {
      enable = true;
    };
    macchanger = {
      enable = true;
    };
  };

  # System-wide packages (empty - packages managed via Home Manager)
  environment.systemPackages = [ ];
}
