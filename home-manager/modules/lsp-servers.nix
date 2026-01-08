# LSP Servers configuration for OpenCode development experience

{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # High Priority (Python packages handled in python.nix)
    bash-language-server # Bash scripts (scripts/ directory)
    nodePackages.yaml-language-server # YAML configs
    nodePackages.svelte-language-server # Svelte framework

    # Medium Priority
    rust-analyzer # Rust support
    lua-language-server # Lua configs
    marksman # Markdown docs

    # Specialized
    taplo # TOML files (Cargo.toml, pyproject.toml, justfile)
  ];
}
