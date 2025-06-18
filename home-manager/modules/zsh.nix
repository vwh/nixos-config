{ config, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    # enableAutosuggestions = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases =
      let
        flakeDir = "~/System";
        editor = "code";
        devShellPath = "github:vwh/.dotfiles?ref=main&dir=dev-environment";
      in
      {
        rb = "sudo nixos-rebuild switch --flake ${flakeDir}";
        upd = "nix flake update ${flakeDir}";
        upg = "sudo nixos-rebuild switch --upgrade --flake ${flakeDir}";

        hms = "home-manager switch --flake ${flakeDir}";

        conf = "${editor} ${flakeDir}/nixos/configuration.nix";
        pkgs = "${editor} ${flakeDir}/nixos/packages.nix";

        ll = "ls -l";
        v = "${editor}";
        se = "sudoedit";
        ff = "fastfetch";

        "bune" = "nix develop '${devShellPath}/bun' --command zsh";
        "nodejse" = "nix develop '${devShellPath}/nodejs' --command zsh";
      };

    history.size = 10000;
    history.path = "${config.xdg.dataHome}/zsh/history";

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" ];
      theme = "agnoster";
    };
  };
}
