# List of utility packages to install.

{ pkgsStable, ... }:

with pkgsStable;
[
  # Core system utilities
  coreutils # Linux core utilities
  findutils # GNU find, xargs, locate
  diffutils # GNU diff
  gzip # GNU gzip
  unzip # GNU zip
  file-roller # archive manager
  p7zip # 7-zip
  unrar # RAR decompression
  xz # xz compression
  bzip2 # bzip2 compression
  xdg-utils # xdg utilities
  desktop-file-utils # desktop file utilities

  # Essential system utilities for AI agents
  lsof # List open files and processes
  procps # Process utilities (ps, top, kill, etc.)
  psmisc # Additional process utilities (killall, pgrep, pstree, etc.)
  util-linux # System utilities (lsblk, mount, etc.)

  # Archive and compression
  zip # ZIP compression

  # Security utilities
  libsecret # Password manager
  sops # Encrypted secrets
  # Note: gnupg is provided by programs.gpg in gpg.nix

  # Media utilities
  optipng # Optimize PNG files
  jpegoptim # Optimize JPEG files
  ueberzugpp # Terminal image viewer

  # System management
  udisks # Automount USB, SD cards, pmount, …
  xarchiver # Archive manager
  pavucontrol # PulseAudio volume control

  # Development utilities
  hexdump # Hex dump utility
  xxd # Hex dump utility
  tree # Directory tree viewer
]
