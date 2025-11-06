# Custom prayer times application package.
# This module defines a custom Nix package for prayerbar, a Rust-based
# prayer time indicator designed for integration with Waybar status bar.

{ pkgsStable, ... }:

[
  (pkgsStable.rustPlatform.buildRustPackage rec {
    # Package metadata
    pname = "prayerbar"; # Package name
    version = "unstable"; # Version (using git commit)

    # Source code from GitHub repository
    src = pkgsStable.fetchFromGitHub {
      owner = "Onizuka893"; # Repository owner
      repo = "prayerbar"; # Repository name
      rev = "337a83ac9c0e10360928c2e7859811e7bc1e3bfd"; # Git commit hash
      sha256 = "sha256-edDyN+shEkgc87yLH2sfpL8TjLn1+mwFCM0RlbQVzsg="; # Source hash
    };

    # Cargo dependencies hash for reproducible builds
    cargoHash = "sha256-3DWCeQnLNINq6dsD0C5xRAZOnkAGRlxOfXwIOwCxy3c=";

    # Package metadata for Nix package manager
    meta = with pkgsStable.lib; {
      description = "A simple prayer time indicator for Waybar"; # Package description
      homepage = "https://github.com/Onizuka893/prayerbar"; # Project homepage
      license = licenses.mit; # Open source license
      platforms = [ pkgsStable.stdenv.hostPlatform.system ];
    };
  })
]
