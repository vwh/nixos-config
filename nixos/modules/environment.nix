# Environment variables and session settings.

{
  environment.sessionVariables = rec {
    # Default terminal emulator for applications that need one
    TERMINAL = "alacritty";

    # Default text editor for applications that need one
    EDITOR = "code";

    # XDG Base Directory specification for user binaries
    XDG_BIN_HOME = "$HOME/.local/bin";

    # System PATH with additional directories
    PATH = [ "${XDG_BIN_HOME}" ];
  };
}
