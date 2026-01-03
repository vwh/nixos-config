# Flatpak configuration for sandboxed application distribution.

{ config, ... }:

{
  # Enable Flatpak service
  services.flatpak.enable = true;

  # Configure Flatpak to use Flathub as the default remote
  # This will be set up on first system rebuild
  systemd.services.add-flathub = {
    description = "Add Flathub remote";
    wantedBy = [ "multi-user.target" ];
    after = [
      "network.target"
      "flatpak-system.service"
    ];
    path = [ config.services.flatpak.package ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };
}
