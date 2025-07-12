# SDDM display manager configuration.

{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
}
