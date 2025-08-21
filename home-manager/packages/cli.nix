# List of CLI tools to install.

{ pkgsStable, ... }:

with pkgsStable;
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

  # Color utilities
  vivid # LS_COLORS generator

  # Network analysis and security
  wireshark-cli # Network protocol analyzer
  mitmproxy # HTTP proxy for debugging

  # Container and process tools
  dive # Docker image analyzer

  # Backup and storage
  restic # Backup tool
  borgbackup # Deduplicating backup

  # Text processing
  sd # Modern sed alternative
  choose # Modern cut/awk alternative
  xan # CSV processing

  # Performance analysis
  flamegraph # Performance visualization

  # HTTP clients
  curlie # Modern curl alternative
  xh # Yet another HTTP client

  # Log analysis
  angle-grinder # Log processing

  # DNS and network utilities
  dog # Modern dig alternative
  dua # Modern du alternative

  # Git tools
  delta # Modern diff tool
  glab # GitLab CLI

  # File watching and automation
  watchexec # File watcher
  entr # File watcher
]
