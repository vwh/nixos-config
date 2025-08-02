# Main Home Manager configuration file.

{
  homeStateVersion,
  user,
  pkgs,
  pkgsStable,
  ...
}:

{
  imports = [
    ./modules
  ];

  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = homeStateVersion;
  };

  nixpkgs.config.allowUnfree = true;

  home.packages =
    let
      extraPkgs = import ./packages { inherit pkgs pkgsStable; };
    in
    (with pkgsStable; [
      nixfmt-rfc-style
      nixd
    ])
    ++ extraPkgs;

  home.sessionVariables = {
    # use wayland as the default backend, fallback to xcb if wayland is not available
    QT_QPA_PLATFORM = "wayland;xcb";

    # remain backwards compatible with qt5
    DISABLE_QT5_COMPAT = "0";

    # tell calibre to use the dark theme
    CALIBRE_USE_DARK_PALETTE = "1";
  };

  programs.home-manager.enable = true;
}
