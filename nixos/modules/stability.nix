# System stability and high-performance networking optimization.
# Ultra-high RPS tuning for load testing and development environments.

{ pkgsStable, lib, ... }:

{
  boot.kernel.sysctl = {
    "fs.file-max" = 1000000; # System-wide file descriptor limit
    "net.core.somaxconn" = 65536; # Max pending connections
    "net.core.netdev_max_backlog" = 250000; # Max network queue backlog
    "net.ipv4.tcp_max_syn_backlog" = 65536; # Max pending SYN connections
    "net.ipv4.ip_local_port_range" = "1000 65535"; # Available ephemeral port range
    "kernel.pid_max" = 4194303; # Maximum process ID

    # Connection reuse and scalability
    "net.ipv4.tcp_tw_reuse" = 1; # Reuse TIME_WAIT sockets
    "net.ipv4.tcp_tw_recycle" = 0; # Disabled to preserve NAT compatibility
    "net.ipv4.tcp_fin_timeout" = 15; # FIN timeout for closed sockets
    "net.ipv4.tcp_slow_start_after_idle" = 0; # Immediate full-speed after idle

    # SYN handling
    "net.ipv4.tcp_syncookies" = lib.mkDefault 1; # Protects against SYN floods

    # TCP buffer tuning
    "net.core.rmem_max" = 16777216; # Max receive buffer (16 MB)
    "net.core.wmem_max" = 16777216; # Max send buffer (16 MB)
    "net.ipv4.tcp_rmem" = "4096 87380 16777216"; # Receive buffer auto-tuning
    "net.ipv4.tcp_wmem" = "4096 65536 16777216"; # Send buffer auto-tuning

    # Memory management
    "vm.swappiness" = 10; # Swap tendency
    "vm.dirty_ratio" = 15; # Max dirty memory percentage
    "vm.dirty_background_ratio" = 5; # Background flush threshold
  };

  services = {
    earlyoom = {
      enable = false;
    };

    dbus = {
      packages = with pkgsStable; [
        gnome-keyring
        gcr
      ];
    };
  };

  systemd.settings.Manager = {
    DefaultLimitNOFILE = 200000; # Systemd-wide FD limit
  };

  security.pam.loginLimits = [
    {
      domain = "*";
      type = "soft";
      item = "nofile";
      value = "200000";
    }
    {
      domain = "*";
      type = "hard";
      item = "nofile";
      value = "200000";
    }
    {
      domain = "*";
      type = "soft";
      item = "nproc";
      value = "65536";
    }
    {
      domain = "*";
      type = "hard";
      item = "nproc";
      value = "65536";
    }
    {
      domain = "*";
      type = "soft";
      item = "stack";
      value = "unlimited";
    }
    {
      domain = "*";
      type = "hard";
      item = "stack";
      value = "unlimited";
    }
  ];
}
