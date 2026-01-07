# Local system packages for the 'pc' host.

{ inputs, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neovim
    inputs.hexecute.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
