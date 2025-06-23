{ pkgs, pkgsStable }:

(with pkgsStable; [
  gcc
  gnumake
  cmake
])

++ (with pkgs; [
  openjdk23
  rustc
  cargo
  go
  sqlite
  just
  bun
  nodejs
  python3
  pnpm
])
