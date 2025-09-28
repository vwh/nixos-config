# Nix flake for a Node.js application.
{
  description = "NodeJS Javascript App";

  inputs = {
    utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      utils,
    }:

    utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShell = pkgs.mkShell {
          name = "nodejs-app";
          buildInputs = with pkgs; [ nodejs ];

          shellHook = ''
            if [ ! -f package.json ]; then
              npm init -y
            fi
          '';
        };
      }
    );
}
