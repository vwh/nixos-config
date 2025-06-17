{ pkgs, ... }: {
  programs.zsh.enable = true;

  users = {
    defaultUserShell = pkgs.zsh;

    users.yazan = {
      isNormalUser = true;
      description = "yazan";
      extraGroups = [ "networkmanager" "wheel" "input" "libvirtd" ];
      packages = with pkgs; [];
    };
  };

  # Enable automatic login for the user.
  services.getty.autologinUser = "yazan";
}