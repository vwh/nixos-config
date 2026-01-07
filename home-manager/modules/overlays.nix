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
      # Custom packages removed - using official packages from nixpkgs instead
    })
  ];
}
