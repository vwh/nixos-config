# Imports all NixOS modules.

{
  imports = [
    ./audio.nix
    ./bluetooth.nix
    ./bootloader.nix
    ./environment.nix
    ./gaming.nix
    ./gnome.nix
    ./graphics.nix
    ./hyprland.nix
    ./i18n.nix
    ./networking.nix
    ./nix.nix
    ./nix-ld.nix
    ./printing.nix
    ./timezone.nix
    ./thunar.nix
    ./tor.nix
    ./users.nix
    ./virtualisation.nix
    ./xserver.nix
  ];
}
