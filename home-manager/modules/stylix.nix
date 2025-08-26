# Stylix theme and font configuration.

{ pkgsStable, inputs, ... }:

{
  imports = [ inputs.stylix.homeModules.stylix ];

  home.packages = with pkgsStable; [
    dejavu_fonts
    jetbrains-mono
    noto-fonts
    noto-fonts-lgc-plus
    texlivePackages.hebrew-fonts
    noto-fonts-emoji
    font-awesome
    powerline-fonts
    powerline-symbols
    font-awesome
    nerd-fonts.jetbrains-mono
  ];

  stylix = {
    enable = true;
    polarity = "dark";
    base16Scheme = "${pkgsStable.base16-schemes}/share/themes/gruvbox-dark-soft.yaml";

    targets = {
      neovim.enable = false;
      waybar.enable = false;
      wofi.enable = false;
      hyprland.enable = false;
      hyprlock.enable = false;

      # Enable stylix to manage GTK and Qt themes
      gtk.enable = true;
      qt.enable = true;

      # Configure zen-browser for stylix
      zen-browser = {
        enable = true;
        profileNames = [ "default" ];
      };
    };

    cursor = {
      name = "DMZ-Black";
      size = 24;
      package = pkgsStable.vanilla-dmz;
    };

    fonts = {
      emoji = {
        name = "Noto Color Emoji";
        package = pkgsStable.noto-fonts-color-emoji;
      };

      monospace = {
        name = "JetBrains Mono";
        package = pkgsStable.jetbrains-mono;
      };

      sansSerif = {
        name = "Noto Sans";
        package = pkgsStable.noto-fonts;
      };

      serif = {
        name = "Noto Serif";
        package = pkgsStable.noto-fonts;
      };

      sizes = {
        terminal = 13;
        applications = 11;
      };
    };

    iconTheme = {
      enable = true;
      package = pkgsStable.papirus-icon-theme;
      dark = "Papirus-Dark";
      light = "Papirus-Light";
    };

    # image = pkgs.fetchurl {
    #   url = "https://codeberg.org/lunik1/nixos-logo-gruvbox-wallpaper/raw/branch/master/png/gruvbox-dark-rainbow.png";
    #   sha256 = "036gqhbf6s5ddgvfbgn6iqbzgizssyf7820m5815b2gd748jw8zc";
    # };

    image = pkgsStable.fetchurl {
      url = "https://raw.githubusercontent.com/ChapST1/gruvbox-wallpapers-web/master/wallpapers/pixelart/16.png";
      sha256 = "sha256-OjH9L9olr2x0zp0EY+BFe6r/C5T98fovdVAkPEBAmq4=";
    };
  };
}
