# Spicetify (Spotify client customizer) configuration.

{
  pkgs,
  config,
  lib,
  inputs,
  ...
}:

let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  accent = "${config.lib.stylix.colors.base0D}";
  background = "${config.lib.stylix.colors.base00}";
in
{
  imports = [ inputs.spicetify-nix.homeManagerModules.default ];

  stylix.targets.spicetify.enable = false;

  programs.spicetify = {
    enable = true;
    theme = lib.mkForce spicePkgs.themes.dribbblish;
    colorScheme = "custom";

    customColorScheme = {
      button = accent;
      button-active = accent;
      tab-active = accent;
      player = background;
      main = background;
      sidebar = background;
    };

    enabledExtensions = with spicePkgs.extensions; [
      playlistIcons
      lastfm
      historyShortcut
      hidePodcasts
      adblock
      fullAppDisplay
      keyboardShortcut
    ];
  };

  # Add environment variables to improve Spotify stability
  home.sessionVariables = {
    # Disable GPU acceleration to prevent crashes
    SPOTIFY_DISABLE_GPU = "1";
    # Force software rendering if GPU issues persist
    SPOTIFY_FORCE_SOFTWARE_RENDERING = "1";
    # Increase memory limits
    SPOTIFY_MAX_CACHE_SIZE_MB = "1024";
    # Disable hardware acceleration
    SPOTIFY_DISABLE_HARDWARE_ACCELERATION = "1";
  };
}
