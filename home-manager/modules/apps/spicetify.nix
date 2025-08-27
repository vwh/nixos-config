# Spicetify (Spotify client customizer) configuration.

{
  pkgs,
  config,
  lib,
  inputs,
  ...
}:

let
  # Spicetify package set from the flake input
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};

  # Extract colors from Stylix theme for consistent theming
  accent = "${config.lib.stylix.colors.base0D}"; # Accent color from theme
  background = "${config.lib.stylix.colors.base00}"; # Background color from theme
in
{
  # Import the Spicetify home-manager module
  imports = [ inputs.spicetify-nix.homeManagerModules.default ];

  # Disable Stylix integration for manual theme control
  stylix.targets.spicetify.enable = false;

  # Spicetify configuration
  programs.spicetify = {
    enable = true; # Enable Spicetify customization
    theme = lib.mkForce spicePkgs.themes.dribbblish; # Use Dribbblish theme
    colorScheme = "custom"; # Use custom color scheme

    # Custom color scheme using Stylix theme colors
    customColorScheme = {
      button = accent; # Button color
      button-active = accent; # Active button color
      tab-active = accent; # Active tab color
      player = background; # Player background
      main = background; # Main interface background
      sidebar = background; # Sidebar background
    };

    # Enabled Spicetify extensions for enhanced functionality
    enabledExtensions = with spicePkgs.extensions; [
      playlistIcons # Add icons to playlists
      lastfm # Last.fm integration
      historyShortcut # Keyboard shortcuts for history
      hidePodcasts # Hide podcasts from interface
      adblock # Block ads in Spotify
      fullAppDisplay # Full app display mode
      keyboardShortcut # Additional keyboard shortcuts
    ];
  };

  # Environment variables to improve Spotify stability and performance
  home.sessionVariables = {
    # Disable GPU acceleration to prevent crashes
    SPOTIFY_DISABLE_GPU = "1";

    # Force software rendering if GPU issues persist
    SPOTIFY_FORCE_SOFTWARE_RENDERING = "1";

    # Increase memory cache size for better performance
    SPOTIFY_MAX_CACHE_SIZE_MB = "1024";

    # Disable hardware acceleration for stability
    SPOTIFY_DISABLE_HARDWARE_ACCELERATION = "1";
  };
}
