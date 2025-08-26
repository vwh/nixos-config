# Main Home Manager configuration file.
# This file defines the core user environment, packages, and session settings

{
  inputs,
  homeStateVersion,
  user,
  pkgs,
  pkgsStable,
  ...
}:

{
  # Import all user-specific modules and configurations
  imports = [
    ./modules
  ];

  # Basic home directory configuration
  home = {
    username = user; # Set username from flake parameter
    homeDirectory = "/home/${user}"; # Standard home directory path
    stateVersion = homeStateVersion; # Home Manager state version for compatibility
  };

  # User packages - core development tools and utilities
  home.packages =
    let
      # Import additional packages from custom package definitions
      extraPkgs = import ./packages { inherit pkgs pkgsStable; };
    in
    # Core development packages
    (with pkgsStable; [
      nixfmt-rfc-style # Official Nix code formatter
      nixd # Nix language server for IDE support
    ])
    ++ extraPkgs; # Additional packages from custom definitions

  # Environment variables for session-wide configuration
  home.sessionVariables = {
    # Qt platform preference - Wayland first, X11 fallback
    QT_QPA_PLATFORM = "wayland;xcb";

    # Maintain Qt5 compatibility for legacy applications
    DISABLE_QT5_COMPAT = "0";

    # Force dark theme in Calibre e-book manager
    CALIBRE_USE_DARK_PALETTE = "1";
  };

  # Enable Home Manager itself for managing dotfiles and user environment
  programs.home-manager.enable = true;
}
