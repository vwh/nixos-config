# Internationalization (i18n) settings.

{ pkgs, lib, ... }:

{
  i18n = {
    defaultLocale = "en_US.UTF-8";

    extraLocaleSettings = {
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

    # Input method for better language switching
    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        waylandFrontend = true;
        addons = with pkgs; [
          fcitx5-gtk
          fcitx5-configtool
          fcitx5-chinese-addons
          fcitx5-anthy
        ];
      };
    };
  };

  # Keyboard layout configuration
  services.xserver = {
    xkb = {
      layout = lib.mkForce "us,ara";
      variant = lib.mkForce ",qwerty";
      options = lib.mkForce "grp:caps_toggle,grp_led:caps";
    };
  };

  # Environment variables for input method
  environment.sessionVariables = {
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
    SDL_IM_MODULE = "fcitx";
    INPUT_METHOD = "fcitx";
    GLFW_IM_MODULE = "ibus";
  };

  # Install input method packages
  environment.systemPackages = with pkgs; [
    fcitx5-with-addons
    fcitx5-gtk
    fcitx5-configtool
  ];
}
