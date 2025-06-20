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

  home.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\\\${HOME}/.steam/root/compatibilitytools.d";
    NIXOS_OZONE_WL = "1";
  };

  nixpkgs.config.allowUnfree = true;

  home.packages =
    let
      extraPkgs = import ./packages { inherit pkgs pkgsStable; };
    in
    (with pkgs; [
      nix-prefetch-scripts
      nixfmt-rfc-style
      nixpkgs-fmt
      nixd
    ])
    ++ extraPkgs;

  programs.home-manager.enable = true;
}
