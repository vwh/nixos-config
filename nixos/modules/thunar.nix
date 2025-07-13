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

  # PolicyKit rule to allow mounting drives without a password for users in the 'wheel' group.
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (action.id == "org.freedesktop.udisks2.filesystem-mount-system" &&
          subject.isInGroup("wheel")) {
        return polkit.Result.YES;
      }
    });
  '';

  environment.systemPackages = with pkgs; [
    # Thunar dependencies
    xfce.exo # Required for "Open Terminal Here" and other integrations.
    xfce.tumbler # Thumbnail daemon package.
    gvfs # Network & removable-media support.
    udisks2 # Automount daemon.
    file-roller # Archive CLI tools (zip, 7z, tar, rar…).
    p7zip
    unrar
    xz
    bzip2
    polkit_gnome # PolicyKit agent so Thunar-Volman prompts you for passwords.

    # Thumbnailers for Tumbler
    ffmpegthumbnailer # Video thumbnails.
    poppler_utils # PDF thumbnails.
  ];

  # Ensure the udisks2 service is enabled for drive management.
  systemd.services.udisks2.enable = true;
}
