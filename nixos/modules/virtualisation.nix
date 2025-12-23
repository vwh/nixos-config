# Virtualisation (Docker, libvirt) configuration.

{
  pkgs,
  pkgsStable,
  user,
  ...
}:

{
  # Kernel modules required for virtualization
  boot.kernelModules = [
    "kvm-intel" # Intel KVM support
    "kvm" # Kernel Virtual Machine support
  ];

  virtualisation = {
    # Docker container runtime
    docker = {
      enable = true;
      enableOnBoot = false; # Enable Docker socket but not daemon
    };

    # Libvirt virtualization API
    libvirtd.enable = true;

    # QEMU/KVM configuration for libvirt
    libvirtd.qemu = {
      package = pkgsStable.qemu_kvm; # QEMU with KVM acceleration
      swtpm.enable = true; # Software TPM for VMs
    };
  };

  # Add user to virtualization groups for proper access
  users.users."${user}" = {
    isNormalUser = true;
    extraGroups = [
      "docker" # Access to Docker daemon
      "libvirtd" # Access to libvirt VMs
      "kvm" # Access to KVM for hardware acceleration
    ];
  };

  # NVIDIA Container Toolkit for GPU support in Docker
  hardware.nvidia-container-toolkit.enable = true;

  # Install virtualization management tools
  environment.systemPackages = with pkgsStable; [
    virt-manager # GUI for managing libvirt/QEMU/KVM virtual machines
    nvidia-container-toolkit # NVIDIA Container Toolkit CLI tools
  ];
}
