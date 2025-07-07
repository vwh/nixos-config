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
    (with pkgs; [
      nixfmt-rfc-style
      nixd
    ])
    ++ extraPkgs;

  programs.home-manager.enable = true;
}
