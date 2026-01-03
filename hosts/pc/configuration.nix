# Main NixOS configuration for the 'pc' host.
# This configuration defines the desktop workstation setup with gaming capabilities,
# hardware-specific configurations, and system-wide settings.

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
    ./modules # Host-specific modules
  ];

  # Network configuration
  networking.hostName = hostname; # Set hostname from flake parameter

  # System state version for compatibility
  system = {
    inherit stateVersion; # NixOS state version from flake
  };

  # Gaming configuration - enable gaming features and GameScope
  mySystem.gaming = {
    enable = true; # Enable gaming module
    enableGamescope = true; # Enable GameScope for gaming session management
  };

  # Sandbox configuration - enable application sandboxing
  mySystem.sandboxing = {
    enable = true; # Enable Firejail and bubblewrap sandboxing
  };

  # System-wide packages (empty - packages managed via Home Manager)
  environment.systemPackages = [ ];
}
