# List of development tools and languages to install.

{ pkgs, pkgsStable }:

(with pkgsStable; [
  gcc # C compiler
  gnumake # GNU make
  cmake # CMake
])

++ (with pkgs; [
  openjdk23 # OpenJDK 23
  rustc # Rust compiler
  cargo # Cargo package manager
  go # Go programming language
  sqlite # SQLite database
  just # Just command runner
  bun # Bun JavaScript runtime
  deno # Deno JavaScript runtime
  nodejs # NodeJS JavaScript runtime
  python3 # Python 3
  pnpm # pnpm package manager
])
