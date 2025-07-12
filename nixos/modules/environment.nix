# Environment variables and session settings.

{
  pkgs,
  ...
}:

{
  environment.sessionVariables = rec {
    TERMINAL = "alacritty";
    EDITOR = "code";
    XDG_BIN_HOME = "$HOME/.local/bin";

    PATH = [
      "${XDG_BIN_HOME}"
    ];
  };
}
