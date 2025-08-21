# System stability and service conflict resolution

{ pkgsStable, ... }:

{
  services = {
    # Enable earlyoom to prevent system lockups due to memory exhaustion
    earlyoom = {
      enable = true;
      freeMemThreshold = 5;
      freeSwapThreshold = 10;
    };

    # Reduce D-Bus service conflicts by managing service startup order
    dbus = {
      packages = with pkgsStable; [
        gnome-keyring
        gcr
      ];
    };
  };

  # Environment variables to improve application stability
  environment.sessionVariables = {
    # Reduce GPU-related crashes
    WEBKIT_DISABLE_COMPOSITING_MODE = "1";
    # Reduce memory usage for some applications
    G_SLICE = "always-malloc";
  };
}
