{ pkgs, user, ... }: {
  programs.zsh.enable = true;

  users = {
    defaultUserShell = pkgs.zsh;
    users.${user} = {
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" "input" "libvirtd" ];
    };
  };

  services.getty.autologinUser = user;
}
