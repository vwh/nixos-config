# Home Manager package aggregation.
# This module aggregates all package definitions from various categories
# into a single flattened list for Home Manager installation.

{ pkgs, pkgsStable }:

let
  # List of package definition files to include
  chunks = [
    ./custom/prayer.nix # Custom prayer times application
    ./applications.nix # General application packages
    ./cli.nix # Command-line interface tools
    ./cool.nix # Interesting/unique packages
    ./development.nix # Development tools and languages
    ./gnome.nix # GNOME desktop environment packages
    ./hyprland.nix # Hyprland window manager packages
    ./multimedia.nix # Media and entertainment packages
    ./networking.nix # Network-related tools
    ./system-monitoring.nix # System monitoring and diagnostics
    ./utilities.nix # General utility packages
  ];
in

# Import each package chunk and flatten into a single list
builtins.concatLists (map (f: import f { inherit pkgs pkgsStable; }) chunks)
