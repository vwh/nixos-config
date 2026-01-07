# This file serves as the central hub for importing all system-wide
# configuration modules that define the complete NixOS system.

{
  imports = [
    ./audio.nix # Audio system configuration (PipeWire/PulseAudio)
    ./bluetooth.nix # Bluetooth services and device management
    ./bootloader.nix # Boot loader configuration (GRUB/systemd-boot)
    ./browser-deps.nix # Browser dependencies for Chrome/Chromium-based applications
    ./cleanup.nix # Automated file cleanup services
    ./dnscrypt-proxy.nix # DNSCrypt-Proxy for encrypted DNS
    ./nautilus.nix # GNOME Files (Nautilus) configuration
    ./nh.nix # Nix Helper (nh) configuration
    ./sandboxing.nix # Application sandboxing and isolation
    ./environment.nix # System-wide environment variables and paths
    ./flatpak.nix # Flatpak sandboxed application support
    ./gaming.nix # Gaming-related configurations and optimizations
    ./gnome.nix # GNOME desktop environment configuration
    ./graphics.nix # Graphics drivers and GPU configuration
    ./hyprland.nix # Hyprland window manager system integration
    ./i18n.nix # Internationalization and localization settings
    ./libinput.nix # Input device configuration (touchpad, mouse, etc.)
    ./macchanger.nix # MAC address randomization for privacy
    ./monitoring.nix # System monitoring and hardware sensors
    ./mullvad-vpn.nix # Mullvad VPN configuration and service
    ./networking.nix # Network configuration and firewall rules
    ./nix-ld.nix # Dynamic linker for running non-Nix binaries
    ./nix.nix # Nix package manager configuration
    ./printing.nix # CUPS printing system and drivers
    ./scripts.nix # Custom utility scripts and tools
    ./sops.nix # Secret management with SOPS
    ./security.nix # System security hardening
    ./stability.nix # System stability and optimization settings
    ./timezone.nix # Time zone and clock configuration
    ./tor.nix # Tor network services and configuration
    ./upower.nix # Power management and battery monitoring
    ./users.nix # User account management and permissions
    ./virtualisation.nix # Virtualization support (QEMU, libvirt, etc.)
    ./xdg-desktop-portal.nix # XDG desktop portal configuration
    ./xserver.nix # X11 server configuration and display settings
  ];
}
