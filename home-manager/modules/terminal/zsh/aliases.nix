# Zsh shell aliases.

{
  programs.zsh.shellAliases =
    let
      flakeDir = "~/System";
      editor = "code";
      nixTemplates = "github:vwh/nixos-config/main?dir=devShells#";
    in
    {
      ls = "eza";
      ll = "eza -l";

      cd = "z";
      ci = "zi";

      find = "fd";
      grep = "rg";

      etree = "eza --tree --level=1 --icons";

      cat = "bat";

      tk = "tokei";
      tf = "tokei --files";

      fs = "fselect";

      v = "${editor}";
      se = "sudoedit";

      ff = "fastfetch";
      mf = "microfetch";
      of = "onefetch";

      lg = "lazygit";
      ld = "lazydocker";

      ns = "nix-shell";

      nd = "nix develop --command zsh";
      nfu = "nix flake update";
      nfs = "nix flake show";

      nfi = "nix flake init";
      nfib = "nix flake init -t '${nixTemplates}bun'";
      nfid = "nix flake init -t '${nixTemplates}deno'";
      nfin = "nix flake init -t '${nixTemplates}nodejs'";
      nfip = "nix flake init -t '${nixTemplates}python-venv'";
      nfirs = "nix flake init -t '${nixTemplates}rust-stable'";
      nfirn = "nix flake init -t '${nixTemplates}rust-nightly'";

      docker = "sudo docker";

      reboot = "sudo reboot";
      shutdown = "sudo shutdown now";
    };
}
