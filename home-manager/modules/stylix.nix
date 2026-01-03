# Stylix theme and font configuration.
# This module configures system-wide theming using Stylix

{ pkgsStable, inputs, ... }:

{
  # Import the Stylix home manager module
  imports = [ inputs.stylix.homeModules.stylix ];

  # Install required font packages for the theme
  home.packages = with pkgsStable; [
    dejavu_fonts # Fallback sans-serif font
    jetbrains-mono # Primary monospace font
    noto-fonts # Comprehensive font collection
    noto-fonts-lgc-plus # Extended language coverage
    texlivePackages.hebrew-fonts # Hebrew language support
    noto-fonts-color-emoji # Emoji font support
    font-awesome # Icon font for UI elements
    powerline-fonts # Special characters for status bars
    powerline-symbols # Additional powerline symbols
    font-awesome # (Duplicate - can be removed)
    nerd-fonts.jetbrains-mono # JetBrains Mono with Nerd Font patches
  ];

  # Main Stylix configuration
  stylix = {
    enable = true; # Enable Stylix theming system
    polarity = "dark"; # Use dark theme variant
    base16Scheme = "${pkgsStable.base16-schemes}/share/themes/gruvbox-dark-soft.yaml"; # Gruvbox color scheme

    # Suppress version mismatch warning (temporary fix for NixOS 25.11 upgrade)
    enableReleaseChecks = false;

    # Target applications for theming
    targets = {
      neovim.enable = false; # Disable Neovim theming (using custom config)
      waybar.enable = false; # Disable Waybar theming (using custom config)
      wofi.enable = false; # Disable Wofi theming (using custom config)
      hyprland.enable = false; # Disable Hyprland theming (using custom config)
      hyprlock.enable = false; # Disable Hyprlock theming (using custom config)

      # Enable core desktop theming
      gtk.enable = true; # Apply theme to GTK applications
      qt.enable = true; # Apply theme to Qt applications

      # Fix GTK theme compatibility issues
      gtk.extraCss = ''
        * {
          border-spacing: inherit;
        }
      '';
    };

    # Cursor configuration
    cursor = {
      name = "DMZ-Black"; # Cursor theme name
      size = 24; # Cursor size in pixels
      package = pkgsStable.vanilla-dmz; # Package providing the cursor theme
    };

    # Font configuration for different contexts
    fonts = {
      emoji = {
        name = "Noto Color Emoji"; # Emoji font
        package = pkgsStable.noto-fonts-color-emoji;
      };

      monospace = {
        name = "JetBrains Mono"; # Coding font
        package = pkgsStable.jetbrains-mono;
      };

      sansSerif = {
        name = "Noto Sans"; # UI font
        package = pkgsStable.noto-fonts;
      };

      serif = {
        name = "Noto Serif"; # Document font
        package = pkgsStable.noto-fonts;
      };

      # Font sizes for different contexts
      sizes = {
        terminal = 13; # Terminal font size
        applications = 11; # GUI application font size
      };
    };

    # Icon theme configuration
    iconTheme = {
      enable = true; # Enable icon theming
      package = pkgsStable.papirus-icon-theme; # Icon theme package
      dark = "Papirus-Dark"; # Dark variant name
      light = "Papirus-Light"; # Light variant name
    };

    # Wallpaper configuration
    # Alternative wallpaper (commented out):
    # image = pkgs.fetchurl {
    #   url = "https://codeberg.org/lunik1/nixos-logo-gruvbox-wallpaper/raw/branch/master/png/gruvbox-dark-rainbow.png";
    #   sha256 = "036gqhbf6s5ddgvfbgn6iqbzgizssyf7820m5815b2gd748jw8zc";
    # };

    # Active wallpaper - Gruvbox pixel art wallpaper
    image = pkgsStable.fetchurl {
      url = "https://raw.githubusercontent.com/ChapST1/gruvbox-wallpapers-web/master/wallpapers/pixelart/16.png";
      sha256 = "sha256-OjH9L9olr2x0zp0EY+BFe6r/C5T98fovdVAkPEBAmq4="; # Integrity hash for security
    };
  };
}
