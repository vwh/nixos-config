# System monitoring and diagnostic tools for system monitoring,
# hardware analysis, performance benchmarking, and system administration.

{ pkgsStable, ... }:

with pkgsStable;
[
  # === Process and System Monitoring ===
  atop # Advanced interactive system monitor

  # === Hardware Information and Analysis ===
  screenfetch # System information display tool
  inxi # Comprehensive hardware information tool
  lshw # Hardware lister with detailed information
  hwinfo # Hardware detection and information tool
  dmidecode # DMI/SMBIOS table decoder for hardware info

  # === Storage and Disk Monitoring ===
  hdparm # Hard disk parameter configuration and testing
  sdparm # SCSI/SATA disk parameter configuration

  # === Memory Analysis ===
  smem # Advanced memory usage reporting tool

  # === Log Analysis and Monitoring ===
  lnav # Advanced log file viewer and analyzer
  multitail # Multi-file tail with color coding

  # === Performance Analysis ===
  perf-tools # Collection of Linux performance analysis tools

  # === File System Event Monitoring ===
  inotify-tools # File system event monitoring utilities

  # === System Benchmarking and Stress Testing ===
  sysbench # Multi-threaded system benchmark tool
  stress # Workload generator for stress testing
  stress-ng # Advanced stress testing tool

  # === Container Monitoring ===
  ctop # Top-like interface for container metrics
]
