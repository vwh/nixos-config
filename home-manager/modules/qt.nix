{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    papirus-icon-theme
    pcmanfm-qt
    gruvbox-gtk-theme
  ];

  qt = {
    enable = true;
    platformTheme.name = "gtk";

    style = {
      package = pkgs.gruvbox-gtk-theme;
      name = "gruvbox-dark";
    };
  };

  gtk = {
    enable = true;
    theme = {
      package = lib.mkDefault pkgs.gruvbox-gtk-theme;
      name = lib.mkDefault "gruvbox-dark";
    };
  };
}
