# Imports all Home Manager modules.

{
  imports = [
    ./apps
    ./hyprland
    ./terminal
    ./overlays.nix
    ./gpg.nix
    ./mime.nix
    ./qt.nix
    ./stylix.nix
  ];
}
