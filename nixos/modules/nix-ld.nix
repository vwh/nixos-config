# Nix-ld configuration for running non-Nix binaries.
# This module enables nix-ld, which allows running dynamically linked
# executables that were not built for NixOS by providing common shared libraries.

{ pkgsStable, ... }:

{
  programs.nix-ld = {
    enable = true; # Enable nix-ld for running non-Nix binaries

    # Common shared libraries that non-Nix binaries might need
    libraries = with pkgsStable; [
      stdenv.cc.cc # GCC compiler runtime and glibc
      libgcc # GCC runtime library
      zlib # Compression library
      openssl # SSL/TLS library
    ];
  };
}
