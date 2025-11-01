# Local system packages for the 'pc' host.

{
  inputs,
  pkgs,
  pkgsStable,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    neovim
    showmethekey
    inputs.hexecute.packages.${pkgs.system}.default
  ];
}
