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
    file-roller # GUI frontend used by thunar-archive-plugin
    p7zip
    unrar
    xz
    bzip2

    # PolicyKit agent so Thunar-Volman prompts you for passwords
    polkit_gnome
  ];

  systemd.services.udisks2.enable = true;

  # Custom “Open Terminal Here” action
  environment.etc."xdg/xfce4/xfconf/xfce-perchannel-xml/thunar-actions.xml".text = ''
    <?xml version="1.0" encoding="UTF-8"?>
    <channel name="thunar-actions" version="1.0">
      <actions>
        <action name="Open Terminal Here">
          <description>Open a foot terminal in this folder</description>
          <icon>utilities-terminal</icon>
          <!-- %f expands to the directory path -->
          <command>foot --working-directory %f</command>
          <patterns>*;</patterns>
          <directories/>
          <startup-notify/>
        </action>
      </actions>
    </channel>
  '';
}
