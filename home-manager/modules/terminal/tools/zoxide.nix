# Zoxide (fast directory changer) configuration.

{ pkgs, ... }:

{
  programs.zoxide = {
    enable = true; # Enable zoxide for smart directory navigation
    package = pkgs.zoxide; # Use the standard zoxide package
    enableZshIntegration = true; # Enable Zsh shell integration for auto-completion
  };
}
