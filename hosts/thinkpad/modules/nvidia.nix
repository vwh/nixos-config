# NVIDIA graphics configuration for ThinkPad.
# This module configures NVIDIA Optimus (hybrid graphics) for ThinkPad laptops,
# enabling proper switching between integrated Intel and dedicated NVIDIA GPUs.

_:

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
      # PCI bus IDs for graphics devices (ThinkPad-specific)
      # Verified with: lspci | grep -i vga
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:2:0:0";

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
