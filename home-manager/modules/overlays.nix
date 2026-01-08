# Global overlays configuration

_:

{
  nixpkgs.overlays = [
    (_final: _prev: {
      # Custom packages removed - using official packages from nixpkgs instead
    })
  ];
}
