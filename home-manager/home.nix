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
  imports = [ ./modules ];

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
      nixfmt-rfc-style # Nix code formatter
      nixd # Nix language server
      nil # Another Nix language server
      statix # Nix linter
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

    # QT/Wayland fixes for Telegram and other Qt applications
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1"; # Let Hyprland handle decorations
    QT_AUTO_SCREEN_SCALE_FACTOR = "1"; # Enable automatic scaling
    QT_ENABLE_HIGHDPI_SCALING = "1"; # Enable high DPI scaling
    GDK_SCALE = "1"; # GTK scaling for consistency
    GDK_DPI_SCALE = "1"; # GTK DPI scaling
  };

  # Enable Home Manager itself for managing dotfiles and user environment
  programs.home-manager.enable = true;
}
