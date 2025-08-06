# System monitoring and analysis tools for AI agents and power users.

{ pkgs, ... }:

with pkgs;
[
  # Process monitoring
  btop # Modern htop alternative
  atop # Advanced system monitor

  # System information
  screenfetch # System information alternative
  inxi # Hardware information
  lshw # Hardware lister
  hwinfo # Hardware information
  dmidecode # DMI table decoder

  # Performance monitoring
  iotop # I/O monitoring

  # Disk monitoring
  smartmontools # Disk health monitoring
  hdparm # Hard disk parameters
  sdparm # SCSI disk parameters

  # Memory monitoring
  smem # Memory usage reporter

  # Log analysis
  lnav # Log navigator
  multitail # Multi-file tail

  # System debugging (moved to development.nix)
  perf-tools # Performance analysis tools

  # File system monitoring
  inotify-tools # File system event monitoring

  # Temperature monitoring
  lm_sensors # Hardware sensors

  # Benchmarking
  sysbench # System benchmark
  stress # System stress testing
  stress-ng # Next generation stress testing

  # Container monitoring
  ctop # Container monitoring
]
