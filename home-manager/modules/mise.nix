# Mise (formerly RTX) configuration.
# This module configures Mise, a polyglot runtime manager for development environments.

{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Mise configuration
  programs.mise = {
    enable = true;

    # Global settings - disable Python building entirely
    settings = {
      experimental = true;
      verbose = false;
      quiet = false;
      python_compile = false;
      python_venv_auto_create = false;
      disable_tools = ["python"];  # Completely disable Python tool management
    };

    # No global tool versions - let system handle Python
    globalConfig = {};
  };

  # Environment variables for Mise
  home.sessionVariables = {
    # Mise configuration
    MISE_EXPERIMENTAL = "1";
    MISE_PYTHON_COMPILE = "0";
    MISE_PYTHON_VENV_AUTO_CREATE = "0";
  };

  # Add Mise to PATH
  home.sessionPath = [ "${config.home.homeDirectory}/.local/share/mise/shims" ];
}
