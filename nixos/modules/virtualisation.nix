# Virtualisation ( docker, virtualbox, libvirt ) configuration.

{ pkgs, user, ... }:

{
  boot.kernelModules = [
    "kvm-intel"
    "kvm"
  ];

  virtualisation = {
    docker.enable = true;
    virtualbox.host.enable = true;
    virtualbox.host.enableExtensionPack = true;

    libvirtd.enable = true;
    libvirtd.qemu = {
      package = pkgs.qemu_kvm;
      swtpm.enable = true;
      ovmf.enable = true;
      ovmf.packages = [ pkgs.OVMFFull.fd ];
    };
  };

  users.users."${user}" = {
    isNormalUser = true;
    extraGroups = [
      "docker"
      "vboxusers"
      "libvirtd"
      "kvm"
    ];
  };

  environment.systemPackages = with pkgs; [
    virtualbox # VBoxManage, VBoxHeadless, etc.
    virt-manager # GUI for libvirt + QEMU/KVM
  ];
}
