# Warp terminal module.

{ pkgs, ... }:

{
  # Note: warp.nix is a package derivation used by the overlay in overlays.nix,
  # not a module to be imported here. It's only present in this directory
  # for organizational purposes.

  # Install Warp terminal package
  home.packages = with pkgs; [ warp-terminal-latest ];
}
