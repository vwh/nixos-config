# List of CLI tools to install.

{ pkgs, ... }:

with pkgs;
[
  tree # Directory tree
  file # File information
  jq # JSON processor
  htmlq # Like jq, but for HTML
  fzf # Command-line fuzzy finder
  direnv # Directory environment
  yt-dlp # YouTube downloader
  curl # Command-line HTTP client
  wget # Internet file retriever
  bc # Arbitrary-precision calculator
  fd # Simple, fast and user-friendly alternative to find
  lazydocker # Docker wrapper
  onefetch # One-line system information
  ripgrep # Fast and user-friendly grep replacement
  fselect # Fast and user-friendly find
  tokei # Code analyzer
  fastfetch # Fast system information
  microfetch # Fast system information
  ncdu # Disk usage analyzer
  nmap # Network discovery and security scanner
  rsync # File synchronization tool
  imagemagick # Image manipulation tools
]
