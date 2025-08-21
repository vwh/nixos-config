# Global overlays configuration

{
  pkgs,
  lib,
  config,
  ...
}:

{
  nixpkgs.overlays = [
    (final: prev: {
      # Custom Warp terminal package
      warp-terminal-latest = final.callPackage ../packages/custom/warp.nix { };
    })
  ];
}
