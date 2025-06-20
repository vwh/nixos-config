{
  programs.zsh.shellAliases =
    let
      flakeDir = "~/System";
      editor = "code";
      nixTemplates = "github:vwh/nixos-config/main?dir=nix-templates#";
    in
    {
      nrs = "sudo nixos-rebuild switch --flake ${flakeDir}";
      hms = "home-manager switch --flake ${flakeDir}";

      nd = "nix develop --command zsh";
      nfu = "nix flake update";
      nfs = "nix flake show";
      nfi = "nix flake init";

      ll = "ls -l";
      v = "${editor}";
      se = "sudoedit";

      "nfib" = "nix flake init -t '${nixTemplates}bun'";
      "nfid" = "nix flake init -t '${nixTemplates}deno'";
      "nfin" = "nix flake init -t '${nixTemplates}nodejs'";

      "nfip" = "nix flake init -t '${nixTemplates}python-venv'";
      
      "nfirs" = "nix flake init -t '${nixTemplates}rust-stable'";
      "nfirn" = "nix flake init -t '${nixTemplates}rust-nightly'";
  };
}