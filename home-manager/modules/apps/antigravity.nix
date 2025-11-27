{ pkgs, antigravity-nix, ... }:

{
  home.packages = [ antigravity-nix.packages.${pkgs.system}.default ];
}
