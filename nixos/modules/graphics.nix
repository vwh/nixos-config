# Graphics and NVIDIA driver configuration.
# This module configures NVIDIA graphics drivers with optimized settings
# for gaming, Wayland compositors, and hardware acceleration.

{ pkgs, config, ... }:

let
  # Using beta driver for recent GPUs like RTX 4070
  # Beta drivers provide better support for newer hardware
  nvidiaDriverChannel = config.boot.kernelPackages.nvidiaPackages.beta;
in
{
  # Video drivers configuration for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ]; # Use NVIDIA proprietary driver

  # Kernel parameters for better Wayland and Hyprland integration
  boot.kernelParams = [
    "nvidia-drm.modeset=1" # Enable DRM kernel mode setting for Wayland
    "nvidia.NVreg_PreserveVideoMemoryAllocations=1" # Preserve GPU memory on suspend/resume
  ];

  # Blacklist nouveau to avoid conflicts with proprietary driver
  boot.blacklistedKernelModules = [ "nouveau" ];

  # Environment variables for better compatibility and performance
  environment.variables = {
    LIBVA_DRIVER_NAME = "nvidia"; # Use NVIDIA for hardware video acceleration
    XDG_SESSION_TYPE = "wayland"; # Force Wayland session
    GBM_BACKEND = "nvidia-drm"; # Use NVIDIA DRM for graphics backend
    __GLX_VENDOR_LIBRARY_NAME = "nvidia"; # Force NVIDIA GLX driver
    WLR_NO_HARDWARE_CURSORS = "1"; # Fix cursor issues on Wayland
    ELECTRON_OZONE_PLATFORM_HINT = "auto"; # Auto-detect Electron platform
    __GL_GSYNC_ALLOWED = "1"; # Enable G-Sync if available
    __GL_VRR_ALLOWED = "1"; # Enable Variable Refresh Rate
    WLR_DRM_NO_ATOMIC = "1"; # Fix atomic mode issues with Hyprland
    NVD_BACKEND = "direct"; # Direct backend for new NVIDIA driver
    MOZ_ENABLE_WAYLAND = "1"; # Enable Wayland support in Firefox
  };

  # Configuration for proprietary packages
  nixpkgs.config = {
    nvidia.acceptLicense = true;
    allowUnfree = true;
  };

  # Hardware configuration for NVIDIA graphics
  hardware = {
    nvidia = {
      open = false; # Use proprietary driver (not open source)
      nvidiaSettings = true; # Enable nvidia-settings utility
      modesetting.enable = true; # Required for Wayland compositors
      package = nvidiaDriverChannel; # Use beta driver package

      powerManagement = {
        enable = true; # Enable power management for better battery life
      };
    };

    # Enhanced graphics support with hardware acceleration
    graphics = {
      enable = true; # Enable graphics support
      package = nvidiaDriverChannel; # Use same driver for consistency
      enable32Bit = true; # Enable 32-bit support for legacy applications

      # Additional graphics packages for full hardware acceleration
      extraPackages = with pkgs; [
        nvidia-vaapi-driver # NVIDIA VA-API driver for video acceleration
        vaapiVdpau # VDPAU backend for VA-API
        libvdpau-va-gl # OpenGL backend for VDPAU
        mesa # Mesa Vulkan drivers
        egl-wayland # EGL platform for Wayland
        vulkan-loader # Vulkan API loader
        vulkan-validation-layers # Vulkan validation and debugging
        libva # Video Acceleration API
      ];
    };
  };

  # Nix binary cache for CUDA packages
  nix.settings = {
    substituters = [ "https://cuda-maintainers.cachix.org" ]; # CUDA package cache

    trusted-public-keys = [
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
    ];
  };

  # Additional graphics debugging and utility packages
  environment.systemPackages = with pkgs; [
    vulkan-tools # Vulkan debugging and information tools
    glxinfo # OpenGL and GLX information utility
    libva-utils # VA-API debugging and testing utilities
  ];
}
