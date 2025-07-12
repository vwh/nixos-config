# Imports all Home Manager modules.

{
  imports = [
    ./terminal/alacritty.nix
    ./cli/bat.nix
    ./cli/cava.nix
    ./cli/eza.nix
    ./git.nix
    ./gpg.nix
    ./cli/htop.nix
    ./hyprland
    ./cli/lazygit.nix
    ./mime.nix
    ./apps/obsidian.nix
    ./qt.nix
    ./stylix.nix
    ./swaync
    ./terminal/tmux.nix
    ./music/spicetify.nix
    ./waybar
    ./wofi
    ./zsh
    ./cli/zathura.nix
    ./cli/zoxide.nix
  ];
}
