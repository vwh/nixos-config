{ pkgs, ... }:

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
}