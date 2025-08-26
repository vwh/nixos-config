# System monitoring and diagnostic tools.
# This module provides comprehensive system monitoring, hardware analysis,
# performance benchmarking, and diagnostic utilities for system administration.

{ pkgsStable, ... }:

with pkgsStable;
[
  # Process and system monitoring
  atop # Advanced interactive system monitor

  # Hardware information and analysis
  screenfetch # System information display tool
  inxi # Comprehensive hardware information tool
  lshw # Hardware lister with detailed information
  hwinfo # Hardware detection and information tool
  dmidecode # DMI/SMBIOS table decoder for hardware info

  # Storage and disk monitoring
  smartmontools # S.M.A.R.T. disk health monitoring
  hdparm # Hard disk parameter configuration and testing
  sdparm # SCSI/SATA disk parameter configuration

  # Memory analysis and monitoring
  smem # Advanced memory usage reporting tool

  # Log analysis and monitoring
  lnav # Advanced log file viewer and analyzer
  multitail # Multi-file tail with color coding

  # Performance analysis tools
  perf-tools # Collection of Linux performance analysis tools

  # File system event monitoring
  inotify-tools # File system event monitoring utilities

  # System benchmarking and stress testing
  sysbench # Multi-threaded system benchmark tool
  stress # Workload generator for stress testing
  stress-ng # Advanced stress testing tool

  # Container monitoring and management
  ctop # Top-like interface for container metrics
]
