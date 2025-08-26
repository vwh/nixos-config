# User and authentication configuration.
# This module configures user accounts, default shells, and system group memberships

{ pkgs, user, ... }:

{
  # Enable Zsh as the system-wide default shell
  programs.zsh.enable = true;

  users = {
    # Set Zsh as the default shell for all users
    defaultUserShell = pkgs.zsh;

    # Configure the main user account
    users.${user} = {
      isNormalUser = true; # Create a normal user account (not system account)

      # Additional groups for enhanced permissions and functionality
      extraGroups = [
        "networkmanager" # Access to NetworkManager for network configuration
        "wheel" # Sudo privileges for system administration
      ];
    };
  };
}
