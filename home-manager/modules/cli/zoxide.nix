# Zoxide (fast directory changer) configuration.

{ pkgs, ... }:

{
  programs.zoxide = {
    enable = true;
    package = pkgs.zoxide;
    enableZshIntegration = true;
  };
}
