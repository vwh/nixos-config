{ pkgs, pkgsStable }:

let
  chunks = [
    ./utilities.nix
    ./gnome.nix
    ./dev.nix
    ./networking.nix
    ./cli.nix
    ./applications.nix
    ./multimedia.nix
  ];
in

# Import each chunk with both pkgs & pkgsStable, then flatten into one big list
builtins.concatLists (map (f: import f { inherit pkgs pkgsStable; }) chunks)
