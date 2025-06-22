{ pkgs, pkgsStable }:

let
  chunks = [
    ./applications.nix
    ./cli.nix
    ./development.nix
    ./gnome.nix
    ./multimedia.nix
    ./networking.nix
    ./utilities.nix
  ];
in

# Import each chunk with both pkgs & pkgsStable, then flatten into one big list
builtins.concatLists (map (f: import f { inherit pkgs pkgsStable; }) chunks)
