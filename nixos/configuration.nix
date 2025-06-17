{ inputs, config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
    ./packages.nix
    ./modules/bundle.nix
  ];

  disabledModules = [
    ./modules/bluetooth.nix
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      yazan = import ../home-manager/home.nix;
    };
  };

  networking.hostName = "nixos";

  time.timeZone = "Asia/Amman";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AG";
    LC_IDENTIFICATION = "en_AG";
    LC_MEASUREMENT = "en_AG";
    LC_MONETARY = "en_AG";
    LC_NAME = "en_AG";
    LC_NUMERIC = "en_AG";
    LC_PAPER = "en_AG";
    LC_TELEPHONE = "en_AG";
    LC_TIME = "en_AG";
  };

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

  # Install firefox.
  programs.firefox.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "25.05";
}
