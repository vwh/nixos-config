{
  environment.sessionVariables = rec {
    TERMINAL = "alacritty";
    EDITOR = "code";
    XDG_BIN_HOME = "$HOME/.local/bin";
    NIXOS_OZONE_WL = "1";

    PATH = [
      "${XDG_BIN_HOME}"
    ];
  };
}
