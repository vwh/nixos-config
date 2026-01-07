# NVIDIA graphics configuration for ThinkPad.
# This module configures NVIDIA Optimus (hybrid graphics) for ThinkPad laptops,
# enabling proper switching between integrated Intel and dedicated NVIDIA GPUs.

{
  hardware,
  lib,
  host,
  ...
}:

{
  # Hardware configuration for NVIDIA graphics on ThinkPad
  hardware.nvidia = {
    # Power management settings for NVIDIA GPU - CRITICAL for battery life
    powerManagement = {
      enable = true; # Enable NVIDIA power management
      finegrained = true; # Fine-grained power control (30-50% battery savings)
    };

    # NVIDIA Optimus (PRIME) configuration for hybrid graphics
    prime = {
      # PCI bus IDs for graphics devices (from host config)
      # These values are hardware-specific and should be verified with lspci | grep -i vga
      inherit (host) intelBusId nvidiaBusId;

      # Enable offloading to dedicated GPU when needed
      offload = {
        enable = true; # Enable GPU offloading
        enableOffloadCmd = true; # Enable offload command
      };

      # Disable sync mode (use offload instead)
      sync.enable = false;
    };
  };
}
