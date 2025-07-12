# Imports all NixOS modules.

{
  imports = [
    ./audio.nix
    ./bluetooth.nix
    ./bootloader.nix
    ./environment.nix
    ./gaming.nix
    ./graphics.nix
    ./hyprland.nix
    ./i18n.nix
    ./networking.nix
    ./nix-ld.nix
    ./nix.nix
    ./printing.nix
    ./thunar.nix
    ./timezone.nix
    ./tor.nix
    ./users.nix
    ./virtualisation.nix
    ./xserver.nix
  ];
}
