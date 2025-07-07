# Nix-ld configuration for running non-Nix binaries.

{ pkgs, ... }:

{
  programs.nix-ld = {
    enable = true;

    libraries = with pkgs; [
      stdenv.cc.cc # glibc + compiler runtime
      libgcc
      zlib
      openssl
    ];
  };
}
