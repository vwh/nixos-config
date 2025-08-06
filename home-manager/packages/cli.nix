# List of CLI tools to install.

{ pkgs, ... }:

with pkgs;
[
  # File and directory utilities
  fd # Simple, fast and user-friendly alternative to find
  fselect # Fast and user-friendly find
  ncdu # Disk usage analyzer
  dust # Disk usage tree (modern du)
  duf # Better df

  # Text processing and search
  ripgrep # Fast and user-friendly grep replacement
  fzf # Command-line fuzzy finder
  jq # JSON processor
  yq # YAML processor
  htmlq # Like jq, but for HTML

  # System information and monitoring
  fastfetch # Fast system information
  microfetch # Fast system information
  onefetch # One-line system information
  tokei # Code analyzer
  procs # Modern ps alternative

  # Development tools
  direnv # Directory environment
  lazydocker # Docker wrapper
  lazygit # Git TUI
  gh # GitHub CLI

  # Media and downloads
  yt-dlp # YouTube downloader
  imagemagick # Image manipulation tools

  # Utilities
  bc # Arbitrary-precision calculator
  rsync # File synchronization tool

  # Performance and benchmarking
  hyperfine # Benchmarking tool

  # JSON/YAML/TOML utilities
  fx # JSON viewer
]
