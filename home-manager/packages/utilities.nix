# General utility packages and system tools.
# This module provides essential system utilities, archive management,
# security tools, media processing utilities, and development helpers.

{ pkgsStable, ... }:

with pkgsStable;
[
  # Core GNU utilities and system tools
  coreutils # Basic file, shell, and text manipulation utilities
  findutils # File search utilities (find, xargs, locate)
  diffutils # File comparison utilities
  gzip # GNU compression utility
  unzip # ZIP archive extraction
  file-roller # Archive manager with GUI
  p7zip # 7-Zip compression and encryption
  unrar # RAR archive extraction
  xz # High-ratio compression utility
  bzip2 # Bzip2 compression utility
  xdg-utils # XDG base directory utilities
  desktop-file-utils # Desktop file management utilities

  # Essential system process and file management
  lsof # List open files and network connections
  procps # Process utilities (ps, top, kill, etc.)
  psmisc # Additional process utilities (killall, pgrep, pstree)
  util-linux # System utilities (lsblk, mount, dmesg, etc.)

  # Archive and compression tools
  zip # ZIP compression and archiving

  # Security and credential management
  libsecret # Secret/password management library
  sops # Encrypted secrets management
  # Note: gnupg is provided by programs.gpg in gpg.nix

  # Media processing and optimization
  optipng # PNG image optimization
  jpegoptim # JPEG image optimization
  ueberzugpp # Terminal image viewer and display

  # System management and device handling
  udisks # Storage device management and auto-mounting
  udiskie # Automatic disk mounting for USB drives with notifications
  xarchiver # Lightweight archive manager
  pavucontrol # PulseAudio volume control GUI

  # Development and debugging utilities
  hexdump # Hexadecimal file dumper
  xxd # Hex dump utility (part of vim)
  tree # Directory tree visualization

  # Application packaging and execution
  appimage-run # Run AppImage applications with proper FHS environment
]
