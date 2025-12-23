{ pkgs, antigravity-nix, ... }:

{
  home.packages = [ antigravity-nix.packages.${pkgs.stdenv.hostPlatform.system}.default ];
}
