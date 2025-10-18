# Virtualisation (Docker, VirtualBox, libvirt) configuration.
# This module enables various virtualization technologies for running

{ pkgsStable, user, ... }:

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

    # VirtualBox virtualization platform
    virtualbox.host.enable = true;
    virtualbox.host.enableExtensionPack = true; # Enable USB and PXE boot support

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
      "vboxusers" # Access to VirtualBox VMs
      "libvirtd" # Access to libvirt VMs
      "kvm" # Access to KVM for hardware acceleration
    ];
  };

  # Install virtualization management tools
  environment.systemPackages = with pkgsStable; [
    virtualbox # VirtualBox command-line tools and GUI
    virt-manager # GUI for managing libvirt/QEMU/KVM virtual machines
  ];
}
