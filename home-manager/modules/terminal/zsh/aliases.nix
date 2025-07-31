# Zsh shell aliases.

{
  programs.zsh.shellAliases =
    let
      editor = "code";
      nixTemplates = "github:vwh/nixos-config/main?dir=devShells#";
    in
    {
      # Navigation
      ls = "eza";
      ll = "eza -l";
      etree = "eza --tree --level=1 --icons";
      cd = "z";
      ci = "zi";

      # Search
      find = "fd";
      grep = "rg";
      hq = "htmlq";
      cat = "bat";

      # Code info
      tk = "tokei";
      tf = "tokei --files";

      # Files
      fs = "fselect";

      # Editors
      v = "${editor}";
      se = "sudoedit";

      # System info
      ff = "fastfetch";
      mf = "microfetch";
      of = "onefetch";

      # General tools
      lg = "lazygit";
      ld = "lazydocker";

      # AI tools
      gemi = "gemini";
      open = "opencode";

      # Nix tools
      ns = "nix-shell";
      nd = "nix develop --command zsh";
      nfu = "nix flake update";
      nfs = "nix flake show";
      nfi = "nix flake init";
      nfib = "nfi -t '${nixTemplates}bun'";
      nfid = "nfi -t '${nixTemplates}deno'";
      nfin = "nfi -t '${nixTemplates}nodejs'";
      nfip = "nfi -t '${nixTemplates}python-venv'";
      nfirs = "nfi -t '${nixTemplates}rust-stable'";
      nfirn = "nfi -t '${nixTemplates}rust-nightly'";

      # System
      docker = "sudo docker";
      reboot = "sudo reboot";
      shutdown = "sudo shutdown now";
    };
}
