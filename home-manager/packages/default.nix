# Aggregates all Home Manager package lists.

{ pkgs, pkgsStable }:

let
  chunks = [
    ./applications.nix
    ./cli.nix
    ./cool.nix
    ./development.nix
    ./gnome.nix
    ./hyprland.nix
    ./multimedia.nix
    ./networking.nix
    ./utilities.nix
  ];
in

# Import each chunk with both pkgs & pkgsStable, then flatten into one big list
builtins.concatLists (map (f: import f { inherit pkgs pkgsStable; }) chunks)
