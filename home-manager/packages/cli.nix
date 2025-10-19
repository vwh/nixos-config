# Command-line interface tools and utilities.
# This module provides essential CLI tools for file management, text processing,
# system monitoring, development workflows, and productivity enhancement.

{ pkgsStable, ... }:

with pkgsStable;
[
  # File and directory management utilities
  fd # Modern find replacement with intuitive syntax
  fselect # SQL-like file selection tool
  ncdu # Interactive disk usage analyzer
  dust # Modern du with tree visualization
  duf # Enhanced df with better formatting

  # Text processing and search tools
  ripgrep # Fast grep replacement with modern features
  fzf # Command-line fuzzy finder
  jq # JSON processor and query tool
  yq # YAML processor similar to jq
  htmlq # HTML processor like jq for HTML

  # System information and monitoring tools
  fastfetch # Fast system information display
  microfetch # Minimal system information
  onefetch # Git repository information tool
  tokei # Code statistics and analysis
  procs # Modern process viewer (ps replacement)

  # Development and version control tools
  lazydocker # Terminal UI for Docker management
  gh # GitHub CLI tool
  hcloud # Hetzner Cloud CLI

  # Media processing and download tools
  yt-dlp # YouTube and video downloader
  imagemagick # Image manipulation and processing suite

  # General utility tools
  bc # Arbitrary precision calculator
  rsync # Fast file synchronization tool

  # Performance measurement and benchmarking
  hyperfine # Command-line benchmarking tool

  # Data format utilities
  fx # Interactive JSON viewer and processor

  # Terminal theming and colors
  vivid # LS_COLORS theme generator

  # Network analysis and security tools
  wireshark-cli # Network protocol analyzer (CLI)
  mitmproxy # HTTP proxy for debugging and analysis

  # Container analysis tools
  dive # Docker image layer analyzer

  # Backup and storage solutions
  restic # Modern backup program
  borgbackup # Deduplicating backup program

  # Text processing and manipulation
  sd # Modern sed replacement
  choose # Modern cut/awk replacement

  # Performance profiling and visualization
  flamegraph # Performance visualization tool

  # HTTP client tools
  curlie # Modern curl replacement with colors
  xh # Friendly HTTP client

  # Log processing and analysis
  angle-grinder # Log processing tool

  # Network diagnostic tools
  dog # Modern DNS lookup tool
  dua # Modern disk usage analyzer

  # Git workflow enhancement tools
  delta # Modern diff viewer for Git
  glab # GitLab CLI tool

  # File watching and automation tools
  watchexec # Execute commands on file changes
  entr # Run commands when files change
]
