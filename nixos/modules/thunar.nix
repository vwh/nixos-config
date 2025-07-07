# Thunar file manager configuration.

{ pkgs, ... }:

let
  inherit (pkgs) xfce;
in
{
  programs.xfconf.enable = true;

  programs.thunar = {
    enable = true;

    plugins = with xfce; [
      thunar-archive-plugin # create/extract .zip/.tar.gz/.7z/etc
      thunar-volman # automount USB, SD cards, pmount, …
      thunar-media-tags-plugin # view/edit ID3 tags, EXIF metadata
    ];
  };

  environment.systemPackages = with pkgs; [
    # Network & removable-media support
    gvfs

    # Automount daemon
    udisks2

    # Archive CLI tools (zip, 7z, tar, rar…)
    file-roller
    p7zip
    unrar
    xz
    bzip2

    # PolicyKit agent so Thunar-Volman prompts you for passwords
    polkit_gnome
  ];

  systemd.services.udisks2.enable = true;

  # Custom “Open Terminal Here” action
  environment.etc."xdg/applications/alacritty.desktop".text = ''
    [Desktop Entry]
    Name=Alacritty
    Comment=A fast, cross-platform, GPU-accelerated terminal emulator
    Exec=alacritty
    Icon=alacritty
    Terminal=false
    Type=Application
    Categories=Utility;System;TerminalEmulator;
    Keywords=shell;prompt;terminal;console;x-terminal-emulator;
  '';
}
