{
  description = "A collection of flake templates";

  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
  in {
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = with pkgs; [
      ];
    };

    templates = {
      python-venv = {
        path = ./python-venv;
        description = "Python development template using venv";
        welcomeText = ''
          You have created a Python template that will help you manage
          your project. See the README for instructions on how to
          use the template.
        '';
      };

      rust-stable = {
        path = ./rust-stable;
        description = "Rust development template";
        welcomeText = ''
          You have created a Rust template that will help you manage
          your project. See the README for instructions on how to use
          the template.
        '';
      };

      rust-nightly = {
        path = ./rust-nightly;
        description = "Rust development template using fenix";
        welcomeText = ''
          You have created a Rust template that will help you manage
          your project. See the README for instructions on how to use
          the template.
        '';
      };

      deno = {
        path = ./deno;
        description = "Deno runtime development template using deno2nix";
        welcomeText = ''
          You have created a Javascript template that will help you manage
          your Deno project. See the README for instructions on how to
          use the template.
        '';
      };

      bun = {
        path = ./bun;
        description = "Bun Javascript App";
        welcomeText = ''
          You have created a Bun template that will help you manage
          your Bun project. See the README for instructions on how to
          use the template.
        '';
      };

      nodejs = {
        path = ./nodejs;
        description = "NodeJS Javascript App";
        welcomeText = ''
          You have created a NodeJS template that will help you manage
          your NodeJS project. See the README for instructions on how to
          use the template.
        '';
      };
    };
  };
}