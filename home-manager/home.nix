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
      nix-prefetch-scripts
      nixfmt-rfc-style
      nixpkgs-fmt
      nixd
    ])
    ++ extraPkgs;

  programs.home-manager.enable = true;
}
