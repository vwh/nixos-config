# Nix flake containing various project templates.

{
  description = "A collection of flake templates";

  outputs =
    {
      self,
      nixpkgs,
    }:

    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
        ];
      };

      templates = {
        python-venv = {
          path = ./python-venv;
          description = "Python development template using venv";
        };

        rust-stable = {
          path = ./rust-stable;
          description = "Rust development template";
        };

        rust-nightly = {
          path = ./rust-nightly;
          description = "Rust development template using fenix";
        };

        deno = {
          path = ./deno;
          description = "Deno runtime development template using deno2nix";
        };

        bun = {
          path = ./bun;
          description = "Bun Javascript App";
        };

        nodejs = {
          path = ./nodejs;
          description = "NodeJS Javascript App";
        };
      };
    };
}
